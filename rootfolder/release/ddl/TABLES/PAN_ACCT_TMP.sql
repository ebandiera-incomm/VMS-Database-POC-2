CREATE TABLE VMSCMS.PAN_ACCT_TMP
(
  PAN            VARCHAR2(16 BYTE),
  ACCT           VARCHAR2(12 BYTE),
  STATUS         CHAR(1 BYTE),
  ACTIVE_DATE    DATE,
  ACC_LUPD_DATE  DATE,
  ACC_INST_CODE  NUMBER(10),
  ACC_LUPD_USER  NUMBER(10),
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


