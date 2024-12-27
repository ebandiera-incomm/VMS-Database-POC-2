CREATE TABLE VMSCMS.VMS_CCFFORMAT_PARAM
  (
    VCP_PARAM_ID   VARCHAR2(50 BYTE),
    VCP_PARAM_DESC VARCHAR2(100 BYTE),
    VCP_INS_USER   NUMBER(5,0),
    VCP_INS_DATE DATE NOT NULL ENABLE,
    VCP_LUPD_USER NUMBER(5,0),
    VCP_LUPD_DATE DATE NOT NULL ENABLE,
    VCP_PARAM_SECTION VARCHAR2(10 BYTE),
    VCP_INST_CODE     NUMBER(3,0),
    CONSTRAINT CHECK_CCFFORMAT_PARAM CHECK (VCP_PARAM_SECTION IN ('H','T','D')) ENABLE,
    CONSTRAINT PK_CCFFORMAT_PARAM PRIMARY KEY (VCP_INST_CODE, VCP_PARAM_SECTION, VCP_PARAM_ID)
  );