CREATE OR REPLACE PROCEDURE VMSCMS.SP_LOG_SUCCESS (PAN IN VARCHAR2,MBRNUMB IN VARCHAR2,PROCTYPE IN VARCHAR2,PROCID IN NUMBER, errmsg OUT VARCHAR2,CSL_MSG IN VARCHAR2 DEFAULT  ' ',CSL_ADDR_REPFLAG IN CHAR DEFAULT ' ')
AS
BEGIN
ERRMSG := 'OK' ;
INSERT INTO CMS_SUCCESS_LOG
       (
       CSL_INST_CODE     ,
       CSL_PAN_CODE       ,
       CSL_MBR_NUMB        ,
       CSL_PROCESS_TYPE     ,
       CSL_PROCESS_ID    ,
       CSL_MESSG     ,
       CSL_ADDR_REPFLAG
       )
   VALUES
       (
       1,
       PAN ,
       MBRNUMB,
       PROCTYPE,
       PROCID ,
       CSL_MSG ,
       CSL_ADDR_REPFLAG
       ) ;

END SP_LOG_SUCCESS ;
/
SHOW ERRORS

