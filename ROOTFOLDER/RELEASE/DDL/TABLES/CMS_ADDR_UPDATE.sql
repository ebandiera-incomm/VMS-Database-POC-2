CREATE TABLE VMSCMS.CMS_ADDR_UPDATE
(
  CAU_ACCT_NO         VARCHAR2(20 BYTE)         NOT NULL,
  CAU_DISP_NAME       VARCHAR2(50 BYTE),
  CAU_ADDR1           VARCHAR2(50 BYTE),
  CAU_ADDR2           VARCHAR2(50 BYTE),
  CAU_CITY_NAME       VARCHAR2(25 BYTE),
  CAU_STATE_SWITCH    VARCHAR2(3 BYTE),
  CAU_PIN_CODE        VARCHAR2(9 BYTE),
  CAU_CNTRY_CODE      VARCHAR2(3 BYTE),
  CAU_PHONE_ONE       VARCHAR2(20 BYTE),
  CAU_PHONE_TWO       VARCHAR2(20 BYTE),
  CAU_DONE_FLAG       VARCHAR2(1 BYTE)          DEFAULT 'N',
  CAU_PROCESS_DATE    DATE,
  CAU_PROCESS_RESULT  VARCHAR2(300 BYTE)        DEFAULT 'Not Processed',
  CAU_MANDATE_FLAG    VARCHAR2(2 BYTE)          DEFAULT '99',
  CAU_LUPD_DATE       DATE,
  CAU_INST_CODE       NUMBER(10),
  CAU_LUPD_USER       NUMBER(10),
  CAU_INS_DATE        DATE,
  CAU_INS_USER        NUMBER(10),
  CAU_MOB_NUM         VARCHAR2(15 BYTE),
  CAU_EMAIL           VARCHAR2(50 BYTE),
  CAU_DOB             VARCHAR2(8 BYTE),
  CAU_CUST_SEG        VARCHAR2(5 BYTE),
  CAU_FILE_NAME       VARCHAR2(30 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

