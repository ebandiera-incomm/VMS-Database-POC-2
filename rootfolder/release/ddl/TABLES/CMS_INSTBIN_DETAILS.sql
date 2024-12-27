CREATE TABLE VMSCMS.CMS_INSTBIN_DETAILS
(
  CID_INST_CODE       NUMBER(3),
  CID_INST_BIN        NUMBER(10),
  CID_INST_FIID       VARCHAR2(4 BYTE),
  CID_INS_DATE        DATE,
  CID_LUPD_DATE       DATE,
  CID_INST_SHORTNAME  VARCHAR2(5 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


