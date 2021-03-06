---
description: Code 화면의 각 기능들을 작업순서에 따라 설명합니다.
---

# Code

### 작업 준비

1. `mwb` 파일에서 sql을 `db-populate.sql` 혹은 `center-db-populate.sql` 에 복사해 옵니다.
2. 자신의 작업영역 이외 코드를 제거합니다.

### 프로그램 사용

![](../.gitbook/assets/assistant.gif)

#### 1. 데이터베이스 최신화

Code 화면의 우측 상단에 <mark style="color:purple;">**데이터베이스 최신화**</mark>를 클릭하여 데이터베이스를 초기화시킵니다.&#x20;

~~자신의 로컬 populate.sql과 svn에 업데이트 되어 있는 populate.sql를 모두 초기화 하게 되며, 모든 테이블 및 칼럼을 분석하기에 10초 정도 소요됩니다~~.  회사 보안 우려로 svn 연동 삭제.

자신의 로컬 populate.sql 을 모두 초기화 하여 테이블 및 칼럼을 분석합니다.

#### 2. 테이블 불러오기

데이터베이스 최신화 좌측에 CENTER or CSTTEC 테이블 불러오기를 클릭하여 각 데이터베이스의 테이블들을 불러옵니다.

#### 3. 검색

데이터베이스를 선택하여 테이블을 불러왔다면 검색창에서 테이블을 불러올 수 있습니다.

검색 후 엔터 및 자동완성된 항목 클릭으로 테이블을 세팅할 수 있습니다.

#### 4. 코드 복사

검색이 완료된 이후 중앙의 각 카드버튼을 통해 원하는 코드를 클립보드에 복사 할 수 있습니다.

## 결과물

#### Sample 데이터 베이스 스크립

![](<../.gitbook/assets/image 7.png>)

#### Domain

![](<../.gitbook/assets/image 6.png>)

#### Interface

![](<../.gitbook/assets/image 8.png>)

#### Mybatis

![](<../.gitbook/assets/image 9.png>)
