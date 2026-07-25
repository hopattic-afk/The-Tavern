import { spawnSync } from 'node:child_process';
import { existsSync, lstatSync, readdirSync } from 'node:fs';
import { extname, relative, resolve, sep } from 'node:path';
import { fileURLToPath, URL } from 'node:url';

const root = resolve(fileURLToPath(new URL('..', import.meta.url)));
const intake = resolve(root, 'founder-input');
const rawBuckets = [
  { name: 'photos', path: resolve(intake, 'photos/raw'), extensions: new Set(['.avif', '.gif', '.heic', '.jpeg', '.jpg', '.png', '.tif', '.tiff', '.webp']) },
  { name: 'stories', path: resolve(intake, 'stories/raw'), extensions: new Set(['.docx', '.md', '.odt', '.pdf', '.rtf', '.txt']) },
  { name: 'characters', path: resolve(intake, 'characters/raw'), extensions: new Set(['.avif', '.docx', '.gif', '.heic', '.jpeg', '.jpg', '.md', '.pdf', '.png', '.rtf', '.txt', '.webp']) },
  { name: 'review-state', path: resolve(intake, 'review-state'), extensions: new Set(['.json', '.md', '.txt']) }
];

const required = [
  'README.md',
  'photos/README.md',
  'photos/PHOTO_INPUT_TEMPLATE.md',
  'stories/README.md',
  'stories/STORY_INPUT_TEMPLATE.md',
  'characters/README.md',
  'characters/CHARACTER_INPUT_TEMPLATE.md'
].map((path) => resolve(intake, path));

const missing = required.filter((path) => !existsSync(path));
if (missing.length) {
  throw new Error(`Missing founder-input files: ${missing.map((path) => relative(root, path)).join(', ')}`);
}

function git(args, allowedStatuses = [0]) {
  const result = spawnSync('git', args, {
    cwd: root,
    encoding: 'utf8',
    shell: false,
    windowsHide: true
  });
  if (result.error) throw new Error(`Unable to run git ${args[0]}: ${result.error.message}`);
  if (!allowedStatuses.includes(result.status)) {
    throw new Error(`git ${args[0]} failed with status ${result.status}: ${result.stderr.trim()}`);
  }
  return result;
}

function listFiles(directory) {
  if (!existsSync(directory)) return [];
  const files = [];
  for (const entry of readdirSync(directory, { withFileTypes: true })) {
    const fullPath = resolve(directory, entry.name);
    const stat = lstatSync(fullPath);
    if (stat.isSymbolicLink()) throw new Error(`Symlinks are not allowed in founder input: ${relative(root, fullPath)}`);
    if (entry.isDirectory()) files.push(...listFiles(fullPath));
    else if (entry.isFile() && entry.name !== '.gitkeep') files.push(fullPath);
  }
  return files;
}

const violations = [];
const counts = {};
const trackedRaw = git([
  'ls-files',
  '-z',
  '--',
  'founder-input/photos/raw',
  'founder-input/stories/raw',
  'founder-input/characters/raw',
  'founder-input/review-state'
]).stdout
  .split('\0')
  .filter((path) => path && !path.endsWith('/.gitkeep'));

for (const path of trackedRaw) violations.push(`${path} is tracked by Git`);

const ignoreProbes = [
  'founder-input/photos/raw/.tavern-ignore-probe.png',
  'founder-input/stories/raw/.tavern-ignore-probe.md',
  'founder-input/characters/raw/.tavern-ignore-probe.png',
  'founder-input/review-state/.tavern-ignore-probe.json'
];
for (const probe of ignoreProbes) {
  const result = git(['check-ignore', '-q', '--', probe], [0, 1]);
  if (result.status !== 0) violations.push(`${probe} is not effectively ignored by Git`);
}

for (const bucket of rawBuckets) {
  const files = listFiles(bucket.path);
  counts[bucket.name] = files.length;
  for (const file of files) {
    const repoPath = relative(root, file).replaceAll('\\', '/');
    const extension = extname(file).toLowerCase();
    if (!bucket.extensions.has(extension)) violations.push(`${repoPath} uses unsupported extension ${extension || '(none)'}`);

    for (const publicRoot of [resolve(root, 'public'), resolve(root, 'dist')]) {
      const duplicate = resolve(publicRoot, file.slice(bucket.path.length + 1));
      if (existsSync(duplicate)) violations.push(`${repoPath} has a same-path copy in ${relative(root, publicRoot)}`);
    }
  }
}

for (const path of [resolve(root, 'public/founder-input'), resolve(root, 'dist/founder-input')]) {
  if (existsSync(path)) violations.push(`${relative(root, path)} exposes the founder-input tree`);
}

const escapedIntake = `${intake}${sep}`;
for (const bucket of rawBuckets) {
  if (bucket.path !== intake && !bucket.path.startsWith(escapedIntake)) {
    violations.push(`Unsafe intake path: ${bucket.path}`);
  }
}

if (violations.length) {
  throw new Error(`Founder-input validation failed:\n- ${violations.join('\n- ')}`);
}

process.stdout.write(`Founder-input validation passed: ${Object.entries(counts).map(([name, count]) => `${name}=${count}`).join(', ')}; supported extensions, Git tracking/ignore behavior, and exact-path public/dist exposure checked without reading payload contents.\n`);
