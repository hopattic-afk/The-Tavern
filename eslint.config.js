import js from '@eslint/js';
import tseslint from 'typescript-eslint';
export default [{ ignores: ['dist/**','.astro/**','public/**'] }, { languageOptions: { globals: { process: 'readonly' } } }, js.configs.recommended, ...tseslint.configs.recommended];
