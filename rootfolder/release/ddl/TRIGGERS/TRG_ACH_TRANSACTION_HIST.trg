CREATE OR REPLACE TRIGGER VMSCMS.TRG_ACH_TRANSACTION_HIST
BEFORE UPDATE
OF PROCESSTYPE
ON transactionlog
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN

   IF :NEW.PROCESSTYPE = 'N'
   THEN
     Insert into ACH_TRANSACTION_HIST
     (
     MSGTYPE,RRN,DELIVERY_CHANNEL,TERMINAL_ID,DATE_TIME,
     TXN_CODE,TXN_TYPE,TXN_MODE,TXN_STATUS,RESPONSE_CODE,
     BUSINESS_DATE,BUSINESS_TIME,CUSTOMER_CARD_NO,TOPUP_CARD_NO,TOPUP_ACCT_NO,
     TOPUP_ACCT_TYPE,BANK_CODE,TOTAL_AMOUNT,RULE_INDICATOR,RULEGROUPID,
     MCCODE,CURRENCYCODE,ADDCHARGE,PRODUCTID,CATEGORYID,
     TIPS,DECLINE_RULEID,ATM_NAME_LOCATION,AUTH_ID,TRANS_DESC,
     AMOUNT,PREAUTHAMOUNT,PARTIALAMOUNT,MCCODEGROUPID,CURRENCYCODEGROUPID,
     TRANSCODEGROUPID,RULES,PREAUTH_DATE,CR_DR_FLAG,PROCESSES_FLAG,
     TRANSACTIONLOG,GL_UPD_FLAG,GL_EOD_FLAG,SYSTEM_TRACE_AUDIT_NO,INSTCODE,
     FEECODE,FEEATTACHTYPE,TRANFEE_AMT,SERVICETAX_AMT,CESS_AMT,
     TRANFEE_CR_ACCTNO,TRANFEE_DR_ACCTNO,TRAN_ST_CALC_FLAG,TRAN_CESS_CALC_FLAG,TRAN_ST_CR_ACCTNO,
     TRAN_ST_DR_ACCTNO,TRAN_CESS_CR_ACCTNO,TRAN_CESS_DR_ACCTNO,TRAN_REVERSE_FLAG,ADD_LUPD_DATE,
     ADD_LUPD_USER,ADD_INS_DATE,ADD_INS_USER,TRAN_CURR,PAN_TRANS_FLAG,
     CUSTOMER_CARD_NO_ENCR,TOPUP_CARD_NO_ENCR,CUSTOMER_ACCT_NO,ERROR_MSG,ORGNL_CARD_NO,
     ORGNL_RRN,ORGNL_BUSINESS_DATE,ORGNL_BUSINESS_TIME,ORGNL_TERMINAL_ID,REVERSAL_CODE,
     PROXY_NUMBER,ACCT_BALANCE,LEDGER_BALANCE,ADDR_VERIFY_RESPONSE,INTERNATION_IND_RESPONSE,
     FEE_REVERSAL_FLAG,ACHFILENAME,RETURNACHFILENAME,ODFI,RDFI,
     SECCODES,IMPDATE,PROCESSDATE,EFFECTIVEDATE,TRACENUMBER,
     ACHTRANTYPE_ID,INCOMING_CRFILEID,ACH_FILE_PATH,BEFRETRAN_LEDGERBAL,BEFRETRAN_AVAILBALANCE,
     ACHRETURNTFILE_TIMESTAMP,INDIDNUM,INDNAME,COMPANYNAME,COMPANYID,
     ACH_ID,COMPENTRYDESC,RESPONSE_ID,IPADDRESS,ANI,
     DNI,REMARK,CTD_INTERNATION_IND_RESPONSE,CUSTOMERLASTNAME,CARDSTATUS,
     PROCESSTYPE
     )
     VALUES
     (
     :OLD.MSGTYPE,:OLD.RRN,:OLD.DELIVERY_CHANNEL,:OLD.TERMINAL_ID,:OLD.DATE_TIME,
     :OLD.TXN_CODE,:OLD.TXN_TYPE,:OLD.TXN_MODE,:OLD.TXN_STATUS,:OLD.RESPONSE_CODE,
     :OLD.BUSINESS_DATE,:OLD.BUSINESS_TIME,:OLD.CUSTOMER_CARD_NO,:OLD.TOPUP_CARD_NO,:OLD.TOPUP_ACCT_NO,
     :OLD.TOPUP_ACCT_TYPE,:OLD.BANK_CODE,:OLD.TOTAL_AMOUNT,:OLD.RULE_INDICATOR,:OLD.RULEGROUPID,
     :OLD.MCCODE,:OLD.CURRENCYCODE,:OLD.ADDCHARGE,:OLD.PRODUCTID,:OLD.CATEGORYID,
     :OLD.TIPS,:OLD.DECLINE_RULEID,:OLD.ATM_NAME_LOCATION,:OLD.AUTH_ID,:OLD.TRANS_DESC,
     :OLD.AMOUNT,:OLD.PREAUTHAMOUNT,:OLD.PARTIALAMOUNT,:OLD.MCCODEGROUPID,:OLD.CURRENCYCODEGROUPID,
     :OLD.TRANSCODEGROUPID,:OLD.RULES,:OLD.PREAUTH_DATE,:OLD.CR_DR_FLAG,:OLD.PROCESSES_FLAG,
     :OLD.TRANSACTIONLOG,:OLD.GL_UPD_FLAG,:OLD.GL_EOD_FLAG,:OLD.SYSTEM_TRACE_AUDIT_NO,:OLD.INSTCODE,
     :OLD.FEECODE,:OLD.FEEATTACHTYPE,:OLD.TRANFEE_AMT,:OLD.SERVICETAX_AMT,:OLD.CESS_AMT,
     :OLD.TRANFEE_CR_ACCTNO,:OLD.TRANFEE_DR_ACCTNO,:OLD.TRAN_ST_CALC_FLAG,:OLD.TRAN_CESS_CALC_FLAG,:OLD.TRAN_ST_CR_ACCTNO,
     :OLD.TRAN_ST_DR_ACCTNO,:OLD.TRAN_CESS_CR_ACCTNO,:OLD.TRAN_CESS_DR_ACCTNO,:OLD.TRAN_REVERSE_FLAG,:OLD.ADD_LUPD_DATE,
     :OLD.ADD_LUPD_USER,:OLD.ADD_INS_DATE,:OLD.ADD_INS_USER,:OLD.TRAN_CURR,:OLD.PAN_TRANS_FLAG,
     :OLD.CUSTOMER_CARD_NO_ENCR,:OLD.TOPUP_CARD_NO_ENCR,:OLD.CUSTOMER_ACCT_NO,:OLD.ERROR_MSG,:OLD.ORGNL_CARD_NO,
     :OLD.ORGNL_RRN,:OLD.ORGNL_BUSINESS_DATE,:OLD.ORGNL_BUSINESS_TIME,:OLD.ORGNL_TERMINAL_ID,:OLD.REVERSAL_CODE,
     :OLD.PROXY_NUMBER,:OLD.ACCT_BALANCE,:OLD.LEDGER_BALANCE,:OLD.ADDR_VERIFY_RESPONSE,:OLD.INTERNATION_IND_RESPONSE,
     :OLD.FEE_REVERSAL_FLAG,:OLD.ACHFILENAME,:OLD.RETURNACHFILENAME,:OLD.ODFI,:OLD.RDFI,
     :OLD.SECCODES,:OLD.IMPDATE,:OLD.PROCESSDATE,:OLD.EFFECTIVEDATE,:OLD.TRACENUMBER,
     :OLD.ACHTRANTYPE_ID,:OLD.INCOMING_CRFILEID,:OLD.ACH_FILE_PATH,:OLD.BEFRETRAN_LEDGERBAL,:OLD.BEFRETRAN_AVAILBALANCE,
     :OLD.ACHRETURNTFILE_TIMESTAMP,:OLD.INDIDNUM,:OLD.INDNAME,:OLD.COMPANYNAME,:OLD.COMPANYID,
     :OLD.ACH_ID,:OLD.COMPENTRYDESC,:OLD.RESPONSE_ID,:OLD.IPADDRESS,:OLD.ANI,
     :OLD.DNI,:OLD.REMARK,
     --:OLD.CTD_INTERNATION_IND_RESPONSE, -- ISSUE TO BE FIXED, DISCUSS WITH SACHIN / SAGAR / SYED
     :OLD.INTERNATION_IND_RESPONSE,
     :OLD.CUSTOMERLASTNAME,:OLD.CARDSTATUS,
     :OLD.PROCESSTYPE
     
     );
   END IF;
END;
/


