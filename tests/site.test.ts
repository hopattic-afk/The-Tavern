import { describe,expect,it } from 'vitest';
import { disclaimer,products,tales } from '../src/data/site';
import { renderNetlifyHeaders,resolveAllianceAlertsEmbedUrl } from '../src/lib/alliance-alerts.mjs';
import { readFileSync } from 'node:fs';
describe('public-safe fixtures',()=>{
  it('keeps exact disclaimer',()=>expect(disclaimer).toBe('An unofficial player-community project. The Tavern and ALE are not affiliated with or endorsed by Kingshot or CenturyGames.'));
  it('uses unique stable product slugs',()=>expect(new Set(products.map(x=>x.slug)).size).toBe(products.length));
  it('uses unique stable tale slugs',()=>expect(new Set(tales.map(x=>x.slug)).size).toBe(tales.length));
  it('constrains intrinsic images to the 320px viewport',()=>{
    const css=readFileSync(new URL('../src/styles/global.css',import.meta.url),'utf8');
    expect(css).toMatch(/img\s*\{[^}]*max-width:\s*100%[^}]*height:\s*auto[^}]*\}/);
  });
  it('serves responsive website artwork',()=>{
    const home=readFileSync(new URL('../src/pages/index.astro',import.meta.url),'utf8');
    expect(home).toContain('srcset=');
    expect(home).not.toMatch(/(?:steve-hero|merch-direction)-v1\.png/);
  });
  it('builds only Steve from the archived character evidence',()=>{
    const route=readFileSync(new URL('../src/pages/trash-pandas/[slug].astro',import.meta.url),'utf8');
    expect(route).toContain("candidate.id==='bramble-bung'");
    expect(route).not.toContain('data.characters.map');
    expect(route).not.toContain('/characters/${character.id}.svg');
  });
  it('accepts only the exact HTTPS public alerts embed surface',()=>{
    expect(resolveAllianceAlertsEmbedUrl('HTTPS://ALERTS.EXAMPLE.COM/embed')).toEqual({
      href:'https://alerts.example.com/embed',
      origin:'https://alerts.example.com'
    });
    for (const value of [
      '',
      'http://alerts.example.com/embed',
      'https://alerts.example.com/',
      'https://alerts-admin.example.com/embed',
      'https://status.example.com/embed',
      'https://other.alerts.example.com/embed',
      'https://127.0.0.1/embed',
      'https://localhost/embed',
      'https://alerts/embed',
      'https://alerts.localhost/embed',
      'https://alerts.127.0.0.1/embed',
      'https://alerts.example.com/api/admin/dashboard',
      'https://alerts.example.com/embed?view=admin',
      'https://alerts.example.com/embed#history',
      'https://user:secret@alerts.example.com/embed'
    ]) expect(resolveAllianceAlertsEmbedUrl(value)).toBeNull();
  });
  it('generates fail-closed headers without weakening existing controls',()=>{
    const closed=renderNetlifyHeaders('');
    expect(closed).toContain("frame-src 'none'");
    const configured=renderNetlifyHeaders('https://alerts.example.com/embed');
    expect(configured).toContain('frame-src https://alerts.example.com');
    expect(configured).not.toMatch(/frame-src https:(?:;|\s)/);
    expect(configured).not.toMatch(/frame-src \*(?:;|\s)/);
    for (const header of [
      'X-Robots-Tag: noindex, nofollow, noarchive',
      'X-Frame-Options: DENY',
      'Permissions-Policy: camera=(), microphone=(), geolocation=(), payment=()',
      "frame-ancestors 'none'",
      "form-action 'none'"
    ]) expect(configured).toContain(header);
  });
  it('keeps Alliance Alerts public-safe and private-preview only',()=>{
    const route=readFileSync(new URL('../src/pages/alliance-alerts.astro',import.meta.url),'utf8');
    const layout=readFileSync(new URL('../src/layouts/BaseLayout.astro',import.meta.url),'utf8');
    expect(layout).toContain('href="/alliance-alerts/"');
    expect(layout).toContain('noindex,nofollow,noarchive');
    expect(layout).toContain('Private build · provisional · not for sale');
    expect(route).toContain('data-alliance-alerts-embed');
    expect(route).toContain('sandbox="allow-scripts"');
    expect(route).toContain('referrerpolicy="no-referrer"');
    expect(route).not.toMatch(/\/api\/admin|last_error|webhook|discord|occurrences/i);
  });
});
