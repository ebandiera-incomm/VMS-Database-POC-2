CREATE TABLE VMSCMS.FHM_TEMP_PRM_MAST
(
  FTP_TEMP_ID     NUMBER(10)                    NOT NULL,
  FTP_FIELD_POS   NUMBER(10)                    NOT NULL,
  FTP_SUB_CODE    NUMBER(10)                    NOT NULL,
  FTP_FIELD_ID    NUMBER(10),
  FTP_DEF_VALUE   VARCHAR2(32 BYTE),
  FTP_TEST_VALUE  VARCHAR2(32 BYTE),
  FTP_PRM_LEN     NUMBER(10),
  FTP_PRM_PAD     VARCHAR2(32 BYTE),
  FTP_LUPD_DATE   DATE,
  FTP_INST_CODE   NUMBER(10),
  FTP_LUPD_USER   NUMBER(10),
  FTP_INS_DATE    DATE,
  FTP_INS_USER    NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.FHM_TEMP_PRM_MAST ADD (
  CONSTRAINT FTP_TEMP_ID_PK
 PRIMARY KEY
 (FTP_TEMP_ID, FTP_FIELD_POS, FTP_SUB_CODE))
/

ALTER TABLE VMSCMS.FHM_TEMP_PRM_MAST ADD (
  CONSTRAINT FTP_TEMP_ID_FK 
 FOREIGN KEY (FTP_TEMP_ID) 
 REFERENCES VMSCMS.FHM_TEMP_MAST (FTM_TEMP_ID))
/

