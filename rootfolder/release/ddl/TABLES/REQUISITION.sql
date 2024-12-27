CREATE TABLE VMSCMS.REQUISITION
(
  REQUISITION_ID    NUMBER(10)                  NOT NULL,
  REQUISITION_NO    VARCHAR2(20 BYTE),
  PRODUCT_CODE      VARCHAR2(20 BYTE),
  PRODUCT_NAME      VARCHAR2(20 BYTE),
  SUBCATEGORY_CODE  VARCHAR2(20 BYTE),
  SUBCATEGORY_NAME  VARCHAR2(20 BYTE),
  LOC_TYPE          VARCHAR2(20 BYTE),
  LOC_CODE          VARCHAR2(20 BYTE),
  NO_OF_CARDS       NUMBER(10),
  IS_APPROVED       CHAR(1 BYTE),
  IS_LUPD_DATE      DATE,
  IS__INST_CODE     NUMBER(10),
  IS__LUPD_USER     NUMBER(10),
  IS_INS_DATE       DATE,
  IS__INS_USER      NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.REQUISITION ADD (
  CONSTRAINT PK_REQUISITION
 PRIMARY KEY
 (REQUISITION_ID))
/
