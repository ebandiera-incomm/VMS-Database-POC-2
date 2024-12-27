CREATE TABLE VMSCMS.CMS_LOOKUP_FILE
(
  CLF_FILE_ID      CHAR(1 BYTE),
  CLF_FILE_DESC    VARCHAR2(50 BYTE),
  CLF_FIELD_NAME   VARCHAR2(50 BYTE),
  CLF_COLUMN_NAME  VARCHAR2(50 BYTE),
  CLF_TABLE_NAME   VARCHAR2(50 BYTE),
  CLF_INST_CODE    NUMBER(3)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


