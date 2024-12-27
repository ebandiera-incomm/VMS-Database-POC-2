CREATE TABLE VMSCMS.HSM_TYPE_MASTER
(
  HTM_TYPE_CODE         VARCHAR2(15 BYTE),
  HTM_TYPE_VALUE        VARCHAR2(25 BYTE),
  HTM_TYPE_DESCRIPTION  VARCHAR2(25 BYTE),
  HTM_INS_DATE          DATE,
  HTM_LUPD_DATE         DATE,
  HTM_INST_CODE         NUMBER(10),
  HTM_LUPD_USER         NUMBER(10),
  HTM_INS_USER          NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

