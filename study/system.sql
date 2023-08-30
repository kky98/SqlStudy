-- 주석 ctrl + / 
-- 계정 만들기 (oracle 11g 이후 계정명에 ## 을 붙여야함.)
-- 예전 스타일로 계정만들기 위해 아래 스크립트를 실행야함.
ALTER SESSION SET "_ORACLE_SCRIPT"=true; 
-- 실행문은 ; <--단위로 인식함.
-- 실행은 ctrl + enter or 위에 버튼 
-- 사용자명 :java , 비밀번호 : oracle
CREATE USER java IDENTIFIED BY oracle;
-- 권한 설정
GRANT CONNECT, RESOURCE TO java;
-- 테이블 스페이스 접근 권한 
GRANT UNLIMITED TABLESPACE TO java;


-- 계정생성 후 데이터 imp 
-- 이후 java/oracle로 접속

