CREATE TABLE VMSCMS.CMS_PRODCCC_FPWAIV_HIST
(
  CPF_INST_CODE      NUMBER(3)                  NOT NULL,
  CPF_PROD_CODE      VARCHAR2(6 BYTE),
  CPF_PLAN_CODE      VARCHAR2(4 BYTE),
  CPF_CARD_TYPE      NUMBER(2),
  CPF_CUST_CATG      NUMBER(2),
  CPF_FEE_CODE       NUMBER(3)                  NOT NULL,
  CPF_CITY_CATG      VARCHAR2(2 BYTE),
  CPF_CARD_POSN      NUMBER(2),
  CPF_WAIV_PRCNT     NUMBER(5,2)                NOT NULL,
  CPF_VALID_FROM     DATE                       NOT NULL,
  CPF_VALID_TO       DATE                       NOT NULL,
  CPF_INS_USER       NUMBER(5)                  NOT NULL,
  CPF_INS_DATE       DATE                       NOT NULL,
  CPF_LUPD_USER      NUMBER(5)                  NOT NULL,
  CPF_LUPD_DATE      DATE                       NOT NULL,
  CPF_RECORDED_DATE  DATE                       NOT NULL,
  CPF_DESC           VARCHAR2(100 BYTE),
  CPF_CUST_TYPE      NUMBER(3)                  NOT NULL
)
TABLESPACE CMS_HIST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


