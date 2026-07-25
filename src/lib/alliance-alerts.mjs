import { URL } from 'node:url';
import { isIP } from 'node:net';

const EMBED_PATH = '/embed';

export function resolveAllianceAlertsEmbedUrl(value) {
  if (typeof value !== 'string' || value.trim() === '') return null;

  try {
    const url = new URL(value.trim());
    const labels = url.hostname.split('.');
    const parentDomain = labels.slice(1).join('.');
    const isPublicAlertsHost =
      labels.length >= 3 &&
      labels[0] === 'alerts' &&
      labels.every(Boolean) &&
      !url.hostname.endsWith('.') &&
      parentDomain !== 'localhost' &&
      !parentDomain.endsWith('.localhost') &&
      isIP(url.hostname) === 0 &&
      isIP(parentDomain) === 0;
    const isApprovedSurface =
      url.protocol === 'https:' &&
      isPublicAlertsHost &&
      url.port === '' &&
      url.pathname === EMBED_PATH &&
      url.username === '' &&
      url.password === '' &&
      url.search === '' &&
      url.hash === '';

    if (!isApprovedSurface) return null;

    return Object.freeze({
      href: url.href,
      origin: url.origin
    });
  } catch {
    return null;
  }
}

export function renderNetlifyHeaders(value) {
  const embed = resolveAllianceAlertsEmbedUrl(value);
  const frameSource = embed?.origin ?? "'none'";
  const contentSecurityPolicy = [
    "default-src 'self'",
    "img-src 'self' data:",
    "style-src 'self' 'unsafe-inline'",
    "font-src 'self'",
    "script-src 'self'",
    "connect-src 'none'",
    `frame-src ${frameSource}`,
    "object-src 'none'",
    "base-uri 'self'",
    "form-action 'none'",
    "frame-ancestors 'none'",
    'upgrade-insecure-requests'
  ].join('; ');

  return `/*
  Content-Security-Policy: ${contentSecurityPolicy}
  Referrer-Policy: strict-origin-when-cross-origin
  X-Content-Type-Options: nosniff
  X-Frame-Options: DENY
  Permissions-Policy: camera=(), microphone=(), geolocation=(), payment=()
  Cross-Origin-Opener-Policy: same-origin
  X-Robots-Tag: noindex, nofollow, noarchive
`;
}
