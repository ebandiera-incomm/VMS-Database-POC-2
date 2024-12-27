CREATE OR REPLACE PROCEDURE VMSCMS.sp_re_pin_regen(ERRMSG OUT VARCHAR2)
AS

CURSOR c1 IS
SELECT pan_no ,ROWID
FROM
TEMP_PIN_REGEN;

INVALID_PAN  EXCEPTION ;
INVALID_PAN1  EXCEPTION;

v_pan_no VARCHAR2(20);
v_CPS_PAN_CODE VARCHAR2(20);
CPH_PAN_CODE VARCHAR2(20);
CPH_NEW_PINDATE DATE;
v_CPH_PAN_CODE VARCHAR2(20);
v_CPH_NEW_PINDATE DATE;

	BEGIN
	ERRMSG := 'OK' ;
		FOR X IN C1
		LOOP
		BEGIN
			BEGIN --Pan Chk Begin
				SELECT CPS_PAN_CODE INTO v_CPS_PAN_CODE FROM CMS_PAN_SPPRT
				WHERE CPS_PAN_CODE=v_pan_no
				AND CPS_SPPRT_KEY='REPIN'
				AND TRUNC(CPS_INS_DATE) IN (TRUNC(TO_DATE('30-OCT-2004','DD-MON-YYYY')),TRUNC(TO_DATE('31-OCT-2004','DD-MON-YYYY')));
			EXCEPTION
			WHEN NO_DATA_FOUND THEN
				ERRMSG := 'PAN_NO: '||X.PAN_NO||' NOT FOUND IN cms_pan_spprt' ;
				RAISE INVALID_PAN ;
			WHEN OTHERS THEN
				ERRMSG := 'PAN_no'||SQLERRM ;
				RAISE INVALID_PAN ;
			END ; --Pan Chk End

			BEGIN --Pan Chk Begin
				SELECT CPH_PAN_CODE,CPH_NEW_PINDATE INTO v_CPH_PAN_CODE,v_CPH_NEW_PINDATE FROM 							CMS_PINREGEN_HIST
				WHERE CPH_NEW_PINDATE IN(TRUNC(TO_DATE('30-OCT-2004','DD-MON-YYYY')),TRUNC(TO_DATE('31-OCT-2004','DD-MON-YYYY')))
				AND CPH_PAN_CODE=v_CPS_PAN_CODE;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
				RAISE INVALID_PAN ;
				WHEN OTHERS THEN
				ERRMSG := 'PAN CHK:'||SQLERRM ;
				RAISE INVALID_PAN ;
			END ; --Pan Chk End


			UPDATE CMS_PINREGEN_HIST
			SET CPH_NEW_PINDATE=TRUNC(SYSDATE)-13
			WHERE CPH_PAN_CODE=v_CPH_PAN_CODE
			AND  CPH_NEW_PINDATE=v_CPH_NEW_PINDATE;
	EXCEPTION
		   WHEN INVALID_PAN THEN
		   UPDATE TEMP_PIN_REGEN
			SET
			PROCESS_FLAG = 'E' ,
			PROC_DESC = ERRMSG
			WHERE
			PAN_NO = X.pan_NO
			AND
			ROWID = X.ROWID ;
			ERRMSG := 'OK' ;
		   WHEN OTHERS THEN
			ERRMSG := 'ERR:'||SQLERRM ;
			UPDATE TEMP_PIN_REGEN
			SET
			PROCESS_FLAG = 'E' ,
			PROC_DESC = ERRMSG
			WHERE
			PAN_NO = X.pan_NO
			AND
			ROWID = X.ROWID ;
			ERRMSG := 'OK' ;
		END;
		END LOOP ;

	EXCEPTION
	WHEN OTHERS THEN
	ERRMSG := 'ERR:'||SQLERRM ;
	END ;
/


