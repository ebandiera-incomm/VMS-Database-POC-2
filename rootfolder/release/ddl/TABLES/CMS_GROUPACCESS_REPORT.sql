CREATE TABLE VMSCMS.CMS_GROUPACCESS_REPORT
(
  CGR_GROUP_ID    NUMBER(5),
  CGR_REPORT_ID   NUMBER(4),
  CGR_FIELD_ID    VARCHAR2(20 BYTE),
  CGR_FIELD_POSN  NUMBER(3),
  CGR_INS_USER    NUMBER(5),
  CGR_INS_DATE    DATE,
  CGR_LUPD_DATE   DATE,
  CGR_INST_CODE   NUMBER(10),
  CGR_LUPD_USER   NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

