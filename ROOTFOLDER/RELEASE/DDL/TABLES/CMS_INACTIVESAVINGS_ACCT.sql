CREATE TABLE VMSCMS.CMS_INACTIVESAVINGS_ACCT
(
  CIA_INST_CODE         NUMBER(3),
  CIA_CARD_NO           RAW(100),
  CIA_SPENDINGACCT_NO   VARCHAR2(20 BYTE),
  CIA_SAVINGSACCT_NO    VARCHAR2(20 BYTE),
  CIA_CLOSING_DATE      DATE,
  CIA_SAVINGS_BAL       NUMBER(20,3),
  CIA_INTEREST_RATE     NUMBER(20,3),
  CIA_TRANSACTION_FLAG  VARCHAR2(1 BYTE),
  CIA_INST_USER         NUMBER(5),
  CIA_INS_DATE          DATE,
  CIA_LUPD_USER         NUMBER(5),
  CIA_LUPD_DATE         DATE,
  CIA_LASTTXN_DATE      DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

