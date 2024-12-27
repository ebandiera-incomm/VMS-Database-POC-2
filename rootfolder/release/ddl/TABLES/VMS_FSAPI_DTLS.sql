CREATE TABLE VMSCMS.VMS_FSAPI_DTLS
  (
    VFD_INST_CODE        NUMBER(3,0),
    VFD_API_NAME         VARCHAR2(50 BYTE) NOT NULL ENABLE,
    VFD_REQ_FIELDS       VARCHAR2(2000 BYTE) NOT NULL ENABLE,
    VFD_RES_FIELDS       VARCHAR2(2000 BYTE),
    VFD_API_URL          VARCHAR2(50 BYTE),
    VFD_SUBTAG_RESPFIELD VARCHAR2(500 BYTE),
    VFD_SUBTAG_REQFIELD  VARCHAR2(1000 BYTE),
    CONSTRAINT PK_VMS_FSAPI_DTLS PRIMARY KEY (VFD_API_NAME)
);	