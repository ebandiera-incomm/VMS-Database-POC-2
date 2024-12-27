CREATE TABLE VMSCMS.CMS_SOPFAILURE_DTL
(
  CSD_CARD_NO          VARCHAR2(90 BYTE),
  CSD_RRN              VARCHAR2(20 BYTE),
  CSD_MBR_NO           VARCHAR2(3 BYTE),
  CSD_INST_CODE        NUMBER(3),
  CSD_INS_DATE         DATE,
  CSD_LUPD_DATE        DATE,
  CSD_HOLD_AMOUNT      VARCHAR2(12 BYTE),
  CSD_EXPIRY_DATE      DATE,
  CSD_PREAUTHTXN_DATE  VARCHAR2(8 BYTE),
  CSD_ERROR_MSG        VARCHAR2(100 BYTE),
  CSD_CLAWBACK_AMNT    NUMBER(15,6),
  CSD_ERRLOG_TYPE      CHAR(1 BYTE)             DEFAULT 'H'
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

