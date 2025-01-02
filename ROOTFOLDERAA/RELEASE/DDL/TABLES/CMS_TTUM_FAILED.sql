CREATE TABLE VMSCMS.CMS_TTUM_FAILED
(
  CTF_INST_CODE    NUMBER(3)                    NOT NULL,
  CTF_FILE_NAME    VARCHAR2(18 BYTE)            NOT NULL,
  CTF_ROW_ID       VARCHAR2(10 BYTE)            NOT NULL,
  CTF_REC_SOURCE   VARCHAR2(4 BYTE)             NOT NULL,
  CTF_ACCT_NO      VARCHAR2(16 BYTE)            NOT NULL,
  CTF_CURR_CODE    VARCHAR2(3 BYTE)             NOT NULL,
  CTF_SOLID_CODE   VARCHAR2(8 BYTE)             NOT NULL,
  CTF_TRAN_TYPE    CHAR(1 BYTE)                 NOT NULL,
  CTF_TRANS_AMT    VARCHAR2(15 BYTE)            NOT NULL,
  CTF_PARTI_CULAR  VARCHAR2(100 BYTE)           NOT NULL,
  CTF_FEE_TRANS    NUMBER(13)                   NOT NULL,
  CTF_RESEND_CNT   NUMBER(2)                    NOT NULL,
  CTF_NEW_FILE     VARCHAR2(18 BYTE),
  CTF_STATUS       CHAR(1 BYTE)                 NOT NULL,
  CTF_INS_USER     NUMBER(5)                    NOT NULL,
  CTF_INS_DATE     DATE                         NOT NULL,
  CTF_LUPD_USER    NUMBER(5)                    NOT NULL,
  CTF_LUPD_DATE    DATE                         NOT NULL
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

