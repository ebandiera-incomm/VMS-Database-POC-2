CREATE TABLE VMSCMS.CMS_INACTIVITY_FEE_DET
(
  CFD_INST_CODE     NUMBER(3),
  CFD_PAN_CODE      VARCHAR2(90 BYTE),
  CFD_FEE_CODE      NUMBER(4),
  CFD_FEE_AMNT      NUMBER(10,3),
  CFD_DEDITED_AMNT  NUMBER(10,3),
  CFD_INS_USER      NUMBER(5),
  CFD_INS_DATE      DATE,
  CFD_LUPD_USER     NUMBER(5),
  CFD_LUPD_DATE     DATE,
  CFD_PROCESS_MSG   VARCHAR2(300 BYTE),
  CFD_FEE_PLAN      NUMBER(4)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

