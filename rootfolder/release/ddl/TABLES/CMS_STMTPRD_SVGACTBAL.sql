CREATE TABLE VMSCMS.CMS_STMTPRD_SVGACTBAL
(
  CSS_INST_CODE        NUMBER(3)                NOT NULL,
  CSS_ACCT_NO          VARCHAR2(20 BYTE)        NOT NULL,
  CSS_ACCT_ID          NUMBER(10)               NOT NULL,
  CSS_STAT_CODE        NUMBER(3)                NOT NULL,
  CSS_ACCT_BAL         NUMBER(20)               NOT NULL,
  CSS_LEDGER_BAL       NUMBER(20)               NOT NULL,
  CSS_STATMENT_PERIOD  DATE                     NOT NULL,
  CSS_INS_USER         NUMBER(5)                NOT NULL,
  CSS_INS_DATE         DATE                     NOT NULL,
  CSS_LUPD_USER        NUMBER(5)                NOT NULL,
  CSS_LUPD_DATE        DATE                     NOT NULL
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_STMTPRD_SVGACTBAL ADD (
  CONSTRAINT FK_CSS_LUPD_USER 
 FOREIGN KEY (CSS_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CSS_INS_USER 
 FOREIGN KEY (CSS_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_STMTPRD_ACCTID 
 FOREIGN KEY (CSS_INST_CODE, CSS_ACCT_ID) 
 REFERENCES VMSCMS.CMS_ACCT_MAST (CAM_INST_CODE,CAM_ACCT_ID))
/

