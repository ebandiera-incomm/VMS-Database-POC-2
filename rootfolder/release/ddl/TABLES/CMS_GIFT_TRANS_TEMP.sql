CREATE TABLE VMSCMS.CMS_GIFT_TRANS_TEMP
(
  CGT_ACCT_NO        VARCHAR2(20 BYTE),
  CGT_SR_NO          NUMBER(4),
  CGT_SOURCE_CODE    VARCHAR2(2 BYTE),
  CGT_RECORD_TYPE    VARCHAR2(2 BYTE),
  CGT_PAN_CODE       VARCHAR2(90 BYTE),
  CGT_GIFT_ORDER     VARCHAR2(14 BYTE),
  CGT_REDEMP_CODE    VARCHAR2(3 BYTE),
  CGT_STAT_CODE      VARCHAR2(3 BYTE),
  CGT_AIRWAY_BILLNO  VARCHAR2(12 BYTE),
  CGT_ITEM_ID        VARCHAR2(6 BYTE),
  CGT_ITEM_QTY       VARCHAR2(2 BYTE),
  CGT_REQ_DATE       VARCHAR2(8 BYTE),
  CGT_POST_DATE      VARCHAR2(8 BYTE),
  CGT_APPRV_DATE     VARCHAR2(8 BYTE),
  CGT_CUST_NAME      VARCHAR2(30 BYTE),
  CGT_ADDR_LINE1     VARCHAR2(30 BYTE),
  CGT_ADDR_LINE2     VARCHAR2(30 BYTE),
  CGT_ADDR_LINE3     VARCHAR2(30 BYTE),
  CGT_ADDR_LINE4     VARCHAR2(30 BYTE),
  CGT_CITY_NAME      VARCHAR2(20 BYTE),
  CGT_PIN_CODE       VARCHAR2(6 BYTE),
  CGT_STD_CODE       VARCHAR2(5 BYTE),
  CGT_PHONE_NUMB     VARCHAR2(7 BYTE),
  CGT_REJECT_RSN     VARCHAR2(3 BYTE),
  CGT_FILE_NAME      VARCHAR2(14 BYTE),
  CGT_PROCESS_FLAG   VARCHAR2(1 BYTE),
  CGT_DISPATCH_DATE  VARCHAR2(8 BYTE),
  CGT_COURIER_NAME   VARCHAR2(2 BYTE),
  CGT_RECD_DATE      VARCHAR2(8 BYTE),
  CGT_DEL_PERSON     VARCHAR2(30 BYTE),
  CGT_RET_DATE       VARCHAR2(8 BYTE),
  CGT_RET_REASON     VARCHAR2(30 BYTE),
  CGT_MEMO_FIELD     VARCHAR2(30 BYTE),
  CGT_LUPD_DATE      DATE,
  CGT_INST_CODE      NUMBER(10),
  CGT_LUPD_USER      NUMBER(10),
  CGT_INS_DATE       DATE,
  CGT_INS_USER       NUMBER(10),
  CGT_PAN_CODE_ENCR  RAW(100)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

