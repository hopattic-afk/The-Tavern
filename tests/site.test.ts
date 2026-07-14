import { describe,expect,it } from 'vitest';
import { disclaimer,products,tales } from '../src/data/site';
import { readFileSync } from 'node:fs';
describe('public-safe fixtures',()=>{
  it('keeps exact disclaimer',()=>expect(disclaimer).toBe('An unofficial player-community project. The Tavern and ALE are not affiliated with or endorsed by Kingshot or CenturyGames.'));
  it('uses unique stable product slugs',()=>expect(new Set(products.map(x=>x.slug)).size).toBe(products.length));
  it('uses unique stable tale slugs',()=>expect(new Set(tales.map(x=>x.slug)).size).toBe(tales.length));
  it('constrains intrinsic images to the 320px viewport',()=>{
    const css=readFileSync(new URL('../src/styles/global.css',import.meta.url),'utf8');
    expect(css).toMatch(/img\s*\{[^}]*max-width:\s*100%[^}]*height:\s*auto[^}]*\}/);
  });
});
