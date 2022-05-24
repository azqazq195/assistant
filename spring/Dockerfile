FROM openjdk:11
ARG JAR_FILE=build/libs/assistant-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar
RUN apt-get update
RUN apt-get install subversion
# 설정파일을 분리해서 사용할 때
# ENTRYPOINT ["java","-jar","-Dspring.profiles.active=dev","/app.jar"]
# java -jar -Dspring.profiles.active=prod app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
