# 시스템 환경 및 설치요령

## 1. 개요

몇 가지 전제가 있다.

- PostgreSQL, Apache Tomcat 은 이미 설치되어 있다고 가정하고, 데이타베이스 연결 설정까지는 이미 완료되어 있는 것으로 가정한다.
- 메모장이 사용하는 라이브러리 등은 사용한 라이브러리 혹은 프로그램은 사용한 라이브러리 혹은 프로그램 에 나열되어 있다.  다만, 메모장 프로그램은 대부분 CDN을 사용하기 때문에 인터넷이 연결되어 있다면 별도로 설치할 필요는 없다.

## 2. 시스템 요구사항

### 2.1. 서버용 소프트웨어에 대한 요구사항

- Apache Tomcat 7.x 이상
- PostgreSQL 9.1.4 이상

### 2.2. 서버 locale 에 대한 요구사항

- Apache Tomcat 은 locale(file.encoding) 과 무관하게 동작하지만, UTF-8을 권장한다.
- 시스템의 기본 locale 은 UTF-8(ko_KR.UTF-8)을 권장한다.
- PostgreSQL 데이타베이스는 UTF-8 로 생성되어야 한다.

## 3. 설치 전 확인 사항

PostgreSQL 데이타베이스에 jdbc/graha_sample 라는 JNDI 이름으로 접속할 수 있도록 설정되어 있어야 한다.

JNDI 이름을 다르게 사용하려먼 webapps/memo/WEB-INF/graha/memo.xml 파일의 4번째 줄을 적당히 변경해야 한다.

```xml
<jndi name="jdbc/graha_sample" />
```

## 4. 설치 (war 파일을 이용하는 방법)

### 4.1. 메모장 프로그램 다운로드 및 압축 해제

먼저 [GitHub](https://github.com/logicielkr/memo) 혹은 [Graha 홈페이지](https://graha.kr) 에서 메모장 프로그램 배포판 중 graha-memo.0.9.0.0.war 파일을 다운로드 받아 Apache Tomcat 의 webapps 디렉토리에 압축을 해제한다.

> Apache Tomcat 10.x 를 사용하는 경우 graha-memo.0.9.0.0-tomcat10.war 파일을 다운로드 한다.

Linux 계열에서는 다음과 같다.

```bash
# cd webapps
# mkdir memo
# jar xvf graha-memo.0.9.0.0.war
```

web.xml은 Apache Tomcat 8.x를 위한 것이다.

WEB-INF 디렉토리 아래에는 Apache Tomcat 버전에 맞는 web.xml 파일들이 있으므로 Apache Tomcat 7.x 나 9.x 를 사용하는 경우  web.xml 파일을 적당한 파일로 덮어쓴다.

war 파일을 webapps 디렉토리에 옮겨놓고 Apache Tomcat 을 재기동하면 war 압축이 자동으로 풀리기 때문에, graha-memo.0.9.0.0.war 파일을 memo.war 로 파일이름으로 변경하고, 그냥 war 파일을 쓰는 방법도 있다.

> 다만 이 방법은 Apache Tomcat 8.x, 10.x 가 아닌 경우 war 파일을 다시 패키징해야 하고, memo 디렉토리 아래의 파일을 수정하면 Apache Tomcat 이 다시 기동될 때 초기화 된다는 것에 주의해야 한다.

## 5. 테이블 생성 및 설치 마무리

### 5.1. 테이블 생성

webapps/memo/WEB-INF/sql 디렉토리 아래에서 ddl_table_postgresql.sql 파일을 열어 테이블을 생성한다.

명령행 유틸리티가 익숙치 않고, pgadmin과 같은 그래픽 기반의 Query 실행기를 사용하지 않는다면, Graha 라이브러리에서 제공하는 SQL 실행기를 사용할 수 있고, 웹브라우저에서 다음과 같은 형식의 URL을 호출하면 된다.

> http://localhost:8080/memo/graha-manager/query

### 5.2. 설치 확인 및 테스트

변경사항을 반영하기 위한 가장 확실한 방법은 Apache Tomcat을 재기돟하는 것이다.

다음은 웹브라우저에서 다음과 같은 형식의 URL을 호출한다.

> http://localhost:8080/memo/graha/memo/list.html

### 5.3. 설치 완료 및 마무리

만약 인터넷망에서 사용할 계획이면 Graha Manager 를 사용할 수 없도록 변경해야 한다.

web.xml 파일에서 다음과 같은 부분을 주석으로 막고, Apache Tomcat 을 재시작한다.

```xml
	<servlet>
	    <servlet-name>GrahaManagerServlet</servlet-name>
	    <servlet-class>kr.graha.assistant.Manager</servlet-class>
	    <init-param>
	        <param-name>jndi</param-name>
	        <param-value>jdbc/graha_sample</param-value>
	    </init-param>
	</servlet>
	<servlet-mapping>
	    <servlet-name>GrahaManagerServlet</servlet-name>
	    <url-pattern>/graha-manager/*</url-pattern>
	</servlet-mapping>
```

## 6. 설치 (tar.gz 파일을 이용하는 방법)

### 6.1. 메모장 프로그램 다운로드 및 압축 해제

먼저 [GitHub](https://github.com/logicielkr/memo) 혹은 [Graha 홈페이지](https://graha.kr) 에서 메모장 프로그램을 다운로드 받는다.

다음은 Apache Tomcat 의 webapps 디렉토리에서 memo 라는 이름의 디렉토리를 만들고, 그 안에 다운로드 받은 메모장 프로그램의 압축을 해제한다.  리눅스 계열에서 다음과 같다.

```bash
# cd webapps
# mkdir memo
# tar xvfz graha-memo.0.9.0.0.tar.gz
```
### 6.2. 필수 라이브러리 다운로드

webapps/memo/WEB-INF 디렉토리 아래에 lib 라는 디렉토리를 만들고 Graha, Apache Commons FileUpload, Apache Commons IO 라이브러리를 각각 다운로드 받는다.  각각의 라이브러리는 다음의 위치에서 다운로드 받을 수 있다.

- Graha : http://graha.kr/
- Apache Commons IO : http://commons.apache.org/proper/commons-io/
- Apache Commons FileUpload : https://commons.apache.org/proper/commons-fileupload/

다운로드 할 때 주의사항은 다음과 같다.

- Graha 라이브러리는 빠르게 변화하고 있으므로 최신 버전을 다운로드 받는다.

### 6.3. web.xml 파일 복사

webapps/memo/WEB-INF 디렉토리 아래에 여러 개의 web.xml 파일이 있다.

Apache Tomcat 버전에 따라 적당한 파일을 web.xml 로 복사한다.
