CREATE TABLE VMSCMS.PCMS_UPLOAD_LOG
(
  PUL_INST_CODE        NUMBER(3),
  PUL_FILE_NAME        VARCHAR2(30 BYTE),
  PUL_APPL_NO          VARCHAR2(21 BYTE),
  PUL_UPLD_STAT        CHAR(1 BYTE),
  PUL_APPROVE_STAT     CHAR(1 BYTE),
  PUL_INS_DATE         DATE,
  PUL_ROW_ID           NUMBER(10),
  PUL_PROCESS_MESSAGE  VARCHAR2(300 BYTE),
  PUL_LUPD_DATE        DATE,
  PUL_LUPD_USER        NUMBER(10),
  PUL_INS_USER         NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


