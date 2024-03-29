SET ECHO ON

GRANT SELECT ON HRAMEMBERSURVEYRESPONSE TO INCV;
GRANT SELECT ON INSURANCEORGANIZATION TO INCV WITH GRANT OPTION;
GRANT SELECT ON INSURANCEORGSUPPLIERRELATION TO INCV WITH GRANT OPTION;
GRANT SELECT ON MEMBER TO INCV WITH GRANT OPTION;
GRANT SELECT ON MEMBERHEALTHTRACKER TO INCV;
GRANT SELECT ON MEMBERMEMBERRELATION TO INCV WITH GRANT OPTION;
GRANT SELECT ON PARTYEMAILADDRESS TO INCV WITH GRANT OPTION;
GRANT SELECT ON PERSON TO INCV WITH GRANT OPTION;
GRANT SELECT ON SUPPLIERORGANIZATION TO INCV WITH GRANT OPTION;
GRANT EXECUTE ON FAGE TO INCV WITH GRANT OPTION;
GRANT SELECT ON HRAMEMBERSURVEY TO INCV;
GRANT SELECT ON PATIENTMEDICALDIAGNOSIS TO INCV;
GRANT SELECT ON PATIENTMEDICALPROCEDURE TO INCV;
GRANT SELECT ON HRAMEMBERSURVEYRESPONSEHIST TO INCV;
GRANT EXECUTE ON FDEBUG TO INCV;
GRANT DEBUG ON FDEBUG TO INCV;
GRANT SELECT ON CMS TO INCV;
GRANT SELECT ON MEMBERPROGRAMPARTICIPATION TO INCV;
GRANT SELECT ON PATIENTTRACK TO INCV;
GRANT SELECT ON PROGRAMTYPE TO INCV;
GRANT EXECUTE ON FERRORCODES TO INCV;
GRANT EXECUTE ON LOG_ERROR TO INCV;
GRANT DEBUG ON LOG_ERROR TO INCV;
GRANT SELECT ON HEALTHTRACKER TO INCV;
GRANT SELECT ON HEALTHTRACKERELEMENT TO INCV;
GRANT EXECUTE ON FGETMEMBERID TO INCV;
GRANT DEBUG ON FGETMEMBERID TO INCV;
GRANT SELECT ON SURVEYTEMPLATE TO INCV;
GRANT SELECT ON VW_PROJECTSUPPLIER TO INCV WITH GRANT OPTION;
GRANT SELECT ON HRAMEMBERSURVEYHIST TO INCV;
GRANT SELECT ON AHMMRNBUSINESSSUPPLIER TO INCV WITH GRANT OPTION;
GRANT SELECT ON VWDMHRAMEMBERSURVEY TO INCV;
GRANT SELECT ON PATIENTPROBLEMINTERIMHIE TO INCV;
GRANT SELECT ON PATIENTPROCEDUREINTERIMHIE TO INCV;
GRANT EXECUTE ON ODS_CORE TO INCV;
GRANT DEBUG ON ODS_CORE TO INCV;
GRANT EXECUTE ON CT_CORE TO INCV;
GRANT DEBUG ON CT_CORE TO INCV;
GRANT SELECT ON MEMBERREPORTEDMEASURE TO INCV;
GRANT EXECUTE ON ODS_COMMON_PKG TO INCV WITH GRANT OPTION;
GRANT DEBUG ON ODS_COMMON_PKG TO INCV;
GRANT SELECT ON MEMBERDIGITALCOACHINGDETAIL TO INCV;
GRANT SELECT ON MEMBERDIGITALCOACHING TO INCV;
GRANT SELECT ON MEMBERPROGRAMCOACHING TO INCV;
GRANT SELECT ON PARTITIONED_TABLE TO INCV;
GRANT SELECT ON MV_CMMEMBERLOGIN TO INCV;
GRANT INSERT ON UNITTESTACTIVITYLOG TO INCV;
GRANT SELECT ON UNITTESTACTIVITYLOG TO INCV;
GRANT EXECUTE ON ODS_TESTCASEACTIVITY_PKG TO INCV;
GRANT INSERT ON TEMP_FINANCEREPORTTAB TO INCV;
GRANT SELECT ON TEMP_FINANCEREPORTTAB TO INCV;
GRANT INSERT ON AETNAMEMBERCOUNTS TO INCV;
GRANT SELECT ON AETNAMEMBERCOUNTS TO INCV;
GRANT INSERT ON FINANCEREPORTTAB TO INCV;
GRANT SELECT ON FINANCEREPORTTAB TO INCV;

EXIT;