-- SET ECHO ON

/*
DROP PROCEDURE INCV.GETEVNTCHNGINFOFORMEMBER;
*/

CREATE OR REPLACE PROCEDURE INCV.getevntchnginfoformember (
   pn_memberplanid_in     IN OUT number,
   pn_memberid_in         IN OUT number,
   pd_processdt_in        IN     date,
   pn_statuschgflg_out       OUT varchar2,
   pv_Eventchgflg_out        OUT varchar2,
   pd_Eventchgdt_out         OUT timestamp,
   pv_pgmchgflg_out          OUT varchar2,
   pd_pgmchgdt_out           OUT timestamp,
   pv_supppgmchgflg_out      OUT varchar2,
   pd_suppgmchgdt_out        OUT timestamp,
   pd_lastrundt_out          OUT timestamp,
   pn_returncode_out         OUT varchar2
)
IS
   ln_memberid           number;
   ln_ahmsupplierid      number;
   ln_mastersupplierid   number;
   ln_pgmid              number;
   lv_errorflg           char (1) := 'N';
BEGIN
   pn_statuschgflg_out := 'N';
   pv_Eventchgflg_out := 'N';
   pv_pgmchgflg_out := 'N';
   pv_supppgmchgflg_out := 'N';

   pd_Eventchgdt_out := NULL;
   pd_pgmchgdt_out := NULL;
   pd_suppgmchgdt_out := NULL;
   pd_lastrundt_out := NULL;



   BEGIN
      IF pn_memberplanid_in IS NOT NULL
      THEN
         SELECT   memberid, ahmsupplierid
           INTO   pn_memberid_in, ln_ahmsupplierid
           FROM   ods.MEMBER
          WHERE   primarymemberplanid = pn_memberplanid_in
                  AND ahmsupplierid <> 0;

         pn_memberid_in := ln_memberid;
      ELSIF pn_memberid_in IS NOT NULL
      THEN
         SELECT   primarymemberplanid, ahmsupplierid
           INTO   pn_memberplanid_in, ln_ahmsupplierid
           FROM   ods.MEMBER
          WHERE   memberid = pn_memberid_in AND ahmsupplierid <> 0;
      END IF;

      IF pn_memberid_in IS NOT NULL
      THEN
         ln_memberid := pn_memberid_in;
         ln_mastersupplierid :=
            ODS.ODS_COMMON_PKG.FGETMASTERSUPPLIERID (ln_memberid);
      ELSE
         pn_returncode_out := ODS.FERRORCODES ('ALL', 'MEMBER NOT FOUND');
         GOTO finish;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         pn_returncode_out := ODS.FERRORCODES ('ALL', 'MEMBER NOT FOUND');
         lv_errorflg := 'Y';
         GOTO finish;
   END;



   ODS.ODS_COMMON_PKG.GETINCVRUNPROCESSSTATUS (
      pn_memberid_in     => ln_memberid,
      pv_runflag_out     => pv_Eventchgflg_out,
      pt_lastupddt_out   => pd_Eventchgdt_out
   );


   BEGIN
        SELECT   MAX (assoc.updateddt) assoc_updateddt,
                 MAX (pgm.updateddt) pgm_updateddt,
                 pgm.PROGRAMID
          INTO   pd_suppgmchgdt_out, pd_pgmchgdt_out, ln_pgmid
          FROM   incv.program pgm, incv.supplierprogramassoc assoc
         WHERE       assoc.ahmsupplierid = ln_ahmsupplierid
                 AND pd_processdt_in BETWEEN assoc.EFFECTIVEDT AND ASSOC.ENDDT
                 AND assoc.programid = pgm.programid
                 ---AND pd_processdt_in BETWEEN pgm.PROGRAMEFFECTIVEDT
                    --                     AND  PGM.PROGRAMENDDT
      GROUP BY   pgm.programid;

      IF pd_suppgmchgdt_out >= pd_Eventchgdt_out
      THEN
         pv_supppgmchgflg_out := 'Y';
      END IF;

      IF pd_pgmchgdt_out >= pd_Eventchgdt_out
      THEN
         pv_pgmchgflg_out := 'Y';
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_errorflg := 'Y';
         GOTO finish;
   END;

   BEGIN
      SELECT   UPDATEDDT
        INTO   pd_lastrundt_out
        FROM   INCV.MEMBERPROGRAMLASTRUN
       WHERE       MASTERSUPPLIERID = ln_mastersupplierid
               AND memberid = ln_memberid
               AND programid = ln_pgmid
               AND voidflg = 'IN';
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_errorflg := 'Y';

         GOTO finish;
   END;

  <<finish>>
   IF lv_errorflg = 'N'
   THEN
      IF (   pv_Eventchgflg_out = 'Y'
          OR pv_pgmchgflg_out = 'Y'
          OR pv_supppgmchgflg_out = 'Y'
          OR pd_lastrundt_out IS NULL)
      THEN
         pn_statuschgflg_out := 'Y';
      END IF;
   END IF;

   pn_returncode_out := ods.ferrorcodes ('ALL', 'SUCCESSFUL');
EXCEPTION
   WHEN OTHERS
   THEN
      pn_returncode_out := ods.ferrorcodes ('ALL', 'NOT SUCCESSFUL');
END;
/


/*
DROP PROCEDURE INCV.SETMEMBERREDEMPTIONFROMESB;
*/

CREATE OR REPLACE PROCEDURE INCV."SETMEMBERREDEMPTIONFROMESB" (
   PV_OPERATION_in         IN     VARCHAR2,
   PV_MEMBERPLANID_inout   IN OUT number,
   P_PROGRAMINFO_TAB       IN OUT PROGRAMINFO_TAB,
   pn_returncode_out          OUT NUMBER,
   pv_returnmsg_out           OUT VARCHAR2
)
AS
   ln_memberid        number;
   lv_returncode      number;
   lv_returnmessage   VARCHAR2 (1000);
   ln_incverrcode   NUMBER;
   ln_incverrmsg    varchar2 (4000);
BEGIN
   lv_returncode := 0;
   BEGIN
      SELECT   memberid
        INTO   ln_memberid
        FROM   ods.MEMBER
       WHERE   primarymemberplanid = PV_MEMBERPLANID_inout;
   EXCEPTION
      WHEN OTHERS
      THEN
         LV_RETURNMESSAGE := 'MEMBER NOT FOUND';
         LV_RETURNCODE :=
            TO_NUMBER (ODS.FERRORCODES ('ALL', 'MEMBER NOT FOUND'));
   END;

   IF LV_RETURNCODE = 0
   THEN
      FOR o_rec IN P_PROGRAMINFO_TAB.FIRST .. P_PROGRAMINFO_TAB.LAST
      LOOP
         FOR i_rec IN P_PROGRAMINFO_TAB (o_rec).MEMBERREDEMPTION.FIRST .. P_PROGRAMINFO_TAB(o_rec).MEMBERREDEMPTION.LAST
         LOOP
            BEGIN
               INSERT INTO incv.MemberRedemption (
                                                     MemberRedemptionsKEY,
                                                     ProgramId,
                                                     MemberId,
                                                     MemberPlanId,
                                                     RedemptionVal,
                                                     RedemptionDt,
                                                     RedemptionDesc,
                                                     RedemtionTypeMnemonic,
                                                     VoidFlg,
                                                     InsertedDt,
                                                     InsertedBy,
                                                     UpdatedDt,
                                                     UpdatedBy,
                                                     rewardid,
													 mastersupplierid,
													 yearqtr
                          )
                 VALUES   (
                              MemberRedemptionsKEY_SEQ.NEXTVAL,
                              P_PROGRAMINFO_TAB (o_rec).PROGRAMID,
                              ln_memberid,
                              PV_MEMBERPLANID_inout,
                              P_PROGRAMINFO_TAB (
                                 O_REC
                              ).MEMBERREDEMPTION (I_REC).REDEMPTIONVAL,
                              P_PROGRAMINFO_TAB (
                                 o_rec
                              ).MEMBERREDEMPTION (i_rec).RedemptionDt,
                              P_PROGRAMINFO_TAB (
                                 o_rec
                              ).MEMBERREDEMPTION (i_rec).RedemptionDesc,
                              P_PROGRAMINFO_TAB(O_REC).MEMBERREDEMPTION (
                                 I_REC
                              ).RedemtionTypeMnemonic,
                              NVL (
                                 P_PROGRAMINFO_TAB (
                                    O_REC
                                 ).MEMBERREDEMPTION (I_REC).VoidFlg,
                                 'IN'
                              ),
                              SYSTIMESTAMP,
                              'INCV',
                              SYSTIMESTAMP,
                              'INCV',
                              P_PROGRAMINFO_TAB (
                                 O_REC
                              ).MEMBERREDEMPTION (I_REC).rewardid,
							  ods.ods_common_pkg.fgetmastersupplierid(pn_memberid_in => ln_memberid),
							  ods.ods_common_pkg.fgetyearqtr(P_PROGRAMINFO_TAB (o_rec).MEMBERREDEMPTION (i_rec).RedemptionDt)
                          );

               P_PROGRAMINFO_TAB (
                  O_REC
               ).MEMBERREDEMPTION (I_REC).MEMBERREDEMPTIONSKEY :=
                  MEMBERREDEMPTIONSKEY_SEQ.CURRVAL;
               P_PROGRAMINFO_TAB (O_REC).MEMBERREDEMPTION (I_REC).RETURNCODE :=
                  TO_NUMBER (ods.ferrorcodes ('ALL', 'SUCCESSFUL'));
               P_PROGRAMINFO_TAB (
                  O_REC
               ).MEMBERREDEMPTION (I_REC).ReturnMessage :=
                  'SUCCESSFUL';
            EXCEPTION
               WHEN OTHERS
               THEN
                  P_PROGRAMINFO_TAB (
                     O_REC
                  ).MEMBERREDEMPTION (I_REC).RETURNCODE :=
                     TO_NUMBER(ods.ferrorcodes (
                                  'INCV',
                                  'INVALID DATA or NOT A VALID VALUE'
                               ));
                  P_PROGRAMINFO_TAB (
                     O_REC
                  ).MEMBERREDEMPTION (I_REC).ReturnMessage :=
                     'INVALID DATA or NOT A VALID VALUE';
            END;
         END LOOP;
      END LOOP;

      pn_returncode_out := TO_NUMBER (ods.ferrorcodes ('ALL', 'SUCCESSFUL'));
      PV_RETURNMSG_OUT := 'SUCCESSFUL';

      ------- Updating INCV Process status
      ods.ODS_COMMON_PKG.updateincvrunprocessstatus (ln_memberid,
                                                 'Y',
                                                 SYSTIMESTAMP,
                                                 ln_incverrcode,
                                                 ln_incverrmsg
                                                 );
   ------- Updating INCV Process status

   ELSE
      PN_RETURNCODE_OUT := LV_RETURNCODE;
      PV_RETURNMSG_OUT := LV_RETURNMESSAGE;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      pn_returncode_out :=
         TO_NUMBER (ods.ferrorcodes ('ALL', 'NOT SUCCESSFUL'));
      PV_RETURNMSG_OUT := 'NOT SUCCESSFUL';
END;
/


GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO ACTS_APPS;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO ACTS_USER;

GRANT EXECUTE ON INCV.GETEVNTCHNGINFOFORMEMBER TO AETINCV_USER;

GRANT EXECUTE ON INCV.SETMEMBERREDEMPTIONFROMESB TO AETINCV_USER;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO CLMFIN;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO CTLM_USER;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO ETLADMIN;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO FIXER WITH GRANT OPTION;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO INCV_APP;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO INCV_DEV;

GRANT EXECUTE ON INCV.GETEVNTCHNGINFOFORMEMBER TO INCV_DML;

GRANT EXECUTE ON INCV.SETMEMBERREDEMPTIONFROMESB TO INCV_DML;

GRANT EXECUTE ON INCV.GETEVNTCHNGINFOFORMEMBER TO INCV_USER;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO INCV_USER;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO ODS_DML;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO ODS_READ;

GRANT EXECUTE, DEBUG ON INCV.SETMEMBERREDEMPTIONFROMESB TO ODS_USER;


-- EXIT;