-- DROP TABLE COM_CODE;

CREATE TABLE COM_CODE(
  CLASSNO 	INT(11),				-- 대분류
  CODECD 	VARCHAR(10),			-- 코드
  CODENM 	VARCHAR(30),			-- 코드명
  PRIMARY KEY (CLASSNO, CODECD)
) ;

-- DROP TABLE COM_DEPT;

CREATE TABLE COM_DEPT(
  DEPTNO 	INT(11),   				-- 부서 번호
  DEPTNM 	VARCHAR(20),            -- 부서명
  PARENTNO  INT(11),                -- 부모 부서
  DELETEFLAG CHAR(1),    	        -- 삭제 여부
  PRIMARY KEY (DEPTNO)
) ;


-- DROP TABLE COM_USER;

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

-- DROP TABLE TBL_BOARD;

CREATE TABLE TBL_BOARD (
  BGNO INT(11),                             -- 게시판 그룹번호
  BRDNO INT(11) NOT NULL AUTO_INCREMENT,    -- 글 번호
  BRDTITLE VARCHAR(255),                    -- 글 제목
  USERNO 	INT,                    		-- 작성자
  BRDMEMO   MEDIUMTEXT,		                -- 글 내용
  BRDDATE   DATETIME,                       -- 작성일자
  BRDNOTICE VARCHAR(1),                     -- 공지사항여부
  LASTDATE  DATETIME, 
  LASTUSERNO  	INT, 
  BRDLIKE 		INT default 0,             	-- 좋아요
  BRDDELETEFLAG CHAR(1),                    -- 삭제 여부
  PRIMARY KEY (BRDNO)
) ;

-- DROP TABLE TBL_BOARDFILE;

CREATE TABLE TBL_BOARDFILE (
    FILENO INT(11)  NOT NULL AUTO_INCREMENT, -- 파일 번호
    BRDNO INT(11),                           -- 글번호
    FILENAME VARCHAR(100),                   -- 파일명
    REALNAME VARCHAR(30),                    -- 실제파일명
    FILESIZE INT,                            -- 파일 크기
    PRIMARY KEY (FILENO)
);

CREATE TABLE TBL_BOARDLIKE (
    BLNO INT(11)  NOT NULL AUTO_INCREMENT,  -- 번호
    BRDNO INT(11),                          -- 글번호
	USERNO 	INT,                    		-- 작성자
	BLDATE  DATETIME, 						-- 일자
    PRIMARY KEY (BLNO)
);

-- DROP TABLE TBL_BOARDREPLY;

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

-- DROP TABLE TBL_BOARDREAD;

CREATE TABLE TBL_BOARDREAD (
	BRDNO INT(11) NOT NULL,                 -- 게시물 번호
	USERNO 	INT,          			     	-- 작성자
	READDATE DATETIME,						-- 작성일자
	PRIMARY KEY (BRDNO, USERNO)
);


-- DROP TABLE TBL_BOARDGROUP;

CREATE TABLE TBL_BOARDGROUP (
  BGNO INT(11) NOT NULL AUTO_INCREMENT,     -- 게시판 그룹번호
  BGNAME VARCHAR(50),                       -- 게시판 그룹명
  BGPARENT INT(11),                         -- 게시판 그룹 부모
  BGDELETEFLAG CHAR(1),                     -- 삭제 여부
  BGUSED CHAR(1),                           -- 사용 여부
  BGREPLY CHAR(1),                          -- 댓글 사용여부
  BGREADONLY CHAR(1),                       -- 글쓰기 가능 여부
  BGNOTICE CHAR(1),                       	-- 공지 쓰기  가능 여부
  BGDATE DATETIME,                          -- 생성일자
  PRIMARY KEY (BGNO)
);

-- DROP TABLE COM_LOGINOUT;

CREATE TABLE COM_LOGINOUT (
  LNO 		INT(11) NOT NULL AUTO_INCREMENT,    -- 순번
  USERNO 	INT,                    			-- 로그인 사용자
  LTYPE 	CHAR(1),                       		-- in / out
  LDATE 	DATETIME,                          	-- 발생일자
  PRIMARY KEY (LNO)
);

CREATE TABLE TBL_CRUD(
  CRNO INT NOT NULL AUTO_INCREMENT,	-- 번호
  CRTITLE  	VARCHAR(255),     		-- 제목
  USERNO 	INT,            		-- 작성자
  CRMEMO   	MEDIUMTEXT,				-- 내용
  CRDATE   	DATETIME,        		-- 작성일자
  CRDELETEFLAG CHAR(1),     		-- 삭제 여부
  PRIMARY KEY (CRNO)
) ;

-- DROP FUNCTION uf_datetime2string;

DELIMITER $$

CREATE FUNCTION `uf_datetime2string`(dt_ Datetime) RETURNS varchar(10) CHARSET utf8
BEGIN
	DECLARE ti INTEGER ;
	DECLARE ret_ VARCHAR(10);

	SET ti :=  TIMESTAMPDIFF(MINUTE, dt_, NOW());

      IF ti < 1 THEN SET ret_:='방금';
      ELSEIF ti < 60 THEN SET ret_:= CONCAT(TRUNCATE(ti ,0), '분전');
      ELSEIF ti < 60*24 THEN 
            IF ( DATEDIFF(NOW(), dt_)=1) THEN 
                SET ret_:= '어제';
            ELSE
                SET ret_:= CONCAT(TRUNCATE(ti/60 ,0), '시간전');
            END IF;
      ELSEIF ti < 60*24*7 THEN SET ret_:= CONCAT(TRUNCATE(ti/60/24 ,0), '일전');
      ELSEIF ti < 60*24*7*4 THEN SET ret_:= CONCAT(TRUNCATE(ti/60/24/7 ,0), '주전');
      ELSEIF (TIMESTAMPDIFF (MONTH, dt_, NOW())=1) THEN SET ret_:= '지난달';
      ELSEIF (TIMESTAMPDIFF (MONTH, dt_, NOW())<13) THEN 
            IF ( TIMESTAMPDIFF (YEAR, dt_, NOW())=1) THEN 
                SET ret_:= '작년';
            ELSE
                SET ret_:= CONCAT(TRUNCATE(TIMESTAMPDIFF (MONTH, dt_, NOW()) ,0), '달전');
            END IF;
      ELSE SET ret_:= CONCAT(TIMESTAMPDIFF (YEAR, dt_, NOW()), '년전');
      END IF;
      
RETURN ret_;
END
