CREATE TABLE VMSCMS.PAN_TMP
(
  PAN            VARCHAR2(20 BYTE),
  ACCT           VARCHAR2(12 BYTE),
  PR_DATE        DATE,
  PR_LUPD_DATE   DATE,
  ACC_INST_CODE  NUMBER(10),
  PR__LUPD_USER  NUMBER(10),
  ACC_INS_DATE   DATE,
  ACC_INS_USER   NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


