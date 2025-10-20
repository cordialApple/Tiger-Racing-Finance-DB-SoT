create table public.purchase_request (
  id uuid not null default gen_random_uuid (),
  status public.purchase_status null,
  requester uuid null default auth.uid (),
  created_at timestamp with time zone not null default now(),
  updated_at timestamp without time zone null default now(),
  constraint purchase_request_pkey1 primary key (id),
  constraint purchase_request_requester_fkey1 foreign KEY (requester) references users (id)
) TABLESPACE pg_default;