export async function translateZhToVi(text: string): Promise<string> {
  if (!text || typeof text !== 'string') return '';

  const url = `https://translate.googleapis.com/translate_a/single?client=gtx&sl=zh-CN&tl=vi&dt=t&q=${encodeURIComponent(
    text,
  )}`;

  const res = await fetch(url, { cache: 'no-store' });
  if (!res.ok) {
    throw new Error(`Translate request failed with status ${res.status}`);
  }
  const data = await res.json();
  const chunks: any[] = Array.isArray(data?.[0]) ? data[0] : [];
  const joined = chunks.map((c) => (Array.isArray(c) ? c[0] : '')).join('');
  return joined.trim();
}

export async function translateEnToVi(text: string): Promise<string> {
  if (!text || typeof text !== 'string') return '';
  const url = `https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=vi&dt=t&q=${encodeURIComponent(
    text,
  )}`;
  const res = await fetch(url, { cache: 'no-store' });
  if (!res.ok) return '';
  const data = await res.json();
  const chunks: any[] = Array.isArray(data?.[0]) ? data[0] : [];
  const joined = chunks.map((c) => (Array.isArray(c) ? c[0] : '')).join('');
  return joined.trim();
}
