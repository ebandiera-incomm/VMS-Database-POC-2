CREATE TABLE VMSCMS.CMS_TXNCODEGRP_TXNCODE
(
  CTT_INST_CODE        NUMBER(10),
  CTT_TXNRULE_GRPCODE  VARCHAR2(4 BYTE),
  CTT_TXNRULE_ID       VARCHAR2(4 BYTE),
  CTT_LUPD_DATE        DATE,
  CTT_LUPD_USER        NUMBER(10),
  CTT_INS_DATE         DATE,
  CTT_INS_USER         NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_TXNCODEGRP_TXNCODE ADD (
  CONSTRAINT PK_TXNRULEID_RULEGRP
 PRIMARY KEY
 (CTT_TXNRULE_GRPCODE, CTT_TXNRULE_ID))
/

ALTER TABLE VMSCMS.CMS_TXNCODEGRP_TXNCODE ADD (
  CONSTRAINT FK_TXNCODEGRP_TXNCODE 
 FOREIGN KEY (CTT_TXNRULE_GRPCODE) 
 REFERENCES VMSCMS.CMS_TXNCODE_RULEGRP (CTR_TXNRULE_GRPCODE))
/

