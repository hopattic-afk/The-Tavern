export const disclaimer = 'An unofficial player-community project. The Tavern and ALE are not affiliated with or endorsed by Kingshot or CenturyGames.';

export const products = [
  { slug:'structural-tab-mug', name:'Structural Tab Mug', summary:'A weighty cream mug with one restrained Tavern mark. Not for sale.', image:'/images/merch-direction-640.webp' },
  { slug:'bad-plans-shirt', name:'Crooked Tankard Heavyweight Tee', summary:'Quiet left-chest mark; Tavern-related back artwork remains pending.', image:'/images/merch-direction-640.webp' },
  { slug:'emotional-north-print', name:'Crooked Tankard Heavyweight Hoodie', summary:'Premium charcoal fleece with restrained front embroidery; back artwork remains pending.', image:'/images/merch-direction-640.webp' }
];
export const tales = [
  { slug:'the-structural-tab', title:'The Structural Tab', summary:'Steve discovers that another stool has become a load-bearing problem.', character:'Steve' },
  { slug:'rain-in-the-cellar', title:'Rain in the Cellar', summary:'Steve investigates weather that has somehow moved indoors.', character:'Steve' },
  { slug:'the-last-clean-tankard', title:'The Last Clean Tankard', summary:'Steve protects the Tavern’s final clean tankard with feral determination.', character:'Steve' }
];
export const notices = ['Steve is the founder-selected mascot direction; commercial rights clearance remains pending.','The store is not connected and nothing is for sale.','Incident collection is disabled.'];

export function fourthwallUrl(path = ''): string | null {
  const raw = import.meta.env.PUBLIC_FOURTHWALL_STORE_URL?.trim();
  if (!raw) return null;
  try { const url = new URL(raw); if (url.protocol !== 'https:' || !/(^|\.)fourthwall\.com$/i.test(url.hostname)) return null; url.pathname = `${url.pathname.replace(/\/$/,'')}${path}`; return url.toString(); } catch { return null; }
}
