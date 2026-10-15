const V='hdc-ver-c-v1-20261015';
const CORE=['./','./index.html','./workorders.js','./manifest.webmanifest','./icon-192.png','./icon-512.png','./logo.png'];
self.addEventListener('install',e=>e.waitUntil(caches.open(V).then(c=>c.addAll(CORE)).then(()=>self.skipWaiting())));
self.addEventListener('activate',e=>e.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==V).map(k=>caches.delete(k)))).then(()=>self.clients.claim())));
self.addEventListener('fetch',e=>{if(e.request.method!=='GET'||new URL(e.request.url).origin!==location.origin)return;e.respondWith(fetch(e.request).then(r=>{if(r.ok){const copy=r.clone();caches.open(V).then(c=>c.put(e.request,copy))}return r}).catch(()=>caches.match(e.request).then(r=>r|| (e.request.mode==='navigate'?caches.match('./index.html'):Response.error()))))});
