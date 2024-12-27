CREATE TABLE VMSCMS.CMS_GROUP_RENEW_TEMP
(
  CGT_INST_CODE     NUMBER(3),
  CGT_CARD_NO       VARCHAR2(90 BYTE),
  CGT_FILE_NAME     VARCHAR2(30 BYTE),
  CGT_REMARKS       VARCHAR2(100 BYTE),
  CGT_PROCESS_FLAG  VARCHAR2(1 BYTE)            DEFAULT 'N',
  CGT_PROCESS_MSG   VARCHAR2(300 BYTE),
  CGT_INS_USER      NUMBER(5),
  CGT_INS_DATE      DATE                        DEFAULT SYSDATE,
  CGT_MBR_NUMB      VARCHAR2(10 BYTE),
  CGT_CARD_NO_ENCR  RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


