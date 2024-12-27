CREATE TABLE VMSCMS.CMS_FUNC_MAST_BACKUP
(
  CFM_INST_CODE  NUMBER(5)                      NOT NULL,
  CFM_FUNC_CODE  VARCHAR2(10 BYTE),
  CFM_FUNC_DESC  VARCHAR2(15 BYTE)              NOT NULL,
  CFM_INST_DATE  DATE                           NOT NULL,
  CFM_LUPD_USER  NUMBER(5)                      NOT NULL,
  CFM_LUPD_DATE  DATE                           NOT NULL,
  CFM_INS_USER   NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

