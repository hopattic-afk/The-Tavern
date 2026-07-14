export const disclaimer = 'An unofficial player-community project. The Tavern and ALE are not affiliated with or endorsed by Kingshot or CenturyGames.';

export const products = [
  { slug:'structural-tab-mug', name:'Structural Tab Mug', summary:'A weighty cream mug with one restrained Tavern mark. Not for sale.', image:'/images/merch-direction-640.webp' },
  { slug:'bad-plans-shirt', name:'Crooked Tankard Heavyweight Tee', summary:'Quiet left-chest mark; Tavern-related back artwork remains pending.', image:'/images/merch-direction-640.webp' },
  { slug:'emotional-north-print', name:'Crooked Tankard Heavyweight Hoodie', summary:'Premium charcoal fleece with restrained front embroidery; back artwork remains pending.', image:'/images/merch-direction-640.webp' }
];
export const tales = [
  { slug:'the-chair-moved', title:'The Chair Moved', summary:'Rook discovers furniture with hostile intent.', character:'Rook Rattleplate' },
  { slug:'emotionally-north', title:'Emotionally North', summary:'Muddle presents a flawless map in several orientations.', character:'Muddle Quill' },
  { slug:'seventeen-responsibilities', title:'Seventeen Responsibilities', summary:'Pip asks one reasonable question.', character:'Pip Kindling' }
];
export const notices = ['Steve is the approved mascot direction; additional character imagery remains pending.','The store is not connected and nothing is for sale.','Incident collection is disabled.'];

export function fourthwallUrl(path = ''): string | null {
  const raw = import.meta.env.PUBLIC_FOURTHWALL_STORE_URL?.trim();
  if (!raw) return null;
  try { const url = new URL(raw); if (url.protocol !== 'https:' || !/(^|\.)fourthwall\.com$/i.test(url.hostname)) return null; url.pathname = `${url.pathname.replace(/\/$/,'')}${path}`; return url.toString(); } catch { return null; }
}
