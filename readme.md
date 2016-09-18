## Spring 4 + MyBatis 3 + MariaDB 기반 웹 프로젝트 템플릿 ##
본 샘플은  Spring 4 + MyBatis 3 + MariaDB (Maven) 기반으로  제작한 웹 프로젝트 템플릿이다.

웹 개발시 많이 사용되는 다양한 기능들 미리 구현해 두고 복사해서 사용하기 위해 제작하였다.

좀더 자세한 설명은 [여기](http://forest71.tistory.com/78)에서 얻을 수 있고,

데모는 [여기](http://52.78.20.235/project9/)에서 확인할 수 있다.

데모는 AWS 무료를 사용하는 관계로  1년(2017-09-17) 이후에는 접속이 안될 수 있고

작성한 데이터는 통보없이 삭제될 수 있다.

### 주요 구현 기능 ###
- 멀티 게시판 (무한 댓글, 좋아요 등)
- 회원 기능: 모든 페이지는 회원만 접속 가능. 로그인/로그 아웃 기능 (로그 저장). 회원관리 등
- 보안 기능: 일반사용자(U)와 관리자(A)로 구분하여 일반 사용자는 관리자 페이지에 접근 불가.
- 사용자 선택: 부서, 사용자 선택 기능 (팝업)
- 날짜 선택 및 챠트 사용법 샘플
- 엑셀 다운로드(jXLS) 샘플
- 다국어 처리
- 디자인: 부트스트랩기반 반응형 웹 적용 (SB-Admin)
- 공통 에러 페이지 처리(404, 500)
- 로그 처리(logback, log4jdbc)

### 주요 LIB  ###
- JQuery-2.2.3
- CKEditor 4.5.10 
- SB-Admin 2, morris v0.5.0, DatePicker
- DynaTree 1.2.4


### 개발 환경 ###
    Programming Language - Java 1.7
    IDE - Eclipse
    DB - MariaDB 
    Framework - MyBatis, Spring 4
    Build Tool - Maven

### 설치 ###
- MariaDB에 데이터 베이스(project9)를 생성하고 tables.sql, tableData.sql를 실행하여 테이블과 데이터를 생성한다.
- applicationContext.xml에 적절한 접속 정보를 입력한다.
- 톰캣이나 이클립스에서 project9를 실행
- http://localhost:8080/project9/로 접속
- ID/PW: admin/admin, user1/user1, user2/user2 ...

### License ###
MIT
  
  