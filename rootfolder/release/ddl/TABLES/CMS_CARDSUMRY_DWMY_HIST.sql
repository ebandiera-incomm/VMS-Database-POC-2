CREATE TABLE VMSCMS.CMS_CARDSUMRY_DWMY_HIST
(
  CCD_INST_CODE      NUMBER(10),
  CCD_PAN_CODE       VARCHAR2(90 BYTE)          NOT NULL,
  CCD_COMB_HASH      VARCHAR2(90 BYTE)          NOT NULL,
  CCD_DALY_TXNCNT    NUMBER(20)                 NOT NULL,
  CCD_DALY_TXNAMNT   NUMBER(22,2)               NOT NULL,
  CCD_WKLY_TXNCNT    NUMBER(20)                 NOT NULL,
  CCD_WKLY_TXNAMNT   NUMBER(22,2)               NOT NULL,
  CCD_MNTLY_TXNCNT   NUMBER(20)                 NOT NULL,
  CCD_MNTLY_TXNAMNT  NUMBER(22,2)               NOT NULL,
  CCD_YERLY_TXNCNT   NUMBER(20)                 NOT NULL,
  CCD_YERLY_TXNAMNT  NUMBER(22,2)               NOT NULL,
  CCD_LUPD_DATE      DATE                       NOT NULL,
  CCD_LUPD_USER      NUMBER(10)                 NOT NULL,
  CCD_INS_DATE       DATE                       NOT NULL,
  CCD_INS_USER       NUMBER(10)                 NOT NULL,
  CCD_LMTCHNG_FLAG   CHAR(1 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


