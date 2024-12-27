CREATE TABLE VMSCMS.CMS_FEE_TYPES
(
  CFT_INST_CODE         NUMBER(3)               NOT NULL,
  CFT_FEETYPE_CODE      NUMBER(5)               NOT NULL,
  CFT_FEETYPE_DESC      VARCHAR2(30 BYTE)       NOT NULL,
  CFT_INS_USER          NUMBER(5)               NOT NULL,
  CFT_INS_DATE          DATE                    NOT NULL,
  CFT_LUPD_USER         NUMBER(5)               NOT NULL,
  CFT_LUPD_DATE         DATE                    NOT NULL,
  CFT_FEE_FREQ          VARCHAR2(2 BYTE)        NOT NULL,
  CFT_TRAN_CODE         VARCHAR2(4 BYTE),
  CFT_SUPP_CATG         VARCHAR2(2 BYTE),
  CFT_DELIVERY_CHANNEL  VARCHAR2(2 BYTE),
  CFT_FEE_TYPE          VARCHAR2(1 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_FEE_TYPES ADD (
  CONSTRAINT PK_FEE_TYPES
 PRIMARY KEY
 (CFT_INST_CODE, CFT_FEETYPE_CODE),
  CONSTRAINT UK_FEE_TYPES
 UNIQUE (CFT_FEETYPE_DESC))
/

ALTER TABLE VMSCMS.CMS_FEE_TYPES ADD (
  CONSTRAINT FK_FEETYPES_USERMAST1 
 FOREIGN KEY (CFT_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_FEETYPES_USERMAST2 
 FOREIGN KEY (CFT_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_FEETYPE_TRANCODE 
 FOREIGN KEY (CFT_TRAN_CODE, CFT_DELIVERY_CHANNEL, CFT_INST_CODE) 
 REFERENCES VMSCMS.TRANSCODE (TRANSCODE,DELIVERY_CHNNEL,ACT_INST_CODE))
/

