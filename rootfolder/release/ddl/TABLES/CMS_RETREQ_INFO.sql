CREATE TABLE VMSCMS.CMS_RETREQ_INFO
(
  CRI_INST_CODE                 NUMBER(3),
  CRI_TRANS_CODE                VARCHAR2(2 BYTE),
  CRI_TRANSCODE_QUAL            VARCHAR2(1 BYTE),
  CRI_TRANS_COMP_SEQ_NUMB_TCR0  VARCHAR2(1 BYTE),
  CRI_PAN_CODE                  VARCHAR2(16 BYTE),
  CRI_MBR_NUMB                  VARCHAR2(3 BYTE),
  CRI_ARN_CODE                  VARCHAR2(23 BYTE),
  CRI_ACQ_BUISS_ID              VARCHAR2(8 BYTE),
  CRI_PURCHASE_DATE             VARCHAR2(4 BYTE),
  CRI_TRANS_AMT                 VARCHAR2(12 BYTE),
  CRI_TRANS_CURR_CODE           VARCHAR2(3 BYTE),
  CRI_MERC_NAME                 VARCHAR2(25 BYTE),
  CRI_MERC_CITY                 VARCHAR2(13 BYTE),
  CRI_MERC_CNTRY_CODE           VARCHAR2(3 BYTE),
  CRI_MERC_CATG_CODE            VARCHAR2(4 BYTE),
  CRI_US_MERC_ZIP_CODE          VARCHAR2(5 BYTE),
  CRI_MERC_STATE                VARCHAR2(3 BYTE),
  CRI_ISSUER_CTRL_NUMB          VARCHAR2(9 BYTE),
  CRI_REQ_REASON_CODE           VARCHAR2(2 BYTE),
  CRI_SETTLEMENT_FLAG           VARCHAR2(1 BYTE),
  CRI_NATIONAL_REIMB_FEE        VARCHAR2(12 BYTE),
  CRI_ATM_ACCT_SELECTION        VARCHAR2(1 BYTE),
  CRI_RETREQ_ID                 VARCHAR2(12 BYTE),
  CRI_CENTRAL_PROC_DATE         VARCHAR2(4 BYTE),
  CRI_REIMB_ATTRIB              VARCHAR2(1 BYTE),
  CRI_TRANS_COMP_SEQ_NUMB_TCR1  VARCHAR2(1 BYTE),
  CRI_RESERVED_TCR1_1           VARCHAR2(12 BYTE),
  CRI_FAX_NUMBER                VARCHAR2(16 BYTE),
  CRI_INTERFACE_TRACE_NUMB      VARCHAR2(6 BYTE),
  CRI_REQ_FULLFILL_METHOD       VARCHAR2(1 BYTE),
  CRI_EST_FULLFILL_METHOD       VARCHAR2(1 BYTE),
  CRI_ISSUER_RFC_BIN            VARCHAR2(6 BYTE),
  CRI_ISSUER_RFC_SUB_ADDR       VARCHAR2(7 BYTE),
  CRI_ISSUER_BILL_CURR_CODE     VARCHAR2(3 BYTE),
  CRI_BILL_TRANS_AMT            VARCHAR2(12 BYTE),
  CRI_TRANS_IDENT               VARCHAR2(15 BYTE),
  CRI_EXCLD_TRANS_ID_REASON     VARCHAR2(1 BYTE),
  CRI_CRS_PROCESS_CODE          VARCHAR2(1 BYTE),
  CRI_MULT_CLEARING_SEQ_NUMB    VARCHAR2(2 BYTE),
  CRI_RESERVED_TCR1_2           VARCHAR2(81 BYTE),
  CRI_TRANS_COMP_SEQ_NUMB_TCR4  VARCHAR2(1 BYTE),
  CRI_RESERVED_TCR4_1           VARCHAR2(12 BYTE),
  CRI_DEBIT_PROD_CODE           VARCHAR2(4 BYTE),
  CRI_CONTACT_FOR_INFO          VARCHAR2(25 BYTE),
  CRI_RESERVED_TCR4_2           VARCHAR2(123 BYTE),
  CRI_FILEGEN_FLAG              CHAR(1 BYTE),
  CRI_FILE_NAME                 VARCHAR2(25 BYTE),
  CRI_FILEGEN_USER              NUMBER(5),
  CRI_FILEGEN_DATE              DATE,
  CRI_INS_USER                  NUMBER(5),
  CRI_INS_DATE                  DATE,
  CRI_LUPD_USER                 NUMBER(5),
  CRI_LUPD_DATE                 DATE,
  CRI_UNIQ_ID                   NUMBER(15),
  CRI_ACTION_NO                 NUMBER(2)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

