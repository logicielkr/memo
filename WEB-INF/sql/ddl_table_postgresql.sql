CREATE SCHEMA memo;

CREATE SEQUENCE memo."memo$memo_id"; 

create table memo.memo (
	memo_id integer NOT NULL DEFAULT nextval('memo.memo$memo_id'::regclass),
	title varchar(1000),
	contents text,
	marked bool,
	encrypted bool,
	parent_id integer,
	insert_date timestamp,
	insert_id varchar(50),
	insert_ip varchar(15),
	update_date timestamp,
	update_id varchar(50),
	update_ip varchar(15),
	PRIMARY KEY (memo_id)
);

/**
like 검색 성능 향상
*/
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX "memo$title" ON memo.memo USING gin (title gin_trgm_ops);
CREATE INDEX "memo$contents" ON memo.memo USING gin (contents gin_trgm_ops);

comment on table memo.memo is '메모';

COMMENT ON COLUMN memo.memo.memo_id IS '고유번호';
COMMENT ON COLUMN memo.memo.title IS '제목';
COMMENT ON COLUMN memo.memo.contents IS '내용';
COMMENT ON COLUMN memo.memo.marked IS '마크다운';
COMMENT ON COLUMN memo.memo.encrypted IS '암호화';
COMMENT ON COLUMN memo.memo.parent_id IS '상위 메모 고유번호';
COMMENT ON COLUMN memo.memo.insert_date IS '최초입력일시';
COMMENT ON COLUMN memo.memo.insert_id IS '최초입력자ID';
COMMENT ON COLUMN memo.memo.insert_ip IS '최초입력자IP';
COMMENT ON COLUMN memo.memo.update_date IS '최종수정일시';
COMMENT ON COLUMN memo.memo.update_id IS '최종수정자ID';
COMMENT ON COLUMN memo.memo.update_ip IS '최종수정자IP';

CREATE SEQUENCE memo."memo_history$memo_history_id";

create table memo.memo_history (
	memo_history_id integer NOT NULL DEFAULT nextval('memo.memo_history$memo_history_id'::regclass),
	title varchar(1000),
	contents text,
	marked bool,
	encrypted bool,
	parent_id integer,
	memo_id integer,
	autosave bool,
	insert_date timestamp,
	insert_id varchar(50),
	insert_ip varchar(15),
	update_date timestamp,                   
	update_id varchar(50),
	update_ip varchar(15),
	PRIMARY KEY (memo_history_id)
);

comment on table memo.memo_history is '메모 이력관리';

COMMENT ON COLUMN memo.memo_history.memo_history_id IS '고유번호';
COMMENT ON COLUMN memo.memo_history.title IS '제목';
COMMENT ON COLUMN memo.memo_history.contents IS '내용';
COMMENT ON COLUMN memo.memo_history.marked IS '마크다운';
COMMENT ON COLUMN memo.memo_history.encrypted IS '암호화';
COMMENT ON COLUMN memo.memo_history.parent_id IS '상위 메모 고유번호';
COMMENT ON COLUMN memo.memo_history.memo_id IS '메모ID';
COMMENT ON COLUMN memo.memo_history.autosave IS '자동저장';
COMMENT ON COLUMN memo.memo_history.insert_date IS '최초입력일시';
COMMENT ON COLUMN memo.memo_history.insert_id IS '최초입력자ID';
COMMENT ON COLUMN memo.memo_history.insert_ip IS '최초입력자IP';
COMMENT ON COLUMN memo.memo_history.update_date IS '최종수정일시';
COMMENT ON COLUMN memo.memo_history.update_id IS '최종수정자ID';
COMMENT ON COLUMN memo.memo_history.update_ip IS '최종수정자IP';

