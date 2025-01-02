CREATE TABLE VMSCMS.CMS_SECURITY_QUESTIONS
(
  CSQ_INST_CODE    NUMBER(3),
  CSQ_CUST_ID      NUMBER(20),
  CSQ_QUESTION     VARCHAR2(200 BYTE),
  CSQ_ANSWER_HASH  VARCHAR2(100 BYTE)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

