import { mkdir, readFile, writeFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { renderNetlifyHeaders } from '../src/lib/alliance-alerts.mjs';

const root = dirname(dirname(fileURLToPath(import.meta.url)));
const dist = join(root, 'dist');
const alertsPage = await readFile(
  join(dist, 'alliance-alerts', 'index.html'),
  'utf8'
);
const iframeTag = alertsPage.match(
  /<iframe\b[^>]*\bdata-alliance-alerts-embed\b[^>]*>/i
)?.[0];
const embedUrl = iframeTag?.match(/\bsrc="([^"]+)"/i)?.[1];

await mkdir(dist, { recursive: true });
await writeFile(
  join(dist, '_headers'),
  renderNetlifyHeaders(embedUrl),
  'utf8'
);
