CREATE TABLE VMSCMS.PCMS_CAF_INFO_ENTRY
(
  CCI_INST_CODE             NUMBER(3),
  CCI_FILE_NAME             VARCHAR2(35 BYTE),
  CCI_ROW_ID                VARCHAR2(8 BYTE)    NOT NULL,
  CCI_APPL_CODE             VARCHAR2(30 BYTE),
  CCI_APPL_NO               VARCHAR2(20 BYTE),
  CCI_PAN_CODE              VARCHAR2(19 BYTE),
  CCI_MBR_NUMB              VARCHAR2(3 BYTE),
  CCI_CRD_STAT              CHAR(1 BYTE),
  CCI_EXP_DAT               VARCHAR2(4 BYTE),
  CCI_REC_TYP               CHAR(1 BYTE),
  CCI_CRD_TYP               VARCHAR2(5 BYTE),
  CCI_REQUESTER_NAME        VARCHAR2(30 BYTE),
  CCI_PROD_CODE             VARCHAR2(12 BYTE),
  CCI_CARD_TYPE             NUMBER(2)           DEFAULT 1,
  CCI_SEG12_BRANCH_NUM      VARCHAR2(4 BYTE),
  CCI_FIID                  VARCHAR2(4 BYTE),
  CCI_TITLE                 VARCHAR2(5 BYTE),
  CCI_SEG12_NAME_LINE1      VARCHAR2(30 BYTE),
  CCI_SEG12_NAME_LINE2      VARCHAR2(30 BYTE),
  CCI_BIRTH_DATE            DATE,
  CCI_MOTHER_NAME           VARCHAR2(40 BYTE),
  CCI_SSN                   VARCHAR2(10 BYTE),
  CCI_HOBBIES               VARCHAR2(10 BYTE),
  CCI_CUST_ID               NUMBER(10),
  CCI_COMM_TYPE             VARCHAR2(3 BYTE),
  CCI_SEG12_ADDR_LINE1      VARCHAR2(34 BYTE),
  CCI_SEG12_ADDR_LINE2      VARCHAR2(34 BYTE),
  CCI_SEG12_CITY            VARCHAR2(22 BYTE),
  CCI_SEG12_STATE           VARCHAR2(3 BYTE),
  CCI_SEG12_POSTAL_CODE     VARCHAR2(15 BYTE),
  CCI_SEG12_COUNTRY_CODE    VARCHAR2(3 BYTE),
  CCI_SEG12_MOBILENO        VARCHAR2(15 BYTE),
  CCI_SEG12_HOMEPHONE_NO    VARCHAR2(40 BYTE),
  CCI_SEG12_OFFICEPHONE_NO  VARCHAR2(15 BYTE),
  CCI_SEG12_EMAILID         VARCHAR2(34 BYTE),
  CCI_SEG13_ADDR_LINE1      VARCHAR2(34 BYTE),
  CCI_SEG13_ADDR_LINE2      VARCHAR2(34 BYTE),
  CCI_SEG13_CITY            VARCHAR2(22 BYTE),
  CCI_SEG13_STATE           VARCHAR2(3 BYTE),
  CCI_SEG13_POSTAL_CODE     VARCHAR2(15 BYTE),
  CCI_SEG13_COUNTRY_CODE    VARCHAR2(3 BYTE),
  CCI_SEG13_MOBILENO        VARCHAR2(15 BYTE),
  CCI_SEG13_HOMEPHONE_NO    VARCHAR2(15 BYTE),
  CCI_SEG13_OFFICEPHONE_NO  VARCHAR2(15 BYTE),
  CCI_SEG13_EMAILID         VARCHAR2(34 BYTE),
  CCI_SEG31_LGTH            VARCHAR2(4 BYTE),
  CCI_SEG31_ACCT_CNT        VARCHAR2(4 BYTE),
  CCI_SEG31_TYP             VARCHAR2(2 BYTE),
  CCI_SEG31_NUM             VARCHAR2(19 BYTE),
  CCI_SEG31_STAT            CHAR(1 BYTE),
  CCI_PROD_AMT              VARCHAR2(10 BYTE),
  CCI_FEE_AMT               VARCHAR2(10 BYTE),
  CCI_TOT_AMT               VARCHAR2(10 BYTE),
  CCI_PAYMENT_MODE          VARCHAR2(15 BYTE),
  CCI_INSTRUMENT_NO         VARCHAR2(15 BYTE),
  CCI_INSTRUMENT_AMT        VARCHAR2(10 BYTE),
  CCI_DRAWN_DATE            VARCHAR2(20 BYTE),
  CCI_PAYREF_NO             VARCHAR2(20 BYTE),
  CCI_EMP_ID                VARCHAR2(15 BYTE),
  CCI_KYC_REASON            VARCHAR2(30 BYTE),
  CCI_KYC_FLAG              VARCHAR2(1 BYTE)    DEFAULT 'Y'                   NOT NULL,
  CCI_ADDON_FLAG            VARCHAR2(6 BYTE)    DEFAULT 'False',
  CCI_VIRTUAL_ACCT          VARCHAR2(19 BYTE),
  CCI_DOCUMENT_VERIFY       VARCHAR2(100 BYTE),
  CCI_EXCHANGE_RATE         VARCHAR2(25 BYTE),
  CCI_UPLD_STAT             VARCHAR2(1 BYTE),
  CCI_APPROVED              VARCHAR2(1 BYTE)    DEFAULT 'N',
  CCI_COMMENTS              VARCHAR2(200 BYTE),
  CCI_INSTRUMENT_REALISED   VARCHAR2(1 BYTE),
  CCI_PROCESS_MSG           VARCHAR2(500 BYTE),
  CCI_MAKER_USER_ID         NUMBER(5),
  CCI_MAKER_DATE            DATE,
  CCI_CHECKER_USER_ID       NUMBER(5),
  CCI_CHEKER_DATE           DATE,
  CCI_AUTH_USER_ID          NUMBER(5),
  CCI_AUTH_DATE             DATE,
  CCI_INS_USER              NUMBER(5),
  CCI_INS_DATE              DATE                NOT NULL,
  CCI_LUPD_USER             NUMBER(5),
  CCI_LUPD_DATE             DATE,
  CCI_CVV                   VARCHAR2(3 BYTE),
  CCI_KYCUPLOAD_USER_ID     NUMBER(5),
  CCI_KYCUPLOAD_DATE        DATE,
  CCI_KYCUPLOAD_FILENAME    VARCHAR2(50 BYTE),
  CCI_KYCPROCESS_STAT       VARCHAR2(1 BYTE),
  CCI_KYCPRCESS_MESSAGE     VARCHAR2(300 BYTE),
  CCI_CARD_NUMBER           VARCHAR2(20 BYTE)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


