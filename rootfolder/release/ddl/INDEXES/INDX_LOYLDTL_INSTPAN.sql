CREATE INDEX VMSCMS.INDX_LOYLDTL_INSTPAN ON VMSCMS.CMS_LOYL_DTL
(CLD_INST_CODE, CLD_PAN_CODE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


