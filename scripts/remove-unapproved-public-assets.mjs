import { rmSync } from 'node:fs';
import { resolve, sep } from 'node:path';

const distRoot = resolve('dist');
const unapprovedCharacters = resolve(distRoot, 'characters');

if (!unapprovedCharacters.startsWith(`${distRoot}${sep}`)) {
  throw new Error('Refusing to remove assets outside dist.');
}

rmSync(unapprovedCharacters, { recursive: true, force: true });
