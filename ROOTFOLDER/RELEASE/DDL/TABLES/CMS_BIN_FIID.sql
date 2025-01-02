CREATE TABLE VMSCMS.CMS_BIN_FIID
(
  CBF_INST_CODE  NUMBER(3),
  CBF_BIN        NUMBER(6),
  CBF_FIID       VARCHAR2(4 BYTE)               NOT NULL,
  CBF_INS_USER   NUMBER(5),
  CBF_INS_DATE   DATE,
  CBF_LUPD_DATE  DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_BIN_FIID ADD (
  CONSTRAINT PK_CBF_BIN
 PRIMARY KEY
 (CBF_INST_CODE, CBF_BIN))
/

ALTER TABLE VMSCMS.CMS_BIN_FIID ADD (
  CONSTRAINT FK_BINFIID_INSTMAST 
 FOREIGN KEY (CBF_INST_CODE, CBF_BIN) 
 REFERENCES VMSCMS.CMS_BIN_MAST (CBM_INST_CODE,CBM_INST_BIN))
/
