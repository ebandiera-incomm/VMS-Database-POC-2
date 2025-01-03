create or replace PACKAGE                             vmscms.vmsachcanada
AS
    /**********************************************************************************************
      * Created By       : Spankaj
      * Created Date     : 15-Jun-2022
      * Purpose          : Canadian ACH processing
      * Created For      : VMS-5971
      * Reviewer         :
      * Build Number     :
   *************************************************************************************************/
   PROCEDURE achcanda_data_load (
      prm_directory       IN       VARCHAR2,
      prm_dest_directory  IN       VARCHAR2,
      prm_rej_directory   IN       VARCHAR2,
      prm_autoschedule    IN       VARCHAR2,
      prm_files           OUT      c_ach_type,
      prm_errmsg          OUT      VARCHAR2
   );

   PROCEDURE achcanda_process (
      prm_instcode         IN       NUMBER,
      prm_autoschedule     IN       VARCHAR2,
      prm_directory        IN       VARCHAR2,
      prm_dest_directory   IN       VARCHAR2,
      prm_rep_directory    IN       VARCHAR2,
      prm_rej_directory    IN       VARCHAR2,
      prm_errmsg           OUT      VARCHAR2
   );

   PROCEDURE achcanda_txn_process (
      p_instcode       IN       NUMBER,
      p_proxy_no       IN       VARCHAR2,
      p_tracenumber    IN       VARCHAR2,
      p_trandate       IN       VARCHAR2,
      p_trantime       IN       VARCHAR2,
      p_txntype        IN       VARCHAR2,
      p_amount         IN       NUMBER,
      p_achfilename    IN       VARCHAR2,
      p_processtype    IN       VARCHAR2,
      p_source_sname   IN       VARCHAR2,
      p_source_fname   IN       VARCHAR2,
      p_cust_name      IN       VARCHAR2, 
      p_orgl_traceno   IN       VARCHAR2, --VMS-5971
      p_resp_code      OUT      VARCHAR2,
      p_errmsg         OUT      VARCHAR2
   );

   PROCEDURE get_file_list (prm_directory IN VARCHAR2);

   FUNCTION get_tabdata (
      prm_rec        IN   NUMBER,
      prm_seg        IN   NUMBER,
      prm_file         IN   VARCHAR2,
      prm_rectype   IN   VARCHAR2,
      prm_data        IN   NUMBER
   )
      RETURN VARCHAR2;

   PROCEDURE send_mail (
      prm_filename   IN       VARCHAR2,
      prm_errmsg     IN OUT   VARCHAR2
   );

   PROCEDURE tokenise_ach (
      prm_instr    IN       VARCHAR2,
      prm_tabout   OUT      c_ach_type,
      prm_errmsg   OUT      VARCHAR2
   );

   PROCEDURE batch_excp_rep (
      prm_filename    IN       VARCHAR2,
      prm_directory   IN       VARCHAR2,
      prm_errmsg      OUT      VARCHAR2
   );

   PROCEDURE batch_load_rep (
      prm_filename    IN       VARCHAR2,
      prm_directory   IN       VARCHAR2,
      prm_errmsg      OUT      VARCHAR2
   );
END;
/
show error