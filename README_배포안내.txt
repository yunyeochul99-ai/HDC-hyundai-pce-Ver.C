HDC현대PCE 설비보전 통합관리 VER.C — 배포 안내
대상 사이트: https://hdc-hyundai-pce-ver-c.netlify.app/

1. 기존 Supabase SQL/데이터를 백업하세요. 기존 서버는 변경하지 않았습니다.
2. Supabase SQL Editor에서 supabase_work_orders.sql 실행. 기존 profiles 테이블(id, approved, is_admin)이 필요합니다.
3. 압축을 풀고 내부 파일 7개(index.html, workorders.js, sw.js, manifest.webmanifest, icon-192.png, icon-512.png, logo.png)를 Netlify 사이트에 배포하세요. ZIP 자체를 업로드할 때에는 ZIP 최상위에 위 파일들이 있어야 합니다.
4. 로그인 후 관리자 승인된 계정으로 작업지시서 등록/서버 동기화 테스트. 기존 점검 기록도 확인하세요.
5. 작업지시서 사진은 현재 브라우저 로컬 저장만 지원합니다. 다른 사용자에게 공유되지 않으며, 브라우저 데이터 삭제 시 사라집니다. 사진 공유 기능은 별도 Storage 권한 설계가 필요합니다.
6. 서버 연결은 기존 Supabase 프로젝트를 사용합니다. Netlify 주소 변경은 DB 프로젝트 이전을 의미하지 않습니다.
7. 서버 동기화는 마지막 저장본 병합 방식으로, 동일 작업의 동시 수정 충돌 해결은 지원하지 않습니다. 현장 운영 전 다중 사용자 시험 필수.
8. 실제 사이트 배포 및 로그인 실사용 테스트는 수행하지 않았습니다. 기존 SQL 원본 미제공으로 기존 profiles 정책과의 완전 호환성은 배포 전 확인해야 합니다.
