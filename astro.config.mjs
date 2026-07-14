import { defineConfig } from 'astro/config';
export default defineConfig({ site: process.env.PUBLIC_SITE_URL || 'https://preview.invalid', output: 'static', build: { format: 'directory' } });
