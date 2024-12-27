CREATE TABLE VMSCMS.CMS_KEY_MASTER_HIST
(
  CKM_KEK_ENCR         VARCHAR2(50 BYTE),
  CKM_DEK_ENCR         VARCHAR2(50 BYTE),
  CKM_SERVICE_TYPE     VARCHAR2(50 BYTE),
  CKM_BIN              VARCHAR2(6 BYTE),
  CKM_INS_USER         NUMBER(5),
  CKM_INS_DATE         DATE,
  CKM_LUPD_USER        NUMBER(5),
  CKM_LUPD_DATE        DATE,
  CKM_INST_CODE        NUMBER(10),
  CKM_HSM_TYPE         VARCHAR2(6 BYTE),
  CKM_HSM_NUMBER       VARCHAR2(6 BYTE),
  CKM_INTERFACE_CODE   VARCHAR2(5 BYTE),
  PROCESS_TYPE         CHAR(1 BYTE),
  CKM_DEK_ENCR_NEWKEY  VARCHAR2(50 BYTE)
)
TABLESPACE CMS_DEFAULT
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

