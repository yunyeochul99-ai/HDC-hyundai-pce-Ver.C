-- 작업지시서 서버 연동을 위한 별도 테이블 (모듈 v1은 로컬 저장만 수행)
create table if not exists public.maintenance_work_orders (
 id text primary key,
 equipment text not null,
 type text not null default '고장수리',
 priority text not null default '보통',
 status text not null default '접수',
 assignee text,
 due date,
 started timestamptz,
 finished timestamptz,
 description text not null,
 safety text,
 result text,
 parts text,
 reviewer text,
 photo_paths jsonb not null default '[]'::jsonb,
 created_by uuid not null default auth.uid(),
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now(),
 constraint work_status check(status in ('접수','배정','진행중','보류','완료','재작업')),
 constraint work_priority check(priority in ('낮음','보통','긴급')),
 constraint work_completion check(status <> '완료' or (nullif(trim(result),'') is not null and nullif(trim(reviewer),'') is not null))
);
alter table public.maintenance_work_orders enable row level security;
-- 기존 profiles의 approved/is_admin 필드를 사용. 읽기는 승인자, 쓰기는 작성자 또는 관리자.
drop policy if exists "approved_read_work_orders" on public.maintenance_work_orders;
create policy "approved_read_work_orders" on public.maintenance_work_orders for select to authenticated
 using (exists(select 1 from public.profiles p where p.id=auth.uid() and p.approved=true));
drop policy if exists "approved_create_work_orders" on public.maintenance_work_orders;
create policy "approved_create_work_orders" on public.maintenance_work_orders for insert to authenticated
 with check(created_by=auth.uid() and exists(select 1 from public.profiles p where p.id=auth.uid() and p.approved=true));
drop policy if exists "owner_admin_update_work_orders" on public.maintenance_work_orders;
create policy "owner_admin_update_work_orders" on public.maintenance_work_orders for update to authenticated
 using(exists(select 1 from public.profiles p where p.id=auth.uid() and p.approved=true and (maintenance_work_orders.created_by=auth.uid() or p.is_admin=true)))
 with check(exists(select 1 from public.profiles p where p.id=auth.uid() and p.approved=true and (maintenance_work_orders.created_by=auth.uid() or p.is_admin=true)));
drop policy if exists "admin_delete_work_orders" on public.maintenance_work_orders;
create policy "admin_delete_work_orders" on public.maintenance_work_orders for delete to authenticated
 using(exists(select 1 from public.profiles p where p.id=auth.uid() and p.approved=true and p.is_admin=true));
