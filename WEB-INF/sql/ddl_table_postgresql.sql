CREATE SEQUENCE "memo$memo_id"; 

create table memo (
	memo_id integer NOT NULL DEFAULT nextval('memo$memo_id'::regclass),
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
CREATE EXTENSION pg_trgm;
CREATE INDEX "memo$title" ON memo USING gin (title gin_trgm_ops);
CREATE INDEX "memo$contents" ON memo USING gin (contents gin_trgm_ops);

comment on table memo is '메모';

COMMENT ON COLUMN memo.memo_id IS '고유번호';
COMMENT ON COLUMN memo.title IS '제목';
COMMENT ON COLUMN memo.contents IS '내용';
COMMENT ON COLUMN memo.marked IS '마크다운';
COMMENT ON COLUMN memo.encrypted IS '암호화';
COMMENT ON COLUMN memo.parent_id IS '상위 메모 고유번호';
COMMENT ON COLUMN memo.insert_date IS '최초입력일시';
COMMENT ON COLUMN memo.insert_id IS '최초입력자ID';
COMMENT ON COLUMN memo.insert_ip IS '최초입력자IP';
COMMENT ON COLUMN memo.update_date IS '최종수정일시';
COMMENT ON COLUMN memo.update_id IS '최종수정자ID';
COMMENT ON COLUMN memo.update_ip IS '최종수정자IP';

CREATE SEQUENCE "memo_history$memo_history_id";

create table memo_history (
	memo_history_id integer NOT NULL DEFAULT nextval('memo_history$memo_history_id'::regclass),
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

comment on table memo_history is '메모 이력관리';

COMMENT ON COLUMN memo_history.memo_history_id IS '고유번호';
COMMENT ON COLUMN memo_history.title IS '제목';
COMMENT ON COLUMN memo_history.contents IS '내용';
COMMENT ON COLUMN memo_history.marked IS '마크다운';
COMMENT ON COLUMN memo_history.encrypted IS '암호화';
COMMENT ON COLUMN memo_history.parent_id IS '상위 메모 고유번호';
COMMENT ON COLUMN memo_history.memo_id IS '메모ID';
COMMENT ON COLUMN memo_history.autosave IS '자동저장';
COMMENT ON COLUMN memo_history.insert_date IS '최초입력일시';
COMMENT ON COLUMN memo_history.insert_id IS '최초입력자ID';
COMMENT ON COLUMN memo_history.insert_ip IS '최초입력자IP';
COMMENT ON COLUMN memo_history.update_date IS '최종수정일시';
COMMENT ON COLUMN memo_history.update_id IS '최종수정자ID';
COMMENT ON COLUMN memo_history.update_ip IS '최종수정자IP';

