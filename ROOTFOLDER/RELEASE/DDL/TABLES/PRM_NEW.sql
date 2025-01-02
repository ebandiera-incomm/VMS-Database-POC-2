CREATE TABLE VMSCMS.PRM_NEW
(
  CPM_FIELD_NAME          VARCHAR2(100 BYTE),
  CPM_FIELD_LENGTH        NUMBER(3),
  CPM_FIELD_DEFAULT       VARCHAR2(100 BYTE),
  CPM_FIELD_STARTPOSTION  VARCHAR2(5 BYTE),
  CPM_DELIVERY_CHANNEL    VARCHAR2(3 BYTE),
  CPM_PRM_TYPE            VARCHAR2(4 BYTE),
  CPM_TRANSACTION_CODE    VARCHAR2(3 BYTE),
  CPM_TXN_FIELDNAME       VARCHAR2(100 BYTE),
  CPM_INS_DATE            DATE,
  CPM_LUPD_DATE           DATE,
  CPM_INST_CODE           VARCHAR2(3 BYTE),
  CPM_PADDING_VALUE       VARCHAR2(2 BYTE),
  CPM_PAD_POS             VARCHAR2(1 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

