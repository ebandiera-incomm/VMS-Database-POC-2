CREATE TABLE VMSCMS.CMS_GL_CATG
(
  CGC_INST_CODE   NUMBER(3)                     NOT NULL,
  CGC_CATG_CODE   NUMBER(2)                     NOT NULL,
  CGC_CATG_SNAME  VARCHAR2(3 BYTE)              NOT NULL,
  CGC_CATG_DESC   VARCHAR2(50 BYTE)             NOT NULL,
  CGC_LUPD_DATE   DATE,
  CGC_LUPD_USER   NUMBER(10),
  CGC_INS_DATE    DATE,
  CGC_INS_USER    NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

