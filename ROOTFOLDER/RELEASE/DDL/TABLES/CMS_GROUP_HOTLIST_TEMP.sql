CREATE TABLE VMSCMS.CMS_GROUP_HOTLIST_TEMP
(
  CGH_INST_CODE     NUMBER(3),
  CGH_CARD_NO       VARCHAR2(90 BYTE),
  CGH_FILE_NAME     VARCHAR2(30 BYTE),
  CGH_REMARKS       VARCHAR2(100 BYTE),
  CGH_PROCESS_FLAG  VARCHAR2(1 BYTE)            DEFAULT 'N',
  CGH_PROCESS_MSG   VARCHAR2(300 BYTE),
  CGH_INS_USER      NUMBER(5),
  CGH_INS_DATE      DATE                        DEFAULT SYSDATE,
  CGH_MBR_NUMB      VARCHAR2(10 BYTE),
  CGH_CARD_NO_ENCR  RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

