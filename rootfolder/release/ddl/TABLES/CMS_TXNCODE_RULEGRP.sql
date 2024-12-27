CREATE TABLE VMSCMS.CMS_TXNCODE_RULEGRP
(
  CTR_INST_CODE        NUMBER(10),
  CTR_TXNRULE_GRPCODE  VARCHAR2(4 BYTE),
  CTR_TXNRULE_GRPDESC  VARCHAR2(50 BYTE)        NOT NULL,
  CTR_TXNRULE_STUS     VARCHAR2(1 BYTE),
  CTR_LUPD_DATE        DATE,
  CTR_LUPD_USER        NUMBER(10),
  CTR_INS_DATE         DATE,
  CTR_INS_USER         NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_TXNCODE_RULEGRP ADD (
  CONSTRAINT PK_TXNCODE_RULEGRP
 PRIMARY KEY
 (CTR_TXNRULE_GRPCODE))
/

