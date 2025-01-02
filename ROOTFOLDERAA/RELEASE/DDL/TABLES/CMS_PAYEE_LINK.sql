CREATE TABLE VMSCMS.CMS_PAYEE_LINK
(
  CPL_LINK_NO    NUMBER(10),
  CPL_CUST_ID    NUMBER(10),
  CPL_PAYEE_NO   VARCHAR2(90 BYTE),
  CPL_APPR_FLAG  CHAR(1 BYTE),
  CPL_LUPD_DATE  DATE,
  CPL_INST_CODE  NUMBER(10),
  CPL_LUPD_USER  NUMBER(10),
  CPL_INS_DATE   DATE,
  CPL_INS_USER   NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

