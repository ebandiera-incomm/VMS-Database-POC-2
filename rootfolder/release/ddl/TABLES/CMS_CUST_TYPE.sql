CREATE TABLE VMSCMS.CMS_CUST_TYPE
(
  CCT_INST_CODE  NUMBER(3)                      NOT NULL,
  CCT_TYPE_CODE  NUMBER(3)                      NOT NULL,
  CCT_TYPE_DESC  VARCHAR2(25 BYTE)              NOT NULL,
  CCT_CUST_PROP  CHAR(1 BYTE)                   NOT NULL,
  CCT_INS_USER   NUMBER(5)                      NOT NULL,
  CCT_INS_DATE   DATE                           NOT NULL,
  CCT_LUPD_USER  NUMBER(5)                      NOT NULL,
  CCT_LUPD_DATE  DATE                           NOT NULL
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CUST_TYPE ADD (
  CONSTRAINT PK_CUST_TYPE
 PRIMARY KEY
 (CCT_INST_CODE, CCT_TYPE_CODE))
/

ALTER TABLE VMSCMS.CMS_CUST_TYPE ADD (
  CONSTRAINT FK_CUSTTYPE_USERMAST2 
 FOREIGN KEY (CCT_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CUSTTYPE_USERMAST1 
 FOREIGN KEY (CCT_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CUSTTYPE_INSTMAST 
 FOREIGN KEY (CCT_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE))
/

