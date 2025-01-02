CREATE TABLE VMSCMS.CMS_REGION_MAST
(
  CRM_INST_CODE    NUMBER(3),
  CRM_REGION_ID    VARCHAR2(8 BYTE),
  CRM_REGION_NAME  VARCHAR2(50 BYTE),
  CRM_INS_USER     NUMBER(5),
  CRM_INS_DATE     DATE,
  CRM_LUPD_USER    NUMBER(5),
  CRM_LUPD_DATE    DATE
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_REGION_MAST ADD (
  CONSTRAINT PK_REGION_ID
 PRIMARY KEY
 (CRM_REGION_ID))
/
