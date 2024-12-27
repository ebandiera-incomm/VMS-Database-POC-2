CREATE TABLE VMSCMS.CMS_INITIALLOAD_DETAIL
(
  CID_ACCT_NO        VARCHAR2(20 BYTE),
  CID_INITIAL_AMT    VARCHAR2(12 BYTE),
  CID_FILE_NAME      VARCHAR2(30 BYTE),
  CID_REMARKS        VARCHAR2(100 BYTE),
  CID_REF_NO         VARCHAR2(25 BYTE),
  CID_MSG24_FLAG     CHAR(1 BYTE)               DEFAULT 'N',
  CID_PAYMENT_MODE   VARCHAR2(15 BYTE),
  CID_INSTRUMENT_NO  VARCHAR2(19 BYTE),
  CID_DRAWN_DATE     DATE,
  CID_PROCESS_FLAG   VARCHAR2(1 BYTE),
  CID_PROCESS_MSG    VARCHAR2(300 BYTE),
  CID_PROCESS_MODE   VARCHAR2(1 BYTE),
  CID_INS_USER       NUMBER(5),
  CID_INS_DATE       DATE,
  CID_LUPD_USER      NUMBER(5),
  CID_LUPD_DATE      DATE,
  CID_INST_CODE      NUMBER(5)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


