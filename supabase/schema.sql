create table if not exists public.leads (
  id bigint generated always as identity primary key,
  lead_id text unique not null,
  name text, email text, phone text, business text, message text,
  source text, service text, score int, urgency text, budget_signal text,
  spam boolean default false, summary text, next_step text,
  hubspot_contact_id text, model text,
  input_tokens int, output_tokens int, trace_id text,
  received_at timestamptz, created_at timestamptz default now()
);

alter table public.leads enable row level security;

create index if not exists leads_score_idx on public.leads (score desc, received_at desc);

-- Weekly review: select * from hot_leads;
create or replace view public.hot_leads as
  select * from public.leads where spam = false and score >= 7 order by received_at desc;

-- Needed when "automatically expose new tables" is off in Supabase Data API settings.
grant usage on schema public to service_role;
grant all on public.leads to service_role;
grant all on public.hot_leads to service_role;
grant usage, select on all sequences in schema public to service_role;
