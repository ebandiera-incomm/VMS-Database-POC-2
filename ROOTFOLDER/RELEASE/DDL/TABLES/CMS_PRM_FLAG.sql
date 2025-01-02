CREATE TABLE VMSCMS.CMS_PRM_FLAG
(
  CPF_DELIVERY_CHANNEL   VARCHAR2(3 BYTE),
  CPF_TRANSACTION_CODE   VARCHAR2(3 BYTE),
  CPF_PRM_TYPE           VARCHAR2(4 BYTE),
  CPF_PRM_ENABLEDISABLE  VARCHAR2(2 BYTE),
  CPF_INS_USER           NUMBER(5),
  CPF_INS_DATE           DATE,
  CPF_LUPD_USER          NUMBER(5),
  CPF_LUPD_DATE          DATE
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_PRM_FLAG ADD (
  CONSTRAINT PK_DEL_TRAN_TYPE
 PRIMARY KEY
 (CPF_DELIVERY_CHANNEL, CPF_TRANSACTION_CODE, CPF_PRM_TYPE))
/
