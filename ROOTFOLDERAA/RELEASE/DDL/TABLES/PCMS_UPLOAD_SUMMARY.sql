CREATE TABLE VMSCMS.PCMS_UPLOAD_SUMMARY
(
  PUC_INST_CODE        NUMBER(3),
  PUC_FILE_NAME        VARCHAR2(50 BYTE),
  PUC_SUCCESS_RECORDS  NUMBER,
  PUC_ERROR_RECORDS    NUMBER,
  PUC_TOT_RECORDS      NUMBER,
  PUC_INS_USER         NUMBER,
  PUC_INS_DATE         DATE,
  PUC_LUPD_USER        NUMBER,
  PUC_LUPD_DATE        DATE,
  PUC_FILE_TYPE        VARCHAR2(1 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.PCMS_UPLOAD_SUMMARY ADD (
  CONSTRAINT PK_UPLDSMRY_FILENAME
 PRIMARY KEY
 (PUC_FILE_NAME))
/
