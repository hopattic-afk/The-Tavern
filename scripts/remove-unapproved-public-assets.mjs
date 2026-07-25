import { existsSync, readFileSync, readdirSync, rmSync } from 'node:fs';
import { resolve, sep } from 'node:path';

const distRoot = resolve('dist');
const unapprovedCharacters = resolve(distRoot, 'characters');

if (!unapprovedCharacters.startsWith(`${distRoot}${sep}`)) {
  throw new Error('Refusing to remove assets outside dist.');
}

rmSync(unapprovedCharacters, { recursive: true, force: true });

if (existsSync(resolve(distRoot, 'founder-input'))) {
  throw new Error('Built output exposes the local founder-input tree.');
}

function htmlFiles(directory) {
  if (!existsSync(directory)) return [];
  return readdirSync(directory, { withFileTypes: true }).flatMap((entry) => {
    const path = resolve(directory, entry.name);
    if (entry.isDirectory()) return htmlFiles(path);
    return entry.isFile() && entry.name.endsWith('.html') ? [path] : [];
  });
}

const builtHtml = htmlFiles(distRoot).map((path) => readFileSync(path, 'utf8')).join('\n');
const deferredNames = ['Rook Rattleplate', 'Muddle Quill', 'Pip Kindling', 'Tansy Tallytail', 'Vellum Sip', 'Drowse Coalpaw'];
const exposed = deferredNames.filter((name) => builtHtml.includes(name));
if (exposed.length) {
  throw new Error(`Built output exposes deferred characters: ${exposed.join(', ')}`);
}
