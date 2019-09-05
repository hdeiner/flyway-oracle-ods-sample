-- SET ECHO ON

/*
DROP PACKAGE INCV.INCV_CEOUTPUT;
*/

CREATE OR REPLACE PACKAGE INCV.INCV_CEOUTPUT
AS

PROCEDURE getEligibleMemberHealthState ( p_incvmem in INCV.MEMBERELIGIBLEME_OBJ, results OUT sys_refcursor);

END;
/


/*
DROP PACKAGE INCV.INCV_DATAINGEST_PKG;
*/

CREATE OR REPLACE PACKAGE INCV.INCV_DATAINGEST_PKG
IS
   PROCEDURE sp_setmemberactoccurence (
      pn_Memberplanid_in            IN     incv.MEMBERACTIVITYOCCURRENCE.MEMBERPLANID%TYPE,
      pv_AHMSupplierid_in           IN     incv.MEMBERACTIVITYOCCURRENCE.AHMSUPPLIERID%TYPE,
      pn_Program_Id_in              IN     incv.MEMBERACTIVITYOCCURRENCE.PROGRAMID%TYPE,
      pn_Run_Id_in                  IN     incv.MEMBERACTIVITYOCCURRENCE.INCENTIVERUNID%TYPE,
      pn_Run_Date_in                IN     incv.MEMBERACTIVITYOCCURRENCE.RUNDT%TYPE,
      pt_ActivityOccurenceList_in   IN     incv.activitycccurencelist_TAB,
      pn_returncode_out                OUT NUMBER
   );

   PROCEDURE sp_setmembertierprogression (
      pn_memberplanid_in      IN     incv.MemberTierInfo.MEMBERPLANID%TYPE,
      pt_TierProgression_in   IN     incv.TIERPROGRESSION_TAB,
      pn_returncode_out          OUT NUMBER
   );
END INCV_DATAINGEST_PKG;
/


/*
DROP PACKAGE INCV.INCV_DMLEXTRACT_PKG;
*/

CREATE OR REPLACE PACKAGE INCV.incv_dmlextract_pkg AS
/******************************************************************************
   NAME:       INCV.incv_dmlextract_pkg
   PURPOSE:

   REVISIONS:

    Ver             Date            Author                  Description
    ---------       ----------      ---------------        ---------------------
    1.0             05/12/2018      Sami R			           Initial Version
    1.1             05/31/2018      Kader					   For User Story US109446
	1.2             07/18/2018      Kader                      For Defect DE91133
******************************************************************************/

	Type rc_cursor is ref cursor;

    FUNCTION f_getquerystring (pv_tablename_in IN VARCHAR2,
    						   pv_dmltype_in   IN VARCHAR2,
							   pv_arg_in       IN VARCHAR2) RETURN VARCHAR2;

    FUNCTION f_getsubquerystring (pv_tablename_in IN VARCHAR2,
                                  pv_dmltype_in   IN VARCHAR2,
                                  pv_arg_in       IN VARCHAR2,
						          pv_where_in     IN VARCHAR2) RETURN VARCHAR2;

	PROCEDURE sp_insertdmlstatement (pn_programid_in  IN NUMBER,
	                                 pv_actiontype_in IN VARCHAR2,
									 pn_err_code_out  OUT NUMBER,
									 pv_err_mesg_out  OUT VARCHAR2);

	PROCEDURE sp_getdmlstatement(pn_programid_in IN NUMBER,
	                                pv_result_out   OUT rc_cursor,
	                                pn_err_code_out	OUT		NUMBER,
									pv_err_mesg_out	OUT		VARCHAR2);
END incv_dmlextract_pkg;
/


/*
DROP PACKAGE INCV.INCV_PROGRAMCONFIGURATION_PKG;
*/

CREATE OR REPLACE PACKAGE INCV.INCV_PROGRAMCONFIGURATION_PKG
AS
    /******************************************************************************
       NAME      : INCV.INCV_PROGRAMCONFIGURATION_PKG
       PURPOSE   : This SP_SETINCENTIVECONFIGURATION procedure will be called from INCV app to configure the basic tables
       REVISIONS :
        Ver             Date            Author                  Description
        ---------       ----------      ---------------        ---------------------
        1.0             06/19/2018      Kader			        Initial Version 18.2
        1.1             07/19/2018      Kader                   For 18.3 User Story US113184
        1.2             08/10/2018      Kader                   For 18.3 User Story US112008
        1.3             08/20/2018      Kader                   For User Story US112432 (ODS Task)
        1.4             08/31/2018      Kader                   For User Story US113970
    ******************************************************************************/
    PROCEDURE SP_SETINCENTIVECONFIGURATION
    (
        pt_programconfiguration_in IN incv.PROGRAM_CONFIGURATION_TAB,
        pn_oldprogramid_in         IN NUMBER,
        pv_programupdate_in        IN VARCHAR2,
        pn_newprogramid_out        OUT NUMBER,
        pn_oldprogramid_out        OUT VARCHAR2,
        pn_returncode_out          OUT NUMBER
    );

    PROCEDURE SP_DELETEPASTPROGRAM
    (
        pt_programid_in            IN INCV.PROGRAMLIST_TAB,
        pn_returncode_out          OUT NUMBER
    );

END INCV_PROGRAMCONFIGURATION_PKG;
/


GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ACTS_APPS;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ACTS_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO CLMFIN;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO CTLM_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ETLADMIN;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO FIXER WITH GRANT OPTION;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO INCV_APP;

GRANT EXECUTE, DEBUG ON INCV.INCV_PROGRAMCONFIGURATION_PKG TO INCV_APP;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO INCV_DEV;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO INCV_DML;

GRANT EXECUTE, DEBUG ON INCV.INCV_DMLEXTRACT_PKG TO INCV_READ;

GRANT EXECUTE, DEBUG ON INCV.INCV_PROGRAMCONFIGURATION_PKG TO INCV_USER;

GRANT EXECUTE ON INCV.INCV_CEOUTPUT TO ODS_DML;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ODS_DML;

GRANT EXECUTE ON INCV.INCV_CEOUTPUT TO ODS_READ;

GRANT EXECUTE ON INCV.INCV_DATAINGEST_PKG TO ODS_READ;

GRANT EXECUTE, DEBUG ON INCV.INCV_DMLEXTRACT_PKG TO ODS_READ;

GRANT EXECUTE ON INCV.INCV_PROGRAMCONFIGURATION_PKG TO ODS_READ;

GRANT EXECUTE ON INCV.INCV_CEOUTPUT TO ODS_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ODS_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_DMLEXTRACT_PKG TO ODS_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_PROGRAMCONFIGURATION_PKG TO ODS_USER;


/*
DROP PACKAGE BODY INCV.INCV_CEOUTPUT;
*/

CREATE OR REPLACE PACKAGE BODY INCV.INCV_CEOUTPUT
AS
PROCEDURE getEligibleMemberHealthState ( p_incvmem in INCV.MEMBERELIGIBLEME_OBJ, results OUT sys_refcursor)
IS
ln_memberid NUMBER;
ln_mastersupplierid NUMBER;
BEGIN

        IF ODS.ODS_COMMON_PKG.fgetdatashareconsentflg(pn_ahmsupplierid_in => p_incvmem.ahmsupplierid)='Y'
        Then  --get aggregate member detail
            ln_memberid := ODS.ODS_COMMON_PKG.FGETPERSONAGGREGATEID (memberid_in => p_incvmem.memberid);
            ln_mastersupplierid :=  ODS.ODS_COMMON_PKG.fgetmastersupplierid (pn_memberid_in => ln_memberid);
        ELSE
        -- get instance member detail
            ln_memberid  :=  p_incvmem.memberid;
			ln_mastersupplierid := ODS.ODS_COMMON_PKG.fgetmastersupplierid (pn_memberid_in => p_incvmem.memberid);

        END IF;
     open results for
      select mhs.MEMBERID,mhs.STATECOMPONENTID,mhs.HEALTHSTATESTATUSCD,mhs.CLINICALREVIEWSTATUSCD, mhs.CLINICALREVIEWSTATUSDT,
	         mhs.HEALTHSTATECHANGEDT,mhs.LASTEVALUATIONDT,mhs.EPISODEID,mhs.VERSIONNBR,mhs.COMPLETIONFLG,mhs.HEALTHSTATESTATUSCHANGEDT
      from csid.memberhealthstate mhs
      where
			mhs.memberid = ln_memberid
		and mhs.mastersupplierid =  ln_mastersupplierid
		and mhs.CLINICALREVIEWSTATUSCD='APPROVED'
		and mhs.VOIDFLG='IN'
		and mhs.CLINICALREVIEWSTATUSDT BETWEEN p_incvmem.PROGRAMSTARTDT and p_incvmem.PROGRAMENDDT
		and mhs.STATECOMPONENTID in ( select * from table(p_incvmem.melist) )
		and mhs.STATETYPECD='ME'
      UNION
      select tmp.MEMBERID,tmp.STATECOMPONENTID,tmp.HEALTHSTATESTATUSCD,tmp.CLINICALREVIEWSTATUSCD,
			tmp.CLINICALREVIEWSTATUSDT,tmp.HEALTHSTATECHANGEDT,tmp.LASTEVALUATIONDT,tmp.EPISODEID,tmp.VERSIONNBR,tmp.COMPLETIONFLG,
            tmp.HEALTHSTATESTATUSCHANGEDT from (
				select mhs.MEMBERID,mhs.STATECOMPONENTID,mhs.HEALTHSTATESTATUSCD,mhs.CLINICALREVIEWSTATUSCD,
					mhs.CLINICALREVIEWSTATUSDT,mhs.HEALTHSTATECHANGEDT,mhs.LASTEVALUATIONDT,mhs.EPISODEID,mhs.VERSIONNBR,mhs.COMPLETIONFLG,
					mhs.HEALTHSTATESTATUSCHANGEDT,
					ROW_NUMBER () OVER (PARTITION BY mhs.STATECOMPONENTID,mhs.MEMBERID
					ORDER BY mhs.EPISODEID ASC ,mhs.VERSIONNBR ASC) rnk
      from csid.memberhealthstate mhs
      where
			mhs.memberid = ln_memberid
		and mhs.mastersupplierid = ln_mastersupplierid
		and mhs.CLINICALREVIEWSTATUSCD='APPROVED'
		and mhs.VOIDFLG='IN'
		and mhs.STATECOMPONENTID in ( select * from table(p_incvmem.melist) )
		and mhs.HEALTHSTATESTATUSCD='CURR'
		and mhs.LASTEVALUATIONDT BETWEEN p_incvmem.PROGRAMSTARTDT and p_incvmem.PROGRAMENDDT
		and mhs.STATETYPECD='ME')tmp where rnk=1;
END;

END INCV_CEOUTPUT;
/


/*
DROP PACKAGE BODY INCV.INCV_DATAINGEST_PKG;
*/

CREATE OR REPLACE PACKAGE BODY INCV."INCV_DATAINGEST_PKG"
IS
   PROCEDURE sp_setmemberactoccurence (
      pn_Memberplanid_in            IN     incv.MEMBERACTIVITYOCCURRENCE.MEMBERPLANID%TYPE,
      pv_AHMSupplierid_in           IN     incv.MEMBERACTIVITYOCCURRENCE.AHMSUPPLIERID%TYPE,
      pn_Program_Id_in              IN     incv.MEMBERACTIVITYOCCURRENCE.PROGRAMID%TYPE,
      pn_Run_Id_in                  IN     incv.MEMBERACTIVITYOCCURRENCE.INCENTIVERUNID%TYPE,
      pn_Run_Date_in                IN     incv.MEMBERACTIVITYOCCURRENCE.RUNDT%TYPE,
      pt_ActivityOccurenceList_in   IN     incv.activitycccurencelist_TAB,
      pn_returncode_out                OUT NUMBER
   )
   IS
      ln_memberid                     ods.MEMBER.memberid%TYPE;
      ln_memberactivityoccskey        MEMBERACTIVITYOCCURRENCE.memberactivityoccurrenceskey%TYPE;
      ln_MEMBERACTIVITYOCCURVALSKEY   MEMBERACTIVITYOCCURVAL.MEMBERACTIVITYOCCURVALSKEY%TYPE;
      ln_mastersupplierid             MEMBERPROGRAMLASTRUN.MASTERSUPPLIERID%TYPE;
      lv_YEARQTR                      MEMBERPROGRAMLASTRUN.YEARQTR%TYPE;
      ln_mbroccskey                   NUMBER;
      ln_rundt                        DATE;
      ln_mastersuppid                 NUMBER;
      ln_cnt_occurrence               NUMBER;

      CURSOR l_cur
      IS
         SELECT   MEMBERACTIVITYOCCURRENCESKEY, RUNDT, MASTERSUPPLIERID
           FROM   INCV.MEMBERACTIVITYOCCURRENCE
          WHERE       MEMBERID = ln_memberid
                  AND PROGRAMID = pn_Program_Id_in
                  AND MASTERSUPPLIERID = ln_mastersupplierid;

      TYPE t_rec IS TABLE OF l_cur%ROWTYPE;

      l_rec                           t_rec;

      PROCEDURE setdebuginfo (
         ln_Memberplanid_in            IN incv.MEMBERACTIVITYOCCURRENCE.MEMBERPLANID%TYPE,
         lv_AHMSupplierid_in           IN incv.MEMBERACTIVITYOCCURRENCE.AHMSUPPLIERID%TYPE,
         ln_Program_Id_in              IN incv.MEMBERACTIVITYOCCURRENCE.PROGRAMID%TYPE,
         ln_Run_Id_in                  IN incv.MEMBERACTIVITYOCCURRENCE.INCENTIVERUNID%TYPE,
         ln_Run_Date_in                IN incv.MEMBERACTIVITYOCCURRENCE.RUNDT%TYPE,
         lt_ActivityOccurenceList_in   IN incv.activitycccurencelist_TAB
      )
      AS
         PRAGMA AUTONOMOUS_TRANSACTION;
      BEGIN
         INSERT INTO incv.DBUG_SETMEMBERACTOCCURENCE (Memberplanid,
                                                      AHMSupplierid,
                                                      ProgramId,
                                                      RunId,
                                                      RunDate,
                                                      ActivityOccurenceList,
                                                      insertdate)
           VALUES   (ln_Memberplanid_in,
                     lv_AHMSupplierid_in,
                     ln_Program_Id_in,
                     ln_Run_Id_in,
                     ln_Run_Date_in,
                     lt_ActivityOccurenceList_in,
                     SYSTIMESTAMP);

         COMMIT;
      END;
   BEGIN
      ods.ods_core.gt_start := SYSTIMESTAMP;

      IF ods.fdebug ('SP_SETMEMBERACTOCCURENCE') = 'Y'
      THEN
         setdebuginfo (
            ln_Memberplanid_in            => pn_memberplanid_in,
            lv_AHMSupplierid_in           => pv_AHMsupplierid_in,
            ln_Program_Id_in              => pn_program_id_in,
            ln_Run_Id_in                  => pn_run_id_in,
            ln_Run_Date_in                => pn_run_date_in,
            lt_ActivityOccurenceList_in   => pt_ActivityOccurenceList_in
         );
      END IF;

      ods.ods_core.gt_chk1 := SYSTIMESTAMP;

      ln_memberid :=
         ods.fgetmemberid (NULL,
                           clientid_in       => pv_ahmsupplierid_in,
                           memberplanid_in   => pn_memberplanid_in);
      ln_mastersupplierid :=
         ods.ods_common_pkg.fgetmastersupplierid (
            pn_memberid_in   => ln_memberid
         );
      lv_YEARQTR := ods.ods_common_pkg.fgetyearqtr (pn_Run_Date_in);
      ods.ods_core.gt_chk2 := SYSTIMESTAMP;

      IF ln_memberid > 0
      THEN
         MERGE INTO   incv.MEMBERPROGRAMLASTRUN mp
              USING   (SELECT   ln_memberid AS memberid,
                                pn_Program_Id_in AS programid,
                                pn_run_id_in AS runid,
                                pn_Run_Date_in AS rundt,
                                ln_mastersupplierid AS MASTER_SUPPLIER_ID,
                                lv_YEARQTR AS year_qtr
                         FROM   DUAL) param
                 ON   (    mp.MASTERSUPPLIERID = param.MASTER_SUPPLIER_ID
                       AND mp.memberid = param.memberid
                       AND mp.programid = param.programid)
         WHEN MATCHED
         THEN
            UPDATE SET
               mp.INCENTIVERUNID = param.runid,
               mp.UPDATEDDT = SYSTIMESTAMP,
               mp.UPDATEDBY = USER,
               mp.yearqtr = param.year_qtr
         WHEN NOT MATCHED
         THEN
            INSERT              (MEMBERACTIVITYLASTRUNSKEY,
                                 MEMBERID,
                                 PROGRAMID,
                                 INCENTIVERUNID,
                                 VOIDFLG,
                                 INSERTEDDT,
                                 INSERTEDBY,
                                 UPDATEDDT,
                                 UPDATEDBY,
                                 MASTERSUPPLIERID,
                                 YEARQTR)
                VALUES   (MEMBERPROGRAMLASTRUN_SEQ.NEXTVAL,
                          param.memberid,
                          param.programid,
                          param.runid,
                          'IN',
                          SYSTIMESTAMP,
                          USER,
                          SYSTIMESTAMP,
                          USER,
                          param.MASTER_SUPPLIER_ID,
                          param.year_qtr);

         ods.ods_core.gt_chk3 := SYSTIMESTAMP;

         /*     FOR i in (SELECT MEMBERACTIVITYOCCURRENCESKEY,
                               RUNDT,
                               MASTERSUPPLIERID
                          FROM INCV.MEMBERACTIVITYOCCURRENCE
                         WHERE MEMBERID = ln_memberid
                           AND PROGRAMID = pn_Program_Id_in
                           AND MASTERSUPPLIERID = ln_mastersupplierid)
              LOOP
                 DELETE FROM INCV.MEMBERACTIVITYOCCURVAL
                  WHERE MEMBERACTIVITYOCCURRENCESKEY = i.MEMBERACTIVITYOCCURRENCESKEY
                    AND Rundt = i.RUNDT
                    and MasterSupplierID = i.MASTERSUPPLIERID;
              END LOOP;     */

         OPEN l_cur;

         LOOP
            FETCH l_cur BULK COLLECT INTO   l_rec LIMIT 500;

            EXIT WHEN l_rec.COUNT = 0;

            FORALL idx IN 1 .. l_rec.COUNT
               DELETE FROM   INCV.MEMBERACTIVITYOCCURVAL
                     WHERE   MEMBERACTIVITYOCCURRENCESKEY =
                                l_rec (idx).MEMBERACTIVITYOCCURRENCESKEY
                             AND Rundt = l_rec (idx).RUNDT
                             AND MasterSupplierID =
                                   l_rec (idx).MASTERSUPPLIERID;
         END LOOP;

         CLOSE l_cur;

         DELETE FROM   INCV.MEMBERACTIVITYOCCURRENCE
               WHERE       MEMBERID = ln_memberid
                       AND PROGRAMID = pn_Program_Id_in
                       AND MASTERSUPPLIERID = ln_mastersupplierid;

         ods.ods_core.gt_chk4 := SYSTIMESTAMP;

         FOR i IN 1 .. pt_ActivityOccurenceList_in.COUNT
         LOOP
            BEGIN
               ln_memberactivityoccskey :=
                  MEMBERACTIVITYOCCURRENCE_SEQ.NEXTVAL;

               INSERT INTO INCV.MEMBERACTIVITYOCCURRENCE_HIST (
                                                                  RUNDT,
                                                                  MEMBERACTIVITYOCCURRENCESKEY,
                                                                  AHMSUPPLIERID,
                                                                  MEMBERID,
                                                                  MEMBERPLANID,
                                                                  INCENTIVERUNID,
                                                                  PROGRAMID,
                                                                  REWARDID,
                                                                  ACTIVITYID,
                                                                  REWARDSTATUSMNEMONIC,
                                                                  RECORDSTATUSMNEMONIC,
                                                                  ACTIVITYSTATUSMNEMONIC,
                                                                  ACTIVITYOCCURSTATUSMNEMONIC,
                                                                  ACTIVITYOCCURRENCEDT,
                                                                  ISOPENIND,
                                                                  ISPRESENTIND,
                                                                  ISAPPLICABLEIND,
                                                                  PARAM1,
                                                                  PARAM2,
                                                                  PARAM3,
                                                                  VOIDFLG,
                                                                  INSERTEDDT,
                                                                  INSERTEDBY,
                                                                  UPDATEDDT,
                                                                  UPDATEDBY,
                                                                  REWARDCOMPLETIONDATE,
                                                                  ACTIVITYCOMPLETIONDT,
                                                                  OVERRIDDENYNIND,
                                                                  MBRINCENTIVESTATUSOVERRIDESKEY,
                                                                  INVALIDIND,
                                                                  ACTIVITYSTARTDT,
                                                                  ACTIVITYENDDT,
                                                                  REWARDSTARTDT,
                                                                  REWARDENDDT,
                                                                  MASTERSUPPLIERID,
                                                                  YEARQTR
                          )
                 VALUES   (
                              pn_Run_Date_in,
                              ln_memberactivityoccskey,
                              pv_ahmsupplierid_in,
                              ln_memberid,
                              pn_Memberplanid_in,
                              pn_Run_Id_in,
                              pn_Program_Id_in,
                              pt_ActivityOccurenceList_in (i).RewardId,
                              pt_ActivityOccurenceList_in (i).Activityid,
                              pt_ActivityOccurenceList_in (i).Rewardstatus,
                              pt_ActivityOccurenceList_in (i).Recordstatus,
                              pt_ActivityOccurenceList_in (i).Activitystatus,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Activityoccurstatus,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Activityoccurrencedt,
                              pt_ActivityOccurenceList_in (i).ISOPEN,
                              pt_ActivityOccurenceList_in (i).Ispresent,
                              pt_ActivityOccurenceList_in (i).Isapplicable,
                              pt_ActivityOccurenceList_in (i).Param1,
                              pt_ActivityOccurenceList_in (i).Param2,
                              pt_ActivityOccurenceList_in (i).Param3,
                              'IN',
                              SYSTIMESTAMP,
                              USER,
                              SYSTIMESTAMP,
                              USER,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Rewardcompletiondate,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Activitycompletiondt,
                              pt_ActivityOccurenceList_in (i).OverriddenyInd,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Mbrincentivestatusoverrideskey,
                              pt_ActivityOccurenceList_in (i).Invalidind,
                              pt_ActivityOccurenceList_in (i).Activitystartdt,
                              pt_ActivityOccurenceList_in (i).Activityenddt,
                              pt_ActivityOccurenceList_in (i).Rewardstartdt,
                              pt_ActivityOccurenceList_in (i).Rewardenddt,
                              ln_mastersupplierid,
                              lv_YEARQTR
                          );

               INSERT INTO INCV.MEMBERACTIVITYOCCURRENCE (
                                                             RUNDT,
                                                             MEMBERACTIVITYOCCURRENCESKEY,
                                                             AHMSUPPLIERID,
                                                             MEMBERID,
                                                             MEMBERPLANID,
                                                             INCENTIVERUNID,
                                                             PROGRAMID,
                                                             REWARDID,
                                                             ACTIVITYID,
                                                             REWARDSTATUSMNEMONIC,
                                                             RECORDSTATUSMNEMONIC,
                                                             ACTIVITYSTATUSMNEMONIC,
                                                             ACTIVITYOCCURSTATUSMNEMONIC,
                                                             ACTIVITYOCCURRENCEDT,
                                                             ISOPENIND,
                                                             ISPRESENTIND,
                                                             ISAPPLICABLEIND,
                                                             PARAM1,
                                                             PARAM2,
                                                             PARAM3,
                                                             VOIDFLG,
                                                             INSERTEDDT,
                                                             INSERTEDBY,
                                                             UPDATEDDT,
                                                             UPDATEDBY,
                                                             REWARDCOMPLETIONDATE,
                                                             ACTIVITYCOMPLETIONDT,
                                                             OVERRIDDENYNIND,
                                                             MBRINCENTIVESTATUSOVERRIDESKEY,
                                                             INVALIDIND,
                                                             ACTIVITYSTARTDT,
                                                             ACTIVITYENDDT,
                                                             REWARDSTARTDT,
                                                             REWARDENDDT,
                                                             MASTERSUPPLIERID,
                                                             YEARQTR
                          )
                 VALUES   (
                              pn_Run_Date_in,
                              ln_memberactivityoccskey,
                              pv_ahmsupplierid_in,
                              ln_memberid,
                              pn_Memberplanid_in,
                              pn_Run_Id_in,
                              pn_Program_Id_in,
                              pt_ActivityOccurenceList_in (i).RewardId,
                              pt_ActivityOccurenceList_in (i).Activityid,
                              pt_ActivityOccurenceList_in (i).Rewardstatus,
                              pt_ActivityOccurenceList_in (i).Recordstatus,
                              pt_ActivityOccurenceList_in (i).Activitystatus,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Activityoccurstatus,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Activityoccurrencedt,
                              pt_ActivityOccurenceList_in (i).ISOPEN,
                              pt_ActivityOccurenceList_in (i).Ispresent,
                              pt_ActivityOccurenceList_in (i).Isapplicable,
                              pt_ActivityOccurenceList_in (i).Param1,
                              pt_ActivityOccurenceList_in (i).Param2,
                              pt_ActivityOccurenceList_in (i).Param3,
                              'IN',
                              SYSTIMESTAMP,
                              USER,
                              SYSTIMESTAMP,
                              USER,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Rewardcompletiondate,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Activitycompletiondt,
                              pt_ActivityOccurenceList_in (i).OverriddenyInd,
                              pt_ActivityOccurenceList_in (
                                 i
                              ).Mbrincentivestatusoverrideskey,
                              pt_ActivityOccurenceList_in (i).Invalidind,
                              pt_ActivityOccurenceList_in (i).Activitystartdt,
                              pt_ActivityOccurenceList_in (i).Activityenddt,
                              pt_ActivityOccurenceList_in (i).Rewardstartdt,
                              pt_ActivityOccurenceList_in (i).Rewardenddt,
                              ln_mastersupplierid,
                              lv_YEARQTR
                          );

               FOR j IN 1 .. pt_ActivityOccurenceList_in (
                                i
                             ).MEMBERACTIVITYOCCURVALUE.COUNT
               LOOP
                  BEGIN
                     ln_MEMBERACTIVITYOCCURVALSKEY :=
                        MEMBERACTIVITYOCCURVAL_SEQ.NEXTVAL;
                     DBMS_OUTPUT.put_line ('Start Inner Loop');

                     INSERT INTO incv.MEMBERACTIVITYOCCURVAL (
                                                                 MEMBERACTIVITYOCCURVALSKEY,
                                                                 MEMBERACTIVITYOCCURRENCESKEY,
                                                                 Rundt,
                                                                 MasterSupplierID,
                                                                 YearQtr,
                                                                 MemberTierMnemonic,
                                                                 GoalTypeMnemonic,
                                                                 EarnedRewardVal,
                                                                 EARNEDOCCURRENCEVAL,
                                                                 EARNEDACTIVITYVAL,
                                                                 MAXREWARDVAL,
                                                                 Redeemedrewardval,
                                                                 Balancerewardval,
                                                                 ACCRUEDDT
                                )
                       VALUES   (
                                    ln_MEMBERACTIVITYOCCURVALSKEY,
                                    ln_memberactivityoccskey,
                                    pn_Run_Date_in,
                                    ln_mastersupplierid,
                                    lv_YEARQTR,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).MemberTierMnemonic,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).GoalTypeMnemonic,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Earnedrewardval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Earnedoccurrenceval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Earnedactivityval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Maxrewardval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Redeemedrewardval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Balancerewardval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).AccruedDate
                                );

                     INSERT INTO incv.MEMBERACTIVITYOCCURVALHIST (
                                                                     MEMBERACTIVITYOCCURVALSKEY,
                                                                     MEMBERACTIVITYOCCURRENCESKEY,
                                                                     Rundt,
                                                                     MasterSupplierID,
                                                                     YearQtr,
                                                                     MemberTierMnemonic,
                                                                     GoalTypeMnemonic,
                                                                     EarnedRewardVal,
                                                                     EARNEDOCCURRENCEVAL,
                                                                     EARNEDACTIVITYVAL,
                                                                     MAXREWARDVAL,
                                                                     Redeemedrewardval,
                                                                     Balancerewardval,
                                                                     ACCRUEDDT
                                )
                       VALUES   (
                                    ln_MEMBERACTIVITYOCCURVALSKEY,
                                    ln_memberactivityoccskey,
                                    pn_Run_Date_in,
                                    ln_mastersupplierid,
                                    lv_YEARQTR,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).MemberTierMnemonic,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).GoalTypeMnemonic,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Earnedrewardval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Earnedoccurrenceval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Earnedactivityval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Maxrewardval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Redeemedrewardval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).Balancerewardval,
                                    pt_ActivityOccurenceList_in(i).MEMBERACTIVITYOCCURVALUE(j).AccruedDate
                                );

                     DBMS_OUTPUT.put_line ('End Inner Loop');
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        ods.log_error (
                           'SP_SETMEMBERACTOCCURENCE',
                           ln_memberid,
                           SQLCODE,
                           SUBSTR (
                              (   'Memberid='
                               || ln_memberid
                               || ',Programid='
                               || pn_Program_Id_in
                               || ',Runid='
                               || pn_Run_Id_in
                               || ' '
                               || SQLERRM),
                              1,
                              255
                           ),
                           SYSDATE,
                           NULL
                        );
                  END;
               END LOOP;

               IF pt_ActivityOccurenceList_in (i).justificationtxt IS NOT NULL
               THEN
                  INSERT INTO INCV.MEMBERACTIVITYJUSTIFICATION (
                                                                   RUNDT,
                                                                   MEMBERACTIVITYOCCURRENCESKEY,
                                                                   JUSTIFICATIONTXT,
                                                                   VOIDFLG,
                                                                   INSERTEDDT,
                                                                   INSERTEDBY,
                                                                   MASTERSUPPLIERID,
                                                                   YEARQTR
                             )
                    VALUES   (
                                 pn_run_date_in,
                                 ln_memberactivityoccskey,
                                 pt_ActivityOccurenceList_in (
                                    i
                                 ).justificationtxt,
                                 'IN',
                                 SYSTIMESTAMP,
                                 USER,
                                 ln_mastersupplierid,
                                 lv_YEARQTR
                             );
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  ods.log_error (
                     'SP_SETMEMBERACTOCCURENCE',
                     ln_memberid,
                     SQLCODE,
                     SUBSTR (
                        (   'Mid='
                         || ln_memberid
                         || ',Pid='
                         || pn_Program_Id_in
                         || ',Rid='
                         || pn_Run_Id_in
                         || ' '
                         || SQLERRM),
                        1,
                        255
                     ),
                     SYSDATE,
                     NULL
                  );
            END;
         END LOOP;

         pn_returncode_out := ods.ct_core.ferrorcodesct ('ALL', 'SUCCESSFUL');
      ELSE
         pn_returncode_out :=
            ods.ct_core.ferrorcodesct ('ALL', 'MEMBER NOT FOUND');
      END IF;

      ods.ods_core.gt_end := SYSTIMESTAMP;

      IF (ods.ods_core.gt_end - ods.ods_core.gt_start) >
            ods.ods_core.fgetdebugexecutiontime ('SP_SETMEMBERACTOCCURENCE')
      THEN
         ods.ods_core.loglongcall (
            pv_procedurenm_in   => 'SP_SETMEMBERACTOCCURENCE',
            pt_start_in         => ods.ods_core.gt_start,
            pt_chk1_in          => ods.ods_core.gt_chk1,
            pt_chk2_in          => ods.ods_core.gt_chk2,
            pt_chk3_in          => ods.ods_core.gt_chk3,
            pt_chk4_in          => ods.ods_core.gt_chk4,
            pt_end_in           => ods.ods_core.gt_end
         );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         ods.log_error (
            'SP_SETMEMBERACTOCCURENCE',
            ln_memberid,
            SQLCODE,
            SUBSTR (
               (   'Mid='
                || ln_memberid
                || ',Pid='
                || pn_Program_Id_in
                || ',Rid='
                || pn_Run_Id_in
                || ' '
                || SQLERRM),
               1,
               255
            ),
            SYSDATE,
            NULL
         );

         pn_returncode_out :=
            ods.ct_core.ferrorcodesct ('ALL', 'NOT SUCCESSFUL');
   END sp_setmemberactoccurence;

   PROCEDURE sp_setmembertierprogression (
      pn_memberplanid_in      IN     incv.MemberTierInfo.MEMBERPLANID%TYPE,
      pt_TierProgression_in   IN     incv.TIERPROGRESSION_TAB,
      pn_returncode_out          OUT NUMBER
   )
   AS
      ln_memberid             NUMBER;
      ln_cnt                  NUMBER := 0;
      ln_MemberTierInfoSKey   NUMBER;

      PROCEDURE setdebuginfo (
         ln_Memberplanid_in      IN incv.MemberTierInfo.MEMBERPLANID%TYPE,
         lt_TierProgression_in   IN incv.TIERPROGRESSION_TAB
      )
      AS
         PRAGMA AUTONOMOUS_TRANSACTION;
      BEGIN
         INSERT INTO incv.DBUG_SP_SETMBRTIERPROGRESSION (
                                                            Memberplanid,
                                                            TierProgression,
                                                            INSERTDATE
                    )
           VALUES   (ln_Memberplanid_in, lt_TierProgression_in, SYSTIMESTAMP);

         COMMIT;
      END;
   BEGIN
      -- Inserting input parameters in debug table DBUG_SP_SETMBRTIERPROGRESSION for tracking purpose
      IF ods.fdebug ('SP_SETMEMBERTIERPROGRESSION') = 'Y'
      THEN
         setdebuginfo (ln_Memberplanid_in      => pn_memberplanid_in,
                       lt_TierProgression_in   => pt_TierProgression_in);
      END IF;

      -- Finding Member Id from MemberPlanId
      ln_memberid :=
         ods.fgetmemberid (memberid_in       => NULL,
                           clientid_in       => NULL,
                           memberplanid_in   => pn_memberplanid_in);

      -- If member id is available for given member plan id
      IF ln_memberid > 0
      THEN
         FOR i IN 1 .. pt_TierProgression_in.COUNT
         LOOP
            BEGIN
               -- Checking any ACTIVE Tier Info available for given Member
               SELECT   COUNT (1)
                 INTO   ln_cnt
                 FROM   incv.MemberTierInfo
                WHERE   memberid = ln_memberid
                        AND RewardId = pt_TierProgression_in (i).RewardId
                        AND MemberTierMnemonic =
                              pt_TierProgression_in (i).MemberTierMnemonic
                        AND GoalTypeMnemonic =
                              pt_TierProgression_in (i).GoalTypeMnemonic
                        AND effstartdt = pt_TierProgression_in (i).effstartdt
                        AND effenddt IS NULL;

               -- Getting key column value for available member with same details
               BEGIN
                  SELECT   MemberTierInfoSKey
                    INTO   ln_MemberTierInfoSKey
                    FROM   incv.MemberTierInfo
                   WHERE   memberid = ln_memberid
                           AND RewardId = pt_TierProgression_in (i).RewardId
                           AND GoalTypeMnemonic =
                                 pt_TierProgression_in (i).GoalTypeMnemonic
                           AND EFFENDDT IS NULL;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     NULL;
               END;

               -- Inserting data if given inputs not available else will get an error (10004) if records is already available
               INSERT INTO INCV.MemberTierInfo (MemberTierInfoSKey,
                                                MemberPlanId,
                                                MemberId,
                                                RewardId,
                                                MemberTierMnemonic,
                                                GoalTypeMnemonic,
                                                EffStartDt,
                                                EffEndDt,
                                                VoidFlg)
                 VALUES   (Membertierinfo_seq.NEXTVAL,
                           pn_memberplanid_in,
                           ln_memberid,
                           pt_TierProgression_in (i).RewardId,
                           pt_TierProgression_in (i).MemberTierMnemonic,
                           pt_TierProgression_in (i).GoalTypeMnemonic,
                           pt_TierProgression_in (i).EffStartDt,
                           NULL,
                           'IN');

               -- Checking key column value is NOT NULL for that member with currency type
               IF ln_cnt = 0 AND ln_MemberTierInfoSKey IS NOT NULL
               THEN
                  -- Updating end date for that member
                  UPDATE   INCV.MemberTierInfo
                     SET   effenddt = pt_TierProgression_in (i).EffStartDt,
                           UPDATEDDT = SYSTIMESTAMP,
                           UPDATEDBY = USER
                   WHERE   MemberTierInfoSKey = ln_MemberTierInfoSKey;
               END IF;

               -- Return Code as 10000
               pn_returncode_out :=
                  ods.ct_core.ferrorcodesct ('ALL', 'SUCCESSFUL');
            EXCEPTION
               WHEN OTHERS
               THEN
                  ods.log_error (
                     'INCV_DATAINGEST_PKG.SP_SETMEMBERTIERPROGRESSION',
                     ln_memberid,
                     SQLCODE,
                     SUBSTR (
                        (   'MemberId='
                         || ln_memberid
                         || ',Rewardid='
                         || pt_TierProgression_in (i).RewardId
                         || ',MemberTierMnemonic='
                         || pt_TierProgression_in (i).MemberTierMnemonic
                         || ',GoalTypeMnemonic='
                         || pt_TierProgression_in (i).GoalTypeMnemonic
                         || ' '
                         || SQLERRM),
                        1,
                        255
                     ),
                     SYSDATE,
                     NULL
                  );
                  -- Return Code as 10004
                  pn_returncode_out :=
                     ods.ct_core.ferrorcodesct ('ALL', 'NOT SUCCESSFUL');
            END;
         END LOOP;
      ELSE
         -- If member id is NOT valid, Return Code as 10010
         pn_returncode_out :=
            ods.ct_core.ferrorcodesct ('ALL', 'MEMBER NOT FOUND');
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         ods.log_error (
            'INCV_DATAINGEST_PKG.SP_SETMEMBERTIERPROGRESSION',
            ln_memberid,
            SQLCODE,
            SUBSTR ( ('MemberId=' || ln_memberid || SQLERRM), 1, 255),
            SYSDATE,
            NULL
         );
         -- Return Code as 10004
         pn_returncode_out :=
            ods.ct_core.ferrorcodesct ('ALL', 'NOT SUCCESSFUL');
   END sp_setmembertierprogression;
END INCV_DATAINGEST_PKG;
/


/*
DROP PACKAGE BODY INCV.INCV_DMLEXTRACT_PKG;
*/

CREATE OR REPLACE PACKAGE BODY INCV.incv_dmlextract_pkg
AS
  /******************************************************************************
  NAME:       INCV.incv_dmlextract_pkg
  PURPOSE:
  REVISIONS:
  Ver             Date            Author                  Description
  ---------       ----------      ---------------        ---------------------
  1.0             05/12/2018      Sami R                       Initial Version
  1.1             05/31/2018      Kader					   For User Story US109446
  ******************************************************************************/

FUNCTION f_getidlist(p_tbl_in IN numberarray)
  RETURN VARCHAR2
IS
  lv_str VARCHAR2(4000) := '';
BEGIN
  FOR cu IN (SELECT * FROM TABLE(p_tbl_in))
  LOOP
    IF lv_str IS NOT NULL THEN
      lv_str := lv_str || ', '||cu.column_value;
    ELSE
      lv_str := cu.column_value;
    END IF;
  END LOOP;

  RETURN lv_str;

END f_getidlist;

FUNCTION f_getsubqueryid(p_tbl_in IN numberarray,
                             pv_tablename_in IN VARCHAR2,
							 pv_arg_in in varchar2,
							 p_seq_no_in in number)
  RETURN VARCHAR2
IS
  lv_str        VARCHAR2(4000) := '';
  lv_sqltext    varchar2(4000);
  lv_sql_insert varchar2(4000);
BEGIN
  FOR cu IN (SELECT * FROM TABLE(p_tbl_in))
  LOOP
      lv_str := cu.column_value;
	  lv_sqltext := f_getsubquerystring(pv_tablename_in, 'INSERT',pv_arg_in,p_seq_no_in)||lv_str||')';

	  IF REGEXP_COUNT(lv_sqltext,'[(]') <> REGEXP_COUNT(lv_sqltext,'[)]')
	  THEN
          lv_sqltext := lv_sqltext||')';
      END IF;

	  IF lv_sqltext IS NOT NULL
	  THEN
          lv_sql_insert := 'INSERT INTO incvsqlstatement_tmp (sequenceno, statementtypecd, tablename, sqltxt) SELECT incvsqlstatement_seq.nextval,''INSERT'','''||pv_tablename_in||''', t from ('||lv_sqltext||')';

          lv_sql_insert := regexp_replace(lv_sql_insert,'IncentiveGoalCategoryID = ', 'IncentiveGoalCategoryID = '||lv_str||')',1,1);

          EXECUTE immediate lv_sql_insert;
      END IF;
   END LOOP;

   RETURN lv_str;

END f_getsubqueryid;

FUNCTION f_getquerystring (pv_tablename_in IN VARCHAR2,
    					   pv_dmltype_in   IN VARCHAR2,
						   pv_arg_in       IN VARCHAR2)
  RETURN VARCHAR2
IS
  lv_insert_statement VARCHAR2(4000) := '';
  lv_ins_columns      VARCHAR2(4000);
  lv_ins_values       VARCHAR2(6000);
BEGIN
  IF UPPER(pv_dmltype_in) NOT IN ('DELETE', 'INSERT')
  THEN
    raise_application_error(20003, 'Error in f_getquerystring -> unsupported DML type');
  END IF;
  -- Start DELETE Scripts Generation
  IF pv_dmltype_in = 'DELETE'
  THEN
    lv_insert_statement := 'DELETE FROM INCV.'||pv_tablename_in;
    FOR cu IN (SELECT tablename, argstmt1, argstmt2, argstmt3, arg1, arg2, arg3
                 FROM incvtablelist
                WHERE tablename = pv_tablename_in
				  AND actiontype = 'DELETE_INSERT')
    LOOP
      IF pv_arg_in = cu.arg1
	  THEN
        lv_insert_statement := lv_insert_statement || cu.argstmt1 ||' (';
      ELSIF pv_arg_in = cu.arg2
	  THEN
        lv_insert_statement := lv_insert_statement || cu.argstmt2 ||' (';
      ELSIF pv_arg_in = cu.arg3
	  THEN
        lv_insert_statement := lv_insert_statement || cu.argstmt3 ||' (';
      END IF;
    END LOOP;
  -- End DELETE Scripts Generation

  -- Start INSERT Scripts Generation
  ELSIF pv_dmltype_in = 'INSERT'
  THEN
    lv_insert_statement:='select ''INSERT INTO INCV.'||pv_tablename_in||' (';

    FOR cu_key IN (SELECT tablename, keycolumn, keystatement, actiontype
	                 FROM incvtablelist
                    WHERE tablename = pv_tablename_in
                      AND actiontype = 'DELETE_INSERT'
					  AND tablename <> 'INCENTIVEOVERRIDE'
					  AND rownum <= 1)
    LOOP
      FOR cu IN (SELECT table_name, column_name, data_type, column_id
                   FROM user_tab_columns
                  WHERE table_name = cu_key.tablename
               ORDER BY column_id )
      LOOP
        IF cu.column_id = 1
		THEN
          lv_insert_statement:= lv_insert_statement;
        ELSE
          lv_insert_statement:= lv_insert_statement||',';
          lv_ins_values := lv_ins_values||',';
        END IF;

        lv_insert_statement := lv_insert_statement||cu.column_name;

		-- For Sub Query Max+1 in Insert
        IF cu_key.keycolumn = cu.column_name
		THEN
          lv_ins_columns :=''''||cu_key.keystatement||'''';
		-- Hard Coding systimestamp for INSERTEDDT and UPDATEDDT columns
        ELSIF instr(cu.data_type,'TIMESTAMP') > 0 AND cu.column_name IN ('INSERTEDDT','UPDATEDDT')
		THEN
          lv_ins_columns := '''systimestamp''';
        ELSIF (instr(cu.data_type,'TIMESTAMP') > 0 OR instr(cu.data_type,'DATE') > 0 )
		THEN
          lv_ins_columns := '''to_timestamp(''''''||to_char('||cu.column_name||',''DD-MON-YYYY HH.MI.SS AM'')||'''''',''''DD-MON-YYYY HH.MI.SS AM'''')''';
        ELSE
          lv_ins_columns := cu.column_name;
        END IF;

        IF instr(cu.data_type,'CHAR') > 0 THEN
          lv_ins_values := lv_ins_values||'''||''q''''[';
          lv_ins_values := lv_ins_values||'''||decode('||cu.column_name||',Null,'''','||lv_ins_columns||')||''';
          lv_ins_values := lv_ins_values||']''''''||''';
        ELSE
          lv_ins_values := lv_ins_values||'''||decode('||cu.column_name||',Null,''Null'','||lv_ins_columns||')||''';
        END IF;

      END LOOP;
    END LOOP;

    lv_insert_statement := lv_insert_statement||') VALUES ('||lv_ins_values||');'' as t from '||pv_tablename_in;

    FOR cu IN (SELECT tablename, argstmt1, argstmt2, argstmt3, arg1, arg2, arg3
                 FROM incvtablelist
                WHERE tablename = pv_tablename_in
				  AND actiontype = 'DELETE_INSERT'
				  )
    LOOP
      IF pv_arg_in = cu.arg1
	  THEN
        lv_insert_statement := lv_insert_statement || cu.argstmt1 ||'(';
      ELSIF pv_arg_in = cu.arg2
	  THEN
        lv_insert_statement := lv_insert_statement || cu.argstmt2 ||'(';
      ELSIF pv_arg_in = cu.arg3
	  THEN
        lv_insert_statement := lv_insert_statement || cu.argstmt3 ||'(';
      END IF;
    END LOOP;
    IF lv_insert_statement IS NULL
	THEN
      raise_application_error(20002, 'Error in f_getquerystring');
    END IF;
  END IF;
    -- End INSERT Scripts Generation

    IF lv_insert_statement IS NULL
	THEN
      raise_application_error(20002, 'Error in f_getquerystring');
    END IF;

  RETURN lv_insert_statement;
EXCEPTION
 WHEN OTHERS THEN
  ods.log_error ('incvpkg_dml.f_getquerystring',
                 pv_tablename_in,
				 SQLCODE,
				 SUBSTR(('Tablename='||pv_tablename_in||',DML='||pv_dmltype_in||' - '||SQLERRM),1,255),
				 SYSDATE,
				 NULL);
END f_getquerystring;
------------------------ INCENTIVE OVERRIDE Query Formation Start --------------
FUNCTION f_getsubquerystring (pv_tablename_in IN VARCHAR2,
                                  pv_dmltype_in   IN VARCHAR2,
                                  pv_arg_in       IN VARCHAR2,
						          pv_where_in     IN VARCHAR2)
  RETURN VARCHAR2
IS
  lv_insert_statement VARCHAR2(4000) := '';
  lv_ins_columns      VARCHAR2(4000);
  lv_ins_values       VARCHAR2(6000);
BEGIN
  IF UPPER(pv_dmltype_in) NOT IN ('DELETE', 'INSERT')
  THEN
    raise_application_error(20003, 'Error in f_getsubquerystring -> unsupported DML type');
  END IF;

  -- Start INSERT INCENTIVEOVERRIDE Scripts Generation
  IF pv_dmltype_in = 'INSERT'
  THEN
    lv_insert_statement:='select ''INSERT INTO INCV.'||pv_tablename_in||' (';

    FOR cu_key IN (SELECT tablename, keycolumn, keystatement, actiontype, argstmt1, argstmt2, argstmt3, arg1, arg2, arg3
	                 FROM incvtablelist
                    WHERE tablename = pv_tablename_in
					 AND sequenceno = pv_where_in
                      AND actiontype = 'INSERT')
    LOOP
      FOR cu IN (SELECT table_name, column_name, data_type, column_id
                   FROM user_tab_columns
                  WHERE table_name = cu_key.tablename
               ORDER BY column_id )
      LOOP
        IF cu.column_id = 1
		THEN
          lv_insert_statement:= lv_insert_statement;
        ELSE
          lv_insert_statement:= lv_insert_statement||',';
          lv_ins_values := lv_ins_values||',';
        END IF;
        lv_insert_statement := lv_insert_statement||cu.column_name;

		-- For Sub Query in Insert
        IF cu.column_id = 1
		THEN
          lv_ins_columns :=''''||cu_key.keystatement||'''';
		-- For SubQuery handling
        ELSIF cu.column_id = 2 AND cu.column_name = 'OVERRIDECATEGORYID'
		THEN
              IF pv_arg_in = cu_key.arg1
			  THEN
				lv_ins_columns := ''''||cu_key.argstmt1||'''';
			  ELSIF pv_arg_in = cu_key.arg2
			  THEN
				lv_ins_columns := ''''||cu_key.argstmt2||'''';
			  ELSIF pv_arg_in = cu_key.arg3
			  THEN
				lv_ins_columns := ''''||cu_key.argstmt3||'''';
			  END IF;
		-- Hard Coding systimestamp for INSERTEDDT and UPDATEDDT columns
        ELSIF instr(cu.data_type,'TIMESTAMP') > 0 AND cu.column_name IN ('INSERTEDDT','UPDATEDDT')
		THEN
          lv_ins_columns := '''systimestamp''';
        ELSIF (instr(cu.data_type,'TIMESTAMP') > 0 OR instr(cu.data_type,'DATE') > 0 )
		THEN
          lv_ins_columns := '''to_timestamp(''''''||to_char('||cu.column_name||',''DD-MON-YYYY HH.MI.SS AM'')||'''''',''''DD-MON-YYYY HH.MI.SS AM'''')''';
        ELSE
          lv_ins_columns := cu.column_name;
        END IF;

        IF instr(cu.data_type,'CHAR') > 0 THEN
          lv_ins_values := lv_ins_values||'''||''q''''[';
          lv_ins_values := lv_ins_values||'''||decode('||cu.column_name||',Null,'''','||lv_ins_columns||')||''';
          lv_ins_values := lv_ins_values||']''''''||''';
        ELSE
          lv_ins_values := lv_ins_values||'''||decode('||cu.column_name||',Null,''Null'','||lv_ins_columns||')||''';
        END IF;

      END LOOP;

    END LOOP;

    lv_insert_statement := lv_insert_statement||') VALUES ('||lv_ins_values||');'' as t from '||pv_tablename_in;

	-- For appending WHERE condition
    FOR cu IN (SELECT tablename, argstmt1, argstmt2, argstmt3, arg1, arg2, arg3
                 FROM incvtablelist
                WHERE tablename = pv_tablename_in
				  AND actiontype = 'DELETE_INSERT')
    LOOP
      IF pv_arg_in = cu.arg1
	  THEN
        lv_insert_statement := lv_insert_statement || cu.argstmt1 ||'(';
      ELSIF pv_arg_in = cu.arg2
	  THEN
        lv_insert_statement := lv_insert_statement || cu.argstmt2 ||'(';
      ELSIF pv_arg_in = cu.arg3
	  THEN
        lv_insert_statement := lv_insert_statement || cu.argstmt3 ||'(';
      END IF;
    END LOOP;

    IF lv_insert_statement IS NULL
	THEN
      raise_application_error(20002, 'Error in f_getsubquerystring');
    END IF;
  END IF;
  -- End INSERT INCENTIVEOVERRIDE Scripts Generation
  RETURN lv_insert_statement;
EXCEPTION
 WHEN OTHERS THEN
  ods.log_error ('incvpkg_dml.f_getsubquerystring',
                 pv_tablename_in,
				 SQLCODE,
				 SUBSTR(('Tablename='||pv_tablename_in||',DML='||pv_dmltype_in||' - '||SQLERRM),1,255),
				 SYSDATE,
				 NULL);
END f_getsubquerystring;
---------------- INCENTIVEOVERRIDE END -------------------
PROCEDURE sp_insertdmlstatement (pn_programid_in  IN NUMBER,
                                     pv_actiontype_in IN VARCHAR2,
									 pn_err_code_out  OUT NUMBER,
									 pv_err_mesg_out  OUT VARCHAR2)
IS
  tbl_program numberarray       := numberarray();
  tbl_reward numberarray        := numberarray();
  tbl_activity numberarray      := numberarray();
  tbl_activitygroup numberarray := numberarray();
  tbl_eligibility numberarray   := numberarray();
  lv_str        VARCHAR2(4000)  := '';
  lv_sqltext    VARCHAR2(4000);
  lv_sql_insert VARCHAR2(4000);
BEGIN
  tbl_program.delete;
  tbl_reward.delete;
  tbl_activity.delete;
  tbl_activitygroup.delete;
  tbl_eligibility.delete;

  SELECT programid bulk collect
    INTO tbl_program
    FROM incv.program
   WHERE programid = pn_programid_in;

  SELECT rewardid bulk collect
    INTO tbl_reward
    FROM incv.reward
   WHERE programid = pn_programid_in;

  SELECT activitygroupid bulk collect
    INTO tbl_activitygroup
    FROM incv.rewardactivitygroupxref x,
         incv.reward r
   WHERE r.programid = pn_programid_in
     AND x.rewardid = r.rewardid;

  SELECT activityid  bulk collect
    INTO tbl_activity
	FROM (SELECT activityid
            FROM incv.activitygroupactivityxref x,
                 incv.rewardactivitygroupxref ragx,
                 incv.reward r
           WHERE r.programid = pn_programid_in
             AND ragx.rewardid = r.rewardid
             AND x.activitygroupid = ragx.activitygroupid
           UNION -- For getting Child Activities (DE91133)
          SELECT rel.relatedactivityid activityid
            FROM incv.relatedactivityxref rel
           WHERE rel.activityid IN (SELECT activityid
                                      FROM incv.activitygroupactivityxref x,
                                           incv.rewardactivitygroupxref ragx,
                                           incv.reward r
                                     WHERE r.programid = pn_programid_in
                                       AND ragx.rewardid = r.rewardid
                                       AND x.activitygroupid = ragx.activitygroupid));

  SELECT incveligibilityskey  bulk collect
    INTO tbl_eligibility
    FROM incv.activitygroupactivityxref x,
         incv.rewardactivitygroupxref ragx,
         incv.reward r,
         incv.incentiveeligibility e
   WHERE r.programid = pn_programid_in
     AND ragx.rewardid = r.rewardid
     AND x.activitygroupid = ragx.activitygroupid
     AND e.INCVELIGIBILITYSKEY = x.activityid;

  IF pv_actiontype_in = 'DELETE'
  THEN
  -- Start DELETE SCRIPTS Insertion
  FOR cu IN (SELECT tablename, argstmt1, argstmt2, argstmt3, arg1, arg2, arg3
               FROM incvtablelist
			  WHERE actiontype = 'DELETE_INSERT'
           ORDER BY sequenceno DESC)
  LOOP
    IF cu.argstmt1 IS NOT NULL
	THEN
      IF cu.arg1 IS NOT NULL
	  THEN
        IF cu.arg1 = 'PROGRAM'
		THEN
          lv_str := f_getidlist(tbl_program);
        ELSIF cu.arg1 = 'REWARD'
		THEN
          lv_str := f_getidlist(tbl_reward);
        ELSIF cu.arg1 = 'ACTIVITY'
		THEN
          lv_str := f_getidlist(tbl_activity);
        ELSIF cu.arg1 = 'ACTIVITYGROUP'
		THEN
          lv_str := f_getidlist(tbl_activitygroup);
        ELSIF cu.arg1 = 'ELIGIBILITY'
		THEN
          lv_str := f_getidlist(tbl_eligibility);
        END IF;
      END IF;

      IF lv_str IS NOT NULL
	  THEN
        lv_sqltext := f_getquerystring(cu.tablename, 'DELETE',cu.arg1)||lv_str;
        IF REGEXP_COUNT(lv_sqltext,'[(]') = 1
		THEN
          lv_sqltext := lv_sqltext||');';
        ELSIF REGEXP_COUNT(lv_sqltext,'[(]') = 2
		THEN
          lv_sqltext := lv_sqltext||'));';
        ELSIF REGEXP_COUNT(lv_sqltext,'[(]') = 3
		THEN
          lv_sqltext := lv_sqltext||')));';
        ELSIF REGEXP_COUNT(lv_sqltext,'[(]') = 4
		THEN
          lv_sqltext := lv_sqltext||'))));';
        END IF;

        INSERT
        INTO incvsqlstatement_tmp
          (
            sequenceno,
            statementtypecd,
            tablename,
            sqltxt
          )
          VALUES
          (
            incvsqlstatement_seq.nextval,
            'DELETE',
            cu.tablename,
            lv_sqltext
          );
      END IF;
    END IF;

    lv_str := '';

    IF cu.argstmt2 IS NOT NULL
	THEN
      IF cu.arg2 IS NOT NULL
	  THEN
        IF cu.arg2 = 'PROGRAM'
		THEN
          lv_str := f_getidlist(tbl_program);
        ELSIF cu.arg2 = 'REWARD'
		THEN
          lv_str := f_getidlist(tbl_reward);
        ELSIF cu.arg2 = 'ACTIVITY'
		THEN
          lv_str := f_getidlist(tbl_activity);
        ELSIF cu.arg2 = 'ACTIVITYGROUP'
		THEN
          lv_str := f_getidlist(tbl_activitygroup);
        ELSIF cu.arg2 = 'ELIGIBILITY'
		THEN
          lv_str := f_getidlist(tbl_eligibility);
        END IF;
      END IF;
      IF lv_str IS NOT NULL
	  THEN
        lv_sqltext := f_getquerystring(cu.tablename, 'DELETE',cu.arg2)||lv_str;
        IF REGEXP_COUNT(lv_sqltext,'[(]') = 1
		THEN
          lv_sqltext := lv_sqltext||');';
        ELSIF REGEXP_COUNT(lv_sqltext,'[(]') = 2
		THEN
          lv_sqltext := lv_sqltext||'));';
        ELSIF REGEXP_COUNT(lv_sqltext,'[(]') = 3
		THEN
          lv_sqltext := lv_sqltext||')));';
        ELSIF REGEXP_COUNT(lv_sqltext,'[(]') = 4
		THEN
          lv_sqltext := lv_sqltext||'))));';
        END IF;

        INSERT
        INTO incvsqlstatement_tmp
          (
            sequenceno,
            statementtypecd,
            tablename,
            sqltxt
          )
          VALUES
          (
            incvsqlstatement_seq.nextval,
            'DELETE',
            cu.tablename,
            lv_sqltext
          );
      END IF;
    END IF;

    lv_str := '';

    IF cu.argstmt3 IS NOT NULL
	THEN
      IF cu.arg3 IS NOT NULL
	  THEN
        IF cu.arg3    = 'PROGRAM'
		THEN
          lv_str     := f_getidlist(tbl_program);
        ELSIF cu.arg3 = 'REWARD'
		THEN
          lv_str     := f_getidlist(tbl_reward);
        ELSIF cu.arg3 = 'ACTIVITY'
		THEN
          lv_str     := f_getidlist(tbl_activity);
        ELSIF cu.arg3 = 'ACTIVITYGROUP'
		THEN
          lv_str     := f_getidlist(tbl_activitygroup);
        ELSIF cu.arg3 = 'ELIGIBILITY'
		THEN
          lv_str := f_getidlist(tbl_eligibility);
        END IF;
      END IF;

      IF lv_str IS NOT NULL
	  THEN
        lv_sqltext := f_getquerystring(cu.tablename, 'DELETE', cu.arg3)||lv_str;
        IF REGEXP_COUNT(lv_sqltext,'[(]') = 1
		THEN
          lv_sqltext := lv_sqltext||');';
        ELSIF REGEXP_COUNT(lv_sqltext,'[(]') = 2
		THEN
          lv_sqltext := lv_sqltext||'));';
        ELSIF REGEXP_COUNT(lv_sqltext,'[(]') = 3
		THEN
          lv_sqltext := lv_sqltext||')));';
        ELSIF REGEXP_COUNT(lv_sqltext,'[(]') = 4
		THEN
          lv_sqltext  := lv_sqltext||'))));';
        END IF;

        INSERT
        INTO incvsqlstatement_tmp
          (
            sequenceno,
            statementtypecd,
            tablename,
            sqltxt
          )
          VALUES
          (
            incvsqlstatement_seq.nextval,
            'DELETE',
            cu.tablename,
            lv_sqltext
          );
      END IF;
    END IF;
  END LOOP;
  -- End DELETE SCRIPTS Insertion
  ELSIF pv_actiontype_in = 'INSERT'
  THEN
  -- Start INSERT SCRIPTS Insertion
  FOR cu IN (SELECT tablename, argstmt1, argstmt2, argstmt3, arg1, arg2, arg3
               FROM incvtablelist
			  WHERE actiontype = 'DELETE_INSERT'
			    AND tablename <> 'INCENTIVEOVERRIDE'
           ORDER BY sequenceno ASC)
  LOOP
    IF cu.argstmt1 IS NOT NULL
	THEN
      IF cu.arg1 IS NOT NULL
	  THEN
        IF cu.arg1 = 'PROGRAM'
		THEN
          lv_str := f_getidlist(tbl_program);
        ELSIF cu.arg1 = 'REWARD'
		THEN
          lv_str := f_getidlist(tbl_reward);
        ELSIF cu.arg1 = 'ACTIVITY'
		THEN
          lv_str := f_getidlist(tbl_activity);
        ELSIF cu.arg1 = 'ACTIVITYGROUP'
		THEN
          lv_str := f_getidlist(tbl_activitygroup);
        ELSIF cu.arg1 = 'ELIGIBILITY'
		THEN
          lv_str := f_getidlist(tbl_eligibility);
        END IF;
      END IF;
      IF lv_str IS NOT NULL
	  THEN
        lv_sqltext := f_getquerystring(cu.tablename, 'INSERT',cu.arg1)||lv_str||')';

        IF REGEXP_COUNT(lv_sqltext,'[(]') <> REGEXP_COUNT(lv_sqltext,'[)]')
		THEN
          lv_sqltext := lv_sqltext||')';
        END IF;

        IF lv_sqltext IS NOT NULL
		THEN
          lv_sql_insert := 'INSERT INTO incvsqlstatement_tmp (sequenceno, statementtypecd, tablename, sqltxt) SELECT incvsqlstatement_seq.nextval,''INSERT'','''||cu.tablename||''', t from ('||lv_sqltext||')';
          EXECUTE immediate lv_sql_insert;
        END IF;
      END IF;
    END IF;

    lv_str := '';

    IF cu.argstmt2 IS NOT NULL
	THEN
      IF cu.arg2 IS NOT NULL
	  THEN
        IF cu.arg2 = 'PROGRAM'
		THEN
          lv_str := f_getidlist(tbl_program);
        ELSIF cu.arg2 = 'REWARD'
		THEN
          lv_str := f_getidlist(tbl_reward);
        ELSIF cu.arg2 = 'ACTIVITY'
		THEN
          lv_str := f_getidlist(tbl_activity);
        ELSIF cu.arg2 = 'ACTIVITYGROUP'
		THEN
          lv_str := f_getidlist(tbl_activitygroup);
        ELSIF cu.arg2 = 'ELIGIBILITY'
		THEN
          lv_str := f_getidlist(tbl_eligibility);
        END IF;
      END IF;

      IF lv_str IS NOT NULL
	  THEN
        lv_sqltext := f_getquerystring(cu.tablename, 'INSERT',cu.arg2)||lv_str||')';

        IF REGEXP_COUNT(lv_sqltext,'[(]') <> REGEXP_COUNT(lv_sqltext,'[)]')
		THEN
          lv_sqltext := lv_sqltext||')';
        END IF;

        IF lv_sqltext IS NOT NULL
		THEN
          lv_sql_insert := 'INSERT INTO incvsqlstatement_tmp (sequenceno, statementtypecd, tablename, sqltxt) SELECT incvsqlstatement_seq.nextval,''INSERT'','''||cu.tablename||''', t from ('||lv_sqltext||')';
		  EXECUTE immediate lv_sql_insert;
        END IF;
      END IF;
    END IF;

    lv_str := '';

    IF cu.argstmt3 IS NOT NULL
	THEN
      IF cu.arg3 IS NOT NULL
	  THEN
        IF cu.arg3 = 'PROGRAM'
		THEN
          lv_str := f_getidlist(tbl_program);
        ELSIF cu.arg3 = 'REWARD'
		THEN
          lv_str := f_getidlist(tbl_reward);
        ELSIF cu.arg3 = 'ACTIVITY'
		THEN
          lv_str := f_getidlist(tbl_activity);
        ELSIF cu.arg3 = 'ACTIVITYGROUP'
		THEN
          lv_str := f_getidlist(tbl_activitygroup);
        ELSIF cu.arg3 = 'ELIGIBILITY'
		THEN
          lv_str := f_getidlist(tbl_eligibility);
        END IF;
      END IF;

      IF lv_str IS NOT NULL
	  THEN
        lv_sqltext := f_getquerystring(cu.tablename, 'INSERT',cu.arg3)||lv_str||')';

        IF REGEXP_COUNT(lv_sqltext,'[(]') <> REGEXP_COUNT(lv_sqltext,'[)]')
		THEN
          lv_sqltext := lv_sqltext||')';
        END IF;

        IF lv_sqltext IS NOT NULL
		THEN
          lv_sql_insert := 'INSERT INTO incvsqlstatement_tmp (sequenceno, statementtypecd, tablename, sqltxt) SELECT incvsqlstatement_seq.nextval,''INSERT'','''||cu.tablename||''', t from ('||lv_sqltext||')';
          EXECUTE immediate lv_sql_insert;
        END IF;
      END IF;
    END IF;
  END LOOP;
  -- End INSERT SCRIPTS Insertion
  -- Start INCENTIVEOVERRIDE INSERT SCRIPTS Insertion
  FOR cu IN (SELECT tablename, argstmt1, argstmt2, argstmt3, arg1, arg2, arg3, sequenceno, actiontype
               FROM incvtablelist
			  WHERE actiontype = 'INSERT'
           ORDER BY sequenceno ASC)
  LOOP
    IF cu.argstmt1 IS NOT NULL
	THEN
      IF cu.arg1 IS NOT NULL
	  THEN
        IF cu.arg1 = 'PROGRAM'
		THEN
          lv_str := f_getsubqueryid(tbl_program, cu.tablename,cu.arg1,cu.sequenceno);
        ELSIF cu.arg1 = 'REWARD'
		THEN
          lv_str := f_getsubqueryid(tbl_reward, cu.tablename,cu.arg1,cu.sequenceno);
        ELSIF cu.arg1 = 'ACTIVITY'
		THEN
		  lv_str := f_getsubqueryid(tbl_activity, cu.tablename,cu.arg1,cu.sequenceno);
        ELSIF cu.arg1 = 'ACTIVITYGROUP'
		THEN
		  lv_str := f_getsubqueryid(tbl_activitygroup, cu.tablename,cu.arg1,cu.sequenceno);
        ELSIF cu.arg1 = 'ELIGIBILITY'
		THEN
		  lv_str := f_getsubqueryid(tbl_eligibility, cu.tablename,cu.arg1,cu.sequenceno);
        END IF;
      END IF;
    END IF;

    lv_str := '';

    IF cu.argstmt2 IS NOT NULL
	THEN
      IF cu.arg2 IS NOT NULL
	  THEN
        IF cu.arg2 = 'PROGRAM'
		THEN
          lv_str := f_getsubqueryid(tbl_program, cu.tablename,cu.arg2,cu.sequenceno);
        ELSIF cu.arg2 = 'REWARD'
		THEN
          lv_str := f_getsubqueryid(tbl_reward, cu.tablename,cu.arg2,cu.sequenceno);
        ELSIF cu.arg2 = 'ACTIVITY'
		THEN
          lv_str := f_getsubqueryid(tbl_activity, cu.tablename,cu.arg2,cu.sequenceno);
        ELSIF cu.arg2 = 'ACTIVITYGROUP'
		THEN
          lv_str := f_getsubqueryid(tbl_activitygroup, cu.tablename,cu.arg2,cu.sequenceno);
        ELSIF cu.arg2 = 'ELIGIBILITY'
		THEN
		  lv_str := f_getsubqueryid(tbl_eligibility, cu.tablename,cu.arg2,cu.sequenceno);
        END IF;
      END IF;
    END IF;

    lv_str := '';

    IF cu.argstmt3 IS NOT NULL
	THEN
      IF cu.arg3 IS NOT NULL
	  THEN
        IF cu.arg3 = 'PROGRAM'
		THEN
          lv_str := f_getsubqueryid(tbl_program, cu.tablename,cu.arg3,cu.sequenceno);
        ELSIF cu.arg3 = 'REWARD'
		THEN
          lv_str := f_getsubqueryid(tbl_reward, cu.tablename,cu.arg3,cu.sequenceno);
        ELSIF cu.arg3 = 'ACTIVITY'
		THEN
          lv_str := f_getsubqueryid(tbl_activity, cu.tablename,cu.arg3,cu.sequenceno);
        ELSIF cu.arg3 = 'ACTIVITYGROUP'
		THEN
          lv_str := f_getsubqueryid(tbl_activitygroup, cu.tablename,cu.arg3,cu.sequenceno);
        ELSIF cu.arg3 = 'ELIGIBILITY'
		THEN
		  lv_str := f_getsubqueryid(tbl_eligibility, cu.tablename,cu.arg3,cu.sequenceno);
        END IF;
      END IF;
    END IF;
  END LOOP;
  -- End INCENTIVEOVERRIDE INSERT SCRIPTS Insertion
  END IF;
EXCEPTION
WHEN OTHERS THEN
  pn_err_code_out := SQLCODE;
  pv_err_mesg_out := 'Error in incvpkg_dml.sp_insertdmlstatement => '||SQLERRM;
  ods.log_error ('incvpkg_dml.sp_insertdmlstatement',
                  pn_programid_in,
				  SQLCODE,
				  SUBSTR(('Program id ='||pn_programid_in||' - '||SQLERRM),1,255),
				  SYSDATE,
				  NULL);
END sp_insertdmlstatement;
PROCEDURE sp_getdmlstatement(pn_programid_in IN NUMBER,
	                                pv_result_out   OUT rc_cursor,
	                                pn_err_code_out	OUT		NUMBER,
									pv_err_mesg_out	OUT		VARCHAR2)
IS
lv_error_cd NUMBER;
lv_error_msg VARCHAR2(2000);
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE incvsqlstatement_tmp';
  -- Delete Script Generation and Insert into incvsqlstatement_tmp table
  sp_insertdmlstatement (pn_programid_in,'DELETE',lv_error_cd,lv_error_msg);
  -- Insert Script Generation and Insert into incvsqlstatement_tmp table
  sp_insertdmlstatement (pn_programid_in,'INSERT',lv_error_cd,lv_error_msg);

  IF lv_error_cd IS NULL THEN
    OPEN pv_result_out FOR
	  SELECT sqltxt
	    FROM incvsqlstatement_tmp
	   WHERE STATEMENTTYPECD IN('DELETE','INSERT')
	ORDER BY sequenceno;
  ELSE
   pn_err_code_out := lv_error_cd;
   pv_err_mesg_out := lv_error_msg;
   OPEN pv_result_out FOR
    SELECT null
	  FROM dual;
  END IF;

EXCEPTION
WHEN OTHERS THEN
  pn_err_code_out := SQLCODE;
  pv_err_mesg_out := 'Error in incvpkg_dml.sp_getdmlstatement => '||sqlerrm;
END sp_getdmlstatement;
END incv_dmlextract_pkg;
/


/*
DROP PACKAGE BODY INCV.INCV_PROGRAMCONFIGURATION_PKG;
*/

CREATE OR REPLACE PACKAGE BODY INCV.INCV_PROGRAMCONFIGURATION_PKG
AS
/******************************************************************************
   NAME      : INCV.INCV_PROGRAMCONFIGURATION_PKG
   PURPOSE   : This SP_SETINCENTIVECONFIGURATION procedure will be called from INCV app to configure the basic tables
   REVISIONS :
    Ver             Date            Author                  Description
    ---------       ----------      ---------------        ---------------------
    1.0             06/19/2018      Kader			        Initial Version 18.2
	1.1             07/19/2018      Kader                   For 18.3 User Story US113184
	1.2             08/10/2018      Kader                   For 18.3 User Story US112008
	1.3             08/20/2018      Kader                   For User Story US112432 (ODS Task)
	1.4             08/31/2018      Kader                   For User Story US113970
******************************************************************************/
PROCEDURE SP_SETINCENTIVECONFIGURATION
  (
    pt_programconfiguration_in IN incv.PROGRAM_CONFIGURATION_TAB,
	pn_oldprogramid_in         IN NUMBER,
	pv_programupdate_in        IN VARCHAR2,
    pn_newprogramid_out        OUT NUMBER,
	pn_oldprogramid_out        OUT VARCHAR2,
    pn_returncode_out          OUT NUMBER
  )
IS
  v_max_program_id          NUMBER;
  v_max_reward_id           NUMBER;
  v_max_goaltype_key        NUMBER;
  v_max_activitygroup_id    NUMBER;
  v_max_activity_id         NUMBER;
  v_max_goalvalue_key       NUMBER;
  v_max_message_id          NUMBER;
  v_max_att_key             NUMBER;
  v_max_child_activity_id   NUMBER;
  v_max_child_goalvalue_key NUMBER;
  v_max_child_att_key       NUMBER;
  v_max_child_message_id    NUMBER;
  v_max_ovr_key             NUMBER;
  v_oldprogramid            VARCHAR2(4000) := '';

   PROCEDURE setdebuginfo(
      lt_programconfiguration_in IN incv.PROGRAM_CONFIGURATION_TAB,
	  ln_oldprogramid_in         IN NUMBER,
	  lv_programupdate_in        IN VARCHAR2)
   AS
     PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      INSERT
       INTO incv.DBUG_SETINCENTIVECONFIGURATION
       (
        programconfiguration,
		oldprogramid,
		programupdate,
	    insertdate
       )
       VALUES
       (
        lt_programconfiguration_in,
		ln_oldprogramid_in,
		lv_programupdate_in,
		SYSTIMESTAMP
       );

     COMMIT;
   END;
BEGIN
   IF ods.fdebug ('SP_SETINCENTIVECONFIGURATION') = 'Y' THEN
     setdebuginfo (
				   lt_programconfiguration_in  => pt_programconfiguration_in,
                   ln_oldprogramid_in		   => pn_oldprogramid_in,
                   lv_programupdate_in         => pv_programupdate_in
				  );
   END IF;
   -- Return the old program ids list
   IF (pt_programconfiguration_in IS NOT NULL AND pt_programconfiguration_in.COUNT > 0)
   THEN
  	FOR u_pgm IN 1..pt_programconfiguration_in.COUNT
    LOOP
     IF (pt_programconfiguration_in(u_pgm).AHMSUPPLIERARRAY IS NOT NULL AND pt_programconfiguration_in(u_pgm).AHMSUPPLIERARRAY.COUNT > 0)
	 THEN
	  FOR u_pgm_ahm IN 1..pt_programconfiguration_in(u_pgm).AHMSUPPLIERARRAY.COUNT
	  LOOP

	   -- Update Old program id as per Input
	   IF pv_programupdate_in = 'Y' AND pn_oldprogramid_in IS NOT NULL THEN
		  UPDATE incv.program
			 SET PROGRAMEFFECTIVEDT = TRUNC(pt_programconfiguration_in(u_pgm).startdate) - interval '1' second,
				 PROGRAMENDDT = TRUNC(pt_programconfiguration_in(u_pgm).startdate) - interval '1' second,
				 UPDATEDDT = systimestamp,
				 UPDATEDBY = USER
		   WHERE programid = pn_oldprogramid_in;

		  UPDATE incv.SUPPLIERPROGRAMASSOC
			 SET EFFECTIVEDT = TRUNC(pt_programconfiguration_in(u_pgm).startdate) - interval '1' second,
				 ENDDT = TRUNC(pt_programconfiguration_in(u_pgm).startdate) - interval '1' second,
				 UPDATEDDT = add_months(pt_programconfiguration_in(u_pgm).enddate,12),
				 UPDATEDBY = USER
		   WHERE programid = pn_oldprogramid_in;
	   END IF;

	    FOR i IN (
            	  SELECT a.programid, b.ahmsupplierid
		            FROM INCV.program a,
			             INCV.SUPPLIERPROGRAMASSOC b
		           WHERE a.programid = b.programid
		             AND b.ahmsupplierid = pt_programconfiguration_in(u_pgm).ahmsupplierarray(u_pgm_ahm).ahmsupplierid
		             AND (
					      TRUNC(a.programeffectivedt) BETWEEN TRUNC(pt_programconfiguration_in(u_pgm).startdate) AND TRUNC(pt_programconfiguration_in(u_pgm).enddate)
		                  OR
						  TRUNC(a.programenddt) BETWEEN TRUNC(pt_programconfiguration_in(u_pgm).startdate) AND TRUNC(pt_programconfiguration_in(u_pgm).enddate)
						  )
					 AND TRIM(a.programeffectivedt) <> TRIM(a.programenddt)
				  )
		LOOP
		  IF v_oldprogramid IS NOT NULL THEN
            v_oldprogramid := v_oldprogramid || ',' ||i.programid;
          ELSE
            v_oldprogramid := i.programid;
          END IF;
        END LOOP;

	  END LOOP;
	 END IF;
	END LOOP;
   END IF;

   IF (pt_programconfiguration_in IS NOT NULL AND pt_programconfiguration_in.COUNT > 0)
   THEN
  	 FOR pgm IN 1..pt_programconfiguration_in.COUNT
     LOOP
	   SELECT MAX(programid)+1
	     INTO v_max_program_id
		 FROM INCV.PROGRAM;

		INSERT INTO INCV.PROGRAM
		(
		PROGRAMID,
		PROGRAMNM,
		PROGRAMEFFECTIVEDT,
		PROGRAMENDDT,
		INSERTEDDT,
		INSERTEDBY,
		UPDATEDDT,
		UPDATEDBY,
		DISPLAYDT
		)
		VALUES
		(
		v_max_program_id,
		pt_programconfiguration_in(pgm).displayname,
		pt_programconfiguration_in(pgm).startdate,
		pt_programconfiguration_in(pgm).enddate,
		systimestamp,
		USER,
		systimestamp,
		USER,
		pt_programconfiguration_in(pgm).displaydate
		);

		IF (pt_programconfiguration_in(pgm).PROGRAMATTRIBUTEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).PROGRAMATTRIBUTEARRAY.COUNT > 0)
		THEN
		  FOR pgm_att IN 1..pt_programconfiguration_in(pgm).PROGRAMATTRIBUTEARRAY.COUNT
		  LOOP

			SELECT MAX(INCENTIVEATTRIBUTESKEY)+1
	          INTO v_max_att_key
		      FROM INCV.INCENTIVEATTRIBUTE;

			INSERT INTO INCV.INCENTIVEATTRIBUTE
			(
			INCENTIVEGOALCATEGORYID,
			INCENTIVEGOALCATEGORYMNEMONIC,
			INCENTIVEATTRIBUTENM,
			ACTIVITYATTRIBDATATYPEMNEMONIC,
			INCENTIVEATTRIBUTEVAL,
			PARTICIPANTTYPEMNEMONIC,
			INSERTEDDT,
			INSERTEDBY,
			UPDATEDDT,
			UPDATEDBY,
			GENDER,
			INCENTIVEATTRIBUTESKEY,
			ATTRIBUTEVALJSONFLG
			)
			VALUES
			(
			v_max_program_id,
			'INCGOALCAT_PGM',
			pt_programconfiguration_in(pgm).PROGRAMATTRIBUTEARRAY(pgm_att).ATTRIBUTENAME,
			pt_programconfiguration_in(pgm).PROGRAMATTRIBUTEARRAY(pgm_att).ATTRIBDATATYPEMNEMONIC,
			pt_programconfiguration_in(pgm).PROGRAMATTRIBUTEARRAY(pgm_att).ATTRIBUTEVALUE,
			pt_programconfiguration_in(pgm).PROGRAMATTRIBUTEARRAY(pgm_att).MEMBERTYPE,
			systimestamp,
			USER,
			systimestamp,
			USER,
			pt_programconfiguration_in(pgm).PROGRAMATTRIBUTEARRAY(pgm_att).GENDER,
			v_max_att_key,
			'Y' --> Hard coded for Now
			);

		  END LOOP; -- pgm_att
		END IF; -- pgm_att IF

		IF (pt_programconfiguration_in(pgm).AHMSUPPLIERARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).AHMSUPPLIERARRAY.COUNT > 0)
		THEN
		  FOR pgm_ahm IN 1..pt_programconfiguration_in(pgm).AHMSUPPLIERARRAY.COUNT
		  LOOP
			INSERT INTO INCV.SUPPLIERPROGRAMASSOC
			(
			AHMSUPPLIERID,
			PROGRAMID,
			EFFECTIVEDT,
			ENDDT,
			INSERTEDDT,
			INSERTEDBY,
			UPDATEDDT,
			UPDATEDBY,
			SPOUSETREATEDASEMPIND,
			ISSPOUSEPARTNERAPPLICABLE
			)
			VALUES
			(
			pt_programconfiguration_in(pgm).ahmsupplierarray(pgm_ahm).ahmsupplierid,
			v_max_program_id,
			pt_programconfiguration_in(pgm).startdate,
			pt_programconfiguration_in(pgm).enddate,
			systimestamp,
			USER,
			add_months(pt_programconfiguration_in(pgm).enddate,12), -- As Per J mail on 09/08/18
			USER,
			NULL,
			'N' --> Hard Coded value as of now
			);

		  END LOOP; -- pgm_ahm
		END IF; -- -- pgm_ahm IF

		IF (pt_programconfiguration_in(pgm).REWARDARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY.COUNT > 0)
		THEN
		  FOR pgm_rwd IN 1..pt_programconfiguration_in(pgm).REWARDARRAY.COUNT
		  LOOP
		    SELECT MAX(rewardid)+1
			  INTO v_max_reward_id
			  FROM incv.REWARD;

			INSERT INTO incv.REWARD
			(
			REWARDID,
			REWARDNM,
			PROGRAMID,
			SORTORDERNBR,
			NOOFACTIVITIESTOCOMPLETE,
			REWARDEFFECTIVEDT,
			REWARDENDDT,
			INSERTEDDT,
			INSERTEDBY,
			UPDATEDDT,
			UPDATEDBY
			)
			VALUES
			(
			v_max_reward_id,
			pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).rewardname,
			v_max_program_id,
			pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).SORTORDERNBR,
			pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).NOOFACTIVITIESTOCOMPLETE,
			pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).startdate,
			pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).enddate,
			systimestamp,
			USER,
			systimestamp,
			USER
			);

			SELECT MAX(incentivegoaltypeskey)+1
			  INTO v_max_goaltype_key
			  FROM incv.INCENTIVEGOALTYPE;

			INSERT INTO incv.INCENTIVEGOALTYPE
			(
			INCENTIVEGOALTYPESKEY,
			GOALCATEGORYIDENTIFIER,
			GOALCATEGORYMNEMONIC,
			GOALTYPEMNEMONIC,
			VOIDFLG,
			INSERTEDDT,
			INSERTEDBY,
			UPDATEDDT,
			UPDATEDBY
			)
			VALUES
			(
			v_max_goaltype_key,
			v_max_reward_id,
			'INCGOALCAT_RWD',
			pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).REWARDTYPE,
			'IN',
			systimestamp,
			USER,
			systimestamp,
			USER
			);

			IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).REWARDATTRIBUTEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).REWARDATTRIBUTEARRAY.COUNT > 0)
			THEN
			  FOR pgm_rwd_att IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).REWARDATTRIBUTEARRAY.COUNT
			  LOOP

				SELECT MAX(INCENTIVEATTRIBUTESKEY)+1
				  INTO v_max_att_key
				  FROM INCV.INCENTIVEATTRIBUTE;

				INSERT INTO INCV.INCENTIVEATTRIBUTE
				(
				INCENTIVEGOALCATEGORYID,
				INCENTIVEGOALCATEGORYMNEMONIC,
				INCENTIVEATTRIBUTENM,
				ACTIVITYATTRIBDATATYPEMNEMONIC,
				INCENTIVEATTRIBUTEVAL,
				PARTICIPANTTYPEMNEMONIC,
				INSERTEDDT,
				INSERTEDBY,
				UPDATEDDT,
				UPDATEDBY,
				GENDER,
				INCENTIVEATTRIBUTESKEY,
				ATTRIBUTEVALJSONFLG
				)
				VALUES
				(
				v_max_reward_id,
				'INCGOALCAT_RWD',
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).REWARDATTRIBUTEARRAY(pgm_rwd_att).ATTRIBUTENAME,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).REWARDATTRIBUTEARRAY(pgm_rwd_att).ATTRIBDATATYPEMNEMONIC,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).REWARDATTRIBUTEARRAY(pgm_rwd_att).ATTRIBUTEVALUE,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).REWARDATTRIBUTEARRAY(pgm_rwd_att).MEMBERTYPE,
				systimestamp,
				USER,
				systimestamp,
				USER,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).REWARDATTRIBUTEARRAY(pgm_rwd_att).GENDER,
				v_max_att_key,
				'Y' --> Hard coded for Now
				);
			  END LOOP; -- pgm_rwd_att
            END IF; -- 	-- pgm_rwd_att IF

			IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES.COUNT > 0)
			THEN
			  FOR pgm_rwd_igl IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES.COUNT
			  LOOP

				SELECT MAX(INCENTIVEGOALVALUESKEY)+1
				  INTO v_max_goalvalue_key
				  FROM incv.INCENTIVEGOALVALUE;

				INSERT INTO incv.INCENTIVEGOALVALUE
				(
				INCENTIVEGOALCATEGORYID,
				INCENTIVEGOALCATEGORYMNEMONIC,
				PARTICIPANTTYPEMNEMONIC,
				INCENTIVEGOALMINVAL,
				INCENTIVEGOALMAXVAL,
				INSERTEDDT,
				INSERTEDBY,
				UPDATEDDT,
				UPDATEDBY,
				INCENTIVEGOALVALUESKEY,
				GOALTYPEMNEMONIC
				)
				VALUES
				(
				v_max_reward_id,
				'INCGOALCAT_RWD',
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).MEMBERTYPE,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).MINIMUMVALUE,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).MAXIMUMVALUE,
				systimestamp,
				USER,
				systimestamp,
				USER,
				v_max_goalvalue_key,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).INCENTIVESTYPE
				);

				IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).OVERRIDEVALUEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).OVERRIDEVALUEARRAY.COUNT > 0)
				THEN
				  FOR pgm_rwd_igl_ovr IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).OVERRIDEVALUEARRAY.COUNT
				  LOOP

					SELECT MAX(INCENTIVEOVERRIDESKEY)+1
					  INTO v_max_ovr_key
					  FROM INCV.INCENTIVEOVERRIDE;

					INSERT INTO INCV.INCENTIVEOVERRIDE
					(
					INCENTIVEOVERRIDESKEY,
					OVERRIDECATEGORYID,
					OVERRIDECATEGORYMNEMONIC,
					DIMENSIONTYPEMNEMONIC,
					DIMENSIONVAL,
					OVERRIDEVAL,
					PRIORITYNBR,
					VOIDFLG,
					INSERTEDDT,
					INSERTEDBY,
					UPDATEDDT,
					UPDATEDBY
					)
					VALUES
					(
					v_max_ovr_key,
					v_max_goalvalue_key,
					'OVERRIDECATG_GOALVAL',
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).OVERRIDEVALUEARRAY(pgm_rwd_igl_ovr).DIMENSIONTYPEMNEMONIC,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).OVERRIDEVALUEARRAY(pgm_rwd_igl_ovr).DIMENSIONVAL,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVESVALUES(pgm_rwd_igl).OVERRIDEVALUEARRAY(pgm_rwd_igl_ovr).OVERRIDEVAL,
					1,
					'IN',
					systimestamp,
					USER,
					systimestamp,
					USER
					);
				  END LOOP; -- pgm_rwd_igl_ovr
				END IF; -- pgm_rwd_igl_ovr IF
			  END LOOP; -- pgm_rwd_igl
			END IF; -- pgm_rwd_igl IF

			IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY.COUNT > 0)
			THEN
			  FOR pgm_rwd_grp IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY.COUNT
			  LOOP
			    SELECT MAX(ACTIVITYGROUPID)+1
				  INTO v_max_activitygroup_id
				  FROM incv.ACTIVITYGROUP;

				INSERT INTO incv.ACTIVITYGROUP
				(
				ACTIVITYGROUPID,
				ACTIVITYGROUPDESC,
				STARTDT,
				ENDDT,
				INSERTEDDT,
				INSERTEDBY,
				UPDATEDDT,
				UPDATEDBY,
				NOTREQUIREDCOUNT
				)
				VALUES
				(
				v_max_activitygroup_id,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYGROUPDESC,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).STARTDATE,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ENDDATE,
				systimestamp,
				USER,
				systimestamp,
				USER,
				0  --> Hard Coded as of now
				);

				INSERT INTO incv.REWARDACTIVITYGROUPXREF
				(
				REWARDID,
				ACTIVITYGROUPID,
				ASSOCIATIONEFFECTIVEDT,
				ASSOCIATIONENDDT,
				SORTORDERNBR,
				INSERTEDDT,
				INSERTEDBY,
				UPDATEDDT,
				UPDATEDBY
				)
				VALUES
				(
				v_max_reward_id,
				v_max_activitygroup_id,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).STARTDATE,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ENDDATE,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).SORTORDERNBR,
				systimestamp,
				USER,
				systimestamp,
				USER
				);

				IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES.COUNT > 0)
				THEN
				  FOR pgm_rwd_grp_igl IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES.COUNT
			      LOOP
					SELECT MAX(INCENTIVEGOALVALUESKEY)+1
					  INTO v_max_goalvalue_key
					  FROM incv.INCENTIVEGOALVALUE;

					INSERT INTO incv.INCENTIVEGOALVALUE
					(
					INCENTIVEGOALCATEGORYID,
					INCENTIVEGOALCATEGORYMNEMONIC,
					PARTICIPANTTYPEMNEMONIC,
					INCENTIVEGOALMINVAL,
					INCENTIVEGOALMAXVAL,
					INSERTEDDT,
					INSERTEDBY,
					UPDATEDDT,
					UPDATEDBY,
					INCENTIVEGOALVALUESKEY,
					GOALTYPEMNEMONIC
					)
					VALUES
					(
					v_max_activitygroup_id,
					'INCGOALCAT_GRP',
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).MEMBERTYPE,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).MINIMUMVALUE,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).MAXIMUMVALUE,
					systimestamp,
					USER,
					systimestamp,
					USER,
					v_max_goalvalue_key,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).INCENTIVESTYPE
					);

					IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).OVERRIDEVALUEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).OVERRIDEVALUEARRAY.COUNT > 0)
					THEN
					  FOR pgm_rwd_grp_igl_ovr IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).OVERRIDEVALUEARRAY.COUNT
					  LOOP

						SELECT MAX(INCENTIVEOVERRIDESKEY)+1
						  INTO v_max_ovr_key
						  FROM INCV.INCENTIVEOVERRIDE;

						INSERT INTO INCV.INCENTIVEOVERRIDE
						(
						INCENTIVEOVERRIDESKEY,
						OVERRIDECATEGORYID,
						OVERRIDECATEGORYMNEMONIC,
						DIMENSIONTYPEMNEMONIC,
						DIMENSIONVAL,
						OVERRIDEVAL,
						PRIORITYNBR,
						VOIDFLG,
						INSERTEDDT,
						INSERTEDBY,
						UPDATEDDT,
						UPDATEDBY
						)
						VALUES
						(
						v_max_ovr_key,
						v_max_goalvalue_key,
						'OVERRIDECATG_GOALVAL',
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).OVERRIDEVALUEARRAY(pgm_rwd_grp_igl_ovr).DIMENSIONTYPEMNEMONIC,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).OVERRIDEVALUEARRAY(pgm_rwd_grp_igl_ovr).DIMENSIONVAL,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).INCENTIVESVALUES(pgm_rwd_grp_igl).OVERRIDEVALUEARRAY(pgm_rwd_grp_igl_ovr).OVERRIDEVAL,
						1,
						'IN',
						systimestamp,
						USER,
						systimestamp,
						USER
						);
					  END LOOP; -- pgm_rwd_grp_igl_ovr
					END IF; -- pgm_rwd_grp_igl_ovr IF
				  END LOOP; -- pgm_rwd_grp_igl
				END IF; -- -- pgm_rwd_grp_igl IF

				IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYATTRIBUTEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYATTRIBUTEARRAY.COUNT > 0)
				THEN
				  FOR pgm_rwd_grp_att IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYATTRIBUTEARRAY.COUNT
				  LOOP

					SELECT MAX(INCENTIVEATTRIBUTESKEY)+1
					  INTO v_max_att_key
					  FROM INCV.INCENTIVEATTRIBUTE;

					INSERT INTO INCV.INCENTIVEATTRIBUTE
					(
					INCENTIVEGOALCATEGORYID,
					INCENTIVEGOALCATEGORYMNEMONIC,
					INCENTIVEATTRIBUTENM,
					ACTIVITYATTRIBDATATYPEMNEMONIC,
					INCENTIVEATTRIBUTEVAL,
					PARTICIPANTTYPEMNEMONIC,
					INSERTEDDT,
					INSERTEDBY,
					UPDATEDDT,
					UPDATEDBY,
					GENDER,
					INCENTIVEATTRIBUTESKEY,
					ATTRIBUTEVALJSONFLG
					)
					VALUES
					(
					v_max_activitygroup_id,
					'INCGOALCAT_GRP',
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_att).ATTRIBUTENAME,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_att).ATTRIBDATATYPEMNEMONIC,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_att).ATTRIBUTEVALUE,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_att).MEMBERTYPE,
					systimestamp,
					USER,
					systimestamp,
					USER,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_att).GENDER,
					v_max_att_key,
					'Y' --> Hard coded for Now
					);

				  END LOOP; -- pgm_rwd_grp_att
				END IF; -- -- pgm_rwd_grp_att IF

				IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY.COUNT > 0)
				THEN
				  FOR pgm_rwd_grp_act IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY.COUNT
				  LOOP
				    SELECT MAX(activityid)+1
					  INTO v_max_activity_id
					  FROM incv.ACTIVITY;

					INSERT INTO incv.ACTIVITY
					(
					ACTIVITYID,
					ACTIVITYDESC,
					ACTIVITYTITLETXT,
					ACTIVITYTYPEMNEMONIC,
					STARTDT,
					ENDDT,
					NUMBEROFOCCURANCE,
					FREQUENCYMNEMONIC,
					INSERTEDDT,
					INSERTEDBY,
					UPDATEDDT,
					UPDATEDBY,
					GENDER,
					MINREQUIREDOCCURRENCE
					)
					VALUES
					(
					v_max_activity_id,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYDESC,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYTITLETXT,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYTYPEMNEMONIC,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).STARTDATE,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ENDDATE,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).NUMBEROFOCCURANCE,
					NULL,
					systimestamp,
					USER,
					systimestamp,
					USER,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).GENDER,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).MINREQUIREDOCCURRENCE
					);

					INSERT INTO incv.ACTIVITYGROUPACTIVITYXREF
					(
					ACTIVITYGROUPID,
					ACTIVITYID,
					REQUIREDYNIND,
					SORTORDERNBR,
					INSERTEDDT,
					INSERTEDBY,
					UPDATEDDT,
					UPDATEDBY
					)
					VALUES
					(
					v_max_activitygroup_id,
					v_max_activity_id,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).REQUIREDYNIND,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).SORTORDERNBR,
					systimestamp,
					USER,
					systimestamp,
					USER
					);

					IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY.COUNT > 0)
					THEN
					  FOR pgm_rwd_grp_act_att IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY.COUNT
					  LOOP

						SELECT MAX(INCENTIVEATTRIBUTESKEY)+1
						  INTO v_max_att_key
						  FROM INCV.INCENTIVEATTRIBUTE;

						INSERT INTO INCV.INCENTIVEATTRIBUTE
						(
						INCENTIVEGOALCATEGORYID,
						INCENTIVEGOALCATEGORYMNEMONIC,
						INCENTIVEATTRIBUTENM,
						ACTIVITYATTRIBDATATYPEMNEMONIC,
						INCENTIVEATTRIBUTEVAL,
						PARTICIPANTTYPEMNEMONIC,
						INSERTEDDT,
						INSERTEDBY,
						UPDATEDDT,
						UPDATEDBY,
						GENDER,
						INCENTIVEATTRIBUTESKEY,
						ATTRIBUTEVALJSONFLG
						)
						VALUES
						(
						v_max_activity_id,
						'INCGOALCAT_ACT',
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).ATTRIBUTENAME,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).ATTRIBDATATYPEMNEMONIC,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).ATTRIBUTEVALUE,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).MEMBERTYPE,
						systimestamp,
						USER,
						systimestamp,
						USER,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).GENDER,
						v_max_att_key,
						'Y' --> Hard coded for Now
						);

					    IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).OVERRIDEVALUEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).OVERRIDEVALUEARRAY.COUNT > 0)
					    THEN
						  FOR pgm_rwd_grp_act_att_ovr IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).OVERRIDEVALUEARRAY.COUNT
						  LOOP

							SELECT MAX(INCENTIVEOVERRIDESKEY)+1
							  INTO v_max_ovr_key
							  FROM INCV.INCENTIVEOVERRIDE;

							INSERT INTO INCV.INCENTIVEOVERRIDE
							(
							INCENTIVEOVERRIDESKEY,
							OVERRIDECATEGORYID,
							OVERRIDECATEGORYMNEMONIC,
							DIMENSIONTYPEMNEMONIC,
							DIMENSIONVAL,
							OVERRIDEVAL,
							PRIORITYNBR,
							VOIDFLG,
							INSERTEDDT,
							INSERTEDBY,
							UPDATEDDT,
							UPDATEDBY
							)
							VALUES
							(
							v_max_ovr_key,
							v_max_att_key,
							'OVERRIDECATG_ATTRIBUTE',
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_att_ovr).DIMENSIONTYPEMNEMONIC,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_att_ovr).DIMENSIONVAL,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_att).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_att_ovr).OVERRIDEVAL,
							1,
							'IN',
							systimestamp,
							USER,
							systimestamp,
							USER
							);
					      END LOOP; -- pgm_rwd_grp_act_att_ovr
                        END IF; -- pgm_rwd_grp_act_att_ovr IF
					  END LOOP; -- pgm_rwd_grp_act_att
                    END IF; -- pgm_rwd_grp_act_att IF

					IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).DEPENDENTACTIVITYCOUNT IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).DEPENDENTACTIVITYCOUNT > 0)
					THEN
						INSERT INTO incv.ACTIVITYDETAIL
						(
						ACTIVITYID,
						DEPENDENTACTIVITYCOUNT,
						INSERTEDDT,
						INSERTEDBY,
						UPDATEDDT,
						UPDATEDBY
						)
						VALUES
						(
						v_max_activity_id,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).DEPENDENTACTIVITYCOUNT,
						systimestamp,
						USER,
						systimestamp,
						USER
						);
					END IF;
-- *** Child Activity Starts ***
-- *********Start **************
					IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY.COUNT > 0)
					THEN
					  FOR pgm_rwd_grp_act_child IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY.COUNT
				      LOOP
				       SELECT MAX(activityid)+1
					     INTO v_max_child_activity_id
					     FROM incv.ACTIVITY;

						INSERT INTO incv.ACTIVITY
						(
						ACTIVITYID,
						ACTIVITYDESC,
						ACTIVITYTITLETXT,
						ACTIVITYTYPEMNEMONIC,
						STARTDT,
						ENDDT,
						NUMBEROFOCCURANCE,
						FREQUENCYMNEMONIC,
						INSERTEDDT,
						INSERTEDBY,
						UPDATEDDT,
						UPDATEDBY,
						GENDER,
						MINREQUIREDOCCURRENCE
						)
						VALUES
						(
						v_max_child_activity_id,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYDESC,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYTITLETXT,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYTYPEMNEMONIC,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).STARTDATE,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ENDDATE,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).NUMBEROFOCCURANCE,
						NULL,
						systimestamp,
						USER,
						systimestamp,
						USER,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).GENDER,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).MINREQUIREDOCCURRENCE
						);

						INSERT INTO incv.RELATEDACTIVITYXREF
						(
						ACTIVITYID,
						RELATEDACTIVITYID,
						REQUIREDYNIND,
						RELATIONTYPEMNEMONIC,
						INSERTEDDT,
						INSERTEDBY,
						UPDATEDDT,
						UPDATEDBY
						)
						VALUES
						(
						v_max_activity_id,
						v_max_child_activity_id,
						'N',
						'RELTYPE_PARENT',
						systimestamp,
						USER,
						systimestamp,
						USER
						);
						-- For User Story US112432 (ODS Task)
						-- Mapping Child activities to the main activity group
						INSERT INTO incv.ACTIVITYGROUPACTIVITYXREF
						(
						ACTIVITYGROUPID,
						ACTIVITYID,
						REQUIREDYNIND,
						SORTORDERNBR,
						INSERTEDDT,
						INSERTEDBY,
						UPDATEDDT,
						UPDATEDBY
						)
						VALUES
						(
						v_max_activitygroup_id,
						v_max_child_activity_id,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).REQUIREDYNIND,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).SORTORDERNBR,
						systimestamp,
						USER,
						systimestamp,
						USER
						);

				        IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES.COUNT > 0)
				        THEN
				          FOR pgm_rwd_grp_act_child_igl IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES.COUNT
			              LOOP
							SELECT MAX(INCENTIVEGOALVALUESKEY)+1
							  INTO v_max_child_goalvalue_key
							  FROM incv.INCENTIVEGOALVALUE;

							INSERT INTO incv.INCENTIVEGOALVALUE
							(
							INCENTIVEGOALCATEGORYID,
							INCENTIVEGOALCATEGORYMNEMONIC,
							PARTICIPANTTYPEMNEMONIC,
							INCENTIVEGOALMINVAL,
							INCENTIVEGOALMAXVAL,
							INSERTEDDT,
							INSERTEDBY,
							UPDATEDDT,
							UPDATEDBY,
							INCENTIVEGOALVALUESKEY,
							GOALTYPEMNEMONIC
							)
							VALUES
							(
							v_max_child_activity_id,
							'INCGOALCAT_ACT',
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).MEMBERTYPE,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).MINIMUMVALUE,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).MAXIMUMVALUE,
							systimestamp,
							USER,
							systimestamp,
							USER,
							v_max_child_goalvalue_key,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).INCENTIVESTYPE
							);

							IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).OVERRIDEVALUEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).OVERRIDEVALUEARRAY.COUNT > 0)
							THEN
							  FOR pgm_rwd_grp_act_child_igl_ovr IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).OVERRIDEVALUEARRAY.COUNT
							  LOOP

								SELECT MAX(INCENTIVEOVERRIDESKEY)+1
								  INTO v_max_ovr_key
								  FROM INCV.INCENTIVEOVERRIDE;

								INSERT INTO INCV.INCENTIVEOVERRIDE
								(
								INCENTIVEOVERRIDESKEY,
								OVERRIDECATEGORYID,
								OVERRIDECATEGORYMNEMONIC,
								DIMENSIONTYPEMNEMONIC,
								DIMENSIONVAL,
								OVERRIDEVAL,
								PRIORITYNBR,
								VOIDFLG,
								INSERTEDDT,
								INSERTEDBY,
								UPDATEDDT,
								UPDATEDBY
								)
								VALUES
								(
								v_max_ovr_key,
								v_max_child_goalvalue_key,
								'OVERRIDECATG_GOALVAL',
								pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_child_igl_ovr).DIMENSIONTYPEMNEMONIC,
								pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_child_igl_ovr).DIMENSIONVAL,
								pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).INCENTIVESVALUES(pgm_rwd_grp_act_child_igl).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_child_igl_ovr).OVERRIDEVAL,
								1,
								'IN',
								systimestamp,
								USER,
								systimestamp,
								USER
								);
							  END LOOP; -- pgm_rwd_grp_act_child_igl_ovr
							END IF; -- pgm_rwd_grp_act_child_igl_ovr IF
				          END LOOP; -- pgm_rwd_grp_act_child_igl
				        END IF; -- -- pgm_rwd_grp_act_child_igl IF

						IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY.COUNT > 0)
				        THEN
				          FOR pgm_rwd_grp_act_child_att IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY.COUNT
				          LOOP
							SELECT MAX(INCENTIVEATTRIBUTESKEY)+1
							  INTO v_max_child_att_key
							  FROM INCV.INCENTIVEATTRIBUTE;

							INSERT INTO INCV.INCENTIVEATTRIBUTE
							(
							INCENTIVEGOALCATEGORYID,
							INCENTIVEGOALCATEGORYMNEMONIC,
							INCENTIVEATTRIBUTENM,
							ACTIVITYATTRIBDATATYPEMNEMONIC,
							INCENTIVEATTRIBUTEVAL,
							PARTICIPANTTYPEMNEMONIC,
							INSERTEDDT,
							INSERTEDBY,
							UPDATEDDT,
							UPDATEDBY,
							GENDER,
							INCENTIVEATTRIBUTESKEY,
							ATTRIBUTEVALJSONFLG
							)
							VALUES
							(
							v_max_child_activity_id, --> Need to check with Arun
							'INCGOALCAT_ACT',       --> Need to check with Arun
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).ATTRIBUTENAME,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).ATTRIBDATATYPEMNEMONIC,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).ATTRIBUTEVALUE,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).MEMBERTYPE,
							systimestamp,
							USER,
							systimestamp,
							USER,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).GENDER,
							v_max_child_att_key,
							'Y' --> Hard coded for Now
							);

							IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).OVERRIDEVALUEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).OVERRIDEVALUEARRAY.COUNT > 0)
							THEN
							  FOR pgm_rwd_grp_act_child_att_ovr IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).OVERRIDEVALUEARRAY.COUNT
							  LOOP

								SELECT MAX(INCENTIVEOVERRIDESKEY)+1
								  INTO v_max_ovr_key
								  FROM INCV.INCENTIVEOVERRIDE;

								INSERT INTO INCV.INCENTIVEOVERRIDE
								(
								INCENTIVEOVERRIDESKEY,
								OVERRIDECATEGORYID,
								OVERRIDECATEGORYMNEMONIC,
								DIMENSIONTYPEMNEMONIC,
								DIMENSIONVAL,
								OVERRIDEVAL,
								PRIORITYNBR,
								VOIDFLG,
								INSERTEDDT,
								INSERTEDBY,
								UPDATEDDT,
								UPDATEDBY
								)
								VALUES
								(
								v_max_ovr_key,
								v_max_child_att_key,
								'OVERRIDECATG_ATTRIBUTE',
								pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_child_att_ovr).DIMENSIONTYPEMNEMONIC,
								pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_child_att_ovr).DIMENSIONVAL,
								pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYATTRIBUTEARRAY(pgm_rwd_grp_act_child_att).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_child_att_ovr).OVERRIDEVAL,
								1,
								'IN',
								systimestamp,
								USER,
								systimestamp,
								USER
								);
							  END LOOP; -- pgm_rwd_grp_act_child_att_ovr
							END IF; -- pgm_rwd_grp_act_child_att_ovr IF
				          END LOOP; -- pgm_rwd_grp_act_child_att
				        END IF; -- -- pgm_rwd_grp_act_child_att IF

					    IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY.COUNT > 0)
					    THEN
					      FOR pgm_rwd_grp_act_child_msg IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY.COUNT
					      LOOP
							SELECT MAX(INCENTIVEMESSAGEID)+1
							  INTO v_max_child_message_id
							  FROM incv.INCENTIVEMESSAGE;

							INSERT INTO incv.INCENTIVEMESSAGE
							(
							INCENTIVEMESSAGEID,
							AHMSUPPLIERID,
							INCENTIVEGOALCATEGORYID,
							INCENTIVEGOALCATEGORYMNEMONIC,
							LANGUAGEMNEMONIC,
							LONGTITLETXT,
							SHORTTITLETXT,
							ADDITIONALINFOTXT,
							VOIDFLG,
							INSERTEDDT,
							INSERTEDBY,
							UPDATEDDT,
							UPDATEDBY
							)
							VALUES
							(
							v_max_child_message_id,
							NULL,
							v_max_child_activity_id,
							'INCGOALCAT_ACT',
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_child_msg).LANGUAGEMNEMONIC,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_child_msg).LONGTITLETXT,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_child_msg).SHORTTITLETXT,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_child_msg).ADDITIONALINFOTXT,
							'IN',
							systimestamp,
							USER,
							systimestamp,
							USER
							);

					        IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_child_msg).INCENTIVEMESSAGEATTRARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_child_msg).INCENTIVEMESSAGEATTRARRAY.COUNT > 0)
						    THEN
							  FOR pgm_rwd_grp_act_child_msg_att IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_child_msg).INCENTIVEMESSAGEATTRARRAY.COUNT
							  LOOP
						        INSERT INTO incv.INCENTIVEMESSAGEATTR
								(
								INCENTIVEMESSAGEID,
								MESSAGEATTRIBUTENM,
								MESSAGEATTRIBUTEVAL,
								VOIDFLG,
								INSERTEDDT,
								INSERTEDBY,
								UPDATEDDT,
								UPDATEDBY
								)
								VALUES
								(
								v_max_child_message_id,
								pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_child_msg).INCENTIVEMESSAGEATTRARRAY(pgm_rwd_grp_act_child_msg_att).MESSAGEATTRIBUTENM,
								pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).CHILDACTIVITYARRAY(pgm_rwd_grp_act_child).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_child_msg).INCENTIVEMESSAGEATTRARRAY(pgm_rwd_grp_act_child_msg_att).MESSAGEATTRIBUTEVAL,
								'IN',
								systimestamp,
								USER,
								systimestamp,
								USER
								);
					          END LOOP; -- pgm_rwd_grp_act_child_msg_att
						    END IF; -- -- pgm_rwd_grp_act_child_msg_att IF
					      END LOOP; -- pgm_rwd_grp_act_child_msg
					    END IF; -- -- pgm_rwd_grp_act_child_msg IF
					  END LOOP; -- pgm_rwd_grp_act_child
                    END IF; -- -- pgm_rwd_grp_act_child
-- Child Activity Ends
-- ********* End **************
					IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES.COUNT > 0)
					THEN
					  FOR pgm_rwd_grp_act_igl IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES.COUNT
				      LOOP

						SELECT MAX(INCENTIVEGOALVALUESKEY)+1
						  INTO v_max_goalvalue_key
						  FROM incv.INCENTIVEGOALVALUE;

						INSERT INTO incv.INCENTIVEGOALVALUE
						(
						INCENTIVEGOALCATEGORYID,
						INCENTIVEGOALCATEGORYMNEMONIC,
						PARTICIPANTTYPEMNEMONIC,
						INCENTIVEGOALMINVAL,
						INCENTIVEGOALMAXVAL,
						INSERTEDDT,
						INSERTEDBY,
						UPDATEDDT,
						UPDATEDBY,
						INCENTIVEGOALVALUESKEY,
						GOALTYPEMNEMONIC
						)
						VALUES
						(
						v_max_activity_id,
						'INCGOALCAT_ACT',
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).MEMBERTYPE,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).MINIMUMVALUE,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).MAXIMUMVALUE,
						systimestamp,
						USER,
						systimestamp,
						USER,
						v_max_goalvalue_key,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).INCENTIVESTYPE
						);

					    IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).OVERRIDEVALUEARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).OVERRIDEVALUEARRAY.COUNT > 0)
					    THEN
						  FOR pgm_rwd_grp_act_igl_ovr IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).OVERRIDEVALUEARRAY.COUNT
						  LOOP

							SELECT MAX(INCENTIVEOVERRIDESKEY)+1
							  INTO v_max_ovr_key
							  FROM INCV.INCENTIVEOVERRIDE;

							INSERT INTO INCV.INCENTIVEOVERRIDE
							(
							INCENTIVEOVERRIDESKEY,
							OVERRIDECATEGORYID,
							OVERRIDECATEGORYMNEMONIC,
							DIMENSIONTYPEMNEMONIC,
							DIMENSIONVAL,
							OVERRIDEVAL,
							PRIORITYNBR,
							VOIDFLG,
							INSERTEDDT,
							INSERTEDBY,
							UPDATEDDT,
							UPDATEDBY
							)
							VALUES
							(
							v_max_ovr_key,
							v_max_goalvalue_key,
							'OVERRIDECATG_GOALVAL',
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_igl_ovr).DIMENSIONTYPEMNEMONIC,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_igl_ovr).DIMENSIONVAL,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).INCENTIVESVALUES(pgm_rwd_grp_act_igl).OVERRIDEVALUEARRAY(pgm_rwd_grp_act_igl_ovr).OVERRIDEVAL,
							1,
							'IN',
							systimestamp,
							USER,
							systimestamp,
							USER
							);
					      END LOOP; -- pgm_rwd_grp_act_igl_ovr
                        END IF; -- pgm_rwd_grp_act_igl_ovr IF
				      END LOOP; -- pgm_rwd_grp_act_igl
					END IF; -- pgm_rwd_grp_act_igl IF

					IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY.COUNT > 0)
					THEN
					  FOR pgm_rwd_grp_act_msg IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY.COUNT
					  LOOP

						SELECT MAX(INCENTIVEMESSAGEID)+1
						  INTO v_max_message_id
						  FROM incv.INCENTIVEMESSAGE;

						INSERT INTO incv.INCENTIVEMESSAGE
						(
						INCENTIVEMESSAGEID,
						AHMSUPPLIERID,
						INCENTIVEGOALCATEGORYID,
						INCENTIVEGOALCATEGORYMNEMONIC,
						LANGUAGEMNEMONIC,
						LONGTITLETXT,
						SHORTTITLETXT,
						ADDITIONALINFOTXT,
						VOIDFLG,
						INSERTEDDT,
						INSERTEDBY,
						UPDATEDDT,
						UPDATEDBY
						)
						VALUES
						(
						v_max_message_id,
						NULL,
						v_max_activity_id,
						'INCGOALCAT_ACT',
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_msg).LANGUAGEMNEMONIC,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_msg).LONGTITLETXT,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_msg).SHORTTITLETXT,
						pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_msg).ADDITIONALINFOTXT,
						'IN',
						systimestamp,
						USER,
						systimestamp,
						USER
						);

					    IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_msg).INCENTIVEMESSAGEATTRARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_msg).INCENTIVEMESSAGEATTRARRAY.COUNT > 0)
						THEN
						  FOR pgm_rwd_grp_act_msg_att IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_msg).INCENTIVEMESSAGEATTRARRAY.COUNT
                          LOOP

							INSERT INTO incv.INCENTIVEMESSAGEATTR
							(
							INCENTIVEMESSAGEID,
							MESSAGEATTRIBUTENM,
							MESSAGEATTRIBUTEVAL,
							VOIDFLG,
							INSERTEDDT,
							INSERTEDBY,
							UPDATEDDT,
							UPDATEDBY
							)
							VALUES
							(
							v_max_message_id,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_msg).INCENTIVEMESSAGEATTRARRAY(pgm_rwd_grp_act_msg_att).MESSAGEATTRIBUTENM,
							pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).ACTIVITYGROUPARRAY(pgm_rwd_grp).ACTIVITYARRAY(pgm_rwd_grp_act).ACTIVITYMESSAGESARRAY(pgm_rwd_grp_act_msg).INCENTIVEMESSAGEATTRARRAY(pgm_rwd_grp_act_msg_att).MESSAGEATTRIBUTEVAL,
							'IN',
							systimestamp,
							USER,
							systimestamp,
							USER
							);
					      END LOOP; -- pgm_rwd_grp_act_msg_att
						END IF; -- -- pgm_rwd_grp_act_msg_att IF
					  END LOOP; -- pgm_rwd_grp_act_msg
					END IF; -- -- pgm_rwd_grp_act_msg IF
				  END LOOP; -- pgm_rwd_grp_act
				END IF; -- pgm_rwd_grp_act IF
			  END LOOP; -- pgm_rwd_grp
			END IF; -- pgm_rwd_grp IF

            IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY.COUNT > 0)
			THEN
			  FOR pgm_rwd_msg IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY.COUNT
			  LOOP
				SELECT MAX(INCENTIVEMESSAGEID)+1
				  INTO v_max_message_id
				  FROM incv.INCENTIVEMESSAGE;

				INSERT INTO incv.INCENTIVEMESSAGE
				(
				INCENTIVEMESSAGEID,
				AHMSUPPLIERID,
				INCENTIVEGOALCATEGORYID,
				INCENTIVEGOALCATEGORYMNEMONIC,
				LANGUAGEMNEMONIC,
				LONGTITLETXT,
				SHORTTITLETXT,
				ADDITIONALINFOTXT,
				VOIDFLG,
				INSERTEDDT,
				INSERTEDBY,
				UPDATEDDT,
				UPDATEDBY
				)
				VALUES
				(
				v_max_message_id,
				NULL,
				v_max_reward_id,
				'INCGOALCAT_RWD',
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY(pgm_rwd_msg).LANGUAGEMNEMONIC,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY(pgm_rwd_msg).LONGTITLETXT,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY(pgm_rwd_msg).SHORTTITLETXT,
				pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY(pgm_rwd_msg).ADDITIONALINFOTXT,
				'IN',
				systimestamp,
				USER,
				systimestamp,
				USER
				);

				IF (pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY(pgm_rwd_msg).INCENTIVEMESSAGEATTRARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY(pgm_rwd_msg).INCENTIVEMESSAGEATTRARRAY.COUNT > 0)
				THEN
				  FOR pgm_rwd_msg_att IN 1..pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY(pgm_rwd_msg).INCENTIVEMESSAGEATTRARRAY.COUNT
				  LOOP
					INSERT INTO incv.INCENTIVEMESSAGEATTR
					(
					INCENTIVEMESSAGEID,
					MESSAGEATTRIBUTENM,
					MESSAGEATTRIBUTEVAL,
					VOIDFLG,
					INSERTEDDT,
					INSERTEDBY,
					UPDATEDDT,
					UPDATEDBY
					)
					VALUES
					(
					v_max_message_id,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY(pgm_rwd_msg).INCENTIVEMESSAGEATTRARRAY(pgm_rwd_msg_att).MESSAGEATTRIBUTENM,
					pt_programconfiguration_in(pgm).REWARDARRAY(pgm_rwd).INCENTIVEMESSAGESARRAY(pgm_rwd_msg).INCENTIVEMESSAGEATTRARRAY(pgm_rwd_msg_att).MESSAGEATTRIBUTEVAL,
					'IN',
					systimestamp,
					USER,
					systimestamp,
					USER
					);
				  END LOOP; -- pgm_rwd_msg_att
				END IF; -- -- pgm_rwd_msg_att IF
			  END LOOP; -- pgm_rwd_msg
		    END IF; -- -- pgm_rwd_msg IF

		  END LOOP; -- pgm_rwd
		END IF; -- pgm_rwd IF

        IF (pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY.COUNT > 0)
		THEN
		  FOR pgm_msg IN 1..pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY.COUNT
		  LOOP
			SELECT MAX(INCENTIVEMESSAGEID)+1
			  INTO v_max_message_id
			  FROM incv.INCENTIVEMESSAGE;

			INSERT INTO incv.INCENTIVEMESSAGE
			(
			INCENTIVEMESSAGEID,
			AHMSUPPLIERID,
			INCENTIVEGOALCATEGORYID,
			INCENTIVEGOALCATEGORYMNEMONIC,
			LANGUAGEMNEMONIC,
			LONGTITLETXT,
			SHORTTITLETXT,
			ADDITIONALINFOTXT,
			VOIDFLG,
			INSERTEDDT,
			INSERTEDBY,
			UPDATEDDT,
			UPDATEDBY
			)
			VALUES
			(
			v_max_message_id,
			NULL,
			v_max_program_id,
			'INCGOALCAT_PGM',
			pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY(pgm_msg).LANGUAGEMNEMONIC,
			pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY(pgm_msg).LONGTITLETXT,
			pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY(pgm_msg).SHORTTITLETXT,
			pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY(pgm_msg).ADDITIONALINFOTXT,
			'IN',
			systimestamp,
			USER,
			systimestamp,
			USER
			);

			IF (pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY(pgm_msg).INCENTIVEMESSAGEATTRARRAY IS NOT NULL AND pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY(pgm_msg).INCENTIVEMESSAGEATTRARRAY.COUNT > 0)
			THEN
			  FOR pgm_msg_att IN 1..pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY(pgm_msg).INCENTIVEMESSAGEATTRARRAY.COUNT
			  LOOP
				INSERT INTO incv.INCENTIVEMESSAGEATTR
				(
				INCENTIVEMESSAGEID,
				MESSAGEATTRIBUTENM,
				MESSAGEATTRIBUTEVAL,
				VOIDFLG,
				INSERTEDDT,
				INSERTEDBY,
				UPDATEDDT,
				UPDATEDBY
				)
				VALUES
				(
				v_max_message_id,
				pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY(pgm_msg).INCENTIVEMESSAGEATTRARRAY(pgm_msg_att).MESSAGEATTRIBUTENM,
				pt_programconfiguration_in(pgm).INCENTIVEMESSAGESARRAY(pgm_msg).INCENTIVEMESSAGEATTRARRAY(pgm_msg_att).MESSAGEATTRIBUTEVAL,
				'IN',
				systimestamp,
				USER,
				systimestamp,
				USER
				);
			  END LOOP; -- pgm_msg_att
			END IF; -- -- pgm_msg_att IF
		  END LOOP; -- pgm_msg
		END IF; -- -- pgm_msg IF

	 END LOOP; -- pgm
   END IF; -- pgm IF


	pn_newprogramid_out := v_max_program_id;
	pn_oldprogramid_out := v_oldprogramid;
    -- Return Code as 10000
	pn_returncode_out := ods.ct_core.ferrorcodesct ('ALL', 'SUCCESSFUL');

    EXCEPTION
    WHEN OTHERS
    THEN
	    ROLLBACK;
        ods.log_error ('INCV_PROGRAMCONFIGURATION_PKG.SP_SETINCENTIVECONFIGURATION',
	   	               NULL,
                       SQLCODE,
					   substr(('Program Id='||v_max_program_id||' '||SQLERRM),1,255),
                       SYSDATE,
                       NULL);
        -- Return Code as 10004
        pn_returncode_out := ods.ct_core.ferrorcodesct ('ALL', 'NOT SUCCESSFUL');
END SP_SETINCENTIVECONFIGURATION;

 PROCEDURE SP_DELETEPASTPROGRAM
 (
   pt_programid_in            IN INCV.PROGRAMLIST_TAB,
   pn_returncode_out          OUT NUMBER
 )
 AS
   lv_error_cd  NUMBER;
   lv_error_msg VARCHAR2(2000);
   v_sql        VARCHAR2(4000);
 BEGIN
   IF (pt_programid_in IS NOT NULL AND pt_programid_in.COUNT > 0)
   THEN
      FOR del_pgm IN 1..pt_programid_in.COUNT
      LOOP
	     -- Generating DELETE scripts
         INCV.incv_dmlextract_pkg.sp_insertdmlstatement (pt_programid_in(del_pgm).programid,'DELETE',lv_error_cd,lv_error_msg);
		 -- Executing DELETE Scripts
		 FOR i IN (select sqltxt from INCV.INCVSQLSTATEMENT_TMP order by sequenceno)
         LOOP
		    v_sql := RTRIM(i.sqltxt,';');
		    EXECUTE IMMEDIATE v_sql;
         END LOOP;
      END LOOP;
   END IF;

   -- Return Code as 10000
   pn_returncode_out := ods.ct_core.ferrorcodesct ('ALL', 'SUCCESSFUL');

 EXCEPTION
 WHEN OTHERS
 THEN
	  ROLLBACK;
      ods.log_error ('INCV_PROGRAMCONFIGURATION_PKG.SP_DELETEPASTPROGRAM',
		               NULL,
                       SQLCODE,
					   substr((SQLERRM),1,255),
                       SYSDATE,
                       NULL);
        -- Return Code as 10004
        pn_returncode_out := ods.ct_core.ferrorcodesct ('ALL', 'NOT SUCCESSFUL');
 END SP_DELETEPASTPROGRAM;

END INCV_PROGRAMCONFIGURATION_PKG;
/


GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ACTS_APPS;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ACTS_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO CLMFIN;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO CTLM_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ETLADMIN;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO FIXER WITH GRANT OPTION;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO INCV_APP;

GRANT EXECUTE, DEBUG ON INCV.INCV_PROGRAMCONFIGURATION_PKG TO INCV_APP;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO INCV_DEV;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO INCV_DML;

GRANT EXECUTE, DEBUG ON INCV.INCV_DMLEXTRACT_PKG TO INCV_READ;

GRANT EXECUTE, DEBUG ON INCV.INCV_PROGRAMCONFIGURATION_PKG TO INCV_USER;

GRANT EXECUTE ON INCV.INCV_CEOUTPUT TO ODS_DML;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ODS_DML;

GRANT EXECUTE ON INCV.INCV_CEOUTPUT TO ODS_READ;

GRANT EXECUTE ON INCV.INCV_DATAINGEST_PKG TO ODS_READ;

GRANT EXECUTE, DEBUG ON INCV.INCV_DMLEXTRACT_PKG TO ODS_READ;

GRANT EXECUTE ON INCV.INCV_PROGRAMCONFIGURATION_PKG TO ODS_READ;

GRANT EXECUTE ON INCV.INCV_CEOUTPUT TO ODS_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_DATAINGEST_PKG TO ODS_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_DMLEXTRACT_PKG TO ODS_USER;

GRANT EXECUTE, DEBUG ON INCV.INCV_PROGRAMCONFIGURATION_PKG TO ODS_USER;


-- EXIT;