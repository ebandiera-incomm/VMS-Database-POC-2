CREATE TABLE VMSCMS.CMS_MERINV_MERPAN
(
  CMM_INST_CODE        NUMBER(10)               NOT NULL,
  CMM_MER_ID           NUMBER(15)               NOT NULL,
  CMM_LOCATION_ID      VARCHAR2(15 BYTE)        NOT NULL,
  CMM_MERPRODCAT_ID    NUMBER(10)               NOT NULL,
  CMM_APPL_CODE        NUMBER(14)               NOT NULL,
  CMM_ORDR_REFRNO      VARCHAR2(11 BYTE)        NOT NULL,
  CMM_TORDR_REFRNO     VARCHAR2(11 BYTE),
  CMM_PANCODE_ENCR     RAW(100)                 NOT NULL,
  CMM_PAN_CODE         VARCHAR2(90 BYTE)        NOT NULL,
  CMM_ACTIVATION_FLAG  CHAR(1 BYTE)             DEFAULT 'M'                   NOT NULL,
  CMM_EXPIRY_DATE      DATE                     NOT NULL,
  CMM_LUPD_DATE        DATE                     NOT NULL,
  CMM_LUPD_USER        NUMBER(10)               NOT NULL,
  CMM_INS_DATE         DATE                     NOT NULL,
  CMM_INS_USER         NUMBER(10)               NOT NULL,
  CMM_FILLER           VARCHAR2(15 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


