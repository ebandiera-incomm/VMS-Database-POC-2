CREATE TABLE VMSCMS.CMS_LOYL_CATG
(
  CLC_INST_CODE   NUMBER(3)                     NOT NULL,
  CLC_CATG_CODE   NUMBER(3)                     NOT NULL,
  CLC_CATG_SNAME  VARCHAR2(4 BYTE)              NOT NULL,
  CLC_CATG_DESC   VARCHAR2(50 BYTE)             NOT NULL,
  CLC_CATG_PRIOR  NUMBER(3)                     NOT NULL,
  CLC_TAB_NAME    VARCHAR2(30 BYTE),
  CLC_INS_USER    NUMBER(5)                     NOT NULL,
  CLC_INS_DATE    DATE                          NOT NULL,
  CLC_LUPD_USER   NUMBER(5)                     NOT NULL,
  CLC_LUPD_DATE   DATE                          NOT NULL
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_LOYL_CATG ADD (
  CONSTRAINT PK_LOYL_CATG
 PRIMARY KEY
 (CLC_INST_CODE, CLC_CATG_CODE),
  CONSTRAINT UK_LOYL_CATG
 UNIQUE (CLC_CATG_SNAME) DISABLE)
/

ALTER TABLE VMSCMS.CMS_LOYL_CATG ADD (
  CONSTRAINT FK_LOYLCATG_USERMAST2 
 FOREIGN KEY (CLC_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_LOYLCATG_USERMAST1 
 FOREIGN KEY (CLC_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_LOYLCATG_INSTMAST 
 FOREIGN KEY (CLC_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE))
/

