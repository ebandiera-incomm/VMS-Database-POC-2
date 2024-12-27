CREATE TABLE VMSCMS.PCMS_RESPALL_HOST
(
  PRH_RESP_ID           NUMBER(20),
  PRH_PRO_ID            VARCHAR2(4 BYTE),
  PRH_TRAN_TYP          VARCHAR2(2 BYTE),
  PRH_BRAN_NO           VARCHAR2(5 BYTE),
  PRH_REF_NO            VARCHAR2(25 BYTE),
  PRH_JRNL_NO           VARCHAR2(9 BYTE),
  PRH_TRAN_DAT          VARCHAR2(8 BYTE),
  PRH_STAT_CODE         VARCHAR2(2 BYTE),
  PRH_ERR_NO            VARCHAR2(4 BYTE),
  PRH_ERR_DESC          VARCHAR2(100 BYTE),
  PRH_MSG_REC_REF_NO    VARCHAR2(20 BYTE),
  PRH_GEN_RECON_REF_NO  VARCHAR2(20 BYTE),
  PRH_FILE_NAME         VARCHAR2(30 BYTE),
  PRH_RECD_COUNT        NUMBER(2),
  PRH_INS_USER          NUMBER(5),
  PRH_INS_DATE          DATE,
  PRH_LUPD_USER         NUMBER(5),
  PRH_LUPD_DATE         DATE,
  PRH_PROCESS_FLAG      VARCHAR2(1 BYTE),
  PRH_INST_CODE         NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


