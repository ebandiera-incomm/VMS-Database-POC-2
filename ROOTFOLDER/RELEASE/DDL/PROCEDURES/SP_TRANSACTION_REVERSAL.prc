create or replace
PROCEDURE        VMSCMS.SP_TRANSACTION_REVERSAL (P_INST_CODE  IN NUMBER,
                                          P_MSG_TYP             IN VARCHAR2,
                                          P_RVSL_CODE           IN VARCHAR2,
                                          P_RRN                 IN VARCHAR2,
                                          P_DELV_CHNL           IN VARCHAR2,
                                          P_TERMINAL_ID         IN VARCHAR2,
                                          P_MERC_ID             IN VARCHAR2,
                                          P_TXN_CODE            IN VARCHAR2,
                                          P_TXN_TYPE            IN VARCHAR2,
                                          P_TXN_MODE            IN VARCHAR2,
                                          P_BUSINESS_DATE       IN VARCHAR2,
                                          P_BUSINESS_TIME       IN VARCHAR2,
                                          P_CARD_NO             IN VARCHAR2,
                                          P_ACTUAL_AMT          IN NUMBER,
                                          P_BANK_CODE           IN VARCHAR2,
                                          P_STAN                IN VARCHAR2,
                                          P_REASON_CODE         IN VARCHAR2,
                                          P_TOCUST_CARD_NO      IN VARCHAR2,
                                          P_TOCUST_EXPRY_DATE   IN VARCHAR2,
                                          P_ORGNL_BUSINESS_DATE IN VARCHAR2,
                                          P_ORGNL_BUSINESS_TIME IN VARCHAR2,
                                          P_ORGNL_RRN           IN VARCHAR2,
                                          P_MBR_NUMB            IN VARCHAR2,
                                          P_ORGNL_TERMINAL_ID   IN VARCHAR2,
                                          P_CURR_CODE           IN VARCHAR2,
                                          P_ANI                 IN VARCHAR2,
                                          P_DNI                 IN VARCHAR2,
                                          P_MERCHANT_NAME       IN VARCHAR2,
                                          P_MERCHANT_CITY       IN VARCHAR2,
                                          /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
                                          P_NETWORK_ID         IN VARCHAR2,
                                          P_INTERCHANGE_FEEAMT IN NUMBER,
                                          P_MERCHANT_ZIP       IN VARCHAR2,
                                          /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
                                          P_NETWORK_SETL_DATE   IN VARCHAR2,  -- Added on 201112 for logging N/W settlement date in transactionlog
                                          P_MERCHANT_ID       IN VARCHAR2,
                                          P_MERCHANT_STATE    IN VARCHAR2, --Added on 21.03.2013 for Merchant Logging Info for the Reversal Txn
                                          P_NETWORKID_SWITCH    IN VARCHAR2, --Added on 20130626 for the Mantis ID 11344
                                          P_RESP_CDE     OUT VARCHAR2,
                                          P_RESP_MSG     OUT VARCHAR2,
                                          P_RESP_MSG_M24 OUT VARCHAR2,
                                          P_FEE_AMT      OUT NUMBER,--Added for C2C CR on 20-Dec-2012
                                            P_REVERSAL_AMOUNT OUT VARCHAR2, --Added  for  Mantis ID 13785 for To return the reversal amount on 21/03/201
                                            P_ORGDATETIME_FLAG IN VARCHAR DEFAULT 'Y'
                                            ) IS
  /**********************************************************************************************
       * Modified By     :  Sagar
      * Modified Date    :  07-Jan-2013
      * Modified Reason  :  To swap the postion of out parameters i.e. fee_amount and fee_plan
                            used in SP_TRAN_REVERSAL_FEES
      * Modified  For    :  Defect 9937
      * Reviewer         :  Dhiraj
      * Reviewed Date    :  07-Jan-2013
      * Release Number   :  CMS3.5.1_RI0023_B0011

      * Modified By      : Pankaj S.
      * Modified Date    : 09-Feb-2013
      * Modified Reason  : Product Category spend limit not being adhered to by VMS
      * Reviewer         : Dhiraj
      * Reviewed Date    :
      * Build Number     :

      * Modified By      : Pankaj S.
      * Modified Date    : 15-Mar-2013
      * Modified Reason  : Logging of system initiated card status change(FSS-390)
      * Reviewer         : Dhiraj
      * Reviewed Date    :
      * Build Number     : CMS3.5.1_RI0024_B0008

      * Modified By      : Sagar M.
      * Modified Date    : 19-Mar-2013
      * Modified Reason  : Logging of input merchant id in Transactionlog and
                           cms_transaction_log_dtl
      * Modified For     : FSS-970
      * Reviewer         : Dhiraj
      * Reviewed Date    : 19-Mar-2013
      * Build Number     : RI0024_B0004

      * Modified By      : Sachin P.
      * Modified Date    : 21-Mar-2013
      * Modified Reason  : Merchant Logging Info for the Reversal Txn
      * Modified For     : FSS-1077
      * Reviewer         : Dhiraj
      * Reviewed Date    :
      * Build Number     : CMS3.5.1_RI0024_B0008

      * Modified By      : Sachin P.
      * Modified Date    : 04-Apr-2013
      * Modified Reason  : Limit Profile not accounting for reversal
      * Modified For     : MVHOST-298
      * Reviewer         : Dhiraj
      * Reviewed Date    : 19-Apr-2013
      * Build Number     : RI0024.1_B0008


      * Modified by      :  Pankaj S.
      * Modified Reason  :  10871
      * Modified Date    :  18-Apr-2013
      * Reviewer         :  Dhiraj
      * Reviewed Date    :
      * Build Number     :  RI0024.1_B0013

      * Modified by      :  Saravanakumar
      * Modified for     :  11000
      * Modified Date    :  09-May-2013
      * Modified Reason  :  Commented logging of To_Card in Transactionlog table
      * Reviewer         :
      * Reviewed Date    :
      * Build Number     :  RI0024.1_B0019

      * Modified by      : Deepa T
      * Modified for     : Mantis ID 11344
      * Modified Reason  : Log the Network ID as ELAN
      * Modified Date    : 26-Jun-2013
      * Reviewer         : Dhiraj
      * Reviewed Date    : 27-06-2013
      * Build Number     : RI0024.2_B0009


      * Modified by       : Sachin P.
      * Modified for      : Mantis Id -11693
      * Modified Reason   : CR_DR_FLAG in transactionlog table is incorrectly inserted for the Reversal
                            Transactions(Original transaction's CR_DR flag is inserted)
      * Modified Date     : 25-Jul-2013
      * Reviewer          : Dhiraj
      * Reviewed Date     : 19-aug-2013
      *  Build Number     : RI0024.4_B0002

      * Modified by       : Sachin P.
      * Modified for      : Mantis Id:11695
      * Modified Reason   : Reversal Fee details(FeePlan id,FeeCode,Fee amount
                           and FeeAttach Type) are not logged in transactionlog
                           table.
      * Modified Date     : 30.07.2013
      * Reviewer          : Dhiraj
      * Reviewed Date     : 19-aug-2013
      * Build Number      : RI0024.4_B0002

      * Modified By       : Sai Prasad K S
      * Modified Date     : 16-Aug-2013
      * Modified Reason   : FWR-11
      * Build Number      : RI0024.4_B0004

      * Modified By       : SIVA ARCOT
      * Modified Date     : 10-Sep-2013
      * Modified Reason   : Mantis Id-0010997
      * Build Number      : RI0024.4_B0010

      * Modified by       : Siva Kumar M
      * Modified for      : LYFEHOST-73 &  LYFEHOST-74
      * Modified Reason   :  Network Acquirer ID & Fee Based on Network
      * Modified Date     :  30.09.2013
      * Reviewer          :  Dhiraj
      * Reviewed Date     :  30.09.2013
      * Build Number      :  RI0024.5_B0001

      * Modified by       : SUVIN S
      * Modified for      : JH 87
      * Modified Reason   : MMPOS Card Topup Reversal transaction declined with response code 89 for more than 4 round numbers and two decimals amount.
      * Modified Date     : 22.10.13
      * Reviewer          : Dhiraj
      * Reviewed Date     : 22.10.13
      * Build Number      : RI0024.6_B0002

      * Modified by       : SUVIN S
      * Modified for      : mantis id:0012841
      * Modified Reason   : 0012841: DEFECT:CMS:INCOMM:CR/DR flag of MMPOS card topup reversal transaction is displayed as incorrect
      * Modified Date     : 28.10.13
      * Reviewer          :
      * Reviewed Date     :
      * Build Number      : RI0024.6_B0004

     * Modified by       :  Pankaj S.
     * Modified Reason   :  Enabling Limit configuration and validation for Preauth(1.7.3.9 integartion)
     * Modified Date     :  23-Oct-2013
     * Reviewer          :  Dhiraj
     * Reviewed Date     :
     * Build Number      : RI0024.6_B0004

     * Modified by       :  Sagar More
     * Modified for      :  Mantis ID- 13063
     * Modified Reason   :  To pass international indicator and pos verfication as null for merchantdise return transactions
     * Modified Date     :  19-Nov-2013
     * Reviewer          :  Sagar
     * Reviewed Date     :  20-Nov-2013
     * Build Number      :  RI0024.6.1_B0002 (RI0024.6.4_B0001)

      * Modified by       : SUVIN S
      * Modified for      : mantis id:0012841
      * Modified Reason   : 0012841: DEFECT:CMS:INCOMM:Transactionlog CR/DR flag of MMPOS card topup reversal and card deactivation transaction were displayed as incorrect
      * Modified Date     : 21.11.13
      * Reviewer          : Dhiraj
      * Reviewed Date     : 21.11.13
      * Build Number      : RI0027_B0002

      * Modified by      :  Pankaj S.
      * Modified Reason  :  FWR-44
      * Modified Date    :  14-Jan-2014
      * Reviewer         :  Dhiraj
     * Reviewed Date    :  20-Jan-2014
     * Build Number     :  RI0027_B0004

     * Modified by      :  Pankaj S.
     * Modified Reason  :  13388
     * Modified Date    :  20-Jan-2014
     * Reviewer         :  Dhiraj
     * Reviewed Date    :  20-Jan-2014
     * Build Number     :  RI0027_B0004

     * Modified by      :  Santosh P.
     * Modified Reason  :  13555
     * Modified Date    :  29-Jan-2014
     * Reviewer         :  Dhiraj
     * Reviewed Date    :
     * Build Number     :  RI0027_B0005

     * Modified by      :  DHINAKARAN B
     * Modified for     :  FSS-1335
     * Modified Reason  :  To logging the international indicator in transactionlog.
     * Modified Date    :  07-JAN-2014
     * Reviewer         :  Dhiraj
     * Reviewed Date    :  07-JAN-2014
     * Build Number     :  RI0027_B0003

     * Modified by      :  Siva Kumar M
     * Modified for     :  Mantis ID:13627
     * Modified Reason  :  To logging the topup card account,ledger balance in transactionlog.
     * Modified Date    :  12-FEB-2014
     * Reviewer         :  Dhiraj
     * Reviewed Date    :
     * Build Number     : RI0027.1_B0001

     * Modified by       : Sagar
     * Modified for      :
     * Modified Reason   : Concurrent Processsing Issue
                            (1.7.6.7 changes integarted)
     * Modified Date     : 04-Mar-2014
     * Reviewer          : Dhiarj
     * Reviewed Date     : 06-Mar-2014
     * Build Number      : RI0027.1.1_B0001

     * Modified by       :  MageshKumar S
     * Modified for      :  MVCSD-4479
     * Modified Reason   :  Saving-spend count decriment
     * Modified Date     :  06-03-2014
     * Reviewer          :
     * Reviewed Date     :
     * Build Number      :

 * Modified by       : Abdul Hameed M.A
     * Modified for      : Mantis ID 13893
     * Modified Reason   : Added card number for duplicate RRN check
     * Modified Date     : 06-Mar-2014
     * Reviewer          : Dhiraj
     * Reviewed Date     : 06-Mar-2014
     * Build Number      : RI0027.2_B0002

     * Modified by       : Abdul Hameed M.A
     * Modified for      : Mantis ID 13785
     * Modified Reason   : To return the reversal amount
     * Modified Date     : 21-Mar-2014
     * Reviewer          : Pankaj S.
     * Reviewed Date     : 01-April-2014
     * Build Number      : RI0027.2_B0003

      * Modified by       : Abdul Hameed M.A
     * Modified for      : Mantis ID 13410
     * Modified Reason   : Cr/Dr flag displaying wrongly in transaction log for MMPOS cashwithdrawal Reversal
     * Modified Date     : 08-Jul-2014
     * Reviewer          : Spankaj
     * Build Number      : RI0027.3_B0003

     * Modified by       : MageshKumar S.
     * Modified Date     : 25-July-14
     * Modified For      : FWR-48
     * Modified reason   : GL Mapping removal changes
     * Reviewer          : Spankaj
     * Build Number      : RI0027.3.1_B0001

     * Modified by       : Sai Prasad
     * Modified Date     : 21-Aug-14
     * Modified For      : FWR-48 (Mantis 0015708)
     * Modified reason   : MMPOS topup reversal amount credited instead of debit
     * Reviewer          : Spankaj
     * Build Number      : RI0027.3.1_B0005

     * Modified by       : Sai Prasad
     * Modified Date     : 05-Oct-2014
     * Modified For      : FWR-70
     *Build No           : RI0027.4_B0003

     * Modified by       : Dhinakaran B
     * Modified for      : MVHOST-1041
     * Modified Date     : 11-Nov-2014
     * Reviewer          :
     * Build Number      :

     * Modified By      :  Narayanaswamy.T
     * Modified For     :  FSS-4118 - C2C transfer transactions must contain masked account number in comment with the from account and to account number
     * Modified Date    :  01-FEB-2016
     * Reviewer         :  Saravanakumar.A
     * Build Number     :  VMSGPRHOST_4.0

     * Modified by      : T.Narayanaswamy
     * Modified for     : FSS-4700
     * Modified Date    : 23-Sep-2016
     * Reviewer         : Saravanankumar
     * Build Number     : VMSGPRHOAT_4.9

     * Modified by          : Spankaj
     * Modified Date        : 21-Nov-2016
     * Modified For         :FSS-4762:VMS OTC Support for Instant Payroll Card
     * Reviewer             : Saravanakumar
     * Build Number         : VMSGPRHOSTCSD4.11

         * Modified By      : Saravana Kumar A
    * Modified Date    : 07/07/2017
    * Purpose          : Prod code and card type logging in statements log
    * Reviewer         : Pankaj S.
    * Release Number   : VMSGPRHOST17.07


        * Modified By      : Saravana Kumar A
    * Modified Date    : 07/13/2017
    * Purpose          : Currency code getting from prodcat profile
    * Reviewer         : Pankaj S.
    * Release Number   : VMSGPRHOST17.07
		 * Modified by       : DHINAKARAN B
     * Modified Date     : 18-Jul-17
     * Modified For      : FSS-5172 - B2B changes
     * Reviewer          : Saravanakumar A
     * Build Number      : VMSGPRHOST_17.07
	 
	 * Modified by       : Sivakumar
     * Modified Date     : 02-Feb-18
     * Modified For      : Consolidated FSAPI changes
     * Reviewer          : Saravanakumar A
     * Build Number      : VMSGPRHOST_18.01
	 
	  * Modified By      : Veneetha C
     * Modified Date    : 21-JAN-2019
     * Purpose          : VMS-622 Redemption delay for activations /reloads processed through ICGPRM
     * Reviewer         : Saravanan
     * Release Number   : VMSGPRHOST R11
     
     * Modified By      : Mageshkumar S
     * Modified Date    : 28-OCT-2020
     * Purpose          : VMS-3135:Location ID received in the MMPOS Reload transactions is not stored in VMS.
     * Reviewer         : SARAVANAKUMAR A
     * Release Number   : VMSGPRHOST_R37_B0003
     
     * Modified By      : Mageshkumar S
     * Modified Date    : 07-MAY-2021
     * Purpose          : VMS-3693:Card Reload and ReTry--B2B Spec Consolidation
     * Reviewer         : SARAVANAKUMAR A
     * Release Number   : VMSGPRHOST_R46_B0001
   *************************************************************************************************/
  V_ORGNL_DELIVERY_CHANNEL   TRANSACTIONLOG.DELIVERY_CHANNEL%TYPE;
  V_ORGNL_RESP_CODE          TRANSACTIONLOG.RESPONSE_CODE%TYPE;
  V_ORGNL_TERMINAL_ID        TRANSACTIONLOG.TERMINAL_ID%TYPE;
  V_ORGNL_TXN_CODE           TRANSACTIONLOG.TXN_CODE%TYPE;
  V_ORGNL_TXN_TYPE           TRANSACTIONLOG.TXN_TYPE%TYPE;
  V_ORGNL_TXN_MODE           TRANSACTIONLOG.TXN_MODE%TYPE;
  V_ORGNL_BUSINESS_DATE      TRANSACTIONLOG.BUSINESS_DATE%TYPE;
  V_ORGNL_BUSINESS_TIME      TRANSACTIONLOG.BUSINESS_TIME%TYPE;
  V_ORGNL_CUSTOMER_CARD_NO   TRANSACTIONLOG.CUSTOMER_CARD_NO%TYPE;
  V_ORGNL_TOTAL_AMOUNT       TRANSACTIONLOG.AMOUNT%TYPE;
  V_ACTUAL_AMT               NUMBER(9, 2);
  V_REVERSAL_AMT             NUMBER(9, 2);
  V_ORGNL_TXN_FEECODE        CMS_FEE_MAST.CFM_FEE_CODE%TYPE;
  V_ORGNL_TXN_FEEATTACHTYPE  TRANSACTIONLOG.FEEATTACHTYPE%TYPE;--Modified by Deepa on sep-17-2012
  V_ORGNL_TXN_TOTALFEE_AMT   TRANSACTIONLOG.TRANFEE_AMT%TYPE;
  V_ORGNL_TXN_SERVICETAX_AMT TRANSACTIONLOG.SERVICETAX_AMT%TYPE;
  V_ORGNL_TXN_CESS_AMT       TRANSACTIONLOG.CESS_AMT%TYPE;
  V_ORGNL_TRANSACTION_TYPE   TRANSACTIONLOG.CR_DR_FLAG%TYPE;
  V_ACTUAL_DISPATCHED_AMT    TRANSACTIONLOG.AMOUNT%TYPE;
  V_RESP_CDE                 VARCHAR2(3);
  V_FUNC_CODE                CMS_FUNC_MAST.CFM_FUNC_CODE%TYPE;
  V_DR_CR_FLAG               TRANSACTIONLOG.CR_DR_FLAG%TYPE;
  V_ORGNL_TRANDATE           DATE;
  V_RVSL_TRANDATE            DATE;
  V_ORGNL_TERMID             TRANSACTIONLOG.TERMINAL_ID%TYPE;
  V_ORGNL_MCCCODE            TRANSACTIONLOG.MCCODE%TYPE;
  V_ERRMSG                   VARCHAR2(300):='OK'; --Modified for 10871
  V_ACTUAL_FEECODE           TRANSACTIONLOG.FEECODE%TYPE;
  V_ORGNL_TRANFEE_AMT        TRANSACTIONLOG.TRANFEE_AMT%TYPE;
  V_ORGNL_SERVICETAX_AMT     TRANSACTIONLOG.SERVICETAX_AMT%TYPE;
  V_ORGNL_CESS_AMT           TRANSACTIONLOG.CESS_AMT%TYPE;
  V_ORGNL_CR_DR_FLAG         TRANSACTIONLOG.CR_DR_FLAG%TYPE;
  V_ORGNL_TRANFEE_CR_ACCTNO  TRANSACTIONLOG.TRANFEE_CR_ACCTNO%TYPE;
  V_ORGNL_TRANFEE_DR_ACCTNO  TRANSACTIONLOG.TRANFEE_DR_ACCTNO%TYPE;
  V_ORGNL_ST_CALC_FLAG       TRANSACTIONLOG.TRAN_ST_CALC_FLAG%TYPE;
  V_ORGNL_CESS_CALC_FLAG     TRANSACTIONLOG.TRAN_CESS_CALC_FLAG%TYPE;
  V_ORGNL_ST_CR_ACCTNO       TRANSACTIONLOG.TRAN_ST_CR_ACCTNO%TYPE;
  V_ORGNL_ST_DR_ACCTNO       TRANSACTIONLOG.TRAN_ST_DR_ACCTNO%TYPE;
  V_ORGNL_CESS_CR_ACCTNO     TRANSACTIONLOG.TRAN_CESS_CR_ACCTNO%TYPE;
  V_ORGNL_CESS_DR_ACCTNO     TRANSACTIONLOG.TRAN_CESS_DR_ACCTNO%TYPE;
  V_PROD_CODE                CMS_APPL_PAN.CAP_PROD_CODE%TYPE;
  V_CARD_TYPE                CMS_APPL_PAN.CAP_CARD_TYPE%TYPE;
  V_GL_UPD_FLAG              TRANSACTIONLOG.GL_UPD_FLAG%TYPE;
  V_TRAN_REVERSE_FLAG        TRANSACTIONLOG.TRAN_REVERSE_FLAG%TYPE;
  V_SAVEPOINT                NUMBER DEFAULT 1;
  V_CURR_CODE                TRANSACTIONLOG.CURRENCYCODE%TYPE;
  V_AUTH_ID                  TRANSACTIONLOG.AUTH_ID%TYPE;
  V_TERMINAL_INDICATOR       PCMS_TERMINAL_MAST.PTM_TERMINAL_INDICATOR%TYPE;
  V_CUTOFF_TIME              VARCHAR2(5);
  V_BUSINESS_TIME            VARCHAR2(5);
  EXP_RVSL_REJECT_RECORD EXCEPTION;
  V_ATM_USAGEAMNT      CMS_TRANSLIMIT_CHECK.CTC_ATMUSAGE_AMT%TYPE;
  V_POS_USAGEAMNT      CMS_TRANSLIMIT_CHECK.CTC_POSUSAGE_AMT%TYPE;
  V_CARD_ACCT_NO       VARCHAR2(20);
  V_TRAN_SYSDATE       DATE;
  V_TRAN_CUTOFF        DATE;
  V_HASH_PAN           CMS_APPL_PAN.CAP_PAN_CODE%TYPE;
  V_ENCR_PAN           CMS_APPL_PAN.CAP_PAN_CODE_ENCR%TYPE;
  V_TRAN_AMT           NUMBER;
  V_DELCHANNEL_CODE    VARCHAR2(2);
  V_CARD_CURR          VARCHAR2(5);
  V_RRN_COUNT          NUMBER;
  V_BASE_CURR          CMS_INST_PARAM.CIP_PARAM_VALUE%TYPE;
  V_CURRCODE           VARCHAR2(3);
  V_ACCT_BALANCE       NUMBER;
  V_TRAN_DESC          CMS_TRANSACTION_MAST.CTM_TRAN_DESC%TYPE;
  V_ATM_USAGELIMIT     CMS_TRANSLIMIT_CHECK.CTC_ATMUSAGE_LIMIT%TYPE;
  V_POS_USAGELIMIT     CMS_TRANSLIMIT_CHECK.CTC_POSUSAGE_LIMIT%TYPE;
  V_BUSINESS_DATE_TRAN DATE;
  V_ORGNL_TXN_AMNT     TRANSACTIONLOG.AMOUNT%TYPE;                        -- Modified for JH-87
  V_MMPOS_USAGEAMNT    CMS_TRANSLIMIT_CHECK.CTC_MMPOSUSAGE_AMT%TYPE;
  V_DC_CODE            VARCHAR2(30);
  V_PROXUNUMBER        CMS_APPL_PAN.CAP_PROXY_NUMBER%TYPE;
  V_ACCT_NUMBER        CMS_APPL_PAN.CAP_ACCT_NO%TYPE;
  V_LEDGE_BALANCE      NUMBER;
  V_AUTHID_DATE        VARCHAR2(8);
 -- V_ORGNL_DRACCT_NO    CMS_FUNC_PROD.CFP_DRACCT_NO%TYPE; --commented for fwr-48
  V_MAX_CARD_BAL       NUMBER;
  V_TXN_NARRATION      CMS_STATEMENTS_LOG.CSL_TRANS_NARRRATION%TYPE;
  V_FEE_NARRATION      CMS_STATEMENTS_LOG.CSL_TRANS_NARRRATION%TYPE;
  --Added by Deepa for the changes to include Merchant name,city and state in statements log
  V_TXN_MERCHNAME  CMS_STATEMENTS_LOG.CSL_MERCHANT_NAME%TYPE;
  V_FEE_MERCHNAME  CMS_STATEMENTS_LOG.CSL_MERCHANT_NAME%TYPE;
  V_TXN_MERCHCITY  CMS_STATEMENTS_LOG.CSL_MERCHANT_CITY%TYPE;
  V_FEE_MERCHCITY  CMS_STATEMENTS_LOG.CSL_MERCHANT_CITY%TYPE;
  V_TXN_MERCHSTATE CMS_STATEMENTS_LOG.CSL_MERCHANT_STATE%TYPE;
  V_FEE_MERCHSTATE CMS_STATEMENTS_LOG.CSL_MERCHANT_STATE%TYPE;
  V_MBR_NUMB       VARCHAR2(3);
  --Added by Deepa on June 26 2012 for Reversal Txn fee
  V_FEE_AMT   NUMBER;
  V_FEE_PLAN  CMS_FEE_PLAN.CFP_PLAN_ID%TYPE;
  V_TXN_TYPE  NUMBER(1);
  V_TRAN_DATE DATE;
  --Sn Added by Pankaj S. for FSS-390
  v_chnge_crdstat   VARCHAR2(2):='N';
  v_cap_card_stat   cms_appl_pan.cap_card_stat%TYPE;
  --En Added by Pankaj S. for FSS-390

  v_prfl_code        cms_appl_pan.cap_prfl_code%TYPE; --Added on 04.04.2013 for MVHOST-298
  v_prfl_flag        cms_transaction_mast.ctm_prfl_flag%type;--Added on 04.04.2013 for MVHOST-298
  v_tran_type        cms_transaction_mast.ctm_tran_type%type;--Added on 04.04.2013 for MVHOST-298
  v_pos_verification transactionlog.pos_verification%type; --Added on 04.04.2013 for MVHOST-298
  v_internation_ind_response transactionlog.internation_ind_response %type;--Added on 04.04.2013 for MVHOST-298
  v_add_ins_date          transactionlog.add_ins_date %type;--Added on 18.04.2013 for MVHOST-298

  --Sn added by Pankaj S. for 10871
  v_acct_type    cms_acct_mast.cam_type_code%TYPE;
  v_timestamp    timestamp(3);
  --En added by Pankaj S. for 10871
  V_FEE_CODE           CMS_FEE_MAST.CFM_FEE_CODE%TYPE; --Added on 30.07.2013 for 11695
  V_ORGNL_TXN_FEE_PLAN     TRANSACTIONLOG.FEE_PLAN%TYPE; --Added for FWR-11
  V_FEEATTACH_TYPE     VARCHAR2(2); --Added on 30.07.2013 for 11695

  v_feecap_flag VARCHAR2(1);
  v_orgnl_fee_amt  CMS_FEE_MAST.CFM_FEE_AMT%TYPE; --Added for FWR-11
  V_REVERSAL_AMT_FLAG VARCHAR2(1) := 'F';  ---Added for Mantis Id-0010997
  --Sn Added for FWR-44
  v_cust_acct_no      cms_acct_mast.cam_acct_no%TYPE;
  v_topup_card_no     transactionlog.topup_card_no%TYPE;
  v_topup_acct_no     transactionlog.topup_acct_no%TYPE;
  v_topup_acct_type     transactionlog.topup_acct_type%TYPE;
  v_timeout_rev       VARCHAR2(2):='N';
  --En Added for FWR-44
    V_Networkidcount  Number Default 0; -- lyfe changes.
    V_TOPUP_CARD_NO_ENCR   TRANSACTIONLOG.TOPUP_CARD_NO_ENCR%TYPE;--Added for Mantis 13555 on 29 Jan 14


    V_ACCT_BALANCE_TO CMS_ACCT_MAST.CAM_ACCT_BAL%TYPE;  -- added for Mantis Id:13627
    V_LEDGE_BALANCE_TO CMS_ACCT_MAST.CAM_LEDGER_BAL%TYPE;  -- added for Mantis Id:13627

    V_INTERCHANGE_FEEAMT   number default 0;
    v_mrlimitbreach_count  number default 0;
    v_mrminmaxlmt_ignoreflag  VARCHAR2 (1) default 'N';
     --Sn Added for FSS-4647
    v_redmption_delay_flag   cms_prod_cattype.cpc_redemption_delay_flag%TYPE;
    v_txn_redmption_flag  cms_transaction_mast.ctm_redemption_delay_flag%TYPE;
    --En Added for FSS-4647
    V_TIME_DIFF               NUMBER;
    V_TIME_OUT_VALUE          NUMBER;
    v_reason_code          vms_reason_mast.VRM_ENUM_VAL%TYPE;
	 v_Retperiod  date;  --Added for VMS-5739/FSP-991
		 v_Retdate  date; --Added for VMS-5739/FSP-991

  CURSOR FEEREVERSE IS
    SELECT CSL_TRANS_NARRRATION,
         CSL_MERCHANT_NAME,
         CSL_MERCHANT_CITY,
         CSL_MERCHANT_STATE,
         CSL_TRANS_AMOUNT
     FROM VMSCMS.CMS_STATEMENTS_LOG_VW  --Added for VMS-5733/FSP-991
    WHERE CSL_BUSINESS_DATE = V_ORGNL_BUSINESS_DATE AND
         CSL_BUSINESS_TIME = V_ORGNL_BUSINESS_TIME AND
         CSL_RRN = P_ORGNL_RRN AND
         CSL_DELIVERY_CHANNEL = V_ORGNL_DELIVERY_CHANNEL AND
         CSL_TXN_CODE = V_ORGNL_TXN_CODE AND
         CSL_PAN_NO = V_ORGNL_CUSTOMER_CARD_NO AND
         CSL_INST_CODE = P_INST_CODE AND TXN_FEE_FLAG = 'Y';
		

BEGIN

  P_RESP_CDE := '00';
  P_RESP_MSG := 'OK';
  V_MBR_NUMB := TRIM(P_MBR_NUMB);


  SAVEPOINT V_SAVEPOINT;

  --SN CREATE HASH PAN
  BEGIN
    V_HASH_PAN := GETHASH(P_CARD_NO);
  EXCEPTION
    WHEN OTHERS THEN
     V_ERRMSG := 'Error while converting pan ' || SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;
  --EN CREATE HASH PAN

  --SN create encr pan
  BEGIN
    V_ENCR_PAN := FN_EMAPS_MAIN(P_CARD_NO);
  EXCEPTION
    WHEN OTHERS THEN
     V_ERRMSG := 'Error while converting pan ' || SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;
  --EN create encr pan

  --Sn find the type of orginal txn (credit or debit)
  BEGIN
    SELECT CTM_CREDIT_DEBIT_FLAG,
         CTM_TRAN_DESC,
         TO_NUMBER(DECODE(CTM_TRAN_TYPE, 'N', '0', 'F', '1')),
          CTM_PRFL_FLAG,CTM_TRAN_TYPE, --Added on 04.04.2013 for MVHOST-298
          NVL(ctm_redemption_delay_flag,'N')
     INTO V_DR_CR_FLAG, V_TRAN_DESC, V_TXN_TYPE,
          v_prfl_flag,v_tran_type, --Added on 04.04.2013 for MVHOST-298
          v_txn_redmption_flag
     FROM CMS_TRANSACTION_MAST
    WHERE CTM_TRAN_CODE = P_TXN_CODE AND
         CTM_DELIVERY_CHANNEL = P_DELV_CHNL AND
         CTM_INST_CODE = P_INST_CODE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'Transaction detail is not found in master for orginal txn code' ||
                P_TXN_CODE || 'delivery channel ' || P_DELV_CHNL;
     RAISE EXP_RVSL_REJECT_RECORD;
    WHEN OTHERS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'Problem while selecting debit/credit flag ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;

  --En find the type of orginal txn (credit or debit)
  
  v_reason_code := P_REASON_CODE;
   
   IF  (P_DELV_CHNL='17' AND P_TXN_CODE ='03') THEN
   
     BEGIN

        SELECT VRM_REASON_DESC,VRM_REASON_CODE
           into V_TRAN_DESC,v_reason_code
           from vms_reason_mast
          where VRM_ENUM_VAL=upper(v_reason_code)
          AND VRM_REASON_TYPE is null;
          
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
          V_TRAN_DESC := V_TRAN_DESC;
         WHEN OTHERS
             THEN
             V_RESP_CDE := '21';
             V_ERRMSG := 'Error while transaction description '  || SUBSTR (SQLERRM, 1, 200);
         RAISE EXP_RVSL_REJECT_RECORD;
        END;
   
   END IF;

  --Sn generate auth id
  BEGIN
    --    SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') INTO V_AUTHID_DATE FROM DUAL;

    -- SELECT V_AUTHID_DATE || LPAD(SEQ_AUTH_ID.NEXTVAL, 6, '0')
    SELECT LPAD(SEQ_AUTH_ID.NEXTVAL, 6, '0') INTO V_AUTH_ID FROM DUAL;

  EXCEPTION
    WHEN OTHERS THEN
     V_ERRMSG   := 'Error while generating authid ' ||
                SUBSTR(SQLERRM, 1, 300);
     V_RESP_CDE := '21'; -- Server Declined
     RAISE EXP_RVSL_REJECT_RECORD;
  END;

  --En generate auth id

  BEGIN
    V_ORGNL_TRANDATE := TO_DATE(SUBSTR(TRIM(P_ORGNL_BUSINESS_DATE), 1, 8),
                          'yyyymmdd');
    V_RVSL_TRANDATE  := TO_DATE(SUBSTR(TRIM(P_BUSINESS_DATE), 1, 8),
                          'yyyymmdd');

  EXCEPTION
    WHEN OTHERS THEN
     V_RESP_CDE := '45';
     V_ERRMSG   := 'Problem while converting transaction date ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;

  --Sn get date
  BEGIN
    V_ORGNL_TRANDATE := TO_DATE(SUBSTR(TRIM(P_ORGNL_BUSINESS_DATE), 1, 8) || ' ' ||
                          SUBSTR(TRIM(P_ORGNL_BUSINESS_TIME), 1, 8),
                          'yyyymmdd hh24:mi:ss');
    V_RVSL_TRANDATE  := TO_DATE(SUBSTR(TRIM(P_BUSINESS_DATE), 1, 8) || ' ' ||
                          SUBSTR(TRIM(P_BUSINESS_TIME), 1, 8),
                          'yyyymmdd hh24:mi:ss');
    V_TRAN_DATE      := V_RVSL_TRANDATE;

  EXCEPTION
    WHEN OTHERS THEN
     V_RESP_CDE := '32';
     V_ERRMSG   := 'Problem while converting transaction Time ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;
  --En get date

  --Sn Duplicate RRN Check

/*  BEGIN

    SELECT COUNT(1)
     INTO V_RRN_COUNT
     FROM TRANSACTIONLOG
    WHERE RRN = P_RRN AND BUSINESS_DATE = P_BUSINESS_DATE AND
         DELIVERY_CHANNEL = P_DELV_CHNL; --Added by ramkumar.Mk on 25 march 2012

    IF V_RRN_COUNT > 0 THEN

     V_RESP_CDE := '22'; -- Modified the response code variable name since this name only used to fetch the external response code. 20-June-2011
     V_ERRMSG   := 'Duplicate RRN on' || P_BUSINESS_DATE;
     RAISE EXP_RVSL_REJECT_RECORD;

    END IF;

  END;*/
 -- MODIFIED BY ABDUL HAMEED M.A ON 06-03-2014
  BEGIN
      sp_dup_rrn_check (V_HASH_PAN, P_RRN, P_BUSINESS_DATE, P_DELV_CHNL, P_MSG_TYP, P_TXN_CODE, V_ERRMSG);
      IF V_ERRMSG <> 'OK' THEN
        v_resp_cde := '22';
        RAISE EXP_RVSL_REJECT_RECORD;
      END IF;
    EXCEPTION
    WHEN EXP_RVSL_REJECT_RECORD THEN
      RAISE;
    WHEN OTHERS THEN
      v_resp_cde := '22';
      V_ERRMSG  := 'Error while checking RRN' || SUBSTR (SQLERRM, 1, 200);
      RAISE EXP_RVSL_REJECT_RECORD;
    END;

  --En Duplicate RRN Check

  --Select the Delivery Channel code of MM-POS
  BEGIN
    IF P_DELV_CHNL = '04' THEN
     V_DC_CODE := 'MMPOS';
    ELSIF P_DELV_CHNL = '07' THEN
     V_DC_CODE := 'IVR';
    ELSIF P_DELV_CHNL = '02' THEN
     V_DC_CODE := 'POS';
    ELSIF P_DELV_CHNL = '10' THEN
     V_DC_CODE := 'CHW';
    ELSIF P_DELV_CHNL = '08' THEN
     V_DC_CODE := 'SPIL';
    ELSIF P_DELV_CHNL = '12' THEN
     V_DC_CODE := 'MPAY';
    ELSIF P_DELV_CHNL = '01' THEN
     V_DC_CODE := 'ATM';
    --Sn Added for FWR-44
    ELSIF P_DELV_CHNL = '13' THEN
     V_DC_CODE := 'MOB';
    --En Added for FWR-44
    --Sn Added for Mantis-13388
    ELSIF P_DELV_CHNL = '05' THEN
     V_DC_CODE := 'HOST';
    --En Added for Mantis-13388
    ELSIF P_DELV_CHNL = '17' THEN
     V_DC_CODE := 'WEB';

    END IF;
    SELECT CDM_CHANNEL_CODE
     INTO V_DELCHANNEL_CODE
     FROM CMS_DELCHANNEL_MAST
    WHERE CDM_CHANNEL_DESC = V_DC_CODE AND CDM_INST_CODE = P_INST_CODE;


    BEGIN

    SELECT CAP_PROD_CODE, CAP_CARD_TYPE, CAP_PROXY_NUMBER, CAP_ACCT_NO,cap_card_stat,
           cap_prfl_code --Added on 04.04.2013 for MVHOST-298
     INTO V_PROD_CODE, V_CARD_TYPE, V_PROXUNUMBER, V_ACCT_NUMBER,v_cap_card_stat,  --v_cap_card_stat added for FSS-390
          v_prfl_code --Added on 04.04.2013 for MVHOST-298
     FROM CMS_APPL_PAN
    WHERE CAP_INST_CODE = P_INST_CODE AND CAP_PAN_CODE = V_HASH_PAN;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := P_CARD_NO || ' Card no not in master';
     RAISE EXP_RVSL_REJECT_RECORD;

    WHEN OTHERS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'Error while retriving card detail ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;

  END;
    --IF the DeliveryChannel is MMPOS then the base currency will be the txn curr

    IF P_CURR_CODE IS NULL AND V_DELCHANNEL_CODE = P_DELV_CHNL THEN

     BEGIN
      /* SELECT CIP_PARAM_VALUE
        INTO V_BASE_CURR
        FROM CMS_INST_PARAM
        WHERE CIP_INST_CODE = P_INST_CODE AND CIP_PARAM_KEY = 'CURRENCY';*/
--                   SELECT TRIM (cbp_param_value) INTO V_BASE_CURR
--                   FROM cms_bin_param
--                   WHERE cbp_param_name = 'Currency'
--                   AND (CBP_INST_CODE, CBP_PROFILE_CODE) IN (
--                   SELECT CPC_INST_CODE, CPC_PROFILE_CODE
--                   FROM cms_appl_pan, cms_prod_CATTYPE
--                   WHERE CPC_INST_CODE = CAP_INST_CODE
--                   AND cap_prod_code = cpC_prod_code AND CPC_CARD_TYPE=CAP_CARD_TYPE
--                   AND cap_pan_code = v_hash_pan);

vmsfunutilities.get_currency_code(v_prod_code,v_card_type,P_INST_CODE,V_BASE_CURR,v_errmsg);

      if v_errmsg<>'OK' then
           raise EXP_RVSL_REJECT_RECORD;
      end if;

       IF TRIM(V_BASE_CURR) IS NULL THEN
        V_ERRMSG := 'Base currency cannot be null ';
        RAISE EXP_RVSL_REJECT_RECORD;
       END IF;
     EXCEPTION
       WHEN EXP_RVSL_REJECT_RECORD THEN
        RAISE EXP_RVSL_REJECT_RECORD;
       WHEN OTHERS THEN
        V_ERRMSG := 'Error while selecting bese currecy  ' ||
                  SUBSTR(SQLERRM, 1, 200);
        RAISE EXP_RVSL_REJECT_RECORD;
     END;

     V_CURRCODE := V_BASE_CURR;

    ELSE
     V_CURRCODE := P_CURR_CODE;
    END IF;
  END;

  --Sn check msg type
  IF (V_DELCHANNEL_CODE <> P_DELV_CHNL) THEN

    IF (P_MSG_TYP NOT IN ('0400', '0410', '0420', '0430')) OR
      (P_RVSL_CODE = '00') THEN
     V_RESP_CDE := '12';
     V_ERRMSG   := 'Not a valid reversal request';
     RAISE EXP_RVSL_REJECT_RECORD;
    END IF;
  END IF;
  --En check msg type

  --Sn check orginal transaction    (-- Amount is missing in reversal request)
  BEGIN
  IF P_ORGDATETIME_FLAG = 'Y' THEN
  --Added for VMS-5739/FSP-991
 select (add_months(trunc(sysdate,'MM'),'-'||RETENTION_PERIOD))
       INTO   v_Retperiod 
       FROM DBA_OPERATIONS.ARCHIVE_MGMNT_CTL 
       WHERE  OPERATION_TYPE='ARCHIVE' 
       AND OBJECT_NAME='TRANSACTIONLOG_EBR';
       
       v_Retdate := TO_DATE(SUBSTR(TRIM(P_ORGNL_BUSINESS_DATE), 1, 8), 'yyyymmdd');


IF (v_Retdate>v_Retperiod)
    THEN
    SELECT DELIVERY_CHANNEL,
         TERMINAL_ID,
         RESPONSE_CODE,
         TXN_CODE,
         TXN_TYPE,
         TXN_MODE,
         BUSINESS_DATE,
         BUSINESS_TIME,
         CUSTOMER_CARD_NO,
         TOTAL_AMOUNT, --Total Transaction amount
         FEE_PLAN, --Added for FWR-11
         FEECODE,
         FEEATTACHTYPE, -- card level / prod cattype level
         TRANFEE_AMT, --Tranfee  Total    amount
         SERVICETAX_AMT, --Tran servicetax amount
         CESS_AMT, --Tran cess amount
         CR_DR_FLAG,
         TERMINAL_ID,
         MCCODE,
         FEECODE,
         TRANFEE_AMT,
         SERVICETAX_AMT,
         CESS_AMT,
         TRANFEE_CR_ACCTNO,
         TRANFEE_DR_ACCTNO,
         TRAN_ST_CALC_FLAG,
         TRAN_CESS_CALC_FLAG,
         TRAN_ST_CR_ACCTNO,
         TRAN_ST_DR_ACCTNO,
         TRAN_CESS_CR_ACCTNO,
         TRAN_CESS_DR_ACCTNO,
         CURRENCYCODE,
         TRAN_REVERSE_FLAG,
         GL_UPD_FLAG,
         AMOUNT,
         pos_verification,--Added on 04.04.2013 for MVHOST-298
         internation_ind_response,--Added on 04.04.2013 for MVHOST-298
         add_ins_date ,         --Added on 18.04.2013 for MVHOST-298
         --Sn Added for FWR-44
         customer_acct_no,
         topup_card_no  ,
         Topup_Acct_No  ,
         Topup_Acct_Type,
         TOPUP_CARD_NO_ENCR --Added for Mantis 13555 on 29 Jan 14
         --En Added for FWR-44
         ,NVL(INTERCHANGE_FEEAMT,0)
     INTO V_ORGNL_DELIVERY_CHANNEL,
         V_ORGNL_TERMINAL_ID,
         V_ORGNL_RESP_CODE,
         V_ORGNL_TXN_CODE,
         V_ORGNL_TXN_TYPE,
         V_ORGNL_TXN_MODE,
         V_ORGNL_BUSINESS_DATE,
         V_ORGNL_BUSINESS_TIME,
         V_ORGNL_CUSTOMER_CARD_NO,
         V_ORGNL_TOTAL_AMOUNT,
         V_ORGNL_TXN_FEE_PLAN, --Added for FWR-11
         V_ORGNL_TXN_FEECODE,
         V_ORGNL_TXN_FEEATTACHTYPE,
         V_ORGNL_TXN_TOTALFEE_AMT,
         V_ORGNL_TXN_SERVICETAX_AMT,
         V_ORGNL_TXN_CESS_AMT,
         V_ORGNL_TRANSACTION_TYPE,
         V_ORGNL_TERMID,
         V_ORGNL_MCCCODE,
         V_ACTUAL_FEECODE,
         V_ORGNL_TRANFEE_AMT,
         V_ORGNL_SERVICETAX_AMT,
         V_ORGNL_CESS_AMT,
         V_ORGNL_TRANFEE_CR_ACCTNO,
         V_ORGNL_TRANFEE_DR_ACCTNO,
         V_ORGNL_ST_CALC_FLAG,
         V_ORGNL_CESS_CALC_FLAG,
         V_ORGNL_ST_CR_ACCTNO,
         V_ORGNL_ST_DR_ACCTNO,
         V_ORGNL_CESS_CR_ACCTNO,
         V_ORGNL_CESS_DR_ACCTNO,
         V_CURR_CODE,
         V_TRAN_REVERSE_FLAG,
         V_GL_UPD_FLAG,
         V_ORGNL_TXN_AMNT,
         v_pos_verification, --Added on 04.04.2013 for MVHOST-298
         v_internation_ind_response, --Added on 04.04.2013 for MVHOST-298
         v_add_ins_date ,        --Added on 18.04.2013 for MVHOST-298
         --Sn Added for FWR-44
         v_cust_acct_no,
         v_topup_card_no ,
         V_Topup_Acct_No ,
         v_topup_acct_type,
         --En Added for FWR-44
         V_TOPUP_CARD_NO_ENCR --Added for Mantis 13555 on 29 Jan 14
          ,V_INTERCHANGE_FEEAMT
     FROM TRANSACTIONLOG
    WHERE RRN = P_ORGNL_RRN AND BUSINESS_DATE = P_ORGNL_BUSINESS_DATE AND
         BUSINESS_TIME = P_ORGNL_BUSINESS_TIME AND
         CUSTOMER_CARD_NO = V_HASH_PAN --P_card_no
         AND DELIVERY_CHANNEL = P_DELV_CHNL --Added by ramkumar.Mk on 25 march 2012
         AND INSTCODE = P_INST_CODE AND RESPONSE_CODE = '00'; -- Added to fetch only success original transaction. -- 20-June-2011
		 
ELSE
		SELECT DELIVERY_CHANNEL,
         TERMINAL_ID,
         RESPONSE_CODE,
         TXN_CODE,
         TXN_TYPE,
         TXN_MODE,
         BUSINESS_DATE,
         BUSINESS_TIME,
         CUSTOMER_CARD_NO,
         TOTAL_AMOUNT, --Total Transaction amount
         FEE_PLAN, --Added for FWR-11
         FEECODE,
         FEEATTACHTYPE, -- card level / prod cattype level
         TRANFEE_AMT, --Tranfee  Total    amount
         SERVICETAX_AMT, --Tran servicetax amount
         CESS_AMT, --Tran cess amount
         CR_DR_FLAG,
         TERMINAL_ID,
         MCCODE,
         FEECODE,
         TRANFEE_AMT,
         SERVICETAX_AMT,
         CESS_AMT,
         TRANFEE_CR_ACCTNO,
         TRANFEE_DR_ACCTNO,
         TRAN_ST_CALC_FLAG,
         TRAN_CESS_CALC_FLAG,
         TRAN_ST_CR_ACCTNO,
         TRAN_ST_DR_ACCTNO,
         TRAN_CESS_CR_ACCTNO,
         TRAN_CESS_DR_ACCTNO,
         CURRENCYCODE,
         TRAN_REVERSE_FLAG,
         GL_UPD_FLAG,
         AMOUNT,
         pos_verification,--Added on 04.04.2013 for MVHOST-298
         internation_ind_response,--Added on 04.04.2013 for MVHOST-298
         add_ins_date ,         --Added on 18.04.2013 for MVHOST-298
         --Sn Added for FWR-44
         customer_acct_no,
         topup_card_no  ,
         Topup_Acct_No  ,
         Topup_Acct_Type,
         TOPUP_CARD_NO_ENCR --Added for Mantis 13555 on 29 Jan 14
         --En Added for FWR-44
         ,NVL(INTERCHANGE_FEEAMT,0)
     INTO V_ORGNL_DELIVERY_CHANNEL,
         V_ORGNL_TERMINAL_ID,
         V_ORGNL_RESP_CODE,
         V_ORGNL_TXN_CODE,
         V_ORGNL_TXN_TYPE,
         V_ORGNL_TXN_MODE,
         V_ORGNL_BUSINESS_DATE,
         V_ORGNL_BUSINESS_TIME,
         V_ORGNL_CUSTOMER_CARD_NO,
         V_ORGNL_TOTAL_AMOUNT,
         V_ORGNL_TXN_FEE_PLAN, --Added for FWR-11
         V_ORGNL_TXN_FEECODE,
         V_ORGNL_TXN_FEEATTACHTYPE,
         V_ORGNL_TXN_TOTALFEE_AMT,
         V_ORGNL_TXN_SERVICETAX_AMT,
         V_ORGNL_TXN_CESS_AMT,
         V_ORGNL_TRANSACTION_TYPE,
         V_ORGNL_TERMID,
         V_ORGNL_MCCCODE,
         V_ACTUAL_FEECODE,
         V_ORGNL_TRANFEE_AMT,
         V_ORGNL_SERVICETAX_AMT,
         V_ORGNL_CESS_AMT,
         V_ORGNL_TRANFEE_CR_ACCTNO,
         V_ORGNL_TRANFEE_DR_ACCTNO,
         V_ORGNL_ST_CALC_FLAG,
         V_ORGNL_CESS_CALC_FLAG,
         V_ORGNL_ST_CR_ACCTNO,
         V_ORGNL_ST_DR_ACCTNO,
         V_ORGNL_CESS_CR_ACCTNO,
         V_ORGNL_CESS_DR_ACCTNO,
         V_CURR_CODE,
         V_TRAN_REVERSE_FLAG,
         V_GL_UPD_FLAG,
         V_ORGNL_TXN_AMNT,
         v_pos_verification, --Added on 04.04.2013 for MVHOST-298
         v_internation_ind_response, --Added on 04.04.2013 for MVHOST-298
         v_add_ins_date ,        --Added on 18.04.2013 for MVHOST-298
         --Sn Added for FWR-44
         v_cust_acct_no,
         v_topup_card_no ,
         V_Topup_Acct_No ,
         v_topup_acct_type,
         --En Added for FWR-44
         V_TOPUP_CARD_NO_ENCR --Added for Mantis 13555 on 29 Jan 14
          ,V_INTERCHANGE_FEEAMT
     FROM VMSCMS_HISTORY.TRANSACTIONLOG_HIST --Added for VMS-5733/FSP-991
    WHERE RRN = P_ORGNL_RRN AND BUSINESS_DATE = P_ORGNL_BUSINESS_DATE AND
         BUSINESS_TIME = P_ORGNL_BUSINESS_TIME AND
         CUSTOMER_CARD_NO = V_HASH_PAN --P_card_no
         AND DELIVERY_CHANNEL = P_DELV_CHNL --Added by ramkumar.Mk on 25 march 2012
         AND INSTCODE = P_INST_CODE AND RESPONSE_CODE = '00'; -- Added to fetch only success original transaction. -- 20-June-2011
END IF;	
	 
    ELSE
    
    SELECT DELIVERY_CHANNEL,
         TERMINAL_ID,
         RESPONSE_CODE,
         TXN_CODE,
         TXN_TYPE,
         TXN_MODE,
         BUSINESS_DATE,
         BUSINESS_TIME,
         CUSTOMER_CARD_NO,
         TOTAL_AMOUNT, --Total Transaction amount
         FEE_PLAN, --Added for FWR-11
         FEECODE,
         FEEATTACHTYPE, -- card level / prod cattype level
         TRANFEE_AMT, --Tranfee  Total    amount
         SERVICETAX_AMT, --Tran servicetax amount
         CESS_AMT, --Tran cess amount
         CR_DR_FLAG,
         TERMINAL_ID,
         MCCODE,
         FEECODE,
         TRANFEE_AMT,
         SERVICETAX_AMT,
         CESS_AMT,
         TRANFEE_CR_ACCTNO,
         TRANFEE_DR_ACCTNO,
         TRAN_ST_CALC_FLAG,
         TRAN_CESS_CALC_FLAG,
         TRAN_ST_CR_ACCTNO,
         TRAN_ST_DR_ACCTNO,
         TRAN_CESS_CR_ACCTNO,
         TRAN_CESS_DR_ACCTNO,
         CURRENCYCODE,
         TRAN_REVERSE_FLAG,
         GL_UPD_FLAG,
         AMOUNT,
         pos_verification,--Added on 04.04.2013 for MVHOST-298
         internation_ind_response,--Added on 04.04.2013 for MVHOST-298
         add_ins_date ,         --Added on 18.04.2013 for MVHOST-298
         --Sn Added for FWR-44
         customer_acct_no,
         topup_card_no  ,
         Topup_Acct_No  ,
         Topup_Acct_Type,
         TOPUP_CARD_NO_ENCR --Added for Mantis 13555 on 29 Jan 14
         --En Added for FWR-44
         ,NVL(INTERCHANGE_FEEAMT,0)
         ,ADD_INS_DATE
     INTO V_ORGNL_DELIVERY_CHANNEL,
         V_ORGNL_TERMINAL_ID,
         V_ORGNL_RESP_CODE,
         V_ORGNL_TXN_CODE,
         V_ORGNL_TXN_TYPE,
         V_ORGNL_TXN_MODE,
         V_ORGNL_BUSINESS_DATE,
         V_ORGNL_BUSINESS_TIME,
         V_ORGNL_CUSTOMER_CARD_NO,
         V_ORGNL_TOTAL_AMOUNT,
         V_ORGNL_TXN_FEE_PLAN, --Added for FWR-11
         V_ORGNL_TXN_FEECODE,
         V_ORGNL_TXN_FEEATTACHTYPE,
         V_ORGNL_TXN_TOTALFEE_AMT,
         V_ORGNL_TXN_SERVICETAX_AMT,
         V_ORGNL_TXN_CESS_AMT,
         V_ORGNL_TRANSACTION_TYPE,
         V_ORGNL_TERMID,
         V_ORGNL_MCCCODE,
         V_ACTUAL_FEECODE,
         V_ORGNL_TRANFEE_AMT,
         V_ORGNL_SERVICETAX_AMT,
         V_ORGNL_CESS_AMT,
         V_ORGNL_TRANFEE_CR_ACCTNO,
         V_ORGNL_TRANFEE_DR_ACCTNO,
         V_ORGNL_ST_CALC_FLAG,
         V_ORGNL_CESS_CALC_FLAG,
         V_ORGNL_ST_CR_ACCTNO,
         V_ORGNL_ST_DR_ACCTNO,
         V_ORGNL_CESS_CR_ACCTNO,
         V_ORGNL_CESS_DR_ACCTNO,
         V_CURR_CODE,
         V_TRAN_REVERSE_FLAG,
         V_GL_UPD_FLAG,
         V_ORGNL_TXN_AMNT,
         v_pos_verification, --Added on 04.04.2013 for MVHOST-298
         v_internation_ind_response, --Added on 04.04.2013 for MVHOST-298
         v_add_ins_date ,        --Added on 18.04.2013 for MVHOST-298
         --Sn Added for FWR-44
         v_cust_acct_no,
         v_topup_card_no ,
         V_Topup_Acct_No ,
         v_topup_acct_type, 
         --En Added for FWR-44
         V_TOPUP_CARD_NO_ENCR --Added for Mantis 13555 on 29 Jan 14
          ,V_INTERCHANGE_FEEAMT
          ,v_add_ins_date
     FROM VMSCMS.TRANSACTIONLOG --Added for VMS-5733/FSP-991
    WHERE RRN = P_ORGNL_RRN 
         AND CUSTOMER_CARD_NO = V_HASH_PAN 
         AND DELIVERY_CHANNEL = P_DELV_CHNL
		 AND TXN_CODE= P_TXN_CODE
         AND INSTCODE = P_INST_CODE AND RESPONSE_CODE = '00'; 
		 IF SQL%ROWCOUNT = 0 THEN 
		 
		 SELECT DELIVERY_CHANNEL,
         TERMINAL_ID,
         RESPONSE_CODE,
         TXN_CODE,
         TXN_TYPE,
         TXN_MODE,
         BUSINESS_DATE,
         BUSINESS_TIME,
         CUSTOMER_CARD_NO,
         TOTAL_AMOUNT, --Total Transaction amount
         FEE_PLAN, --Added for FWR-11
         FEECODE,
         FEEATTACHTYPE, -- card level / prod cattype level
         TRANFEE_AMT, --Tranfee  Total    amount
         SERVICETAX_AMT, --Tran servicetax amount
         CESS_AMT, --Tran cess amount
         CR_DR_FLAG,
         TERMINAL_ID,
         MCCODE,
         FEECODE,
         TRANFEE_AMT,
         SERVICETAX_AMT,
         CESS_AMT,
         TRANFEE_CR_ACCTNO,
         TRANFEE_DR_ACCTNO,
         TRAN_ST_CALC_FLAG,
         TRAN_CESS_CALC_FLAG,
         TRAN_ST_CR_ACCTNO,
         TRAN_ST_DR_ACCTNO,
         TRAN_CESS_CR_ACCTNO,
         TRAN_CESS_DR_ACCTNO,
         CURRENCYCODE,
         TRAN_REVERSE_FLAG,
         GL_UPD_FLAG,
         AMOUNT,
         pos_verification,--Added on 04.04.2013 for MVHOST-298
         internation_ind_response,--Added on 04.04.2013 for MVHOST-298
         add_ins_date ,         --Added on 18.04.2013 for MVHOST-298
         --Sn Added for FWR-44
         customer_acct_no,
         topup_card_no  ,
         Topup_Acct_No  ,
         Topup_Acct_Type,
         TOPUP_CARD_NO_ENCR --Added for Mantis 13555 on 29 Jan 14
         --En Added for FWR-44
         ,NVL(INTERCHANGE_FEEAMT,0)
         ,ADD_INS_DATE
     INTO V_ORGNL_DELIVERY_CHANNEL,
         V_ORGNL_TERMINAL_ID,
         V_ORGNL_RESP_CODE,
         V_ORGNL_TXN_CODE,
         V_ORGNL_TXN_TYPE,
         V_ORGNL_TXN_MODE,
         V_ORGNL_BUSINESS_DATE,
         V_ORGNL_BUSINESS_TIME,
         V_ORGNL_CUSTOMER_CARD_NO,
         V_ORGNL_TOTAL_AMOUNT,
         V_ORGNL_TXN_FEE_PLAN, --Added for FWR-11
         V_ORGNL_TXN_FEECODE,
         V_ORGNL_TXN_FEEATTACHTYPE,
         V_ORGNL_TXN_TOTALFEE_AMT,
         V_ORGNL_TXN_SERVICETAX_AMT,
         V_ORGNL_TXN_CESS_AMT,
         V_ORGNL_TRANSACTION_TYPE,
         V_ORGNL_TERMID,
         V_ORGNL_MCCCODE,
         V_ACTUAL_FEECODE,
         V_ORGNL_TRANFEE_AMT,
         V_ORGNL_SERVICETAX_AMT,
         V_ORGNL_CESS_AMT,
         V_ORGNL_TRANFEE_CR_ACCTNO,
         V_ORGNL_TRANFEE_DR_ACCTNO,
         V_ORGNL_ST_CALC_FLAG,
         V_ORGNL_CESS_CALC_FLAG,
         V_ORGNL_ST_CR_ACCTNO,
         V_ORGNL_ST_DR_ACCTNO,
         V_ORGNL_CESS_CR_ACCTNO,
         V_ORGNL_CESS_DR_ACCTNO,
         V_CURR_CODE,
         V_TRAN_REVERSE_FLAG,
         V_GL_UPD_FLAG,
         V_ORGNL_TXN_AMNT,
         v_pos_verification, --Added on 04.04.2013 for MVHOST-298
         v_internation_ind_response, --Added on 04.04.2013 for MVHOST-298
         v_add_ins_date ,        --Added on 18.04.2013 for MVHOST-298
         --Sn Added for FWR-44
         v_cust_acct_no,
         v_topup_card_no ,
         V_Topup_Acct_No ,
         v_topup_acct_type, 
         --En Added for FWR-44
         V_TOPUP_CARD_NO_ENCR --Added for Mantis 13555 on 29 Jan 14
          ,V_INTERCHANGE_FEEAMT
          ,v_add_ins_date
     FROM VMSCMS_HISTORY.TRANSACTIONLOG_HIST --Added for VMS-5733/FSP-991
    WHERE RRN = P_ORGNL_RRN 
         AND CUSTOMER_CARD_NO = V_HASH_PAN 
         AND DELIVERY_CHANNEL = P_DELV_CHNL
		 AND TXN_CODE= P_TXN_CODE
         AND INSTCODE = P_INST_CODE AND RESPONSE_CODE = '00'; 
		 END IF;
         
      V_ORGNL_TRANDATE := TO_DATE(SUBSTR(TRIM(V_ORGNL_BUSINESS_DATE), 1, 8) || ' ' ||
                          SUBSTR(TRIM(V_ORGNL_BUSINESS_TIME), 1, 8),
                          'yyyymmdd hh24:mi:ss');
                          
      
                          
    END IF;
         
         
    IF V_ORGNL_RESP_CODE <> '00' THEN
     V_Resp_Cde := '23';
     V_ERRMSG   := ' The original transaction was not successful';
     RAISE EXP_RVSL_REJECT_RECORD;
    END IF;
    IF V_TRAN_REVERSE_FLAG = 'Y' THEN
     V_RESP_CDE := '52';
     V_ERRMSG   := 'The reversal already done for the orginal transaction';
     RAISE EXP_RVSL_REJECT_RECORD;
    END IF;
    IF (P_DELV_CHNL='07' AND P_TXN_CODE ='57')
       OR (P_DELV_CHNL ='10' AND P_TXN_CODE ='76')
       OR (P_DELV_CHNL = '13' AND P_TXN_CODE ='90') THEN
     IF V_ORGNL_TXN_AMNT <> P_ACTUAL_AMT THEN
       V_RESP_CDE := '25';
       V_ERRMSG   := 'INVALID AMOUNT';
       RAISE EXP_RVSL_REJECT_RECORD;
      ELSE
       V_REVERSAL_AMT := P_ACTUAL_AMT;
     END IF;
    END IF;
    IF P_DELV_CHNL = '07' THEN
     IF V_ORGNL_TXN_AMNT < P_ACTUAL_AMT THEN
       V_RESP_CDE := '37';
       V_ERRMSG   := 'Reversal Amount exceeds the Actual Amount';
       RAISE EXP_RVSL_REJECT_RECORD;
     END IF;
    END IF;

  Exception
    WHEN EXP_RVSL_REJECT_RECORD THEN
     Raise;
    WHEN NO_DATA_FOUND THEN
     V_Resp_Cde := '53';
     V_ERRMSG   := 'Matching transaction not found';
     RAISE EXP_RVSL_REJECT_RECORD;
    WHEN TOO_MANY_ROWS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'More than one matching record found in the master';
     RAISE EXP_RVSL_REJECT_RECORD;
    WHEN OTHERS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'Error while selecting master data' ||
                SUBSTR(SQLERRM, 1, 300);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;
  --En check orginal transaction

 IF (P_DELV_CHNL='07' AND P_TXN_CODE ='57')
       OR (P_DELV_CHNL ='10' AND P_TXN_CODE ='76')
       OR (P_DELV_CHNL = '13' AND P_TXN_CODE ='90') THEN
                          
 BEGIN
    SELECT CIP_PARAM_VALUE
     INTO V_TIME_OUT_VALUE
     FROM CMS_INST_PARAM
    WHERE CIP_PARAM_KEY = 'TIME_OUT_REVERSAL' AND CIP_INST_CODE = P_INST_CODE;
    
    V_TIME_DIFF := (SYSDATE - v_add_ins_date) * 24*60*60;
    IF V_TIME_DIFF >0 AND V_TIME_DIFF > V_TIME_OUT_VALUE THEN
       V_ERRMSG   := 'Original Cannot Be Reversed';
       SELECT DECODE (P_DELV_CHNL, '07', '253', '13', '253', '10', '296')
           INTO V_RESP_CDE
           FROM DUAL;
       RAISE EXP_RVSL_REJECT_RECORD;
       END IF;    
  EXCEPTION
    WHEN EXP_RVSL_REJECT_RECORD THEN
      RAISE;
    WHEN OTHERS THEN
      v_resp_cde := '21';
      V_ERRMSG  := 'Error while checking time difference' || SUBSTR (SQLERRM, 1, 200);
      RAISE EXP_RVSL_REJECT_RECORD;
    END;
  END IF; 
  ---Sn check card number
  IF V_ORGNL_CUSTOMER_CARD_NO <> V_HASH_PAN THEN

    V_RESP_CDE := '21';
    V_ERRMSG   := 'Customer card number is not matching in reversal and orginal transaction';
    RAISE EXP_RVSL_REJECT_RECORD;

  END IF;
  --En check card number

  --Sn find the converted tran amt
  V_TRAN_AMT := P_ACTUAL_AMT;

  IF (P_ACTUAL_AMT >= 0) THEN

    BEGIN
     SP_CONVERT_CURR(P_INST_CODE,
                  V_CURRCODE,
                  P_CARD_NO,
                  P_ACTUAL_AMT,
                  V_RVSL_TRANDATE,
                  V_TRAN_AMT,
                  V_CARD_CURR,
                  V_ERRMSG,
                  V_PROD_CODE,
                  V_CARD_TYPE
                  );

     IF V_ERRMSG <> 'OK' THEN
       V_RESP_CDE := '44';
       RAISE EXP_RVSL_REJECT_RECORD;
     END IF;
    EXCEPTION
     WHEN EXP_RVSL_REJECT_RECORD THEN
       RAISE;
     WHEN OTHERS THEN
       V_RESP_CDE := '44'; -- Server Declined -220509
       V_ERRMSG   := 'Error from currency conversion ' ||
                  SUBSTR(SQLERRM, 1, 200);
       RAISE EXP_RVSL_REJECT_RECORD;
    END;
  ELSE
    -- If transaction Amount is zero - Invalid Amount -220509
    V_RESP_CDE := '13';
    V_ERRMSG   := 'INVALID AMOUNT';
    RAISE EXP_RVSL_REJECT_RECORD;
  END IF;

  --En find the  converted tran amt

  --Sn Check the Original and Reversal txn amount

  IF P_ACTUAL_AMT > V_ORGNL_TXN_AMNT THEN

    V_RESP_CDE := '59';
    V_ERRMSG   := 'Reversal amount exceeds the original transaction amount';
    RAISE EXP_RVSL_REJECT_RECORD;

  END IF;
  --En Check the Original and Reversal txn amount

 IF NOT ((P_DELV_CHNL='07' AND P_TXN_CODE ='57')
       OR (P_DELV_CHNL ='10' AND P_TXN_CODE ='76')
       OR (P_DELV_CHNL = '13' AND P_TXN_CODE ='90')) THEN
  --Sn check amount with orginal transaction
  IF (V_TRAN_AMT IS NULL OR V_TRAN_AMT = 0) THEN

    V_ACTUAL_DISPATCHED_AMT := 0;
  ELSE
    V_ACTUAL_DISPATCHED_AMT := V_TRAN_AMT;
  END IF;
  --En check amount with orginal transaction
  V_REVERSAL_AMT := V_ORGNL_TXN_AMNT - V_ACTUAL_DISPATCHED_AMT;

  IF V_REVERSAL_AMT < V_ORGNL_TXN_AMNT THEN   ---Modified For Mantis id-0010997
  V_REVERSAL_AMT_FLAG :='P';
  END IF;
  END IF;
  
  IF V_DR_CR_FLAG = 'NA' THEN
    V_RESP_CDE := '21';
    V_ERRMSG   := 'Not a valid orginal transaction for reversal';
    RAISE EXP_RVSL_REJECT_RECORD;
  END IF;
 -- comented on 28.10.13 for
-- mantis id 0012841: DEFECT:CMS:INCOMM:CR/DR flag of MMPOS card topup reversal transaction is displayed as incorrect

 /* IF V_DR_CR_FLAG <> V_ORGNL_TRANSACTION_TYPE THEN
    V_RESP_CDE := '21';
    V_ERRMSG   := 'Orginal transaction type is not matching with actual transaction type';
    RAISE EXP_RVSL_REJECT_RECORD;
  END IF;
  */
  --Sn reverse the amount

  --Sn commented for fwr-48

  --Sn find the orginal func code
/*  BEGIN
    SELECT CFM_FUNC_CODE
     INTO V_FUNC_CODE
     FROM CMS_FUNC_MAST
    WHERE CFM_TXN_CODE = V_ORGNL_TXN_CODE AND
         CFM_TXN_MODE = V_ORGNL_TXN_MODE AND
         CFM_DELIVERY_CHANNEL = V_ORGNL_DELIVERY_CHANNEL AND
         CFM_INST_CODE = P_INST_CODE;
    --TXN mode and delivery channel we need to attach
    --bkz txn code may be same for all type of channels
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
     V_RESP_CDE := '69'; --Ineligible Transaction
     V_ERRMSG   := 'Function code not defined for txn code ' || P_TXN_CODE;
     RAISE EXP_RVSL_REJECT_RECORD;
    WHEN TOO_MANY_ROWS THEN
     V_RESP_CDE := '69';
     V_ERRMSG   := 'More than one function defined for txn code ' ||
                P_TXN_CODE;
     RAISE EXP_RVSL_REJECT_RECORD;
    WHEN OTHERS THEN
     V_RESP_CDE := '69';
     V_ERRMSG   := 'Problem while selecting function code from function mast  ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;*/

   --En commented for fwr-48

  --Sn update the amount

  ---Sn find cutoff time
  BEGIN
    SELECT CIP_PARAM_VALUE
     INTO V_CUTOFF_TIME
     FROM CMS_INST_PARAM
    WHERE CIP_PARAM_KEY = 'CUTOFF' AND CIP_INST_CODE = P_INST_CODE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
     V_CUTOFF_TIME := 0;
     V_RESP_CDE    := '21';
     V_ERRMSG      := 'Cutoff time is not defined in the system';
     RAISE EXP_RVSL_REJECT_RECORD;
    WHEN OTHERS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'Error while selecting cutoff  dtl  from system ';
     RAISE EXP_RVSL_REJECT_RECORD;
  END;
  ---En find cutoff time

  BEGIN
    SELECT CAM_ACCT_NO, CAM_ACCT_BAL, CAM_LEDGER_BAL,cam_type_code
     INTO V_CARD_ACCT_NO, V_ACCT_BALANCE, V_LEDGE_BALANCE,v_acct_type  --v_acct_type added by Pankaj S. for 10871
     FROM CMS_ACCT_MAST
    WHERE CAM_ACCT_NO =
         (SELECT CAP_ACCT_NO
            FROM CMS_APPL_PAN
           WHERE CAP_PAN_CODE = V_HASH_PAN AND CAP_MBR_NUMB = V_MBR_NUMB AND
                CAP_INST_CODE = P_INST_CODE) AND
         CAM_INST_CODE = P_INST_CODE
         FOR UPDATE;    --SN: Added for Concurrent Processsing Issue  on 25-FEB-2014 By Revathi
        --FOR UPDATE NOWAIT;   --SN: Commented for Concurrent Processsing Issue  on 25-FEB-2014 By Revathi
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
     V_RESP_CDE := '14'; --Ineligible Transaction
     V_ERRMSG   := 'Invalid Card ';
     RAISE EXP_RVSL_REJECT_RECORD;
    WHEN OTHERS THEN
     V_RESP_CDE := '12';
     V_ERRMSG   := 'Error while selecting data from card Master for card number ' ||
                P_CARD_NO;
     RAISE EXP_RVSL_REJECT_RECORD;
  END;

-- added for FSS-4700 changes beg

IF  (P_DELV_CHNL='17' AND P_TXN_CODE ='03') AND (nvl(V_REVERSAL_AMT,0)-nvl(V_ORGNL_TRANFEE_AMT,0)) > V_ACCT_BALANCE AND V_DR_CR_FLAG ='CR' THEN
    V_RESP_CDE := '25';
    V_ERRMSG   := 'Available balance is less than the request reversal amount';
    RAISE EXP_RVSL_REJECT_RECORD;
ELSIF  V_REVERSAL_AMT > V_ACCT_BALANCE AND V_DR_CR_FLAG ='CR' THEN
    V_RESP_CDE := '263';
    V_ERRMSG   := 'Topup amount has been used, Reversal Cannot be done'||V_REVERSAL_AMT||V_ACCT_BALANCE;
    RAISE EXP_RVSL_REJECT_RECORD;
END IF;
  

-- added for FSS-4700 changes end

    ------------------------------------------------------
        --Sn Added for Concurrent Processsing Issue
    ------------------------------------------------------

    /*  BEGIN

        SELECT COUNT(1)
         INTO V_RRN_COUNT
         FROM TRANSACTIONLOG
        WHERE RRN = P_RRN AND BUSINESS_DATE = P_BUSINESS_DATE AND
             DELIVERY_CHANNEL = P_DELV_CHNL; --Added by ramkumar.Mk on 25 march 2012

        IF V_RRN_COUNT > 0 THEN

         V_RESP_CDE := '22'; -- Modified the response code variable name since this name only used to fetch the external response code. 20-June-2011
         V_ERRMSG   := 'Duplicate RRN on' || P_BUSINESS_DATE;
         RAISE EXP_RVSL_REJECT_RECORD;

        END IF;

      END;  */
      -- MODIFIED BY ABDUL HAMEED M.A ON 06-03-2014
BEGIN
      sp_dup_rrn_check (V_HASH_PAN, P_RRN, P_BUSINESS_DATE, P_DELV_CHNL, P_MSG_TYP, P_TXN_CODE, V_ERRMSG);
      IF V_ERRMSG <> 'OK' THEN
        v_resp_cde := '22';
        RAISE EXP_RVSL_REJECT_RECORD;
      END IF;
    EXCEPTION
    WHEN EXP_RVSL_REJECT_RECORD THEN
      RAISE;
    WHEN OTHERS THEN
      v_resp_cde := '22';
      V_ERRMSG  := 'Error while checking RRN' || SUBSTR (SQLERRM, 1, 200);
      RAISE EXP_RVSL_REJECT_RECORD;
    END;
    ------------------------------------------------------
        --En Added for Concurrent Processsing Issue
    ------------------------------------------------------

  --Sn get the product code


  --Sn find narration

  BEGIN
	--Added for VMS-5739/FSP-991
 select (add_months(trunc(sysdate,'MM'),'-'||RETENTION_PERIOD))
       INTO   v_Retperiod 
       FROM DBA_OPERATIONS.ARCHIVE_MGMNT_CTL 
       WHERE  OPERATION_TYPE='ARCHIVE' 
       AND OBJECT_NAME='CMS_STATEMENTS_LOG_EBR';
       
       v_Retdate := TO_DATE(SUBSTR(TRIM(V_ORGNL_BUSINESS_DATE), 1, 8), 'yyyymmdd');


IF (v_Retdate>v_Retperiod)
    THEN
    SELECT CSL_TRANS_NARRRATION,
         CSL_MERCHANT_NAME,
         CSL_MERCHANT_CITY,
         CSL_MERCHANT_STATE
     INTO V_TXN_NARRATION,
         V_TXN_MERCHNAME,
         V_TXN_MERCHCITY,
         V_TXN_MERCHSTATE --Mofified by Deepa on 09-May-2012 to include Merchant name,city and state in statements log
     FROM CMS_STATEMENTS_LOG
    WHERE CSL_BUSINESS_DATE = V_ORGNL_BUSINESS_DATE AND
         CSL_BUSINESS_TIME = V_ORGNL_BUSINESS_TIME AND
         CSL_RRN = P_ORGNL_RRN AND
         CSL_DELIVERY_CHANNEL = V_ORGNL_DELIVERY_CHANNEL AND
         CSL_TXN_CODE = V_ORGNL_TXN_CODE AND
         CSL_PAN_NO = V_ORGNL_CUSTOMER_CARD_NO AND
         CSL_INST_CODE = P_INST_CODE AND TXN_FEE_FLAG = 'N'
        and rownum=1; --Added for FWR-44
ELSE
	  SELECT CSL_TRANS_NARRRATION,
         CSL_MERCHANT_NAME,
         CSL_MERCHANT_CITY,
         CSL_MERCHANT_STATE
     INTO V_TXN_NARRATION,
         V_TXN_MERCHNAME,
         V_TXN_MERCHCITY,
         V_TXN_MERCHSTATE --Mofified by Deepa on 09-May-2012 to include Merchant name,city and state in statements log
     FROM VMSCMS_HISTORY.CMS_STATEMENTS_LOG_HIST --Added for VMS-5733/FSP-991
    WHERE CSL_BUSINESS_DATE = V_ORGNL_BUSINESS_DATE AND
         CSL_BUSINESS_TIME = V_ORGNL_BUSINESS_TIME AND
         CSL_RRN = P_ORGNL_RRN AND
         CSL_DELIVERY_CHANNEL = V_ORGNL_DELIVERY_CHANNEL AND
         CSL_TXN_CODE = V_ORGNL_TXN_CODE AND
         CSL_PAN_NO = V_ORGNL_CUSTOMER_CARD_NO AND
         CSL_INST_CODE = P_INST_CODE AND TXN_FEE_FLAG = 'N'
        and rownum=1; --Added for FWR-44
END IF;		
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
     V_TXN_NARRATION := NULL;
    WHEN OTHERS THEN
     V_TXN_NARRATION := NULL;

  END;

  --En find narration

       --Added for MVHOST-1041
    BEGIN
       IF p_delv_chnl = '02' AND p_txn_code = '25'
       THEN
          SELECT COUNT (1)
            INTO v_mrlimitbreach_count
            FROM cms_mrlimitbreach_merchantname
           WHERE cpt_inst_code = p_inst_code
             AND UPPER (TRIM (v_txn_merchname)) LIKE cmm_merchant_name || '%';

          IF v_mrlimitbreach_count > 0
          THEN
             v_mrminmaxlmt_ignoreflag := 'Y';
          END IF;
       END IF;
    EXCEPTION
       WHEN OTHERS
       THEN
          v_resp_cde := '21';
          v_errmsg :=
                'Error While Occured checking the  limit breach count'
             || SUBSTR (SQLERRM, 1, 200);
          RAISE exp_rvsl_reject_record;
    END;
    --End MVHOST-1041

  --Sn Added by Pankaj S. for enabling limit validation
  IF v_add_ins_date is not null and  v_prfl_code IS NOT NULL AND v_prfl_flag = 'Y' THEN
    IF p_delv_chnl='02' AND p_txn_code='25' THEN
    BEGIN
       sp_check_minmax (v_hash_pan,
                        v_orgnl_mcccode,
                        p_txn_code,
                        v_tran_type,
                        null,--v_internation_ind_response commented and added NULL for 13063
                        null,--v_pos_verification commented and added NULL for 13063
                        p_inst_code,
                        'NA',
                        v_prfl_code,
                        v_reversal_amt,
                        p_delv_chnl,
                        v_resp_cde,
                        v_errmsg
                        ,v_mrminmaxlmt_ignoreflag
                       );

       IF v_errmsg <> 'OK' THEN
          v_errmsg := v_errmsg;
          RAISE exp_rvsl_reject_record;
       END IF;
    EXCEPTION
       WHEN exp_rvsl_reject_record THEN
          RAISE;
       WHEN OTHERS THEN
          v_resp_cde := '21';
          v_errmsg := 'Error from Limit Min-Max check-' || SUBSTR (SQLERRM, 1, 200);
          RAISE exp_rvsl_reject_record;
    END;
    END IF;
    END IF;
    --En Added by Pankaj S. for enabling limit validation

  --Sn Check for maximum card balance configured for the product profile.
IF not( P_DELV_CHNL  ='02' and P_TXN_CODE  = '25' ) then --Added by Besky on 05/02/13
  BEGIN
   --Sn Added on 09-Feb-2013 for max card balance check based on product category
      SELECT TO_NUMBER (cbp_param_value)
        INTO v_max_card_bal
        FROM cms_bin_param
       WHERE cbp_inst_code = p_inst_code
         AND cbp_param_name = 'Max Card Balance'
         AND cbp_profile_code IN (
                SELECT cpc_profile_code
                  FROM cms_prod_cattype
                 WHERE cpc_inst_code = p_inst_code
                   AND cpc_prod_code = v_prod_code
                   AND cpc_card_type = v_card_type);
   --En Added on 09-Feb-2013 for max card balance check based on product category
    --Sn Commented on 09-Feb-2013 for max card balance check based on product category
    /*SELECT TO_NUMBER(CBP_PARAM_VALUE)
     INTO V_MAX_CARD_BAL
     FROM CMS_BIN_PARAM
    WHERE CBP_INST_CODE = P_INST_CODE AND
         CBP_PARAM_NAME = 'Max Card Balance' AND
         CBP_PROFILE_CODE IN
         (SELECT CPM_PROFILE_CODE
            FROM CMS_PROD_MAST
           WHERE CPM_PROD_CODE = V_PROD_CODE);*/
    --En Commented on 09-Feb-2013 for max card balance check based on product category
  EXCEPTION
    WHEN OTHERS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'ERROR IN FETCHING CARD BALANCE CONFIGURATION FOR THE PRODUCT PROFILE ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;

  END;
  -- En Check for maximum card balance configured for the product profile.

  BEGIN
    /*SELECT CFP_DRACCT_NO
     INTO V_ORGNL_DRACCT_NO
     FROM CMS_FUNC_PROD
    WHERE CFP_FUNC_CODE = V_FUNC_CODE AND CFP_PROD_CODE = V_PROD_CODE AND
         CFP_PROD_CATTYPE = V_CARD_TYPE AND CFP_INST_CODE = P_INST_CODE;*/  -- commented for fwr-48

    --IF V_ORGNL_DRACCT_NO IS NULL THEN  -- commented for fwr-48

    IF V_DR_CR_FLAG = 'DR' THEN -- added for fwr-48

     IF ((V_ACCT_BALANCE + (V_REVERSAL_AMT + V_ORGNL_TXN_TOTALFEE_AMT)) >
        V_MAX_CARD_BAL) OR
        ((V_LEDGE_BALANCE + (V_REVERSAL_AMT + V_ORGNL_TXN_TOTALFEE_AMT)) >
        V_MAX_CARD_BAL) THEN
          IF v_cap_card_stat<>'12' THEN --added for FSS-390
           UPDATE CMS_APPL_PAN
             SET CAP_CARD_STAT = '12'
            WHERE CAP_PAN_CODE = V_HASH_PAN AND CAP_INST_CODE = P_INST_CODE;
           IF SQL%ROWCOUNT = 0 THEN

            V_ERRMSG   := 'Error while updating the card status';
            V_RESP_CDE := '21';
            RAISE EXP_RVSL_REJECT_RECORD;
           END IF;
           --Sn added for FSS-390
           v_chnge_crdstat:='Y';
         END IF;
         --En added for FSS-390
     END IF;

    END IF;
  EXCEPTION

   /* WHEN NO_DATA_FOUND THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'Credit and debit gl is not defined for the funcode' ||
                V_FUNC_CODE || ' Product ' || V_PROD_CODE ||
                'Prod cattype ' || V_CARD_TYPE;
     RAISE EXP_RVSL_REJECT_RECORD;
    WHEN TOO_MANY_ROWS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'More than one record found for function code ' ||
                V_FUNC_CODE || ' Product ' || V_PROD_CODE ||
                'Prod cattype ' || V_CARD_TYPE;
     RAISE EXP_RVSL_REJECT_RECORD;*/--commented for fwr-48
    WHEN EXP_RVSL_REJECT_RECORD THEN
     RAISE;
    WHEN OTHERS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'Error while checking card status based on DR Flag ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;

END IF;

    v_timestamp:=systimestamp; --added by Pankaj S. for 10871

  --Sn reverse  the amount

  BEGIN
    SP_REVERSE_CARD_AMOUNT(P_INST_CODE,
                      V_FUNC_CODE,
                      P_RRN,
                      P_DELV_CHNL,
                      P_ORGNL_TERMINAL_ID,
                      P_MERC_ID,
                      --P_TXN_CODE,
                      V_ORGNL_TXN_CODE, -- Mantis id 0015708
                      V_RVSL_TRANDATE,
                      P_TXN_MODE,
                      P_CARD_NO,
                      V_REVERSAL_AMT,
                      P_ORGNL_RRN,
                      V_CARD_ACCT_NO,
                      P_BUSINESS_DATE,
                      P_BUSINESS_TIME,
                      V_AUTH_ID,
                      V_TXN_NARRATION,
                      V_ORGNL_BUSINESS_DATE,
                      V_ORGNL_BUSINESS_TIME,
                      /*V_TXN_MERCHNAME, --Added by Deepa on 09-May-2012 to include Merchant name,city and state in statements log
                      V_TXN_MERCHCITY,
                      V_TXN_MERCHSTATE,*/--Commented and modified on 21.03.2013 for Merchant Logging Info for the Reversal Txn
                      P_MERCHANT_NAME,
                      P_MERCHANT_CITY,
                      P_MERCHANT_STATE,
                      V_RESP_CDE,
                      V_ERRMSG,
                      P_TXN_CODE);
    IF V_RESP_CDE <> '00' OR V_ERRMSG <> 'OK' THEN
     RAISE EXP_RVSL_REJECT_RECORD;
    END IF;

  EXCEPTION
    WHEN EXP_RVSL_REJECT_RECORD THEN
     RAISE;
    WHEN OTHERS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'Error while reversing the amount ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;
  --En reverse the amount

  --Sn Added for FWR-44
  IF (P_DELV_CHNL='07' AND P_TXN_CODE IN('07','10','11','57'))
       OR (P_DELV_CHNL ='10' AND P_TXN_CODE IN('07','19','20','76'))
       OR (P_DELV_CHNL = '13' AND P_TXN_CODE IN('04','11','13','90'))
       OR (p_delv_chnl = '05' AND p_txn_code='23') THEN --Added for Mantis ID-13388
   v_timeout_rev:='Y';
  END IF;
  --En Added for FWR-44

  --Sn reverse the fee
  BEGIN
    --Sn Modified for FWR-44
    --IF P_TXN_CODE = '07' AND P_DELV_CHNL = '07' THEN
    IF v_timeout_rev='Y' THEN
    --En Modified for FWR-44
     BEGIN
       SP_DAILY_BIN_BAL(P_CARD_NO,
                    V_RVSL_TRANDATE,
                    V_REVERSAL_AMT,
                    'CR',
                    P_INST_CODE,
                    P_BANK_CODE,
                    V_ERRMSG);
     EXCEPTION
       WHEN OTHERS THEN
        NULL;
     END;
    ELSE
     BEGIN
       SP_DAILY_BIN_BAL(P_CARD_NO,
                    V_RVSL_TRANDATE,
                    V_REVERSAL_AMT,
                    'DR',
                    P_INST_CODE,
                    P_BANK_CODE,
                    V_ERRMSG);
     EXCEPTION
       WHEN OTHERS THEN
        RAISE EXP_RVSL_REJECT_RECORD;
     END;
    END IF;
  END;

  --Added by Deepa For Reversal Fees on June 27 2012

  IF V_REVERSAL_AMT_FLAG <>'P' THEN   --Modified For Mantis Id-0010997
  IF V_ORGNL_TXN_TOTALFEE_AMT > 0 or V_ORGNL_TXN_FEECODE is not null THEN --Modified for FWR-11
    -- SN Added for FWR-11
    BEGIN
         select CFM_FEECAP_FLAG,CFM_FEE_AMT into v_feecap_flag,v_orgnl_fee_amt from CMS_FEE_MAST
         where CFM_INST_CODE = P_INST_CODE and CFM_FEE_CODE = V_ORGNL_TXN_FEECODE;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
                v_feecap_flag := '';
          WHEN OTHERS THEN
              V_ERRMSG := 'Error in feecap flag fetch ' || SUBSTR(SQLERRM, 1, 200);
              RAISE EXP_RVSL_REJECT_RECORD;
        End;
        -- EN Added for FWR-11
    BEGIN
     FOR C1 IN FEEREVERSE LOOP
         -- SN Added for FWR-11
     V_ORGNL_TRANFEE_AMT := C1.CSL_TRANS_AMOUNT;
        if v_feecap_flag = 'Y' then
        BEGIN
            SP_TRAN_FEES_REVCAPCHECK(P_INST_CODE,
                    V_ACCT_NUMBER,
                    V_ORGNL_BUSINESS_DATE,
                    V_ORGNL_TRANFEE_AMT,
                    v_orgnl_fee_amt,
                    V_ORGNL_TXN_FEE_PLAN,
                    V_ORGNL_TXN_FEECODE,
                    V_ERRMSG
                  ); -- Added for FWR-11
        EXCEPTION
          WHEN OTHERS THEN
          V_RESP_CDE := '21';
          V_ERRMSG   := 'Error while reversing the fee Cap amount ' ||
                     SUBSTR(SQLERRM, 1, 200);
          RAISE EXP_RVSL_REJECT_RECORD;
       END;
       End if;
           -- EN Added for FWR-11
       BEGIN
        SP_REVERSE_FEE_AMOUNT(P_INST_CODE,
                          P_RRN,
                          P_DELV_CHNL,
                          P_ORGNL_TERMINAL_ID,
                          P_MERC_ID,
                          P_TXN_CODE,
                          -- V_ORGNL_TXN_CODE, -- Mantis id 0015708
                          V_RVSL_TRANDATE,
                          P_TXN_MODE,
             -- C1.CSL_TRANS_AMOUNT,
                         V_ORGNL_TRANFEE_AMT, -- Modified for FWR-11
                          P_CARD_NO,
                          V_ACTUAL_FEECODE,
                          --C1.CSL_TRANS_AMOUNT,
                          V_ORGNL_TRANFEE_AMT, -- Modified for FWR-11
                          V_ORGNL_TRANFEE_CR_ACCTNO,
                          V_ORGNL_TRANFEE_DR_ACCTNO,
                          V_ORGNL_ST_CALC_FLAG,
                          V_ORGNL_SERVICETAX_AMT,
                          V_ORGNL_ST_CR_ACCTNO,
                          V_ORGNL_ST_DR_ACCTNO,
                          V_ORGNL_CESS_CALC_FLAG,
                          V_ORGNL_CESS_AMT,
                          V_ORGNL_CESS_CR_ACCTNO,
                          V_ORGNL_CESS_DR_ACCTNO,
                          P_ORGNL_RRN,
                          V_CARD_ACCT_NO,
                          P_BUSINESS_DATE,
                          P_BUSINESS_TIME,
                          V_AUTH_ID,
                          C1.CSL_TRANS_NARRRATION,
                          /*C1.CSL_MERCHANT_NAME,
                          C1.CSL_MERCHANT_CITY,
                          C1.CSL_MERCHANT_STATE,*/
                          --Commented and modified on 21.03.2013 for Merchant Logging Info for the Reversal Txn
                          P_MERCHANT_NAME,
                          P_MERCHANT_CITY,
                          P_MERCHANT_STATE,
                          V_RESP_CDE,
                          V_ERRMSG);

        V_FEE_NARRATION := C1.CSL_TRANS_NARRRATION;

        IF V_RESP_CDE <> '00' OR V_ERRMSG <> 'OK' THEN
          RAISE EXP_RVSL_REJECT_RECORD;
        END IF;

       EXCEPTION
        WHEN EXP_RVSL_REJECT_RECORD THEN
          RAISE;

        WHEN OTHERS THEN
          V_RESP_CDE := '21';
          V_ERRMSG   := 'Error while reversing the fee amount ' ||
                     SUBSTR(SQLERRM, 1, 200);
          RAISE EXP_RVSL_REJECT_RECORD;
       END;

     END LOOP;

    EXCEPTION
     WHEN NO_DATA_FOUND THEN
       V_FEE_NARRATION := NULL;
     WHEN OTHERS THEN
       V_FEE_NARRATION := NULL;

    END;

  END IF;

  --Added by Deepa For Reversal Fees on June 27 2012
  IF V_FEE_NARRATION IS NULL THEN
    BEGIN
    --SN Added for FWR-11
           if v_feecap_flag = 'Y' then
        BEGIN
            SP_TRAN_FEES_REVCAPCHECK(P_INST_CODE,
                    V_ACCT_NUMBER,
                    V_ORGNL_BUSINESS_DATE,
                    V_ORGNL_TRANFEE_AMT,
                    v_orgnl_fee_amt,
                    V_ORGNL_TXN_FEE_PLAN,
                    V_ORGNL_TXN_FEECODE,
                    V_ERRMSG
                  ); -- Added for FWR-11
        EXCEPTION
          WHEN OTHERS THEN
          V_RESP_CDE := '21';
          V_ERRMSG   := 'Error while reversing the fee Cap amount ' ||
                     SUBSTR(SQLERRM, 1, 200);
          RAISE EXP_RVSL_REJECT_RECORD;
       END;
       End if;
       --EN Added for FWR-11
     SP_REVERSE_FEE_AMOUNT(P_INST_CODE,
                       P_RRN,
                       P_DELV_CHNL,
                       P_ORGNL_TERMINAL_ID,
                       P_MERC_ID,
                       P_TXN_CODE,
                      --  V_ORGNL_TXN_CODE, -- Mantis id 0015708
                       V_RVSL_TRANDATE,
                       P_TXN_MODE,
                       V_ORGNL_TXN_TOTALFEE_AMT,
                       P_CARD_NO,
                       V_ACTUAL_FEECODE,
                       V_ORGNL_TRANFEE_AMT,
                       V_ORGNL_TRANFEE_CR_ACCTNO,
                       V_ORGNL_TRANFEE_DR_ACCTNO,
                       V_ORGNL_ST_CALC_FLAG,
                       V_ORGNL_SERVICETAX_AMT,
                       V_ORGNL_ST_CR_ACCTNO,
                       V_ORGNL_ST_DR_ACCTNO,
                       V_ORGNL_CESS_CALC_FLAG,
                       V_ORGNL_CESS_AMT,
                       V_ORGNL_CESS_CR_ACCTNO,
                       V_ORGNL_CESS_DR_ACCTNO,
                       P_ORGNL_RRN,
                       V_CARD_ACCT_NO,
                       P_BUSINESS_DATE,
                       P_BUSINESS_TIME,
                       V_AUTH_ID,
                       V_FEE_NARRATION,
                       /*V_FEE_MERCHNAME,
                       V_FEE_MERCHCITY,
                       V_FEE_MERCHSTATE,*/
                       --Commented and modified on 21.03.2013 for Merchant Logging Info for the Reversal Txn
                       P_MERCHANT_NAME,
                       P_MERCHANT_CITY,
                       P_MERCHANT_STATE,
                       V_RESP_CDE,
                       V_ERRMSG);

     IF V_RESP_CDE <> '00' OR V_ERRMSG <> 'OK' THEN
       RAISE EXP_RVSL_REJECT_RECORD;
     END IF;

    EXCEPTION
     WHEN EXP_RVSL_REJECT_RECORD THEN
       RAISE;

     WHEN OTHERS THEN
       V_RESP_CDE := '21';
       V_ERRMSG   := 'Error while reversing the fee amount ' ||
                  SUBSTR(SQLERRM, 1, 200);
       RAISE EXP_RVSL_REJECT_RECORD;
    END;

  END IF;
  END IF; ----Added For Mantis-Id-0010997

  --En reverse the fee

  --Sn reverse the GL entries

  IF V_GL_UPD_FLAG = 'Y' THEN

    --Sn find business date
    V_BUSINESS_TIME := TO_CHAR(V_RVSL_TRANDATE, 'HH24:MI');
    IF V_BUSINESS_TIME > V_CUTOFF_TIME THEN
     V_RVSL_TRANDATE := TRUNC(V_RVSL_TRANDATE) + 1;
    ELSE
     V_RVSL_TRANDATE := TRUNC(V_RVSL_TRANDATE);
    END IF;
    --En find businesses date

    --Sn commented for fwr-48

  /*  SP_REVERSE_GL_ENTRIES(P_INST_CODE,
                     V_RVSL_TRANDATE,
                     V_PROD_CODE,
                     V_CARD_TYPE,
                     V_REVERSAL_AMT,
                     V_FUNC_CODE,
                     P_TXN_CODE,
                     V_DR_CR_FLAG,
                     P_CARD_NO,
                     V_ACTUAL_FEECODE,
                     V_ORGNL_TXN_TOTALFEE_AMT,
                     V_ORGNL_TRANFEE_CR_ACCTNO,
                     V_ORGNL_TRANFEE_DR_ACCTNO,
                     V_CARD_ACCT_NO,
                     P_RVSL_CODE,
                     P_MSG_TYP,
                     P_DELV_CHNL,
                     V_RESP_CDE,
                     V_GL_UPD_FLAG,
                     V_ERRMSG);
    IF V_GL_UPD_FLAG <> 'Y' THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := V_ERRMSG || 'Error while retriving gl detail ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
    END IF;*/

    --En commented for fwr-48

  END IF;
  --En reverse the GL entries

  V_RESP_CDE := '1';
  --Added by Deepa on June 26 2012 for Reversal Fee Calculation

    IF P_DELV_CHNL = '01' THEN
        BEGIN

          SELECT COUNT(*)
          INTO V_NETWORKIDCOUNT
          FROM CMS_PROD_CATTYPE prodCat,
          VMS_PRODCAT_NETWORKID_MAPPING MAPP
          WHERE prodCat.CPC_INST_CODE=MAPP.VPN_INST_CODE
          AND prodCat.CPC_INST_CODE=p_inst_code
          AND prodCat.CPC_NETWORKACQID_FLAG='Y'
          and prodCat.CPC_PROD_CODE=MAPP.VPN_PROD_CODE
          and upper(MAPP.VPN_NETWORK_ID)='VDBZ'
           AND prodCat.CPC_CARD_TYPE= v_card_type
          AND prodCat.CPC_CARD_TYPE= MAPP.VPN_CARD_TYPE
          and MAPP.VPN_PROD_CODE=v_prod_code;

        EXCEPTION
        WHEN OTHERS THEN
         V_RESP_CDE := '21';
            v_ERRMSG :=
                'Error while selecting product network id ' || SUBSTR (SQLERRM, 1, 200);
            RAISE EXP_RVSL_REJECT_RECORD;

        END;

      END IF;

   IF v_timeout_rev='N' THEN --Added for FWR-44
   IF V_NETWORKIDCOUNT <> 1 THEN

  --Sn reversal Fee Calculation
  BEGIN

    SP_TRAN_REVERSAL_FEES(P_INST_CODE,
                     P_CARD_NO,
                     P_DELV_CHNL,
                     V_ORGNL_TXN_MODE,
                     P_TXN_CODE,
                     P_CURR_CODE,
                     NULL,
                     NULL,
                     V_REVERSAL_AMT,
                     P_BUSINESS_DATE,
                     P_BUSINESS_TIME,
                     v_internation_ind_response, --NULL commented and value passed for 13063
                     v_pos_verification,         --NULL commented and value passed for 13063
                     V_RESP_CDE,
                     P_MSG_TYP,
                     P_MBR_NUMB,
                     P_RRN,
                     P_TERMINAL_ID,
                     /*V_TXN_MERCHNAME,
                     V_TXN_MERCHCITY,*/
                     --Commented and modified on 21.03.2013 for Merchant Logging Info for the Reversal Txn
                     P_MERCHANT_NAME,
                     P_MERCHANT_CITY,
                     V_AUTH_ID,
                     --V_FEE_MERCHSTATE,--Commented and modified on 21.03.2013 for Merchant Logging Info for the Reversal Txn
                     P_MERCHANT_STATE,
                     P_RVSL_CODE,
                     V_TXN_NARRATION,
                     V_TXN_TYPE,
                     V_TRAN_DATE,
                     V_ERRMSG,
                     V_RESP_CDE,
                     V_FEE_AMT,  --Modified for C2C CR on 20-Dec-2012 --position swapped on 07-jan-2013
                     V_FEE_PLAN,--Modified for C2C CR on 20-Dec-2012 --position swapped on 07-jan-2013
                     V_FEE_CODE,      --Added on 30.07.2013 for 11695
                     V_FEEATTACH_TYPE --Added on 30.07.2013 for 11695
                     );

        P_FEE_AMT:=V_FEE_AMT;--Added for C2C CR on 20-Dec-2012
        IF V_ERRMSG <> 'OK' THEN
         RAISE EXP_RVSL_REJECT_RECORD;
        END IF;
      END;
   ELSE
     v_fee_amt :=0;
  END IF;
  END IF; --Added for FWR-44

  --En reversal Fee Calculation

  --Sn added by Pankaj S. for 10871
     BEGIN
	 --Added for VMS-5739/FSP-991
 select (add_months(trunc(sysdate,'MM'),'-'||RETENTION_PERIOD))
       INTO   v_Retperiod 
       FROM DBA_OPERATIONS.ARCHIVE_MGMNT_CTL 
       WHERE  OPERATION_TYPE='ARCHIVE' 
       AND OBJECT_NAME='CMS_STATEMENTS_LOG_EBR';
       
       v_Retdate := TO_DATE(SUBSTR(TRIM(p_business_date), 1, 8), 'yyyymmdd');


IF (v_Retdate>v_Retperiod)
    THEN



        UPDATE cms_statements_log
           SET csl_prod_code = v_prod_code,
               csl_card_type=v_card_type,
               --csl_acct_type = v_acct_type, --Commented for FWR-44
               csl_time_stamp = v_timestamp
         WHERE csl_inst_code = p_inst_code
           AND csl_pan_no = v_hash_pan
           AND csl_rrn = p_rrn
           AND csl_txn_code = p_txn_code
           AND csl_delivery_channel = p_delv_chnl
           AND csl_business_date = p_business_date
           AND csl_business_time = p_business_time;
ELSE
		UPDATE VMSCMS_HISTORY.CMS_STATEMENTS_LOG_HIST --Added for VMS-5733/FSP-991
           SET csl_prod_code = v_prod_code,
               csl_card_type=v_card_type,
               --csl_acct_type = v_acct_type, --Commented for FWR-44
               csl_time_stamp = v_timestamp
         WHERE csl_inst_code = p_inst_code
           AND csl_pan_no = v_hash_pan
           AND csl_rrn = p_rrn
           AND csl_txn_code = p_txn_code
           AND csl_delivery_channel = p_delv_chnl
           AND csl_business_date = p_business_date
           AND csl_business_time = p_business_time;
END IF;		   
       IF SQL%ROWCOUNT =0
       THEN
         NULL;
       END IF;
       EXCEPTION
       WHEN OTHERS
       THEN
          V_RESP_CDE := '21';
          v_errmsg :=
               'Error while updating timestamp in statementlog-' || SUBSTR (SQLERRM, 1, 200);
          RAISE EXP_RVSL_REJECT_RECORD;
    END;
    --Sn added by Pankaj S. for 10871

  --Sn Logging of system initiated card status change(FSS-390)
    IF v_chnge_crdstat='Y' THEN
    BEGIN
       sp_log_cardstat_chnge (p_inst_code,
                              v_hash_pan,
                              v_encr_pan,
                              v_auth_id,
                              '03',
                              p_rrn,
                              p_business_date,
                              p_business_time,
                              v_resp_cde,
                              v_errmsg
                             );

       IF v_resp_cde <> '00' AND v_errmsg <> 'OK'
       THEN
          RAISE exp_rvsl_reject_record;
       END IF;
       v_resp_cde:='1';
    EXCEPTION
       WHEN exp_rvsl_reject_record
       THEN
          RAISE;
       WHEN OTHERS
       THEN
          v_resp_cde := '21';
          v_errmsg :=
                'Error while logging system initiated card status change '
             || SUBSTR (SQLERRM, 1, 200);
          RAISE exp_rvsl_reject_record;
    END;
    END IF;
  --En Logging of system initiated card status change(FSS-390)

  --Sn create a entry for successful
  BEGIN

    IF V_ERRMSG = 'OK' THEN

     INSERT INTO CMS_TRANSACTION_LOG_DTL
       (CTD_DELIVERY_CHANNEL,
        CTD_TXN_CODE,
        CTD_TXN_TYPE,
        CTD_MSG_TYPE,
        CTD_TXN_MODE,
        CTD_BUSINESS_DATE,
        CTD_BUSINESS_TIME,
        CTD_CUSTOMER_CARD_NO,
        CTD_TXN_AMOUNT,
        CTD_TXN_CURR,
        CTD_ACTUAL_AMOUNT,
        CTD_BILL_AMOUNT,
        CTD_BILL_CURR,
        CTD_PROCESS_FLAG,
        CTD_PROCESS_MSG,
        CTD_RRN,
        CTD_SYSTEM_TRACE_AUDIT_NO,
        CTD_INST_CODE,
        CTD_CUSTOMER_CARD_NO_ENCR,
        CTD_CUST_ACCT_NUMBER,
        /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        CTD_NETWORK_ID,
        CTD_INTERCHANGE_FEEAMT,
        CTD_MERCHANT_ZIP,
        /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        CTD_MERCHANT_ID     --Added on 19-Mar-2013 for FSS-970
        ,CTD_INTERNATION_IND_RESPONSE,
        ctd_location_id,
        ctd_reason_code)
     VALUES
       (P_DELV_CHNL,
        P_TXN_CODE,
        --P_TXN_TYPE,
        V_TXN_TYPE, --Modified by Deepa on June 26 2012 As the value is passed as NULL
        P_MSG_TYP,
        P_TXN_MODE,
        P_BUSINESS_DATE,
        P_BUSINESS_TIME,
        V_HASH_PAN,
        P_ACTUAL_AMT,
        V_CURRCODE,
        V_TRAN_AMT,
        V_REVERSAL_AMT,
        V_CARD_CURR,
        'Y',
        'Successful',
        P_RRN,
        P_STAN,
        P_INST_CODE,
        V_ENCR_PAN,
        --Sn Modified for FWR-44
        CASE WHEN (p_delv_chnl IN ('07','13') AND p_txn_code ='11') OR (p_delv_chnl = '10' AND p_txn_code ='20') THEN
              v_cust_acct_no
        ELSE
               V_ACCT_NUMBER
        END,
        --En Modified for FWR-44
        /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        P_NETWORK_ID,
        P_INTERCHANGE_FEEAMT,
        P_MERCHANT_ZIP,
        /* End  Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        P_MERCHANT_ID  --Added on 19-Mar-2013 for FSS-970
       ,v_internation_ind_response,
       P_ORGNL_TERMINAL_ID,
       v_reason_code);
    END IF;
    BEGIN
     SELECT CAM_ACCT_BAL, CAM_LEDGER_BAL,cam_type_code
       INTO V_ACCT_BALANCE, V_LEDGE_BALANCE,v_acct_type
       FROM CMS_ACCT_MAST
      --Sn Modified for FWR-44
      WHERE CAM_ACCT_NO = (CASE WHEN (p_delv_chnl IN ('07','13') AND p_txn_code ='11') OR (p_delv_chnl = '10' AND p_txn_code ='20') THEN
                                  v_cust_acct_no
                           ELSE
                                  V_ACCT_NUMBER
                           END)
         /*  (SELECT CAP_ACCT_NO
             FROM CMS_APPL_PAN
            WHERE CAP_PAN_CODE = V_HASH_PAN AND
                 CAP_INST_CODE = P_INST_CODE) AND*/
      --En Modified for FWR-44
       AND CAM_INST_CODE = P_INST_CODE;
    EXCEPTION
     WHEN OTHERS THEN
       V_ACCT_BALANCE  := 0;
       V_LEDGE_BALANCE := 0;
    END;
    -- added for mantis Id:13627
   IF V_Topup_Acct_No is not null THEN
    BEGIN
     SELECT CAM_ACCT_BAL, CAM_LEDGER_BAL
       INTO V_ACCT_BALANCE_TO, V_LEDGE_BALANCE_TO
       FROM CMS_ACCT_MAST
       WHERE CAM_ACCT_NO =V_Topup_Acct_No
      AND CAM_INST_CODE = P_INST_CODE;
    EXCEPTION
     WHEN OTHERS THEN
       V_ACCT_BALANCE_TO  := 0;
       V_LEDGE_BALANCE_TO := 0;
    END;
       END IF;
    --Added the 5 empty values for CMS_TRANSACTION_LOG_DTL in cms
  EXCEPTION
    WHEN OTHERS THEN
     V_ERRMSG   := 'Problem while selecting data from response master ' ||
                SUBSTR(SQLERRM, 1, 300);
     V_RESP_CDE := '21';
     RAISE EXP_RVSL_REJECT_RECORD;
  END;

  --En create a entry for successful

  --Sn generate response code

  BEGIN
    SELECT CMS_ISO_RESPCDE
     INTO P_RESP_CDE
     FROM CMS_RESPONSE_MAST
    WHERE CMS_INST_CODE = P_INST_CODE AND
         CMS_DELIVERY_CHANNEL = P_DELV_CHNL AND
         CMS_RESPONSE_ID = TO_NUMBER(V_RESP_CDE);
  EXCEPTION
    WHEN OTHERS THEN
     V_ERRMSG   := 'Problem while selecting data from response master for respose code' ||
                V_RESP_CDE || SUBSTR(SQLERRM, 1, 300);
     V_RESP_CDE := '69';
     RAISE EXP_RVSL_REJECT_RECORD;
  END;

  --En generate response code

  BEGIN

    INSERT INTO TRANSACTIONLOG
     (MSGTYPE,
      RRN,
      DELIVERY_CHANNEL,
      TERMINAL_ID,
      DATE_TIME,
      TXN_CODE,
      TXN_TYPE,
      TXN_MODE,
      TXN_STATUS,
      RESPONSE_CODE,
      BUSINESS_DATE,
      BUSINESS_TIME,
      CUSTOMER_CARD_NO,
      TOPUP_CARD_NO,
      TOPUP_ACCT_NO,
      TOPUP_ACCT_TYPE,
      BANK_CODE,
      TOTAL_AMOUNT,
      RULE_INDICATOR,
      RULEGROUPID,
      MCCODE,
      CURRENCYCODE,
      PRODUCTID,
      CATEGORYID,
      TRANFEE_AMT,
      TIPS,
      DECLINE_RULEID,
      ATM_NAME_LOCATION,
      AUTH_ID,
      TRANS_DESC,
      AMOUNT,
      PREAUTHAMOUNT,
      PARTIALAMOUNT,
      MCCODEGROUPID,
      CURRENCYCODEGROUPID,
      TRANSCODEGROUPID,
      RULES,
      PREAUTH_DATE,
      GL_UPD_FLAG,
      SYSTEM_TRACE_AUDIT_NO,
      INSTCODE,
      FEECODE,
      FEEATTACHTYPE,
      TRAN_REVERSE_FLAG,
      CUSTOMER_CARD_NO_ENCR,
      TOPUP_CARD_NO_ENCR,
      PROXY_NUMBER,
      REVERSAL_CODE,
      CUSTOMER_ACCT_NO,
      ACCT_BALANCE,
      LEDGER_BALANCE,
      ORGNL_RRN,
      ORGNL_BUSINESS_DATE,
      ORGNL_BUSINESS_TIME,
      ORGNL_CARD_NO,
      ORGNL_TERMINAL_ID,
      RESPONSE_ID,
      ANI,
      DNI,
      /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
      NETWORK_ID,
      INTERCHANGE_FEEAMT,
      MERCHANT_ZIP,
      /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
      FEE_PLAN, --Added by Deepa on June 26 2012 for fee plan
      MERCHANT_NAME, -- Added FOR MERCHANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
      MERCHANT_CITY, -- Added FOR MERCHANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
      MERCHANT_STATE, -- Added FOR MERCHANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
      NETWORK_SETTL_DATE,  -- Added on 201112 for logging N/W settlement date in transactionlog
      MERCHANT_ID,          --Added on 19-Mar-2013 for FSS-970
      --Sn added by Pankaj S. for 10871
      cr_dr_flag,
      cardstatus,
      acct_type,
      error_msg,
      time_stamp,
      --En added by Pankaj S. for 10871
      NETWORKID_SWITCH,   --Added on 20130626 for the Mantis ID 11344
       NETWORKID_ACQUIRER     -- Added for LYFE Changes
      ,INTERNATION_IND_RESPONSE,
      TOPUP_ACCT_BALANCE,   -- added for Mantis ID:13627
      TOPUP_LEDGER_BALANCE,  -- added for Mantis ID:13627
      REMARK,
      REASON_CODE
      )
    VALUES
     (P_MSG_TYP,
      P_RRN,
      P_DELV_CHNL,
      P_TERMINAL_ID,
      V_RVSL_TRANDATE,
      P_TXN_CODE,
      -- P_TXN_TYPE,
      V_TXN_TYPE, --Modified by Deepa on June 26 2012 As the value is passed as NULL
      P_TXN_MODE,
      DECODE(P_RESP_CDE, '00', 'C', 'F'),
      P_RESP_CDE,
      P_BUSINESS_DATE,
      SUBSTR(P_BUSINESS_TIME, 1, 6),
      V_HASH_PAN,
      --Sn modified for FWR-44
      V_TOPUP_CARD_NO,--NULL--V_TOPUP_CARD_NO replaced by NULL for mantis is 11000
      v_topup_acct_no, --NULL--P_topup_acctno    ,
      v_topup_acct_type, --NULL--P_topup_accttype,
      --En modified for FWR-44
      P_INST_CODE,
      TRIM(TO_CHAR(nvl(V_REVERSAL_AMT,0), '999999999999999990.99'))  --formated fro 10871
      -- reversal amount will be passed in the table as the same is used in the recon report.
     ,
      NULL,
      NULL,
      P_MERC_ID,
      V_CURR_CODE,
      V_PROD_CODE,
      V_CARD_TYPE,
      nvl(V_FEE_AMT,0), --Added by Deepa on June 26 2012 for logging fee
      '0.00',--modified by Pankaj S. for 10871
      NULL,
      NULL,
      V_AUTH_ID,
      V_TRAN_DESC,
      TRIM(TO_CHAR(nvl(V_REVERSAL_AMT,0), '999999999999999990.99')), --formated fro 10871
      -- reversal amount will be passed in the table as the same is used in the recon report.
      '0.00',--modified by Pankaj S. for 10871  --- PRE AUTH AMOUNT
      '0.00',--modified by Pankaj S. for 10871 -- Partial amount (will be given for partial txn)
      NULL,
      NULL,
      NULL,
      NULL,
      NULL,
      'Y',
      P_STAN,
      P_INST_CODE,
     --NULL,
      V_FEE_CODE, --Added on 30.07.2013 for 11695
      --NULL,
      V_FEEATTACH_TYPE, --Added on 30.07.2013 for 11695
      'N',
      V_ENCR_PAN,
      --V_TOPUP_CARD_NO_ENCR,
    --  NULL,                  --Added for mantis is 11000
    V_TOPUP_CARD_NO_ENCR, --Added for Mantis 13555 on 29 Jan 14
      V_PROXUNUMBER,
      P_RVSL_CODE,
      --Sn Modified for FWR-44
      CASE WHEN (p_delv_chnl IN ('07','13') AND p_txn_code ='11') OR (p_delv_chnl = '10' AND p_txn_code ='20') THEN
             v_cust_acct_no
      ELSE
             V_ACCT_NUMBER
      END,
      --En Modified for FWR-44
      V_ACCT_BALANCE,
      V_LEDGE_BALANCE,
      P_ORGNL_RRN,
      V_ORGNL_BUSINESS_DATE,
      V_ORGNL_BUSINESS_TIME,
      V_ENCR_PAN,
      P_ORGNL_TERMINAL_ID,
      V_RESP_CDE,
      P_ANI,
      P_DNI,
      /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
      P_NETWORK_ID,
      P_INTERCHANGE_FEEAMT,
      P_MERCHANT_ZIP,
      /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
      V_FEE_PLAN, --Added by Deepa on June 26 2012 for fee plan
       /*V_TXN_MERCHNAME, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         V_TXN_MERCHCITY, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         V_TXN_MERCHSTATE, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012*/
       --Commented and modified on 21.03.2013 for Merchant Logging Info for the Reversal Txn
       P_MERCHANT_NAME,
       P_MERCHANT_CITY,
       P_MERCHANT_STATE,
       P_NETWORK_SETL_DATE,  -- Added on 201112 for logging N/W settlement date in transactionlog
      P_MERCHANT_ID,  --Added on 19-Mar-2013 for FSS-970
      --Sn added by Pankaj S. for 10871
      --v_dr_cr_flag, --Commented and modified on 25.07.2013 for 11693
     -- decode(P_DELV_CHNL,'04',v_dr_cr_flag,decode(v_dr_cr_flag,'CR','DR','DR','CR',v_dr_cr_flag)),--modified for mantis id 0012841: DEFECT:CMS:INCOMM:Transactionlog CR/DR flag of MMPOS
      decode(P_DELV_CHNL,'04',decode(P_RVSL_CODE,'00',v_dr_cr_flag,decode(v_dr_cr_flag,'CR','DR','DR','CR',v_dr_cr_flag)) ,decode(v_dr_cr_flag,'CR','DR','DR','CR',v_dr_cr_flag)), --Modified for 13410
      --card topup reversal and card deactivation transaction were displayed as incorrect
      v_cap_card_stat,
      v_acct_type,
      v_errmsg,
      v_timestamp,
      --En added by Pankaj S. for 10871
      P_NETWORKID_SWITCH,  --Added on 20130626 for the Mantis ID 11344
       DECODE (P_DELV_CHNL, '01', 'VDBZ', '')  -- Added for LYFE Changes
      ,v_internation_ind_response,
      nvl(V_ACCT_BALANCE_TO,0),
      nvl(V_LEDGE_BALANCE_TO,0),
      --changed for FSS-4118
     CASE WHEN (p_delv_chnl IN ('07','10') AND p_txn_code ='07') OR (p_delv_chnl = '13' AND p_txn_code ='13') THEN
            'From Account No : ' ||
                                  FN_MASK_ACCT(V_ACCT_NUMBER) || ' ' ||
                                  'To Account No : ' ||
                                  FN_MASK_ACCT(V_Topup_Acct_No)
      ELSE
             NULL
      END,
      v_reason_code
);

    --Sn update reverse flag
    BEGIN
	--Added for VMS-5739/FSP-991
 select (add_months(trunc(sysdate,'MM'),'-'||RETENTION_PERIOD))
       INTO   v_Retperiod 
       FROM DBA_OPERATIONS.ARCHIVE_MGMNT_CTL 
       WHERE  OPERATION_TYPE='ARCHIVE' 
       AND OBJECT_NAME='TRANSACTIONLOG_EBR';
       
       v_Retdate := TO_DATE(SUBSTR(TRIM(V_ORGNL_BUSINESS_DATE), 1, 8), 'yyyymmdd');


IF (v_Retdate>v_Retperiod)
    THEN
     UPDATE TRANSACTIONLOG
        SET TRAN_REVERSE_FLAG = 'Y',
           ANI               = P_ANI,
           DNI               = P_DNI
           --CUSTOMER_ACCT_NO  = V_ACCT_NUMBER  --commented for FWR-44
      WHERE RRN = P_ORGNL_RRN AND BUSINESS_DATE = V_ORGNL_BUSINESS_DATE AND
           BUSINESS_TIME = V_ORGNL_BUSINESS_TIME AND
           CUSTOMER_CARD_NO = V_HASH_PAN --P_card_no;
           AND INSTCODE = P_INST_CODE;
ELSE
	 UPDATE VMSCMS_HISTORY.TRANSACTIONLOG_HIST --Added for VMS-5733/FSP-991
        SET TRAN_REVERSE_FLAG = 'Y',
           ANI               = P_ANI,
           DNI               = P_DNI
           --CUSTOMER_ACCT_NO  = V_ACCT_NUMBER  --commented for FWR-44
      WHERE RRN = P_ORGNL_RRN AND BUSINESS_DATE = V_ORGNL_BUSINESS_DATE AND
           BUSINESS_TIME = V_ORGNL_BUSINESS_TIME AND
           CUSTOMER_CARD_NO = V_HASH_PAN --P_card_no;
           AND INSTCODE = P_INST_CODE;
END IF;		   

     IF SQL%ROWCOUNT = 0 THEN

       V_RESP_CDE := '21';
       V_ERRMSG   := 'Reverse flag is not updated ';
       RAISE EXP_RVSL_REJECT_RECORD;
     END IF;
    EXCEPTION
     WHEN EXP_RVSL_REJECT_RECORD THEN
       RAISE;
     WHEN OTHERS THEN
       V_RESP_CDE := '21';
       V_ERRMSG   := 'Error while updating gl flag ' ||
                  SUBSTR(SQLERRM, 1, 200);
       RAISE EXP_RVSL_REJECT_RECORD;

    END;

    BEGIN
	--Added for VMS-5739/FSP-991
 select (add_months(trunc(sysdate,'MM'),'-'||RETENTION_PERIOD))
       INTO   v_Retperiod 
       FROM DBA_OPERATIONS.ARCHIVE_MGMNT_CTL 
       WHERE  OPERATION_TYPE='ARCHIVE' 
       AND OBJECT_NAME='TRANSACTIONLOG_EBR';
       
       v_Retdate := TO_DATE(SUBSTR(TRIM(P_BUSINESS_DATE), 1, 8), 'yyyymmdd');


IF (v_Retdate>v_Retperiod)
    THEN
     UPDATE TRANSACTIONLOG
        SET ANI = P_ANI, DNI = P_DNI, --CUSTOMER_ACCT_NO = V_ACCT_NUMBER --Commented for FWR-44
        --changed for FSS-4118
           REMARK=CASE WHEN (p_delv_chnl IN ('07','10') AND p_txn_code ='07') OR (p_delv_chnl = '13' AND p_txn_code ='1.3') THEN
            'From Account No : ' ||
                                  FN_MASK_ACCT(V_ACCT_NUMBER) || ' ' ||
                                  'To Account No : ' ||
                                  FN_MASK_ACCT(V_Topup_Acct_No)
      ELSE
             NULL
      END
      WHERE RRN = P_RRN AND BUSINESS_DATE = P_BUSINESS_DATE AND
           TXN_CODE = P_TXN_CODE AND MSGTYPE = P_MSG_TYP AND
           BUSINESS_TIME = P_BUSINESS_TIME AND
           DELIVERY_CHANNEL = P_DELV_CHNL;
ELSE
	 UPDATE VMSCMS_HISTORY.TRANSACTIONLOG_HIST --Added for VMS-5733/FSP-991
        SET ANI = P_ANI, DNI = P_DNI, --CUSTOMER_ACCT_NO = V_ACCT_NUMBER --Commented for FWR-44
        --changed for FSS-4118
           REMARK=CASE WHEN (p_delv_chnl IN ('07','10') AND p_txn_code ='07') OR (p_delv_chnl = '13' AND p_txn_code ='1.3') THEN
            'From Account No : ' ||
                                  FN_MASK_ACCT(V_ACCT_NUMBER) || ' ' ||
                                  'To Account No : ' ||
                                  FN_MASK_ACCT(V_Topup_Acct_No)
      ELSE
             NULL
      END
      WHERE RRN = P_RRN AND BUSINESS_DATE = P_BUSINESS_DATE AND
           TXN_CODE = P_TXN_CODE AND MSGTYPE = P_MSG_TYP AND
           BUSINESS_TIME = P_BUSINESS_TIME AND
           DELIVERY_CHANNEL = P_DELV_CHNL;
END IF;
		   
		   

     IF SQL%ROWCOUNT = 0 THEN
       V_ERRMSG   := 'Error while updating the TRANSACTIONLOG';
       V_RESP_CDE := '21';
       RAISE EXP_RVSL_REJECT_RECORD;
     END IF;

    EXCEPTION
     WHEN OTHERS THEN
       V_RESP_CDE := '69';
       V_ERRMSG   := 'Problem while inserting data into transaction log  dtl' ||
                  SUBSTR(SQLERRM, 1, 300);
    END;
    --En update reverse flag

    BEGIN

     SELECT CTC_ATMUSAGE_AMT,
           CTC_POSUSAGE_AMT,
           CTC_BUSINESS_DATE,
           CTC_MMPOSUSAGE_AMT
       INTO V_ATM_USAGEAMNT,
           V_POS_USAGEAMNT,
           V_BUSINESS_DATE_TRAN,
           V_MMPOS_USAGEAMNT
       FROM CMS_TRANSLIMIT_CHECK
      WHERE CTC_INST_CODE = P_INST_CODE AND CTC_PAN_CODE = V_HASH_PAN AND
           CTC_MBR_NUMB = V_MBR_NUMB;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
       V_ERRMSG   := 'Cannot get the Transaction Limit Details of the Card' ||
                  V_RESP_CDE || SUBSTR(SQLERRM, 1, 300);
       V_RESP_CDE := '21';
       RAISE EXP_RVSL_REJECT_RECORD;
     WHEN OTHERS THEN
       V_ERRMSG   := 'Error while selecting 1 CMS_TRANSLIMIT_CHECK ' ||
                  SUBSTR(SQLERRM, 1, 200);
       V_RESP_CDE := '21';
       RAISE EXP_RVSL_REJECT_RECORD;
    END;

    BEGIN

     --Sn Limit and amount check for ATM
     IF P_DELV_CHNL = '01' THEN

       IF V_RVSL_TRANDATE > V_BUSINESS_DATE_TRAN THEN
        BEGIN
          UPDATE CMS_TRANSLIMIT_CHECK
            SET CTC_POSUSAGE_AMT       = 0,
                CTC_POSUSAGE_LIMIT     = 0,
                CTC_ATMUSAGE_AMT       = 0,
                CTC_ATMUSAGE_LIMIT     = 0,
                CTC_BUSINESS_DATE      = TO_DATE(P_BUSINESS_DATE ||
                                          '23:59:59',
                                          'yymmdd' || 'hh24:mi:ss'),
                CTC_PREAUTHUSAGE_LIMIT = 0,
                CTC_MMPOSUSAGE_AMT     = 0,
                CTC_MMPOSUSAGE_LIMIT   = 0
           WHERE CTC_INST_CODE = P_INST_CODE AND
                CTC_PAN_CODE = V_HASH_PAN AND CTC_MBR_NUMB = V_MBR_NUMB;

          IF SQL%ROWCOUNT = 0 THEN
            V_ERRMSG   := 'CMS_TRANSLIMIT_CHECK 1 is not done.';
            V_RESP_CDE := '21';
            RAISE EXP_RVSL_REJECT_RECORD;
          END IF;

        EXCEPTION
          WHEN OTHERS THEN
            V_ERRMSG   := 'Error while updating 1 CMS_TRANSLIMIT_CHECK ' ||
                       SUBSTR(SQLERRM, 1, 200);
            V_RESP_CDE := '21';
            RAISE EXP_RVSL_REJECT_RECORD;
        END;
       ELSE
        IF V_ORGNL_BUSINESS_DATE = P_BUSINESS_DATE THEN

          IF V_REVERSAL_AMT IS NULL THEN
            V_ATM_USAGEAMNT := V_ATM_USAGEAMNT;
          ELSE
            V_ATM_USAGEAMNT := V_ATM_USAGEAMNT -
                           TRIM(TO_CHAR(V_REVERSAL_AMT,
                                     '999999999999.99'));
          END IF;
          BEGIN
            UPDATE CMS_TRANSLIMIT_CHECK
              SET CTC_POSUSAGE_AMT = V_ATM_USAGEAMNT
            WHERE CTC_INST_CODE = P_INST_CODE AND
                 CTC_PAN_CODE = V_HASH_PAN AND
                 CTC_MBR_NUMB = V_MBR_NUMB;
          EXCEPTION
            WHEN OTHERS THEN
             V_ERRMSG   := 'Error while updating 2 CMS_TRANSLIMIT_CHECK ' ||
                        SUBSTR(SQLERRM, 1, 200);
             V_RESP_CDE := '21';
             RAISE EXP_RVSL_REJECT_RECORD;
          END;
        END IF;
       END IF;
     END IF;
     --En Limit and amount check for ATM

     --Sn Limit and amount check for POS

     IF P_DELV_CHNL = '02' THEN

       IF V_RVSL_TRANDATE > V_BUSINESS_DATE_TRAN THEN
        BEGIN
          UPDATE CMS_TRANSLIMIT_CHECK
            SET CTC_POSUSAGE_AMT       = 0,
                CTC_POSUSAGE_LIMIT     = 0,
                CTC_ATMUSAGE_AMT       = 0,
                CTC_ATMUSAGE_LIMIT     = 0,
                CTC_BUSINESS_DATE      = TO_DATE(P_BUSINESS_DATE ||
                                          '23:59:59',
                                          'yymmdd' || 'hh24:mi:ss'),
                CTC_PREAUTHUSAGE_LIMIT = 0,
                CTC_MMPOSUSAGE_AMT     = 0,
                CTC_MMPOSUSAGE_LIMIT   = 0
           WHERE CTC_INST_CODE = P_INST_CODE AND
                CTC_PAN_CODE = V_HASH_PAN AND CTC_MBR_NUMB = V_MBR_NUMB;
        EXCEPTION
          WHEN OTHERS THEN
            V_ERRMSG   := 'Error while updating 3 CMS_TRANSLIMIT_CHECK ' ||
                       SUBSTR(SQLERRM, 1, 200);
            V_RESP_CDE := '21';
            RAISE EXP_RVSL_REJECT_RECORD;
        END;
       ELSE
        IF V_ORGNL_BUSINESS_DATE = P_BUSINESS_DATE THEN

          IF V_REVERSAL_AMT IS NULL THEN
            V_POS_USAGEAMNT := V_POS_USAGEAMNT;

          ELSE
            V_POS_USAGEAMNT := V_POS_USAGEAMNT -
                           TRIM(TO_CHAR(V_REVERSAL_AMT,
                                     '999999999999.99'));
          END IF;
          BEGIN
            UPDATE CMS_TRANSLIMIT_CHECK
              SET CTC_POSUSAGE_AMT = V_POS_USAGEAMNT
            WHERE CTC_INST_CODE = P_INST_CODE AND
                 CTC_PAN_CODE = V_HASH_PAN AND
                 CTC_MBR_NUMB = V_MBR_NUMB;
          EXCEPTION
            WHEN OTHERS THEN
             V_ERRMSG   := 'Error while updating 4 CMS_TRANSLIMIT_CHECK ' ||
                        SUBSTR(SQLERRM, 1, 200);
             V_RESP_CDE := '21';
             RAISE EXP_RVSL_REJECT_RECORD;
          END;
        END IF;
       END IF;
     END IF;

     --En Limit and amount check for POS

     --Sn Limit and amount check for MMPOS

     IF P_DELV_CHNL = '04' THEN

       IF V_RVSL_TRANDATE > V_BUSINESS_DATE_TRAN THEN
        BEGIN
          UPDATE CMS_TRANSLIMIT_CHECK
            SET CTC_POSUSAGE_AMT       = 0,
                CTC_POSUSAGE_LIMIT     = 0,
                CTC_ATMUSAGE_AMT       = 0,
                CTC_ATMUSAGE_LIMIT     = 0,
                CTC_BUSINESS_DATE      = TO_DATE(P_BUSINESS_DATE ||
                                          '23:59:59',
                                          'yymmdd' || 'hh24:mi:ss'),
                CTC_PREAUTHUSAGE_LIMIT = 0,
                CTC_MMPOSUSAGE_AMT     = 0,
                CTC_MMPOSUSAGE_LIMIT   = 0
           WHERE CTC_INST_CODE = P_INST_CODE AND
                CTC_PAN_CODE = V_HASH_PAN AND CTC_MBR_NUMB = V_MBR_NUMB;
        EXCEPTION
          WHEN OTHERS THEN
            V_ERRMSG   := 'Error while updating 51 CMS_TRANSLIMIT_CHECK ' ||
                       SUBSTR(SQLERRM, 1, 200);
            V_RESP_CDE := '21';
            RAISE EXP_RVSL_REJECT_RECORD;
        END;
       ELSE
        IF V_ORGNL_BUSINESS_DATE = P_BUSINESS_DATE THEN

          IF V_REVERSAL_AMT IS NULL THEN
            V_MMPOS_USAGEAMNT := V_MMPOS_USAGEAMNT;

          ELSE

            IF V_DR_CR_FLAG = 'CR' THEN

             V_MMPOS_USAGEAMNT := V_MMPOS_USAGEAMNT;
            ELSE
             V_MMPOS_USAGEAMNT := V_MMPOS_USAGEAMNT -
                              TRIM(TO_CHAR(V_REVERSAL_AMT,
                                        '999999999999.99'));
            END IF;

          END IF;
          BEGIN
            UPDATE CMS_TRANSLIMIT_CHECK
              SET CTC_POSUSAGE_AMT = V_MMPOS_USAGEAMNT
            WHERE CTC_INST_CODE = P_INST_CODE AND
                 CTC_PAN_CODE = V_HASH_PAN AND
                 CTC_MBR_NUMB = V_MBR_NUMB;
          EXCEPTION
            WHEN OTHERS THEN
             V_ERRMSG   := 'Error while updating 6 CMS_TRANSLIMIT_CHECK ' ||
                        SUBSTR(SQLERRM, 1, 200);
             V_RESP_CDE := '21';
             RAISE EXP_RVSL_REJECT_RECORD;
          END;
        END IF;
       END IF;
     END IF;

     IF SQL%ROWCOUNT = 0 THEN
       V_ERRMSG   := 'Error while updating the CMS_TRANSLIMIT_CHECK';
       V_RESP_CDE := '21';
       RAISE EXP_RVSL_REJECT_RECORD;
     END IF;

     --En Limit and amount check for MMPOS

    END;

    IF V_ERRMSG = 'OK' THEN

     --Sn find prod code and card type and available balance for the card number
     BEGIN
       SELECT CAM_ACCT_BAL, CAM_LEDGER_BAL
        INTO V_ACCT_BALANCE, V_LEDGE_BALANCE
        FROM CMS_ACCT_MAST
        --Sn Modified for FWR-44
      WHERE CAM_ACCT_NO = (CASE WHEN (p_delv_chnl IN('07','13') AND p_txn_code ='11') OR (p_delv_chnl = '10' AND p_txn_code ='20') THEN
                                  v_cust_acct_no
                           ELSE
                                  V_ACCT_NUMBER
                           END)
         /*  (SELECT CAP_ACCT_NO
               FROM CMS_APPL_PAN
              WHERE CAP_PAN_CODE = V_HASH_PAN AND
                   CAP_MBR_NUMB = V_MBR_NUMB AND
                   CAP_INST_CODE = P_INST_CODE) AND*/
      --En Modified for FWR-44
      AND CAM_INST_CODE = P_INST_CODE;
          --FOR UPDATE NOWAIT;                -- Commented for Concurrent Processsing Issue
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
        V_RESP_CDE := '14'; --Ineligible Transaction
        V_ERRMSG   := 'Invalid Card ';
        RAISE EXP_RVSL_REJECT_RECORD;
       WHEN OTHERS THEN
        V_RESP_CDE := '12';
        V_ERRMSG   := 'Error while selecting data from card Master for card number ' ||
                    SQLERRM;
        RAISE EXP_RVSL_REJECT_RECORD;
     END;

     --En find prod code and card type for the card number
     P_RESP_MSG := TO_CHAR(V_ACCT_BALANCE);

    ELSE

     P_RESP_MSG := V_ERRMSG;

    END IF;

  EXCEPTION
    WHEN EXP_RVSL_REJECT_RECORD THEN
     RAISE;

    WHEN OTHERS THEN
     V_RESP_CDE := '21';
     V_ERRMSG   := 'Error while inserting records in transaction log ' ||
                SUBSTR(SQLERRM, 1, 200);
     RAISE EXP_RVSL_REJECT_RECORD;
  END;
  --En  create a entry in GL

  IF v_orgnl_txn_totalfee_amt=0 AND v_orgnl_txn_feecode IS NOT NULL THEN
    BEGIN
       vmsfee.fee_freecnt_reverse (v_acct_number, v_orgnl_txn_feecode, v_errmsg);

       IF v_errmsg <> 'OK' THEN
          v_resp_cde := '21';
          RAISE exp_rvsl_reject_record;
       END IF;
    EXCEPTION
       WHEN exp_rvsl_reject_record THEN
          RAISE;
       WHEN OTHERS THEN
          v_resp_cde := '21';
          v_errmsg :='Error while reversing freefee count-'|| SUBSTR (SQLERRM, 1, 200);
          RAISE exp_rvsl_reject_record;
    END;
  END IF;

   --SN Added on 04.04.2013 for MVHOST-298
   BEGIN
         IF v_add_ins_date is not null and  v_prfl_code IS NOT NULL AND v_prfl_flag = 'Y'
         THEN
               pkg_limits_check.sp_limitcnt_rever_reset
                              (P_INST_CODE,
                                v_hash_pan, --null --Added for FWR-44
                                v_topup_card_no, --null --Added for FWR-44
                                V_ORGNL_MCCCODE,
                                P_TXN_CODE,
                                v_tran_type,
                                case when P_DELV_CHNL ='02' and P_TXN_CODE ='25' -- Case added for 13063 defect
                                then null else v_internation_ind_response end,
                                case when P_DELV_CHNL ='02' and P_TXN_CODE ='25' -- Case added for 13063 defect
                                then null else v_pos_verification end,
                                v_prfl_code,
                                V_REVERSAL_AMT  ,
                                V_ORGNL_TXN_AMNT,
                                P_DELV_CHNL,
                                v_hash_pan,
                                v_add_ins_date,
                                v_resp_cde,
                                V_ERRMSG
                              );


         END IF;
         --Sn Added for FSS-4647
         IF p_delv_chnl='04' AND p_txn_code='87' AND v_txn_redmption_flag='Y' THEN
            BEGIN
               SELECT NVL(cpc_redemption_delay_flag,'N')
                 INTO v_redmption_delay_flag
                 FROM cms_prod_cattype
                WHERE cpc_prod_code = v_prod_code
                     AND cpc_card_type = v_card_type
                     AND cpc_inst_code = p_inst_code;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  v_errmsg := 'Product category not found';
                  v_resp_cde := '21';
                  RAISE exp_rvsl_reject_record;
               WHEN OTHERS
               THEN
                  v_errmsg :=
                     'Error while fetching redemption delay flag from prodcattype: '
                     || SUBSTR (SQLERRM, 1, 200);
                  v_resp_cde := '21';
                  RAISE exp_rvsl_reject_record;
            END;
            IF v_redmption_delay_flag='Y' THEN
                BEGIN
                   vmsredemptiondelay.redemption_delay (v_acct_number,
                                        p_orgnl_rrn,
                                        p_delv_chnl,
                                        v_orgnl_txn_code,
                                        v_orgnl_txn_amnt,
                                        v_prod_code,
                                        v_card_type,
                                        UPPER (p_merchant_name),
                                        P_MERCHANT_ZIP,--added for VMS-622 (redemption_delay zip code validation)
                                        v_errmsg,
                                        'Y');
                    IF v_errmsg<>'OK' THEN
                         RAISE  exp_rvsl_reject_record;
                    END IF;
                EXCEPTION
                   WHEN exp_rvsl_reject_record THEN
                     RAISE;
                   WHEN OTHERS
                   THEN
                      v_errmsg :=
                         'Error while calling sp_log_delayed_load: '
                         || SUBSTR (SQLERRM, 1, 200);
                      v_resp_cde := '21';
                      RAISE exp_rvsl_reject_record;
                END;
            END IF;
         END IF;
         --En Added for FSS-4647

         IF V_ERRMSG='OK' THEN
IF (P_DELV_CHNL IN ('07','13') AND P_TXN_CODE='11') OR (P_DELV_CHNL = '10' AND P_TXN_CODE='20') THEN
 BEGIN
      UPDATE cms_acct_mast
         SET cam_lupd_date = SYSDATE,
             cam_lupd_user = 1,
             CAM_SAVTOSPD_TFER_COUNT=CAM_SAVTOSPD_TFER_COUNT-1
       WHERE cam_acct_id IN (
                SELECT cca_acct_id
                  FROM cms_cust_acct
                 WHERE cca_cust_code = (select cap_cust_code from cms_appl_pan where  cap_pan_code=V_HASH_PAN and cap_inst_code=p_inst_code)
                   AND cca_inst_code = p_inst_code) AND
          cam_inst_code = p_inst_code
         AND cam_type_code = '2'
         AND cam_stat_code='8'
         AND TO_CHAR(TO_DATE(cam_savtospd_tfer_date),'YYYYMM') = TO_CHAR(TO_DATE(V_ORGNL_TRANDATE),'YYYYMM');

   EXCEPTION
      WHEN OTHERS
      THEN
         v_resp_cde := '21';
         V_ERRMSG :=
               'Error while count decrement in cms_acct_mast for saving ' || SUBSTR (SQLERRM, 1, 200);
         RAISE EXP_RVSL_REJECT_RECORD;
   END;
END IF;
END IF;
--En Added for MVCSD-4479

         IF V_ERRMSG <> 'OK'
         THEN
            V_ERRMSG := V_ERRMSG;
            RAISE EXP_RVSL_REJECT_RECORD;
         END IF;
      EXCEPTION
         WHEN EXP_RVSL_REJECT_RECORD
         THEN
            RAISE;
         WHEN OTHERS
         THEN
            v_resp_cde := '21';
            V_ERRMSG :=
                'Error from Limit count reveer Process ' || SUBSTR (SQLERRM, 1, 200);
            RAISE EXP_RVSL_REJECT_RECORD;
   END;

  --EN Added on 04.04.2013 for MVHOST-298
   P_REVERSAL_AMOUNT := V_REVERSAL_AMT; --Added  for  Mantis ID 13785 for To return the reversal amount on 21/03/201
EXCEPTION
  -- << MAIN EXCEPTION>>
  WHEN EXP_RVSL_REJECT_RECORD THEN
    ROLLBACK TO V_SAVEPOINT;
    BEGIN
     SELECT CAM_ACCT_BAL, CAM_LEDGER_BAL, CAM_ACCT_NO,
            cam_type_code  --added by Pankaj S. for 10871
       INTO V_ACCT_BALANCE, V_LEDGE_BALANCE, V_ACCT_NUMBER,
            v_acct_type --added by Pankaj S. for 10871
       FROM CMS_ACCT_MAST
       --Sn Modified for FWR-44
      WHERE CAM_ACCT_NO =(CASE WHEN ((p_delv_chnl IN('07','13') AND p_txn_code ='11') OR (p_delv_chnl = '10' AND p_txn_code ='20')) AND v_cust_acct_no IS NOT NULL THEN
                                  v_cust_acct_no
                           ELSE
       --En Modified for FWR-44
           (SELECT CAP_ACCT_NO
             FROM CMS_APPL_PAN
            WHERE CAP_PAN_CODE = V_HASH_PAN AND
                 CAP_INST_CODE = P_INST_CODE) END) AND
           CAM_INST_CODE = P_INST_CODE;
    EXCEPTION
     WHEN OTHERS THEN
       V_ACCT_BALANCE  := 0;
       V_LEDGE_BALANCE := 0;
    END;

      -- added for mantis Id:13627
   IF V_Topup_Acct_No is not null THEN
    BEGIN
     SELECT CAM_ACCT_BAL, CAM_LEDGER_BAL
       INTO V_ACCT_BALANCE_TO, V_LEDGE_BALANCE_TO
       FROM CMS_ACCT_MAST
       WHERE CAM_ACCT_NO =V_Topup_Acct_No
      AND CAM_INST_CODE = P_INST_CODE;
    EXCEPTION
     WHEN OTHERS THEN
       V_ACCT_BALANCE_TO  := 0;
       V_LEDGE_BALANCE_TO := 0;
    END;

   END IF;

    BEGIN
     SELECT CMS_ISO_RESPCDE
       INTO P_RESP_CDE
       FROM CMS_RESPONSE_MAST
      WHERE CMS_INST_CODE = P_INST_CODE AND
           CMS_DELIVERY_CHANNEL = P_DELV_CHNL AND
           CMS_RESPONSE_ID = TO_NUMBER(V_RESP_CDE);
     P_RESP_MSG := V_ERRMSG;
    EXCEPTION
     WHEN OTHERS THEN
       P_RESP_MSG := 'Problem while selecting data from response master ' ||
                  V_RESP_CDE || SUBSTR(SQLERRM, 1, 300);
       P_RESP_CDE := '69';
    END;

    BEGIN

     SELECT CTC_ATMUSAGE_AMT,
           CTC_POSUSAGE_AMT,
           CTC_BUSINESS_DATE,
           CTC_MMPOSUSAGE_AMT
       INTO V_ATM_USAGEAMNT,
           V_POS_USAGEAMNT,
           V_BUSINESS_DATE_TRAN,
           V_MMPOS_USAGEAMNT
       FROM CMS_TRANSLIMIT_CHECK
      WHERE CTC_INST_CODE = P_INST_CODE AND CTC_PAN_CODE = V_HASH_PAN AND
           CTC_MBR_NUMB = V_MBR_NUMB;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
       V_ERRMSG   := 'Cannot get the Transaction Limit Details of the Card--' ||
                  V_HASH_PAN || P_INST_CODE || V_MBR_NUMB;
       V_RESP_CDE := '21';
       RAISE EXP_RVSL_REJECT_RECORD;
     WHEN OTHERS THEN
       V_ERRMSG   := 'Checking ' || V_RESP_CDE || SUBSTR(SQLERRM, 1, 300);
       V_RESP_CDE := '21';
    END;

    BEGIN

     --Sn limit update for ATM

     IF P_DELV_CHNL = '01' THEN

       IF V_RVSL_TRANDATE > V_BUSINESS_DATE_TRAN THEN

        UPDATE CMS_TRANSLIMIT_CHECK
           SET CTC_POSUSAGE_AMT       = 0,
              CTC_POSUSAGE_LIMIT     = 0,
              CTC_ATMUSAGE_AMT       = 0,
              CTC_ATMUSAGE_LIMIT     = 0,
              CTC_BUSINESS_DATE      = TO_DATE(P_BUSINESS_DATE ||
                                        '23:59:59',
                                        'yymmdd' || 'hh24:mi:ss'),
              CTC_PREAUTHUSAGE_LIMIT = 0,
              CTC_MMPOSUSAGE_AMT     = 0,
              CTC_MMPOSUSAGE_LIMIT   = 0
         WHERE CTC_INST_CODE = P_INST_CODE AND CTC_PAN_CODE = V_HASH_PAN AND
              CTC_MBR_NUMB = V_MBR_NUMB;
       END IF;
     END IF;

     --Sn limit update for POS

     IF P_DELV_CHNL = '02' THEN

       IF V_RVSL_TRANDATE > V_BUSINESS_DATE_TRAN THEN

        UPDATE CMS_TRANSLIMIT_CHECK
           SET CTC_POSUSAGE_AMT       = 0,
              CTC_POSUSAGE_LIMIT     = 0,
              CTC_ATMUSAGE_AMT       = 0,
              CTC_ATMUSAGE_LIMIT     = 0,
              CTC_BUSINESS_DATE      = TO_DATE(P_BUSINESS_DATE ||
                                        '23:59:59',
                                        'yymmdd' || 'hh24:mi:ss'),
              CTC_PREAUTHUSAGE_LIMIT = 0,
              CTC_MMPOSUSAGE_AMT     = 0,
              CTC_MMPOSUSAGE_LIMIT   = 0
         WHERE CTC_INST_CODE = P_INST_CODE AND CTC_PAN_CODE = V_HASH_PAN AND
              CTC_MBR_NUMB = V_MBR_NUMB;
       END IF;
     END IF;

     --Sn limit update for MMPOS
     IF P_DELV_CHNL = '04' THEN

       IF V_RVSL_TRANDATE > V_BUSINESS_DATE_TRAN THEN

        UPDATE CMS_TRANSLIMIT_CHECK
           SET CTC_POSUSAGE_AMT       = 0,
              CTC_POSUSAGE_LIMIT     = 0,
              CTC_ATMUSAGE_AMT       = 0,
              CTC_ATMUSAGE_LIMIT     = 0,
              CTC_BUSINESS_DATE      = TO_DATE(P_BUSINESS_DATE ||
                                        '23:59:59',
                                        'yymmdd' || 'hh24:mi:ss'),
              CTC_PREAUTHUSAGE_LIMIT = 0,
              CTC_MMPOSUSAGE_AMT     = 0,
              CTC_MMPOSUSAGE_LIMIT   = 0
         WHERE CTC_INST_CODE = P_INST_CODE AND CTC_PAN_CODE = V_HASH_PAN AND
              CTC_MBR_NUMB = V_MBR_NUMB;
       END IF;
     END IF;

     IF SQL%ROWCOUNT = 0 THEN
       V_ERRMSG   := 'Error while updating the CMS_TRANSLIMIT_CHECK';
       V_RESP_CDE := '21';
       RAISE EXP_RVSL_REJECT_RECORD;
     END IF;

    EXCEPTION
     WHEN OTHERS THEN
       V_ERRMSG   := 'Error while updating 7 CMS_TRANSLIMIT_CHECK ' ||
                  SUBSTR(SQLERRM, 1, 200);
       V_RESP_CDE := '21';
       RAISE EXP_RVSL_REJECT_RECORD;
    END;

    --Sn create a entry in txn log

    IF V_RESP_CDE NOT IN ('45', '32') THEN --Added by Deepa on Apr-23-2012 not to log the Invalid transaction Date and Time

    --Sn added by Pankaj S. for 10871
      IF v_dr_cr_flag IS NULL THEN
      BEGIN
        SELECT  ctm_credit_debit_flag,ctm_tran_desc,
                to_number(decode(ctm_tran_type, 'N', '0', 'F', '1'))
          INTO v_dr_cr_flag, v_tran_desc, v_txn_type
          FROM cms_transaction_mast
         WHERE ctm_tran_code = p_txn_code
           AND ctm_delivery_channel = p_delv_chnl
           AND ctm_inst_code = p_inst_code;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
      END IF;

      IF v_prod_code is NULL THEN
      BEGIN
        SELECT cap_prod_code, cap_card_type, cap_card_stat
          INTO v_prod_code, v_card_type, v_cap_card_stat
          FROM cms_appl_pan
         WHERE cap_inst_code = p_inst_code
           AND cap_pan_code = gethash (p_card_no);
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
      END IF;
      --En added by Pankaj S. for 10871

     BEGIN
       INSERT INTO TRANSACTIONLOG
        (MSGTYPE,
         RRN,
         DELIVERY_CHANNEL,
         TERMINAL_ID,
         DATE_TIME,
         TXN_CODE,
         TXN_TYPE,
         TXN_MODE,
         TXN_STATUS,
         RESPONSE_CODE,
         BUSINESS_DATE,
         BUSINESS_TIME,
         CUSTOMER_CARD_NO,
         TOPUP_CARD_NO,
         TOPUP_ACCT_NO,
         TOPUP_ACCT_TYPE,
         BANK_CODE,
         TOTAL_AMOUNT,
         CURRENCYCODE,
         ADDCHARGE,
         CATEGORYID,
         ATM_NAME_LOCATION,
         AUTH_ID,
         AMOUNT,
         PREAUTHAMOUNT,
         PARTIALAMOUNT,
         INSTCODE,
         CUSTOMER_CARD_NO_ENCR,
         TOPUP_CARD_NO_ENCR,
         PROXY_NUMBER,
         REVERSAL_CODE,
         CUSTOMER_ACCT_NO,
         ACCT_BALANCE,
         LEDGER_BALANCE,
         ORGNL_RRN,
         ORGNL_BUSINESS_DATE,
         ORGNL_BUSINESS_TIME,
         ORGNL_CARD_NO,
         ORGNL_TERMINAL_ID,
         RESPONSE_ID,
         ANI,
         DNI,
         /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
         NETWORK_ID,
         INTERCHANGE_FEEAMT,
         MERCHANT_ZIP,
         /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
         TRANS_DESC, -- FOR Transaction detail report issue
         MERCHANT_NAME, -- Added FOR MERCHANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         MERCHANT_CITY, -- Added FOR MERCHANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         MERCHANT_STATE, -- Added FOR MERCHANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         NETWORK_SETTL_DATE,  -- Added on 201112 for logging N/W settlement date in transactionlog
         MERCHANT_ID  ,        --Added on 19-Mar-2013 for FSS-970
         --Sn added by Pankaj S. for 10871
        productid,
        cardstatus,
        cr_dr_flag,
        acct_type,
        error_msg,
        time_stamp,
        --En added by Pankaj S. for 10871
        NETWORKID_SWITCH ,  --Added on 20130626 for the Mantis ID 11344
         --SN Added on 30.07.2013 for 11695
         FEE_PLAN,
         FEECODE,
         TRANFEE_AMT,
         FEEATTACHTYPE,
         --EN Added on 30.07.2013 for 11695
         NETWORKID_ACQUIRER
         ,INTERNATION_IND_RESPONSE,
         TOPUP_ACCT_BALANCE,   -- added for Mantis ID:13627
         TOPUP_LEDGER_BALANCE, -- added for Mantis ID:13627
         REMARK,
         REASON_CODE)
       VALUES
        (P_MSG_TYP,
         P_RRN,
         P_DELV_CHNL,
         P_TERMINAL_ID,
         V_RVSL_TRANDATE,
         P_TXN_CODE,
         --P_TXN_TYPE,
         V_TXN_TYPE, --Modified by Deepa on June 26 2012 As the value is passed as NULL
         P_TXN_MODE,
         DECODE(P_RESP_CDE, '00', 'C', 'F'),
         P_RESP_CDE,
         P_BUSINESS_DATE,
         SUBSTR(P_BUSINESS_TIME, 1, 10),
         V_HASH_PAN,
         --V_TOPUP_CARD_NO,
         --Sn modified for FWR-44
         V_TOPUP_CARD_NO,--NULL --V_ENCR_PAN replaced by NULL for 11000
         v_topup_acct_no,
         v_topup_acct_type,
         --En modified for FWR-44
         P_INST_CODE,
         TRIM(TO_CHAR(P_ACTUAL_AMT, '999999999999999990.99')),--Modified by Pankaj S. for 10871
         V_CURRCODE,
         NULL,
         v_card_type,  --added by Pankaj S. for 10871
         P_TERMINAL_ID,
         V_AUTH_ID,
         TRIM(TO_CHAR(P_ACTUAL_AMT, '999999999999999990.99')),--Modified by Pankaj S. for 10871
         '0.00',--modified by Pankaj S. for 10871
         '0.00',--modified by Pankaj S. for 10871
         P_INST_CODE,
         V_Encr_Pan,
      --   NULL,               --V_ENCR_PAN replaced by NULL for 11000
      V_TOPUP_CARD_NO_ENCR, --Added for Mantis 13555 on 29 Jan 14
         V_PROXUNUMBER,
         P_RVSL_CODE,
         V_ACCT_NUMBER,
         V_ACCT_BALANCE,
         V_LEDGE_BALANCE,
         P_ORGNL_RRN,
         v_ORGNL_BUSINESS_DATE,
         v_ORGNL_BUSINESS_TIME,
         V_ENCR_PAN,
         P_ORGNL_TERMINAL_ID,
         V_RESP_CDE,
         P_ANI,
         P_DNI,
         /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
         P_NETWORK_ID,
         P_INTERCHANGE_FEEAMT,
         P_MERCHANT_ZIP,
         /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
         V_TRAN_DESC, -- FOR Transaction detail report issue
         /*V_TXN_MERCHNAME, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         V_TXN_MERCHCITY, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         V_TXN_MERCHSTATE, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012*/
           --Commented and modified on 21.03.2013 for Merchant Logging Info for the Reversal Txn
         P_MERCHANT_NAME,
         P_MERCHANT_CITY,
         P_MERCHANT_STATE,
         P_NETWORK_SETL_DATE,  -- Added on 201112 for logging N/W settlement date in transactionlog
         P_MERCHANT_ID , --Added on 19-Mar-2013 for FSS-970
          --Sn added by Pankaj S. for 10871
         v_prod_code,
         v_cap_card_stat,
         --v_dr_cr_flag, --Commented and modified on 25.07.2013 for 11693
    --     decode(P_DELV_CHNL,'04',v_dr_cr_flag,decode(v_dr_cr_flag,'CR','DR','DR','CR',v_dr_cr_flag)),--modified for mantis id 0012841: DEFECT:CMS:INCOMM:Transactionlog CR/DR flag of MMPOS
     decode(P_DELV_CHNL,'04',decode(P_RVSL_CODE,'00',v_dr_cr_flag,decode(v_dr_cr_flag,'CR','DR','DR','CR',v_dr_cr_flag)) ,decode(v_dr_cr_flag,'CR','DR','DR','CR',v_dr_cr_flag)), --Modified for 13410
      --card topup reversal and card deactivation transaction were displayed as incorrect
         v_acct_type,
         v_errmsg,
         NVL(v_timestamp,systimestamp) ,
         --En added by Pankaj S. for 10871
         P_NETWORKID_SWITCH , --Added on 20130626 for the Mantis ID 11344
           --SN Added on 30.07.2013 for 11695
         V_FEE_PLAN,
         V_FEE_CODE,
         V_FEE_AMT,
         V_FEEATTACH_TYPE,
         --EN Added on 30.07.2013 for 11695
         DECODE (P_DELV_CHNL, '01', 'VDBZ', '')  -- Added for LYFE Changes
        ,v_internation_ind_response,
         nvl(V_ACCT_BALANCE_TO,0),
      nvl(V_LEDGE_BALANCE_TO,0),
      --changed for FSS-4118
CASE WHEN (p_delv_chnl IN ('07','10') AND p_txn_code ='07') OR (p_delv_chnl = '13' AND p_txn_code ='13') THEN
            'From Account No : ' ||
                                  FN_MASK_ACCT(V_ACCT_NUMBER) || ' ' ||
                                  'To Account No : ' ||
                                  FN_MASK_ACCT(V_Topup_Acct_No)
      ELSE
             NULL
      END,
      v_reason_code);

     EXCEPTION
       WHEN OTHERS THEN

        P_RESP_CDE := '89';
        P_RESP_MSG := 'Problem while inserting data into transaction log ' ||
                    SUBSTR(SQLERRM, 1, 300);
     END;
    END IF;
    --En create a entry in txn log

    BEGIN
     INSERT INTO CMS_TRANSACTION_LOG_DTL
       (CTD_DELIVERY_CHANNEL,
        CTD_TXN_CODE,
        CTD_TXN_TYPE,
        CTD_MSG_TYPE,
        CTD_TXN_MODE,
        CTD_BUSINESS_DATE,
        CTD_BUSINESS_TIME,
        CTD_CUSTOMER_CARD_NO,
        CTD_TXN_AMOUNT,
        CTD_TXN_CURR,
        CTD_ACTUAL_AMOUNT,
        CTD_FEE_AMOUNT,
        CTD_WAIVER_AMOUNT,
        CTD_SERVICETAX_AMOUNT,
        CTD_CESS_AMOUNT,
        CTD_BILL_AMOUNT,
        CTD_BILL_CURR,
        CTD_PROCESS_FLAG,
        CTD_PROCESS_MSG,
        CTD_RRN,
        CTD_SYSTEM_TRACE_AUDIT_NO,
        CTD_INST_CODE,
        CTD_CUSTOMER_CARD_NO_ENCR,
        CTD_CUST_ACCT_NUMBER,
        /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        CTD_NETWORK_ID,
        CTD_INTERCHANGE_FEEAMT,
        CTD_MERCHANT_ZIP,
        /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        CTD_MERCHANT_ID     --Added on 19-Mar-2013 for FSS-970
        ,CTD_INTERNATION_IND_RESPONSE,
        ctd_location_id,
        ctd_reason_code)
     VALUES
       (P_DELV_CHNL,
        P_TXN_CODE,
        --P_TXN_TYPE,
        V_TXN_TYPE, --Modified by Deepa on June 26 2012 As the value is passed as NULL
        P_MSG_TYP,
        P_TXN_MODE,
        P_BUSINESS_DATE,
        P_BUSINESS_TIME,
        V_HASH_PAN,
        P_ACTUAL_AMT,
        V_CURRCODE,
        V_TRAN_AMT,
        NULL,
        NULL,
        NULL,
        NULL,
        P_ACTUAL_AMT,
        V_CARD_CURR,
        'E',
        V_ERRMSG,
        P_RRN,
        P_STAN,
        P_INST_CODE,
        V_ENCR_PAN,
        V_ACCT_NUMBER,
        /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        P_NETWORK_ID,
        P_INTERCHANGE_FEEAMT,
        P_MERCHANT_ZIP,
        /* End  Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        P_MERCHANT_ID  --Added on 19-Mar-2013 for FSS-970
        ,v_internation_ind_response,
        P_ORGNL_TERMINAL_ID,
        v_reason_code);
    EXCEPTION
     WHEN OTHERS THEN
       P_RESP_MSG := 'Problem while inserting data into transaction log  dtl' ||
                  SUBSTR(SQLERRM, 1, 300);
       P_RESP_CDE := '69'; -- Server Decline Response 220509
       ROLLBACK;
       RETURN;
    END;

    P_RESP_MSG := V_ERRMSG;
  WHEN OTHERS THEN
    ROLLBACK TO V_SAVEPOINT;
    BEGIN
     SELECT CMS_ISO_RESPCDE
       INTO P_RESP_CDE
       FROM CMS_RESPONSE_MAST
      WHERE CMS_INST_CODE = P_INST_CODE AND
           CMS_DELIVERY_CHANNEL = P_DELV_CHNL AND
           CMS_RESPONSE_ID = TO_NUMBER(V_RESP_CDE);
     P_RESP_MSG := V_ERRMSG;
    EXCEPTION
     WHEN OTHERS THEN
       P_RESP_MSG := 'Problem  while selecting data from response master ' ||
                  V_RESP_CDE ||V_ERRMSG||P_INST_CODE||P_DELV_CHNL|| SUBSTR(SQLERRM, 1, 300);
       P_RESP_CDE := '69';
    END;

    BEGIN

     SELECT CTC_ATMUSAGE_AMT,
           CTC_POSUSAGE_AMT,
           CTC_BUSINESS_DATE,
           CTC_MMPOSUSAGE_AMT
       INTO V_ATM_USAGEAMNT,
           V_POS_USAGEAMNT,
           V_BUSINESS_DATE_TRAN,
           V_MMPOS_USAGEAMNT
       FROM CMS_TRANSLIMIT_CHECK
      WHERE CTC_INST_CODE = P_INST_CODE AND CTC_PAN_CODE = V_HASH_PAN AND
           CTC_MBR_NUMB = V_MBR_NUMB;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
       V_ERRMSG   := 'Cannot get the Transaction Limit Details of the Card' ||
                  V_RESP_CDE || SUBSTR(SQLERRM, 1, 300);
       V_RESP_CDE := '21';
       RAISE EXP_RVSL_REJECT_RECORD;
     WHEN OTHERS THEN
       V_ERRMSG   := 'Error while selecting 2 CMS_TRANSLIMIT_CHECK ' ||
                  SUBSTR(SQLERRM, 1, 200);
       V_RESP_CDE := '21';
       RAISE EXP_RVSL_REJECT_RECORD;
    END;

    BEGIN

     --Sn limit update for ATM

     IF P_DELV_CHNL = '01' THEN

       IF V_RVSL_TRANDATE > V_BUSINESS_DATE_TRAN THEN
        BEGIN
          UPDATE CMS_TRANSLIMIT_CHECK
            SET CTC_POSUSAGE_AMT       = 0,
                CTC_POSUSAGE_LIMIT     = 0,
                CTC_ATMUSAGE_AMT       = 0,
                CTC_ATMUSAGE_LIMIT     = 0,
                CTC_BUSINESS_DATE      = TO_DATE(P_BUSINESS_DATE ||
                                          '23:59:59',
                                          'yymmdd' || 'hh24:mi:ss'),
                CTC_PREAUTHUSAGE_LIMIT = 0,
                CTC_MMPOSUSAGE_AMT     = 0,
                CTC_MMPOSUSAGE_LIMIT   = 0
           WHERE CTC_INST_CODE = P_INST_CODE AND
                CTC_PAN_CODE = V_HASH_PAN AND CTC_MBR_NUMB = V_MBR_NUMB;
        EXCEPTION
          WHEN OTHERS THEN
            V_ERRMSG   := 'Error while updating 8 CMS_TRANSLIMIT_CHECK ' ||
                       SUBSTR(SQLERRM, 1, 200);
            V_RESP_CDE := '21';
            RAISE EXP_RVSL_REJECT_RECORD;
        END;
       END IF;
     END IF;

     --Sn limit update for POS

     IF P_DELV_CHNL = '02' THEN

       IF V_RVSL_TRANDATE > V_BUSINESS_DATE_TRAN THEN
        BEGIN
          UPDATE CMS_TRANSLIMIT_CHECK
            SET CTC_POSUSAGE_AMT       = 0,
                CTC_POSUSAGE_LIMIT     = 0,
                CTC_ATMUSAGE_AMT       = 0,
                CTC_ATMUSAGE_LIMIT     = 0,
                CTC_BUSINESS_DATE      = TO_DATE(P_BUSINESS_DATE ||
                                          '23:59:59',
                                          'yymmdd' || 'hh24:mi:ss'),
                CTC_PREAUTHUSAGE_LIMIT = 0,
                CTC_MMPOSUSAGE_AMT     = 0,
                CTC_MMPOSUSAGE_LIMIT   = 0
           WHERE CTC_INST_CODE = P_INST_CODE AND
                CTC_PAN_CODE = V_HASH_PAN AND CTC_MBR_NUMB = V_MBR_NUMB;
        EXCEPTION
          WHEN OTHERS THEN
            V_ERRMSG   := 'Error while updating 9 CMS_TRANSLIMIT_CHECK ' ||
                       SUBSTR(SQLERRM, 1, 200);
            V_RESP_CDE := '21';
            RAISE EXP_RVSL_REJECT_RECORD;
        END;
       END IF;
     END IF;

     --Sn limit update for MMPOS
     IF P_DELV_CHNL = '04' THEN

       IF V_RVSL_TRANDATE > V_BUSINESS_DATE_TRAN THEN
        BEGIN
          UPDATE CMS_TRANSLIMIT_CHECK
            SET CTC_POSUSAGE_AMT       = 0,
                CTC_POSUSAGE_LIMIT     = 0,
                CTC_ATMUSAGE_AMT       = 0,
                CTC_ATMUSAGE_LIMIT     = 0,
                CTC_BUSINESS_DATE      = TO_DATE(P_BUSINESS_DATE ||
                                          '23:59:59',
                                          'yymmdd' || 'hh24:mi:ss'),
                CTC_PREAUTHUSAGE_LIMIT = 0,
                CTC_MMPOSUSAGE_AMT     = 0,
                CTC_MMPOSUSAGE_LIMIT   = 0
           WHERE CTC_INST_CODE = P_INST_CODE AND
                CTC_PAN_CODE = V_HASH_PAN AND CTC_MBR_NUMB = V_MBR_NUMB;
          IF SQL%ROWCOUNT = 0 THEN
            V_ERRMSG   := 'Error while updating the CMS_TRANSLIMIT_CHECK';
            V_RESP_CDE := '21';
            RAISE EXP_RVSL_REJECT_RECORD;
          END IF;

        EXCEPTION
          WHEN OTHERS THEN
            V_ERRMSG   := 'Error while updating 10 CMS_TRANSLIMIT_CHECK ' ||
                       SUBSTR(SQLERRM, 1, 200);
            V_RESP_CDE := '21';
            RAISE EXP_RVSL_REJECT_RECORD;
        END;
       END IF;
     END IF;
    END;

    --Sn create a entry in txn log
    IF V_RESP_CDE NOT IN ('45', '32') THEN--Added by Deepa on Apr-23-2012 not to log the Invalid transaction Date and Time

    --Sn added by Pankaj S. for 10871
      IF v_dr_cr_flag IS NULL THEN
      BEGIN
        SELECT  ctm_credit_debit_flag,ctm_tran_desc,
                to_number(decode(ctm_tran_type, 'N', '0', 'F', '1'))
          INTO v_dr_cr_flag, v_tran_desc, v_txn_type
          FROM cms_transaction_mast
         WHERE ctm_tran_code = p_txn_code
           AND ctm_delivery_channel = p_delv_chnl
           AND ctm_inst_code = p_inst_code;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
      END IF;

      IF v_prod_code is NULL THEN
      BEGIN
        SELECT cap_prod_code, cap_card_type, cap_card_stat,cap_acct_no
          INTO v_prod_code, v_card_type, v_cap_card_stat,v_acct_number
          FROM cms_appl_pan
         WHERE cap_inst_code = p_inst_code
           AND cap_pan_code = gethash (p_card_no);
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
      END IF;

      IF v_acct_type IS NULL THEN
      BEGIN
       SELECT cam_acct_bal,cam_ledger_bal,cam_type_code
        INTO v_acct_balance,v_ledge_balance,v_acct_type
        FROM cms_acct_mast
       WHERE cam_inst_code = p_inst_code
         AND cam_acct_no = v_acct_number;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
      END IF;
      --En added by Pankaj S. for 10871


            -- added for mantis Id:13627
       IF V_Topup_Acct_No is not null THEN
        BEGIN
         SELECT CAM_ACCT_BAL, CAM_LEDGER_BAL
           INTO V_ACCT_BALANCE_TO, V_LEDGE_BALANCE_TO
           FROM CMS_ACCT_MAST
           WHERE CAM_ACCT_NO =V_Topup_Acct_No
          AND CAM_INST_CODE = P_INST_CODE;
        EXCEPTION
         WHEN OTHERS THEN
           V_ACCT_BALANCE_TO  := 0;
           V_LEDGE_BALANCE_TO := 0;
        END;

       END IF;

     BEGIN
       INSERT INTO TRANSACTIONLOG
        (MSGTYPE,
         RRN,
         DELIVERY_CHANNEL,
         TERMINAL_ID,
         DATE_TIME,
         TXN_CODE,
         TXN_TYPE,
         TXN_MODE,
         TXN_STATUS,
         RESPONSE_CODE,
         BUSINESS_DATE,
         BUSINESS_TIME,
         CUSTOMER_CARD_NO,
         TOPUP_CARD_NO,
         TOPUP_ACCT_NO,
         TOPUP_ACCT_TYPE,
         BANK_CODE,
         TOTAL_AMOUNT,
         CURRENCYCODE,
         ADDCHARGE,
         CATEGORYID,
         ATM_NAME_LOCATION,
         AUTH_ID,
         AMOUNT,
         PREAUTHAMOUNT,
         PARTIALAMOUNT,
         INSTCODE,
         CUSTOMER_CARD_NO_ENCR,
         TOPUP_CARD_NO_ENCR,
         PROXY_NUMBER,
         REVERSAL_CODE,
         CUSTOMER_ACCT_NO,
         ACCT_BALANCE,
         LEDGER_BALANCE,
         ORGNL_RRN,
         ORGNL_BUSINESS_DATE,
         ORGNL_BUSINESS_TIME,
         ORGNL_CARD_NO,
         ORGNL_TERMINAL_ID,
         RESPONSE_ID,
         ANI,
         DNI,
         /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
         NETWORK_ID,
         INTERCHANGE_FEEAMT,
         MERCHANT_ZIP,
         /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
         TRANS_DESC, -- FOR Transaction detail report issue
         MERCHANT_NAME, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         MERCHANT_CITY, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         MERCHANT_STATE, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         NETWORK_SETTL_DATE,  -- Added on 201112 for logging N/W settlement date in transactionlog
         MERCHANT_ID   ,       --Added on 19-Mar-2013 for FSS-970
         --Sn added by Pankaj S. for 10871
        productid,
        cardstatus,
        cr_dr_flag,
        acct_type,
        error_msg,
        time_stamp,
        --En added by Pankaj S. for 10871
        NETWORKID_SWITCH ,  --Added on 20130626 for the Mantis ID 11344
       --SN Added on 30.07.2013 for 11695
        FEE_PLAN,
        FEECODE,
        TRANFEE_AMT,
        FEEATTACHTYPE,
     --EN Added on 30.07.2013 for 11695
        NETWORKID_ACQUIRER     -- Added for LYFE Changes
        ,INTERNATION_IND_RESPONSE,
        TOPUP_ACCT_BALANCE,   -- added for Mantis ID:13627
        TOPUP_LEDGER_BALANCE,  -- added for Mantis ID:13627
        REMARK,
        REASON_CODE)
       VALUES
        (P_MSG_TYP,
         P_RRN,
         P_DELV_CHNL,
         P_TERMINAL_ID,
         V_RVSL_TRANDATE,
         P_TXN_CODE,
         --P_TXN_TYPE,
         V_TXN_TYPE, --Modified by Deepa on June 26 2012 As the value is passed as NULL
         P_TXN_MODE,
         DECODE(P_RESP_CDE, '00', 'C', 'F'),
         P_RESP_CDE,
         P_BUSINESS_DATE,
         SUBSTR(P_BUSINESS_TIME, 1, 10),
         V_HASH_PAN,
         NULL,--V_TOPUP_CARD_NO replaced by NULL for mantis is 11000
         NULL,
         NULL,
         P_INST_CODE,
         TRIM(TO_CHAR(P_ACTUAL_AMT, '999999999999999990.99')),--Modified by Pankaj S. for 10871
         V_CURRCODE,
         NULL,
         v_card_type, --added by Pankaj S. for 10871
         P_TERMINAL_ID,
         V_AUTH_ID,
         TRIM(TO_CHAR(P_ACTUAL_AMT, '999999999999999990.99')),--Modified by Pankaj S. for 10871
         '0.00', --modified by Pankaj S. for 10871
         '0.00', --modified by Pankaj S. for 10871
         P_INST_CODE,
         V_Encr_Pan,
       --  NUll,      --V_ENCR_PAN replaced by NULL for 11000
       V_TOPUP_CARD_NO_ENCR, --Added for Mantis 13555 on 29 Jan 14
         V_PROXUNUMBER,
         P_RVSL_CODE,
         V_ACCT_NUMBER,
         V_ACCT_BALANCE,
         V_LEDGE_BALANCE,
         P_ORGNL_RRN,
         v_ORGNL_BUSINESS_DATE,
         v_ORGNL_BUSINESS_TIME,
         V_ENCR_PAN,
         P_ORGNL_TERMINAL_ID,
         V_RESP_CDE,
         P_ANI,
         P_DNI,
         /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
         P_NETWORK_ID,
         P_INTERCHANGE_FEEAMT,
         P_MERCHANT_ZIP,
         /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
         V_TRAN_DESC, -- FOR Transaction detail report issue
         /*V_TXN_MERCHNAME, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         V_TXN_MERCHCITY, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012
         V_TXN_MERCHSTATE, -- Added FOR MERCJANT DETAILS LOGGED IN TRANSACTIONLOG TABLE on 07-Sep-2012*/
         --Commented and modified on 21.03.2013 for Merchant Logging Info for the Reversal Txn
         P_MERCHANT_NAME,
         P_MERCHANT_CITY,
         P_MERCHANT_STATE,
         P_NETWORK_SETL_DATE,  -- Added on 201112 for logging N/W settlement date in transactionlog
         P_MERCHANT_ID , --Added on 19-Mar-2013 for FSS-970
          --Sn added by Pankaj S. for 10871
         v_prod_code,
         v_cap_card_stat,
         --v_dr_cr_flag, --Commented and modified on 25.07.2013 for 11693
       -- decode(P_DELV_CHNL,'04',v_dr_cr_flag,decode(v_dr_cr_flag,'CR','DR','DR','CR',v_dr_cr_flag)),--modified for mantis id 0012841: DEFECT:CMS:INCOMM:Transactionlog CR/DR flag of MMPOS
      decode(P_DELV_CHNL,'04',decode(P_RVSL_CODE,'00',v_dr_cr_flag,decode(v_dr_cr_flag,'CR','DR','DR','CR',v_dr_cr_flag)) ,decode(v_dr_cr_flag,'CR','DR','DR','CR',v_dr_cr_flag)), --Modified for 13410
      --card topup reversal and card deactivation transaction were displayed as incorrect
         v_acct_type,
         V_ERRMSG,
         nvl(v_timestamp,systimestamp)   ,
         --En added by Pankaj S. for 10871
          P_NETWORKID_SWITCH,  --Added on 20130626 for the Mantis ID 11344
        --SN Added on 30.07.2013 for 11695
        V_FEE_PLAN,
        V_FEE_CODE,
        V_FEE_AMT,
        V_FEEATTACH_TYPE,
        --EN Added on 30.07.2013 for 11695
         DECODE (P_DELV_CHNL, '01', 'VDBZ', '')  -- Added for LYFE Changes
         ,v_internation_ind_response,
          nvl(V_ACCT_BALANCE_TO,0),
      nvl(V_LEDGE_BALANCE_TO,0),
      --changed for FSS-4118
CASE WHEN (p_delv_chnl IN ('07','10') AND p_txn_code ='07') OR (p_delv_chnl = '13' AND p_txn_code ='13') THEN
            'From Account No : ' ||
                                  FN_MASK_ACCT(V_ACCT_NUMBER) || ' ' ||
                                  'To Account No : ' ||
                                  FN_MASK_ACCT(V_Topup_Acct_No)
      ELSE
             NULL
      END,
      v_reason_code);


     EXCEPTION
       WHEN OTHERS THEN

        P_RESP_CDE := '89';
        P_RESP_MSG := 'Problem while inserting data into transaction log  dtl' ||
                    SUBSTR(SQLERRM, 1, 300);
     END;
    END IF;
    --En create a entry in txn log
    
    
    

    BEGIN
     INSERT INTO CMS_TRANSACTION_LOG_DTL
       (CTD_DELIVERY_CHANNEL,
        CTD_TXN_CODE,
        CTD_TXN_TYPE,
        CTD_MSG_TYPE,
        CTD_TXN_MODE,
        CTD_BUSINESS_DATE,
        CTD_BUSINESS_TIME,
        CTD_CUSTOMER_CARD_NO,
        CTD_TXN_AMOUNT,
        CTD_TXN_CURR,
        CTD_ACTUAL_AMOUNT,
        CTD_FEE_AMOUNT,
        CTD_WAIVER_AMOUNT,
        CTD_SERVICETAX_AMOUNT,
        CTD_CESS_AMOUNT,
        CTD_BILL_AMOUNT,
        CTD_BILL_CURR,
        CTD_PROCESS_FLAG,
        CTD_PROCESS_MSG,
        CTD_RRN,
        CTD_SYSTEM_TRACE_AUDIT_NO,
        CTD_INST_CODE,
        CTD_CUSTOMER_CARD_NO_ENCR,
        CTD_CUST_ACCT_NUMBER,
        /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        CTD_NETWORK_ID,
        CTD_INTERCHANGE_FEEAMT,
        CTD_MERCHANT_ZIP,
        /* End Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        CTD_MERCHANT_ID     --Added on 19-Mar-2013 for FSS-970
        ,CTD_INTERNATION_IND_RESPONSE,
        ctd_location_id,
        ctd_reason_code)
     VALUES
       (P_DELV_CHNL,
        P_TXN_CODE,
        --P_TXN_TYPE,
        V_TXN_TYPE, --Modified by Deepa on June 26 2012 As the value is passed as NULL
        P_MSG_TYP,
        P_TXN_MODE,
        P_BUSINESS_DATE,
        P_BUSINESS_TIME,
        V_HASH_PAN,
        P_ACTUAL_AMT,
        V_CURRCODE,
        V_TRAN_AMT,
        NULL,
        NULL,
        NULL,
        NULL,
        P_ACTUAL_AMT,
        V_CARD_CURR,
        'E',
        V_ERRMSG,
        P_RRN,
        P_STAN,
        P_INST_CODE,
        V_ENCR_PAN,
        V_ACCT_NUMBER,
        /* Start Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        P_NETWORK_ID,
        P_INTERCHANGE_FEEAMT,
        P_MERCHANT_ZIP,
        /* End  Added by Dhiraj G on 31052012 for Pre - Auth Parameter changes  */
        P_MERCHANT_ID  --Added on 19-Mar-2013 for FSS-970
        ,v_internation_ind_response,
        P_ORGNL_TERMINAL_ID,
        v_reason_code);
    EXCEPTION
     WHEN OTHERS THEN
       P_RESP_MSG := 'Problem while inserting data into transaction log  dtl' ||
                  SUBSTR(SQLERRM, 1, 300);
       P_RESP_CDE := '69'; -- Server Decline Response 220509
       ROLLBACK;
       RETURN;
    END;
    P_RESP_MSG_M24 := V_ERRMSG;
END;
/
show error;