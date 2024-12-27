CREATE TABLE VMSCMS.CMS_MERC_LOYL
(
  CML_INST_CODE   NUMBER(3)                     NOT NULL,
  CML_LOYL_CODE   NUMBER(3)                     NOT NULL,
  CML_MERC_CODE   VARCHAR2(8 BYTE)              NOT NULL,
  CML_TRANS_AMT   NUMBER(15,6)                  NOT NULL,
  CML_LOYL_POINT  NUMBER(1)                     NOT NULL,
  CML_INS_USER    NUMBER(5)                     NOT NULL,
  CML_INS_DATE    DATE                          NOT NULL,
  CML_LUPD_USER   NUMBER(5)                     NOT NULL,
  CML_LUPD_DATE   DATE                          NOT NULL
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_MERC_LOYL ADD (
  CONSTRAINT PK_MERC_LOYL
 PRIMARY KEY
 (CML_INST_CODE, CML_LOYL_CODE))
/

ALTER TABLE VMSCMS.CMS_MERC_LOYL ADD (
  CONSTRAINT FK_MERCLOYL_USERMAST1 
 FOREIGN KEY (CML_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_MERCLOYL_USERMAST2 
 FOREIGN KEY (CML_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_MERCLOYL_MERCMAST 
 FOREIGN KEY (CML_INST_CODE, CML_MERC_CODE) 
 REFERENCES VMSCMS.CMS_MERC_MAST (CMM_INST_CODE,CMM_MERC_CODE),
  CONSTRAINT FK_MERCLOYL_LOYLMAST 
 FOREIGN KEY (CML_INST_CODE, CML_LOYL_CODE) 
 REFERENCES VMSCMS.CMS_LOYL_MAST (CLM_INST_CODE,CLM_LOYL_CODE))
/

