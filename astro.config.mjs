import { defineConfig } from 'astro/config';
import { URL } from 'node:url';

const configuredSite = process.env.PUBLIC_SITE_URL?.trim() || 'https://trashtavern.com';
const site = new URL(configuredSite);

if (!['http:', 'https:'].includes(site.protocol)) {
  throw new Error('PUBLIC_SITE_URL must use HTTP or HTTPS.');
}

site.pathname = '/';
site.search = '';
site.hash = '';

export default defineConfig({ site: site.toString(), output: 'static', build: { format: 'directory' } });
