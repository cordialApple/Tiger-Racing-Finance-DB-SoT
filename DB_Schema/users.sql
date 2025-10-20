create table public.users (
  id uuid not null default gen_random_uuid (),
  name text not null default ''::text,
  email text null default ''::text,
  password_hash text null,
  lsu_email text not null default ''::text,
  eight_nine bigint not null,
  hazing_status boolean not null default false,
  fee_status boolean not null default false,
  grad_date date null,
  shirt_size text null,
  system text null,
  subsystem text null,
  created_at timestamp without time zone not null default now(),
  updated_at timestamp without time zone null default now(),
  constraint user_pkey primary key (id)
) TABLESPACE pg_default;