CREATE TABLE VMSCMS.RULEGROUPING
(
  RULEGROUPID       VARCHAR2(4 BYTE),
  RULEGROUPDESC     VARCHAR2(50 BYTE)           NOT NULL,
  ADDCHARGE         VARCHAR2(12 BYTE),
  ACTIVATIONSTATUS  VARCHAR2(1 BYTE),
  ACT_LUPD_DATE     DATE,
  ACT_INST_CODE     NUMBER(10),
  ACT_LUPD_USER     NUMBER(10),
  ACT_INS_DATE      DATE,
  ACT_INS_USER      NUMBER(10),
  PERMRULE_FLAG     VARCHAR2(1 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.RULEGROUPING ADD (
  CONSTRAINT PK_RULEGROUPING
 PRIMARY KEY
 (RULEGROUPID))
/
