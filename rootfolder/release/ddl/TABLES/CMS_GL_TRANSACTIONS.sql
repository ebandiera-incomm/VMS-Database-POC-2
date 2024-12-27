CREATE TABLE VMSCMS.CMS_GL_TRANSACTIONS
(
  CGT_INST_CODE   NUMBER(5)                     NOT NULL,
  CGT_FUNC_CODE   VARCHAR2(10 BYTE)             NOT NULL,
  CGT_ACCOUNT_NO  VARCHAR2(19 BYTE)             NOT NULL,
  CGT_SPPRT_KEY   VARCHAR2(10 BYTE)             NOT NULL,
  CGT_TRANS_AMT   VARCHAR2(10 BYTE)             NOT NULL,
  CGT_INST_DATE   DATE                          NOT NULL,
  CGT_LUPD_USER   NUMBER(5)                     NOT NULL,
  CGT_LUPD_DATE   DATE                          NOT NULL,
  CGT_INS_USER    NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_GL_TRANSACTIONS ADD (
  CONSTRAINT FK_GLTRANSACTIONS_FUNCMAST 
 FOREIGN KEY (CGT_INST_CODE, CGT_FUNC_CODE) 
 REFERENCES VMSCMS.CMS_FUNC_MAST (CFM_INST_CODE,CFM_FUNC_CODE))
/

