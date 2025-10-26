-- Create a sample table for test
create table if not exists public.sample_table (
  id uuid not null default gen_random_uuid(),
  name text not null,
  age int,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone default now(),
  constraint sample_table_pkey primary key (id)
) tablespace pg_default;