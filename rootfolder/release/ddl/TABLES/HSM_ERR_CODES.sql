CREATE TABLE VMSCMS.HSM_ERR_CODES
(
  HEC_ERROR_CODE  VARCHAR2(4 BYTE),
  HEC_ERROR_DESC  VARCHAR2(200 BYTE),
  HEC_LUPD_DATE   DATE,
  HEC_INST_CODE   NUMBER(10),
  HEC_LUPD_USER   NUMBER(10),
  HEC_INS_DATE    DATE,
  HEC_INS_USER    NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


