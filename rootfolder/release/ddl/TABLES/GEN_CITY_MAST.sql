CREATE TABLE VMSCMS.GEN_CITY_MAST
(
  GCM_CNTRY_CODE  NUMBER(3)                     NOT NULL,
  GCM_STATE_CODE  NUMBER(3),
  GCM_CITY_CODE   NUMBER(5)                     NOT NULL,
  GCM_CITY_NAME   VARCHAR2(25 BYTE)             NOT NULL,
  GCM_LUPD_USER   NUMBER(5)                     NOT NULL,
  GCM_LUPD_DATE   DATE                          NOT NULL,
  GCM_INST_CODE   NUMBER(10),
  GCM_INS_DATE    DATE,
  GCM_INS_USER    NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.GEN_CITY_MAST ADD (
  CONSTRAINT PK_CITY_MAST
 PRIMARY KEY
 (GCM_INST_CODE, GCM_CNTRY_CODE, GCM_CITY_CODE))
/

ALTER TABLE VMSCMS.GEN_CITY_MAST ADD (
  CONSTRAINT FK_CITYMAST_CNTRYMAST 
 FOREIGN KEY (GCM_INST_CODE, GCM_CNTRY_CODE) 
 REFERENCES VMSCMS.GEN_CNTRY_MAST (GCM_INST_CODE,GCM_CNTRY_CODE),
  CONSTRAINT FK_CITYMAST_USERMAST 
 FOREIGN KEY (GCM_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN))
/

