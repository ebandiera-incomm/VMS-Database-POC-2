CREATE TABLE VMSCMS.CMS_GIROAPPL_FORMAT
(
  CAD_APPL_NUM         VARCHAR2(20 BYTE),
  CAD_APPL_DATE        DATE,
  CAD_BO_NAME          VARCHAR2(50 BYTE),
  CAD_FI_NAME          VARCHAR2(50 BYTE),
  CAD_CUST_NAME        VARCHAR2(50 BYTE),
  CAD_BR_NAME          VARCHAR2(50 BYTE),
  CAD_CUSTREF_NO       VARCHAR2(20 BYTE),
  CAD_PAY_LIMIT        NUMBER(20,2),
  CAD_EXP_DATE         DATE,
  CAD_STATUS           VARCHAR2(15 BYTE),
  CAD_INS_DATE         DATE,
  CAD_INS_USER         NUMBER(5),
  CAD_LUPD_DATE        DATE,
  CAD_LUPD_USER        NUMBER(5),
  CAD_AUTHORISED_BY    NUMBER(5),
  CAD_AUTHORISED_DATE  DATE,
  CAD_PAY_PERIOD       VARCHAR2(10 BYTE),
  CAD_MANDATEACC_NO    VARCHAR2(20 BYTE),
  CAD_CUST_CODE        NUMBER,
  CAD_AGENT_CODE       VARCHAR2(10 BYTE),
  CAD_INST_CODE        NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_GIROAPPL_FORMAT ADD (
  CONSTRAINT PK_APPL_NO
 PRIMARY KEY
 (CAD_APPL_NUM),
  CONSTRAINT UK_BANK_DTL
 UNIQUE (CAD_BO_NAME, CAD_CUST_NAME, CAD_BR_NAME, CAD_CUSTREF_NO, CAD_MANDATEACC_NO))
/

