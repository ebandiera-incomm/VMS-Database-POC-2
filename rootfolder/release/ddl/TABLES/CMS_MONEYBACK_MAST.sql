CREATE TABLE VMSCMS.CMS_MONEYBACK_MAST
(
  CMM_INST_CODE      NUMBER(3)                  NOT NULL,
  CMM_MBSCHEME_CODE  NUMBER(3)                  NOT NULL,
  CMM_MB_DESC        VARCHAR2(75 BYTE),
  CMM_MB_AMT         NUMBER(15,6)               NOT NULL,
  CMM_INS_USER       NUMBER(5)                  NOT NULL,
  CMM_INS_DATE       DATE                       NOT NULL,
  CMM_LUPD_USER      NUMBER(5)                  NOT NULL,
  CMM_LUPD_DATE      DATE                       NOT NULL
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_MONEYBACK_MAST ADD (
  CONSTRAINT PK_MONEYBACK_MAST
 PRIMARY KEY
 (CMM_MBSCHEME_CODE),
  CONSTRAINT UK_MONEYBACK_MAST
 UNIQUE (CMM_MB_DESC))
/

