## Spring 4 + MyBatis 3 + MariaDB 기반 웹 프로젝트 템플릿 ##
본 샘플은  Spring 4 + MyBatis 3 + MariaDB (Maven) 기반으로  웹 프로젝트 템플릿이다.

웹 개발시 많이 사용되는 다양한 기능들 미리 구현해 두고 복사해서 사용하기 위해 제작하였다.

## 주요 구현 기능은 다음과 같다.## 
- 회원 기능: 모든 페이지는 회원만 접속 가능. 로그인/로그 아웃 기능. 회원관리 등 
- 보안 기능: 일반사용자(U)와 관리자로 구분하여 일반 사용자는 관리자 페이지에 접근 불가.
- 파일 첨부: 게시판 예제
- 사용자 선택: 부서, 사용자 선택 기능 (팝업)
- 다국어 처리
- 디자인: SB-Admin으로 반응형 웹 적용


## 설치 ## 
- MariaDB에 데이터 베이스(project9)를 생성하고 tables.sql, tableData.sql를 실행하여 테이블과 데이터를 생성한다.
- applicationContext.xml에 적절한 접속 정보를 입력한다.
- 톰캣이나 이클립스에서 project9를 실행
- http://localhost:8080/project9/로 접속
- ID/PW: admin/admin 