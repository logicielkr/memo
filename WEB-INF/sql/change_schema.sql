CREATE SCHEMA memo;
ALTER TABLE memo SET SCHEMA memo;
ALTER TABLE memo_history SET SCHEMA memo;
alter SEQUENCE "memo$memo_id" SET SCHEMA memo;
alter SEQUENCE "memo_history$memo_history_id" SET SCHEMA memo;
alter table memo.memo alter column memo_id set default nextval('memo.memo$memo_id'::regclass);
alter table memo.memo_history alter column memo_history_id set default nextval('memo.memo_history$memo_history_id'::regclass);

