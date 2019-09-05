-- SET ECHO ON

--
-- LOG_ERROR  (Procedure) 
--
--  Dependencies: 
--   STANDARD (Package)
--   JERRORLOG (Table)
--   JERRORLOG_SEQ (Sequence)
--
CREATE OR REPLACE PROCEDURE ODS.Log_Error (
	   	  ProcedureName_IN  	IN 		  VARCHAR2,
		  Memberid_IN			IN		  VARCHAR2,
		  ErrorNumber_IN    	IN 		  NUMBER,
		  ErrorMessage_IN   	IN		  VARCHAR2,
		  ErrorTimestamp_IN  	IN		  TIMESTAMP,
		  JSeq_IN			   	IN		  NUMBER)
IS

PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN
  INSERT INTO JErrorLog
  (ErrorLogSeq,ProcedureName,Memberid,
   ErrorNumber,ErrorMessage,
   ErrorTimestamp,JSeq)
  VALUES
  (ODS.JErrorLog_SEQ.nextval,ProcedureName_IN,Memberid_IN,
   ErrorNumber_IN,ErrorMessage_IN,
   ErrorTimestamp_IN,JSeq_IN);

COMMIT;

EXCEPTION
WHEN OTHERS
	 THEN NULL;
END log_error;


-- EXIT;