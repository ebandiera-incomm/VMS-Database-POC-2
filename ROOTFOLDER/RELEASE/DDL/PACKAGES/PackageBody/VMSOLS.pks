create or replace
PACKAGE                             VMSCMS.VMSOLS
AS
procedure cr_adjust_cmsauth_iso93(
    p_i_inst_code               in number, 
    p_i_msg                     in varchar2,
    p_i_rrn                     in varchar2,
    p_i_del_channel             in varchar2,
    p_i_term_id                 in varchar2,
    p_i_txn_code                in varchar2,
    p_i_txn_mode                in varchar2,
    p_i_tran_date               in varchar2,
    p_i_tran_time               in varchar2,
    p_i_card_no                 in varchar2,
    p_i_txn_amt                 in number,
    p_i_merchant_name           in varchar2,
    p_i_merchant_city           in varchar2,
    p_i_mcc_code                in varchar2,
    p_i_curr_code               in varchar2,
    p_i_pos_verification        in varchar2,
    p_i_atmname_loc             IN VARCHAR2,
    p_i_expry_date              IN VARCHAR2,
    p_i_stan                    IN VARCHAR2,
    p_i_international_ind       IN VARCHAR2,
    p_i_rvsl_code               IN NUMBER,
    p_i_network_id              IN VARCHAR2,
    p_i_merchant_zip            IN VARCHAR2,
    p_i_addl_amt                IN VARCHAR2,
    p_i_networkid_switch        IN VARCHAR2,
    p_i_networkid_acquirer      IN VARCHAR2,
    p_i_network_setl_date       IN VARCHAR2,
    p_i_cvv_verificationtype    IN VARCHAR2,
    p_partial_preauth_ind       IN VARCHAR2,
    p_i_pulse_transactionid     IN VARCHAR2,
    p_i_visa_transactionid      IN VARCHAR2,
    p_i_mc_traceid              IN VARCHAR2,
    p_i_cardverification_result IN VARCHAR2,
    p_i_merchant_id             IN VARCHAR2 ,
    p_i_merchant_cntrycode      IN VARCHAR2 ,
    p_i_product_type            IN VARCHAR2 ,
    p_i_expiry_date_check       IN VARCHAR2 ,
    p_i_original_stan           in varchar2,
    p_i_orgnl_trandate          in varchar2,
    p_i_orgnl_trantime          in varchar2,
    p_o_auth_id                 out varchar2,
    p_o_resp_code               out varchar2,
    p_o_resp_msg                out clob,
    p_o_ledger_bal              out varchar2,
    p_o_iso_respcde             out varchar2,
    p_o_resp_id                 out varchar2);
END VMSOLS;

/
show error