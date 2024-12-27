CREATE TABLE VMSCMS.TRANSACTIONLOG_ONLINE
(
  MSGTYPE              VARCHAR2(4 BYTE)         NOT NULL,
  RRN                  VARCHAR2(12 BYTE)        NOT NULL,
  DELIVERY_CHANNEL     VARCHAR2(2 BYTE),
  TERMINAL_ID          VARCHAR2(20 BYTE),
  DATE_TIME            DATE,
  TXN_CODE             VARCHAR2(2 BYTE),
  TXN_TYPE             VARCHAR2(2 BYTE),
  TXN_MODE             VARCHAR2(1 BYTE),
  TXN_STATUS           VARCHAR2(1 BYTE),
  RESPONSE_CODE        VARCHAR2(3 BYTE),
  BUSINESS_DATE        VARCHAR2(8 BYTE),
  BUSINESS_TIME        VARCHAR2(6 BYTE),
  CUSTOMER_CARD_NO     VARCHAR2(20 BYTE),
  TOPUP_CARD_NO        VARCHAR2(20 BYTE),
  TOPUP_ACCT_NO        VARCHAR2(20 BYTE),
  TOPUP_ACCT_TYPE      VARCHAR2(2 BYTE),
  BANK_CODE            VARCHAR2(12 BYTE),
  TOTAL_AMOUNT         VARCHAR2(12 BYTE),
  RULE_INDICATOR       VARCHAR2(1 BYTE),
  RULEGROUPID          VARCHAR2(4 BYTE),
  MCCODE               VARCHAR2(4 BYTE),
  CURRENCYCODE         VARCHAR2(4 BYTE),
  ADDCHARGE            VARCHAR2(12 BYTE),
  PRODUCTID            VARCHAR2(4 BYTE),
  CATEGORYID           VARCHAR2(4 BYTE),
  TXN_FEE              VARCHAR2(12 BYTE),
  TIPS                 VARCHAR2(12 BYTE),
  DECLINE_RULEID       VARCHAR2(4 BYTE),
  ATM_NAME_LOCATION    VARCHAR2(40 BYTE),
  AUTH_ID              VARCHAR2(6 BYTE),
  TRANS_DESC           VARCHAR2(50 BYTE),
  AMOUNT               VARCHAR2(12 BYTE),
  PREAUTHAMOUNT        VARCHAR2(12 BYTE),
  PARTIALAMOUNT        VARCHAR2(12 BYTE),
  MCCODEGROUPID        VARCHAR2(4 BYTE),
  CURRENCYCODEGROUPID  VARCHAR2(4 BYTE),
  TRANSCODEGROUPID     VARCHAR2(4 BYTE),
  RULES                VARCHAR2(200 BYTE),
  PREAUTH_DATE         DATE,
  CR_DR_FLAG           VARCHAR2(2 BYTE),
  PROCESSES_FLAG       VARCHAR2(1 BYTE),
  TRANSACTIONLOG       VARCHAR2(3 BYTE),
  DR_CR_FLAG           VARCHAR2(3 BYTE),
  GL_UPD_FLAG          VARCHAR2(1 BYTE),
  ADD_LUPD_DATE        DATE,
  ADD_INST_CODE        NUMBER(10),
  ADD_LUPD_USER        NUMBER(10),
  ADD_INS_DATE         DATE,
  ADD_INS_USER         NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


