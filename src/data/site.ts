export const disclaimer = 'An unofficial player-community project. The Tavern and ALE are not affiliated with or endorsed by Kingshot or CenturyGames.';

export const products = [
  { slug:'structural-tab-mug', name:'Structural Tab Mug', summary:'A provisional tankard-adjacent vessel for structural damage paperwork.', image:'/brand/recommended/simplified-mark.svg' },
  { slug:'bad-plans-shirt', name:'Bad Plans Shirt', summary:'Provisional uniform for questionable councils and strong rallies.', image:'/characters/ensemble-lineup.svg' },
  { slug:'emotional-north-print', name:'Emotional North Print', summary:'A provisional strategy-map print with directions of uncertain authority.', image:'/characters/muddle-quill.svg' }
];
export const tales = [
  { slug:'the-chair-moved', title:'The Chair Moved', summary:'Rook discovers furniture with hostile intent.', character:'Rook Rattleplate' },
  { slug:'emotionally-north', title:'Emotionally North', summary:'Muddle presents a flawless map in several orientations.', character:'Muddle Quill' },
  { slug:'seventeen-responsibilities', title:'Seventeen Responsibilities', summary:'Pip asks one reasonable question.', character:'Pip Kindling' }
];
export const notices = ['Roster and mascot await founder approval.','The store is not connected and nothing is for sale.','Incident collection is disabled.'];

export function fourthwallUrl(path = ''): string | null {
  const raw = import.meta.env.PUBLIC_FOURTHWALL_STORE_URL?.trim();
  if (!raw) return null;
  try { const url = new URL(raw); if (url.protocol !== 'https:' || !/(^|\.)fourthwall\.com$/i.test(url.hostname)) return null; url.pathname = `${url.pathname.replace(/\/$/,'')}${path}`; return url.toString(); } catch { return null; }
}
