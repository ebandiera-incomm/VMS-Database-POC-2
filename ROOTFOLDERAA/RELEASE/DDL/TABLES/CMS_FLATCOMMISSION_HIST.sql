CREATE TABLE VMSCMS.CMS_FLATCOMMISSION_HIST
(
  CFH_INST_CODE        NUMBER(10),
  CFH_PLAN_AMT         NUMBER(10,4),
  CFH_PLAN_PERCENT     NUMBER(3),
  CFH_PAN_CODE         VARCHAR2(90 BYTE),
  CFH_PLAN_ID          VARCHAR2(10 BYTE),
  CFH_BRANCH_CODE      VARCHAR2(6 BYTE),
  CFH_COMMISSION_CALC  NUMBER(10,4),
  CFH_INS_USER         NUMBER(10),
  CFH_INS_DATE         DATE,
  CFH_LUPD_USER        NUMBER(10),
  CFH_LUPD_DATE        DATE,
  CFH_PAN_CODE_ENCR    RAW(100)
)
TABLESPACE CMS_HIST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

