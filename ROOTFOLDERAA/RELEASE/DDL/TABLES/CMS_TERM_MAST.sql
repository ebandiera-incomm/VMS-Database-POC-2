CREATE TABLE VMSCMS.CMS_TERM_MAST
(
  CTM_INST_CODE   NUMBER(3)                     NOT NULL,
  CTM_BANK_ID     VARCHAR2(11 BYTE)             NOT NULL,
  CTM_MERC_CODE   VARCHAR2(8 BYTE)              NOT NULL,
  CTM_TERM_ID     VARCHAR2(12 BYTE)             NOT NULL,
  CTM_CNTRY_CODE  NUMBER(3)                     NOT NULL,
  CTM_CITY_CODE   NUMBER(5)                     NOT NULL,
  CTM_REL_STAT    CHAR(1 BYTE)                  NOT NULL,
  CTM_INS_USER    NUMBER(5)                     NOT NULL,
  CTM_INS_DATE    DATE                          NOT NULL,
  CTM_LUPD_USER   NUMBER(5)                     NOT NULL,
  CTM_LUPD_DATE   DATE                          NOT NULL
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_TERM_MAST ADD (
  CONSTRAINT PK_TERM_MAST
 PRIMARY KEY
 (CTM_INST_CODE, CTM_BANK_ID, CTM_TERM_ID))
/

ALTER TABLE VMSCMS.CMS_TERM_MAST ADD (
  CONSTRAINT FK_TERMMAST_USERMAST1 
 FOREIGN KEY (CTM_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_TERMMAST_USERMAST2 
 FOREIGN KEY (CTM_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_TERMMAST_MERCMAST 
 FOREIGN KEY (CTM_INST_CODE, CTM_MERC_CODE) 
 REFERENCES VMSCMS.CMS_MERC_MAST (CMM_INST_CODE,CMM_MERC_CODE),
  CONSTRAINT FK_TERMMAST_CITYMAST 
 FOREIGN KEY (CTM_INST_CODE, CTM_CNTRY_CODE, CTM_CITY_CODE) 
 REFERENCES VMSCMS.GEN_CITY_MAST (GCM_INST_CODE,GCM_CNTRY_CODE,GCM_CITY_CODE) DISABLE)
/
