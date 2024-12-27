CREATE TABLE VMSCMS.CMS_INTERCHANGE_MAST
(
  CIM_INTERCHANGE_CODE  VARCHAR2(2 BYTE)        NOT NULL,
  CIM_INTERCHANGE_NAME  VARCHAR2(20 BYTE)       NOT NULL,
  CIM_INS_USER          NUMBER(5)               NOT NULL,
  CIM_INS_DATE          DATE                    NOT NULL,
  CIM_LUPD_USER         NUMBER(5)               NOT NULL,
  CIM_LUPD_DATE         DATE                    NOT NULL,
  CIM_INST_CODE         NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_INTERCHANGE_MAST ADD (
  CONSTRAINT PK_INTERCHANGE_MAST
 PRIMARY KEY
 (CIM_INST_CODE, CIM_INTERCHANGE_CODE))
/

ALTER TABLE VMSCMS.CMS_INTERCHANGE_MAST ADD (
  CONSTRAINT FK_INTERMAST_USERMAST1 
 FOREIGN KEY (CIM_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_INTERMAST_USERMAST2 
 FOREIGN KEY (CIM_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN))
/

