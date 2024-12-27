CREATE TABLE VMSCMS.PCMS_ISSUANCEENTRY_UPDATE
(
  CIU_APPL_CODE        NUMBER(14)               NOT NULL,
  CIU_ADDR_COMM_CODE   NUMBER(10),
  CIU_ADDR_OTHER_CODE  NUMBER(10),
  CIU_PAN_CODE         VARCHAR2(20 BYTE),
  CIU_LUPD_DATE        DATE,
  CIU_INST_CODE        NUMBER(10),
  CIU_LUPD_USER        NUMBER(10),
  CIU_INS_DATE         DATE,
  CIU_INS_USER         NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


