CREATE TABLE VMSCMS.CMS_CORPLOGIN_TRACK
(
  CCT_INST_CODE       NUMBER(3),
  CCT_CUST_ID         VARCHAR2(20 BYTE),
  CCT_WRONG_LOGINCNT  NUMBER(3),
  CCT_LOGIN_DATE      DATE,
  CCT_LUPD_DATE       DATE,
  CCT_LUPD_USER       NUMBER(10),
  CCT_INS_DATE        DATE,
  CCT_INS_USER        NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


