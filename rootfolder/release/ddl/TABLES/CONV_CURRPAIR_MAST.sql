CREATE TABLE VMSCMS.CONV_CURRPAIR_MAST
(
  CCM_INST_CODE        NUMBER(10)               NOT NULL,
  CCM_UNIQUE_ID        VARCHAR2(12 BYTE)        NOT NULL,
  CCM_CURR_FRM_CODE    VARCHAR2(4 BYTE),
  CCM_CURR_TO_CODE     VARCHAR2(4 BYTE),
  CCM_DEC_RATE_VAL     NUMBER(18,10),
  CCM_RATE_SPREAD      NUMBER(18,10),
  CCM_SOURCE_UNIT      NUMBER(18,10),
  CCM_TARGET_UNIT      NUMBER(18,10),
  CCM_LAST_USER        NUMBER(10),
  CCM_LAST_DATE        DATE,
  CCM_CURRPAIR_DESCRP  VARCHAR2(50 BYTE),
  CCM_LUPD_DATE        DATE,
  CCM_LUPD_USER        NUMBER(10),
  CCM_INS_DATE         DATE,
  CCM_INS_USER         NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CONV_CURRPAIR_MAST ADD (
  CONSTRAINT PK__CONV_CURRPAIR_MA__316EE0E7
 PRIMARY KEY
 (CCM_INST_CODE, CCM_UNIQUE_ID))
/

