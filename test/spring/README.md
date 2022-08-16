# Spring Boot 2.7.2

### build.gradle

```groovy
dependencies {
	implementation 'org.springframework.boot:spring-boot-starter'
	implementation 'org.springframework.boot:spring-boot-starter-security'
	implementation 'org.springframework.boot:spring-boot-starter-web'
	implementation 'org.springframework.boot:spring-boot-starter-jdbc'
	implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
	implementation 'org.mariadb.jdbc:mariadb-java-client:3.0.6'
	implementation 'io.jsonwebtoken:jjwt:0.9.1'

	testImplementation 'org.springframework.boot:spring-boot-starter-test'

//    spring-boot-starter-aop
//    Starter for aspect-oriented programming with Spring AOP and AspectJ

//    spring-boot-starter-batch
//    Starter for using Spring Batch

//    spring-boot-starter-data-redis
//    Starter for using Redis key-value data store with Spring Data Redis and the Lettuce client

//    spring-boot-starter-json
//    Starter for reading and writing json
    
//    spring-boot-starter-mail
//    Starter for using Java Mail and Spring Framework’s email sending support

//    spring-boot-starter-oauth2-client
//    Starter for using Spring Security’s OAuth2/OpenID Connect client features

//    spring-boot-starter-validation
//    Starter for using Java Bean Validation with Hibernate Validator
    
//    spring-boot-starter-webflux
//    Starter for building WebFlux applications using Spring Framework’s Reactive Web support
}
```

**참조:**
[스프링 공식 문서](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#using.build-systems.starters)

**적용 내역**

| 이름                            | 설명                                                                                                                        |
|-------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| spring-boot-starter           | Core starter, including auto-configuration support, logging and YAML                                                      |
| spring-boot-starter-security  | Starter for using Spring Security                                                                                         |
| spring-boot-starter-web       | Starter for building web, including RESTful, applications using Spring MVC. Uses Tomcat as the default embedded container |
| spring-boot-starter-data-jdbc | Starter for using Spring Data JDBC                                                                                        |
| spring-boot-starter-data-jpa  | Starter for using Spring Data JPA with Hibernate                                                                          |
| mariadb-java-client           | mariadb                                                                                                                   |
| jjwt                          | json web token                                                                                                            |
