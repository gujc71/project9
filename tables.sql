DROP TABLE COM_CODE;

CREATE TABLE COM_CODE(
  CLASSNO 	INT(11),				-- 대분류
  CODECD 	VARCHAR(10),			-- 코드
  CODENM 	VARCHAR(30),			-- 코드명
  PRIMARY KEY (CLASSNO, CODECD)
) ;

DROP TABLE COM_DEPT;

CREATE TABLE COM_DEPT(
  DEPTNO 	INT(11),   				-- 부서 번호
  DEPTNM 	VARCHAR(20),            -- 부서명
  PARENTNO  INT(11),                -- 부모 부서
  DELETEFLAG CHAR(1),    	        -- 삭제 여부
  PRIMARY KEY (DEPTNO)
) ;


DROP TABLE COM_USER;

CREATE TABLE COM_USER(
  USERNO 	INT(11) NOT NULL AUTO_INCREMENT,	-- 사용자 번호
  USERID 	VARCHAR(20),                    	-- ID
  USERNM 	VARCHAR(20),                    	-- 이름
  USERPW 	VARCHAR(100),                    	-- 비밀번호
  USERROLE	CHAR(1),                    		-- 권한
  PHOTO 	VARCHAR(50),                   		-- 사진
  DEPTNO	INT,
  DELETEFLAG CHAR(1),    	                 	-- 삭제 여부
  PRIMARY KEY (USERNO)
) ;

/*------------------------------------------*/

DROP TABLE TBL_BOARD;

CREATE TABLE TBL_BOARD (
  BGNO INT(11),                             -- 게시판 그룹번호
  BRDNO INT(11) NOT NULL AUTO_INCREMENT,    -- 글 번호
  BRDTITLE VARCHAR(255),                    -- 글 제목
  USERNO 	INT,                    		-- 작성자
  BRDMEMO   MEDIUMTEXT,		                -- 글 내용
  BRDDATE   DATETIME,                       -- 작성일자
  LASTDATE  DATETIME, 
  LASTUSERNO  INT, 
  BRDDELETEFLAG CHAR(1),                     -- 삭제 여부
  PRIMARY KEY (BRDNO)
) ;

DROP TABLE TBL_BOARDFILE;

CREATE TABLE TBL_BOARDFILE (
    FILENO INT(11)  NOT NULL AUTO_INCREMENT, -- 파일 번호
    BRDNO INT(11),                           -- 글번호
    FILENAME VARCHAR(100),                   -- 파일명
    REALNAME VARCHAR(30),                    -- 실제파일명
    FILESIZE INT,                            -- 파일 크기
    PRIMARY KEY (FILENO)
);

DROP TABLE TBL_BOARDREPLY;

CREATE TABLE TBL_BOARDREPLY (
    BRDNO INT(11) NOT NULL,                 -- 게시물 번호
    RENO INT(11) NOT NULL,                  -- 댓글 번호
	USERNO 	INT,                    		-- 작성자
    REMEMO VARCHAR(500) DEFAULT NULL,       -- 댓글내용
	REPARENT INT(11),						-- 부모 댓글
	REDEPTH INT,							-- 깊이
	REORDER INT,							-- 순서
    REDATE DATETIME DEFAULT NULL,           -- 작성일자
    REDELETEFLAG VARCHAR(1) NOT NULL,       -- 삭제여부
	LASTDATE  DATETIME, 
    LASTUSERNO  INT, 

    PRIMARY KEY (RENO)
);

DROP TABLE TBL_BOARDREAD;

CREATE TABLE TBL_BOARDREAD (
	BRDNO INT(11) NOT NULL,                  -- 게시물 번호
	USERNO 	INT,          			     		-- 작성자
	READDATE DATETIME,
	PRIMARY KEY (BRDNO, USERNO)
);


DROP TABLE TBL_BOARDGROUP;

CREATE TABLE TBL_BOARDGROUP (
  BGNO INT(11) NOT NULL AUTO_INCREMENT,     -- 게시판 그룹번호
  BGNAME VARCHAR(50),                       -- 게시판 그룹명
  BGPARENT INT(11),                         -- 게시판 그룹 부모
  BGDELETEFLAG CHAR(1),                     -- 삭제 여부
  BGUSED CHAR(1),                           -- 사용 여부
  BGREPLY CHAR(1),                          -- 댓글 사용여부
  BGREADONLY CHAR(1),                       -- 글쓰기 가능 여부
  BGDATE DATETIME,                          -- 생성일자
  PRIMARY KEY (BGNO)
);


