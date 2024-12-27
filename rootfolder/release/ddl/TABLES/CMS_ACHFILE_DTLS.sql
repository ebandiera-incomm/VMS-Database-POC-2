CREATE TABLE VMSCMS.CMS_ACHFILE_DTLS
(
  CAD_BATCH_NO       NUMBER(10),
  CAD_FILE_NAME       VARCHAR2(255),
  CAD_TOT_ROWS        NUMBER(10),
  CAD_SUCC_ROWS     NUMBER(10),
  CAD_ERR_ROWS        NUMBER(10),
  CAD_TOT_AMT           NUMBER (20,2),
  CAT_SCHEDR_FLAG  CHAR(1),
  CAD_UPD_STAT         CHAR(1)                DEFAULT 'N',
  CAD_INS_DATE          DATE                   DEFAULT sysdate,
  CAD_PROCESS_MSG   VARCHAR2(3000),
  CAD_PROCESS_DATE  DATE,
  CAD_REP_STAT      VARCHAR2(3000)
)
TABLESPACE CMS_BIG_TXN;