CREATE TABLE VMSCMS.VMS_FSAPI_VALIDATIONDTLS
  (
    VFV_INST_CODE         NUMBER(3,0),
    VFV_API_NAME          VARCHAR2(50 BYTE) NOT NULL ENABLE,
    VFV_FIELD_NAME        VARCHAR2(50 BYTE) NOT NULL ENABLE,
    VFV_PAARENT_TAG       VARCHAR2(50 BYTE),
    VFV_DATA_TYPE         VARCHAR2(10 BYTE),
    VFV_FIELD_VALUES      VARCHAR2(100 BYTE),
    VFV_REGEX_EXPRESSION  VARCHAR2(200 BYTE),
    VFV_VALIDATION_TYPE   VARCHAR2(1 BYTE),
    VFV_VALIDATION_ERRMSG VARCHAR2(200 BYTE),
    VFV_RESPONSE_CODE     VARCHAR2(10 BYTE),
    VFV_SUB_TAG           VARCHAR2(500 BYTE),
    VFV_SUB_TAGFIELD      VARCHAR2(10 BYTE),
    CONSTRAINT PK_VMS_FSAPI_VALIDDTLS PRIMARY KEY (VFV_API_NAME, VFV_FIELD_NAME) 
  );
  
  