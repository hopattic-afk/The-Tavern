const SENSITIVE_PATTERNS=[
  /\b\d{2,4}\s*[,:]\s*\d{2,4}\b/gi,
  /\b(?:password|credential|account\s*(?:id|number)?|login|token)\b\s*[:=#-]?\s*\S+/gi,
  /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/gi,
  /(?:\+?\d[\d .()-]{7,}\d)/g,
  /@[A-Za-z0-9_-]+/g,
  /\b(?:alliance strategy|private message)\b[^.!?\n]*/gi
];
export const FORBIDDEN_RAW_FIELDS=['rawNarrative','contactRef','consentRecordId','recordId','whoWasInvolved','namesMayBeUsed','exactQuotesMayBeUsed','capturedAt','submittedNamePermission','submittedQuotePermission'];
export type Status='received'|'privacy-review'|'needs-clarification'|'approved-brief'|'handed-to-writers'|'scripted'|'ip-review'|'founder-review'|'approved'|'scheduled'|'published'|'rejected'|'withdrawn'|'takedown-review'|'archived';
export const transitions:Record<Status,Status[]>={received:['privacy-review','withdrawn'],'privacy-review':['needs-clarification','approved-brief','rejected','withdrawn'],'needs-clarification':['privacy-review','rejected','withdrawn'],'approved-brief':['handed-to-writers','withdrawn'],'handed-to-writers':['scripted','withdrawn'],scripted:['ip-review','withdrawn'],'ip-review':['founder-review','rejected','withdrawn'],'founder-review':['approved','rejected','withdrawn'],approved:['scheduled','withdrawn'],scheduled:['published','withdrawn'],published:['takedown-review'],'takedown-review':['archived'],rejected:[],withdrawn:[],archived:[]};
export function canTransition(from:Status,to:Status){return transitions[from]?.includes(to)??false;}
export function containsSensitiveData(text:string){return SENSITIVE_PATTERNS.some(p=>{p.lastIndex=0;return p.test(text)});}
export function redactNarrative(text:string){return SENSITIVE_PATTERNS.reduce((safe,p)=>{p.lastIndex=0;return safe.replace(p,'[REMOVED]')},text);}
export function validateSyntheticSubmission(value:Record<string,unknown>){const required=['whatHappened','whyFunny','whoWasInvolved','namesMayBeUsed','exactQuotesMayBeUsed','privateEvent','changeIdentities','suggestedCharacter','suggestedPunchline','deadline','permissionToAdapt','consentVersion'];const errors=required.filter(k=>!(k in value));if(value.permissionToAdapt!==true)errors.push('permissionToAdapt');const text=Object.values(value).filter(v=>typeof v==='string').join(' ');if(containsSensitiveData(text))errors.push('private-data');return{ok:errors.length===0,errors:[...new Set(errors)]};}
export type WriterBrief={briefId:string;status:'approved-brief';generalizedEvent:string;whyFunny:string;allowedAdaptation:true;identityRule:'anonymize-all'|'verified-names-only';quoteRule:'paraphrase-only'|'verified-quotes-only';suggestedCharacter:string;suggestedPunchline:string;deadline:string|null;reviewReference:string};
export function createWriterBrief(input:Record<string,unknown>):WriterBrief{
  if(input.status!=='approved-brief'||input.permissionToAdapt!==true||input.privacyReviewState!=='verified'||input.consentVerificationState!=='verified')throw new Error('Verified privacy review and consent required');
  const reviewed=[input.generalizedEvent,input.reviewedWhyFunny,input.paraphrasedPunchline];if(reviewed.some(v=>typeof v!=='string'||v.trim().length<3))throw new Error('Reviewer-authored minimized fields required');
  const narrative=reviewed.join(' ');if(containsSensitiveData(narrative))throw new Error('Sensitive data must be rejected and re-reviewed before handoff');
  const forcePrivate=input.privateEvent===true||input.changeIdentities===true;
  const identityRule=!forcePrivate&&input.reviewedNamePermission==='verified-parties'?'verified-names-only':'anonymize-all';
  const quoteRule=!forcePrivate&&input.reviewedQuotePermission==='verified-speakers'?'verified-quotes-only':'paraphrase-only';
  return{briefId:String(input.briefId),status:'approved-brief',generalizedEvent:String(input.generalizedEvent),whyFunny:String(input.reviewedWhyFunny),allowedAdaptation:true,identityRule,quoteRule,suggestedCharacter:String(input.reviewedSuggestedCharacter??''),suggestedPunchline:String(input.paraphrasedPunchline),deadline:typeof input.deadline==='string'?input.deadline:null,reviewReference:String(input.reviewReference)};
}
export function writerBriefHasRawFields(value:Record<string,unknown>){return FORBIDDEN_RAW_FIELDS.some(k=>k in value);}
