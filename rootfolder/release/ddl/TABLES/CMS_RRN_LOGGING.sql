CREATE TABLE VMSCMS.CMS_RRN_LOGGING
  (
    CRL_INST_CODE    VARCHAR2(3),
    CRL_CARD_NO       VARCHAR2(90 BYTE),
    CRL_TRANS_DATE   VARCHAR2(10 BYTE),
    CRL_TRANS_TIME    VARCHAR2(10 BYTE),
    CRL_RRN              VARCHAR2(20 BYTE),
    CRL_DELIVERY_CHANNEL VARCHAR2(2 BYTE),
    CRL_TXN_CODE         VARCHAR2(2 BYTE),
    CRL_TIME_TAKENMS  VARCHAR2(20 BYTE),
    CRL_SEVER  VARCHAR2(20 BYTE),
    CRL_TIME_STAMP TIMESTAMP(3),
	CRL_MSG_TYPE   VARCHAR2(10),
	CRL_DBRESP_TIMEMS VARCHAR2(20)
  ) tablespace cms_big_txn;
  