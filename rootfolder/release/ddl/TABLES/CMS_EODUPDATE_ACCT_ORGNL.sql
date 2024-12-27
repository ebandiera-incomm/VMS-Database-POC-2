CREATE TABLE VMSCMS.CMS_EODUPDATE_ACCT_ORGNL
(
  CEU_RRN               VARCHAR2(12 BYTE),
  CEU_TERMINAL_ID       VARCHAR2(20 BYTE),
  CEU_DELIVERY_CHANNEL  VARCHAR2(2 BYTE),
  CEU_TXN_CODE          VARCHAR2(2 BYTE),
  CEU_TXN_MODE          VARCHAR2(1 BYTE),
  CEU_TRAN_DATE         DATE,
  CEU_CUSTOMER_CARD_NO  VARCHAR2(20 BYTE),
  CEU_UPD_ACCTNO        VARCHAR2(20 BYTE),
  CEU_UPD_AMOUNT        NUMBER,
  CEU_UPD_FLAG          VARCHAR2(1 BYTE),
  CEU_PROCESS_FLAG      VARCHAR2(1 BYTE),
  CEU_PROCESS_MSG       VARCHAR2(300 BYTE),
  CEU_LUPD_DATE         DATE,
  CEU_INST_CODE         NUMBER(10),
  CEU_LUPD_USER         NUMBER(10),
  CEU_INS_DATE          DATE,
  CEU_INS_USER          NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


