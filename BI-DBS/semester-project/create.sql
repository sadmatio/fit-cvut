CREATE TABLE ADDRESS
  (
    ADDRESS_ID           INTEGER NOT NULL ,
    STATE                VARCHAR2 (50 CHAR) NOT NULL ,
    CITY                 VARCHAR2 (50 CHAR) NOT NULL ,
    STREET_ADDRESS_LINE1 VARCHAR2 (50 CHAR) NOT NULL ,
    STREET_ADDRESS_LINE2 VARCHAR2 (50 CHAR) ,
    POSTAL_CODE          VARCHAR2 (15 CHAR) NOT NULL ,
    COMPANY_ID           INTEGER NOT NULL
  ) ;
CREATE UNIQUE INDEX ADDRESS__IDX ON ADDRESS
  (
    COMPANY_ID ASC
  )
  ;
ALTER TABLE ADDRESS ADD CONSTRAINT ADDRESS_PK PRIMARY KEY ( ADDRESS_ID ) ;


CREATE TABLE COMPANY
  (
    COMPANY_ID INTEGER NOT NULL ,
    NAME       CHAR (50 CHAR) NOT NULL ,
    NOTE       CHAR (150 CHAR)
  ) ;
ALTER TABLE COMPANY ADD CONSTRAINT COMPANY_PK PRIMARY KEY ( COMPANY_ID ) ;


CREATE TABLE CONTACT_PERSON
  (
    CONTACT_PERSON_ID INTEGER NOT NULL ,
    JOB_TITLE         VARCHAR2 (50 CHAR) NOT NULL ,
    COMPANY_ID        INTEGER
  ) ;
CREATE UNIQUE INDEX CONTACT_PERSON__IDX ON CONTACT_PERSON
  (
    COMPANY_ID ASC
  )
  ;
ALTER TABLE CONTACT_PERSON ADD CONSTRAINT CONTACT_PERSON_PK PRIMARY KEY ( CONTACT_PERSON_ID ) ;


CREATE TABLE CONTRACT
  (
    CONTRACT_ID           INTEGER NOT NULL ,
    NAME                  CHAR (300 CHAR) NOT NULL ,
    DESCRIPTION           VARCHAR2 (2000 CHAR) ,
    DATE_ADDED            DATE NOT NULL ,
    COMPANY_ID            INTEGER NOT NULL ,
    FINANCIAL_CATEGORY_ID INTEGER NOT NULL ,
    EMPLOYEE_ID           INTEGER NOT NULL
  ) ;
ALTER TABLE CONTRACT ADD CONSTRAINT CONTRACT_PK PRIMARY KEY ( CONTRACT_ID ) ;


CREATE TABLE EMPLOYEE
  (
    EMPLOYEE_ID     INTEGER NOT NULL ,
    PERSONAL_NUMBER VARCHAR2 (50 CHAR) NOT NULL
  ) ;
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_PK PRIMARY KEY ( EMPLOYEE_ID ) ;


CREATE TABLE FINANCIAL_CATEGORY
  (
    FINANCIAL_CATEGORY_ID INTEGER NOT NULL ,
    LABEL                 VARCHAR2 (50 CHAR) NOT NULL
  ) ;
ALTER TABLE FINANCIAL_CATEGORY ADD CONSTRAINT FINANCIAL_CATEGORY_PK PRIMARY KEY ( FINANCIAL_CATEGORY_ID ) ;


CREATE TABLE PERSON
  (
    PERSON_ID         INTEGER NOT NULL ,
    LAST_NAME         VARCHAR2 (50 CHAR) NOT NULL ,
    FIRST_NAME        VARCHAR2 (50 CHAR) NOT NULL ,
    EMAIL             VARCHAR2 (50 CHAR) ,
    PHONE             VARCHAR2 (25 CHAR) NOT NULL ,
    EMPLOYEE_ID       INTEGER ,
    CONTACT_PERSON_ID INTEGER
  ) ;
ALTER TABLE PERSON ADD CONSTRAINT FKArc_1 CHECK ( ( (EMPLOYEE_ID IS NOT NULL) AND (CONTACT_PERSON_ID IS NULL) ) OR ( (CONTACT_PERSON_ID IS NOT NULL) AND (EMPLOYEE_ID IS NULL) ) ) ;
ALTER TABLE PERSON ADD CONSTRAINT PERSON_PK PRIMARY KEY ( PERSON_ID ) ;


CREATE TABLE PROJECT
  (
    NAME        VARCHAR2 (300 CHAR) NOT NULL ,
    START_DATE  DATE NOT NULL ,
    END_DATE    DATE ,
    COST        NUMBER (12,2) NOT NULL ,
    CONTRACT_ID INTEGER NOT NULL ,
    EMPLOYEE_ID INTEGER NOT NULL
  ) ;
CREATE UNIQUE INDEX PROJECT__IDX ON PROJECT
  (
    CONTRACT_ID ASC
  )
  ;
ALTER TABLE PROJECT ADD CONSTRAINT PROJECT_PK PRIMARY KEY ( CONTRACT_ID, NAME ) ;


CREATE TABLE PROJECT_REALIZATION
  (
    CONTRACT_ID INTEGER NOT NULL ,
    NAME        VARCHAR2 (300 CHAR) NOT NULL ,
    EMPLOYEE_ID INTEGER NOT NULL
  ) ;
ALTER TABLE PROJECT_REALIZATION ADD CONSTRAINT PROJECT_REALIZATION_PK PRIMARY KEY ( CONTRACT_ID, NAME, EMPLOYEE_ID ) ;


CREATE TABLE TECHNOLOGY
  (
    TECHNOLOGY_ID INTEGER NOT NULL ,
    LABEL         VARCHAR2 (50 CHAR) NOT NULL
  ) ;
ALTER TABLE TECHNOLOGY ADD CONSTRAINT TECHNOLOGY_PK PRIMARY KEY ( TECHNOLOGY_ID ) ;


CREATE TABLE USED_TECHNOLOGIES
  (
    CONTRACT_ID   INTEGER NOT NULL ,
    TECHNOLOGY_ID INTEGER NOT NULL
  ) ;
ALTER TABLE USED_TECHNOLOGIES ADD CONSTRAINT USED_TECHNOLOGIES_PK PRIMARY KEY ( CONTRACT_ID, TECHNOLOGY_ID ) ;


ALTER TABLE ADDRESS ADD CONSTRAINT ADDRESS_COMPANY_FK FOREIGN KEY ( COMPANY_ID ) REFERENCES COMPANY ( COMPANY_ID ) ON DELETE CASCADE;

ALTER TABLE CONTACT_PERSON ADD CONSTRAINT CONTACT_PERSON_COMPANY_FK FOREIGN KEY ( COMPANY_ID ) REFERENCES COMPANY ( COMPANY_ID ) ON DELETE CASCADE;

ALTER TABLE CONTRACT ADD CONSTRAINT CONTRACT_COMPANY_FK FOREIGN KEY ( COMPANY_ID ) REFERENCES COMPANY ( COMPANY_ID ) ON DELETE CASCADE;

ALTER TABLE CONTRACT ADD CONSTRAINT CONTRACT_EMPLOYEE_FK FOREIGN KEY ( EMPLOYEE_ID ) REFERENCES EMPLOYEE ( EMPLOYEE_ID ) ON DELETE CASCADE ;

ALTER TABLE CONTRACT ADD CONSTRAINT CONTRACT_FINANCIAL_CATEGORY_FK FOREIGN KEY ( FINANCIAL_CATEGORY_ID ) REFERENCES FINANCIAL_CATEGORY ( FINANCIAL_CATEGORY_ID ) ON DELETE CASCADE ;

ALTER TABLE PROJECT_REALIZATION ADD CONSTRAINT FK_ASS_3 FOREIGN KEY ( CONTRACT_ID, NAME ) REFERENCES PROJECT ( CONTRACT_ID, NAME ) ON DELETE CASCADE ;

ALTER TABLE PROJECT_REALIZATION ADD CONSTRAINT FK_ASS_4 FOREIGN KEY ( EMPLOYEE_ID ) REFERENCES EMPLOYEE ( EMPLOYEE_ID ) ON DELETE CASCADE ;

ALTER TABLE USED_TECHNOLOGIES ADD CONSTRAINT FK_ASS_7 FOREIGN KEY ( CONTRACT_ID ) REFERENCES CONTRACT ( CONTRACT_ID ) ON DELETE CASCADE ;

ALTER TABLE USED_TECHNOLOGIES ADD CONSTRAINT FK_ASS_8 FOREIGN KEY ( TECHNOLOGY_ID ) REFERENCES TECHNOLOGY ( TECHNOLOGY_ID ) ON DELETE CASCADE;

ALTER TABLE PERSON ADD CONSTRAINT PERSON_CONTACT_PERSON_FK FOREIGN KEY ( CONTACT_PERSON_ID ) REFERENCES CONTACT_PERSON ( CONTACT_PERSON_ID ) ON DELETE CASCADE ;

ALTER TABLE PERSON ADD CONSTRAINT PERSON_EMPLOYEE_FK FOREIGN KEY ( EMPLOYEE_ID ) REFERENCES EMPLOYEE ( EMPLOYEE_ID ) ON DELETE CASCADE ;

ALTER TABLE PROJECT ADD CONSTRAINT PROJECT_CONTRACT_FK FOREIGN KEY ( CONTRACT_ID ) REFERENCES CONTRACT ( CONTRACT_ID ) ON DELETE CASCADE;

ALTER TABLE PROJECT ADD CONSTRAINT PROJECT_EMPLOYEE_FK FOREIGN KEY ( EMPLOYEE_ID ) REFERENCES EMPLOYEE ( EMPLOYEE_ID ) ON DELETE CASCADE;
