import { describe,expect,it } from 'vitest';
import { disclaimer,products,tales } from '../src/data/site';
import { existsSync, readFileSync } from 'node:fs';
describe('public-safe fixtures',()=>{
  it('keeps exact disclaimer',()=>expect(disclaimer).toBe('An unofficial player-community project. The Tavern and ALE are not affiliated with or endorsed by Kingshot or CenturyGames.'));
  it('uses unique stable product slugs',()=>expect(new Set(products.map(x=>x.slug)).size).toBe(products.length));
  it('uses unique stable tale slugs',()=>expect(new Set(tales.map(x=>x.slug)).size).toBe(tales.length));
  it('keeps public tale concepts limited to Steve',()=>expect(new Set(tales.map(x=>x.character))).toEqual(new Set(['Steve'])));
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
  it('pins production canonical metadata to the custom domain',()=>{
    const packageJson=JSON.parse(readFileSync(new URL('../package.json',import.meta.url),'utf8'));
    const config=readFileSync(new URL('../astro.config.mjs',import.meta.url),'utf8');
    expect(packageJson.scripts.build).toContain('PUBLIC_SITE_URL=https://trashtavern.com');
    expect(config).toContain("'https://trashtavern.com'");
    expect(config).not.toContain('preview.invalid');
  });
  it('keeps the reachable site truthful and explicitly pre-launch',()=>{
    const layout=readFileSync(new URL('../src/layouts/BaseLayout.astro',import.meta.url),'utf8');
    const home=readFileSync(new URL('../src/pages/index.astro',import.meta.url),'utf8');
    expect(`${layout}\n${home}`).toContain('Pre-launch');
    expect(`${layout}\n${home}`).not.toMatch(/Private build|private preview|private mockup/i);
  });
  it('keeps founder input outside public and source trees',()=>{
    const gitignore=readFileSync(new URL('../.gitignore',import.meta.url),'utf8');
    const scanner=readFileSync(new URL('../scripts/validate-founder-input.mjs',import.meta.url),'utf8');
    const guide=readFileSync(new URL('../founder-input/README.md',import.meta.url),'utf8');
    expect(gitignore).toContain('founder-input/photos/raw/*');
    expect(gitignore).toContain('founder-input/stories/raw/*');
    expect(gitignore).toContain('founder-input/characters/raw/*');
    expect(scanner).toContain("'ls-files'");
    expect(scanner).toContain("'check-ignore'");
    expect(scanner).toContain('shell: false');
    expect(scanner).not.toMatch(/readFileSync|readFile\(/);
    expect(guide).toContain('exact relative-path copies');
    expect(guide).toContain('does not read image or document contents');
    expect(guide).toContain('detect a renamed/manual derivative');
    expect(existsSync(new URL('../public/founder-input',import.meta.url))).toBe(false);
    expect(existsSync(new URL('../src/founder-input',import.meta.url))).toBe(false);
  });
});
