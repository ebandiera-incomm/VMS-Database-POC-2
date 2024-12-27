CREATE OR REPLACE PROCEDURE vmscms.sp_set_gen_acctdata (
   prm_inst_code      IN       NUMBER,
   prm_acct_rec       IN       type_acct_rec_array
         DEFAULT type_acct_rec_array (),
   prm_acct_rec_out   OUT      type_acct_rec_array,
   prm_err_msg        OUT      VARCHAR2
)
IS
   v_acct_rec_outdata       type_acct_rec_array;
   v_error_message          VARCHAR2 (300);
   exp_acct_reject_record   EXCEPTION;
BEGIN
   prm_err_msg := 'OK';
   v_error_message := 'OK';

   BEGIN
      prm_acct_rec_out := prm_acct_rec;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_error_message :=
                        'Error in fetching data ' || SUBSTR (SQLERRM, 1, 200);
         RAISE exp_acct_reject_record;
   END;
EXCEPTION
   WHEN exp_acct_reject_record
   THEN
      prm_err_msg := v_error_message;
   WHEN OTHERS
   THEN
      prm_err_msg := 'Error from main' || SUBSTR (SQLERRM, 1, 200);
END;
/

SHOW ERROR