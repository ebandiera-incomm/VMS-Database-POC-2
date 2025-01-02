create or replace
PACKAGE        PKG_DAILY_JOBS AS
    PROCEDURE PR_EOD_PASSIVEPERIOD_CALC(P_INST_CODE IN NUMBER,P_RESP_MSG OUT VARCHAR2);
    PROCEDURE PR_CALC_INACTIVE_FEES(P_INSTCODE IN NUMBER,P_LUPDUSER IN NUMBER,P_RUNDATE IN DATE,P_ERRMSG OUT VARCHAR2);
    PROCEDURE PR_PASSIVE_CALC (P_INSTCODE IN NUMBER,P_LUPDUSER IN NUMBER);
END PKG_DAILY_JOBS; 
/
show error