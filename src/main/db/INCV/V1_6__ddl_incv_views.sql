-- SET ECHO ON

/*
DROP VIEW INCV.VWSTDREPORTMEMELGINCNV;
*/

/* Formatted on 4/19/2019 12:25:25 PM (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW INCV.VWSTDREPORTMEMELGINCNV
(
   MEMBERID,
   INCENTIVERUNID,
   ELIGIBILITYTYPEMNEMONIC,
   ELIGIBILITYIND,
   ELIGIBILITYTYPEDESC,
   INSERTEDDT,
   INSERTEDBY,
   UPDATEDDT,
   UPDATEDBY
)
AS
   (SELECT   me.memberid,
             me.incentiverunid,
             me.ELIGIBILITYTYPEMNEMONIC,
             me.ELIGIBILITYIND,
             (SELECT   m.MASTERCODEDESC
                FROM   incv.MASTERMNEMONIC m
               WHERE   m.MASTERCODEMNEMONIC = me.ELIGIBILITYTYPEMNEMONIC)
                AS ELIGIBILITYTYPEDESC,
             me.INSERTEDDT,
             me.INSERTEDBY,
             me.UPDATEDDT,
             me.UPDATEDBY
      FROM   incv.membereligibility me, incv.memberprogramlastrun mplr
     WHERE   me.memberid = mplr.memberid
             AND me.incentiverunid = mplr.incentiverunid
             -- Included Partition columns
             -- Start
             AND mplr.mastersupplierid =
                   ods.ods_common_pkg.fgetmastersupplierid (
                      pn_memberid_in   => mplr.memberid
                   )
             AND me.mastersupplierid = mplr.mastersupplierid
             AND (me.yearqtr BETWEEN ods.ods_common_pkg.fgetpreviousyearqtr (
                                        SYSDATE
                                     )
                                 AND  ods.ods_common_pkg.fgetyearqtr (
                                         SYSDATE
                                      ))                                -- End
                                        );


/*
DROP VIEW INCV.VW_CMMEMBERACTIVITYOCCURRENCE;
*/

/* Formatted on 4/19/2019 12:25:25 PM (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW INCV.VW_CMMEMBERACTIVITYOCCURRENCE
(
   RUNDT,
   MEMBERACTIVITYOCCURRENCESKEY,
   AHMSUPPLIERID,
   MEMBERID,
   MEMBERPLANID,
   INCENTIVERUNID,
   PROGRAMID,
   REWARDID,
   ACTIVITYID,
   ACTIVITYOCCURSTATUSMNEMONIC,
   ACTIVITYOCCURRENCEDT,
   ACTIVITYCOMPLETIONDT,
   REWARDCOMPLETIONDATE,
   REDEEMEDREWARDVAL,
   BALANCEREWARDVAL,
   GOALTYPEMNEMONIC,
   MEMBERTIERMNEMONIC,
   SUPPLIERCATEGORY
)
AS
   SELECT   mao.RUNDT,
            mao.MEMBERACTIVITYOCCURRENCESKEY,
            mao.AHMSUPPLIERID,
            mao.MEMBERID,
            mao.MEMBERPLANID,
            mao.INCENTIVERUNID,
            mao.PROGRAMID,
            mao.REWARDID,
            mao.ACTIVITYID,
            mao.ACTIVITYOCCURSTATUSMNEMONIC,
            mao.ACTIVITYOCCURRENCEDT,
            mao.ACTIVITYCOMPLETIONDT,
            mao.REWARDCOMPLETIONDATE,
            maov.REDEEMEDREWARDVAL,
            maov.BALANCEREWARDVAL,
            maov.GOALTYPEMNEMONIC,
            maov.MEMBERTIERMNEMONIC,
            so1.datasourcenm AS Suppliercategory --US114714  psa/non psa supplier indicator
     FROM   INCV.MEMBERACTIVITYOCCURRENCE mao,
            INCV.MEMBERACTIVITYOCCURVAL maov,
            INCV.memberprogramlastrun mplr,
            ods.supplierorganization so1               -- added for --US114714
    WHERE       mao.memberid = mplr.memberid
            AND mao.programid = mplr.programid
            AND mao.incentiverunid = mplr.incentiverunid
            AND mao.mastersupplierid = maov.mastersupplierid
            AND mao.rundt = maov.rundt
            AND mao.memberactivityoccurrenceskey =
                  maov.memberactivityoccurrenceskey
            AND mplr.VOIDFLG = 'IN'
            AND mao.VOIDFLG = 'IN'
            AND mao.invalidind = 'N'
            AND mao.mastersupplierid = mplr.mastersupplierid
            AND so1.ahmsupplierid = mao.ahmsupplierid               --US114714
            AND EXISTS
                  (SELECT   1
                     FROM   ODS.partyemailaddress email, ods.MEMBER m
                    WHERE       mao.memberid = m.memberid
                            AND m.personid = email.partyid
                            AND m.ahmsupplierid <> 0
                            AND email.deletedbydatasourcenm IS NULL
                            AND NVL (m.effectiveenddt,
                                     TO_DATE ('12/12/9999', 'MM/DD/YYYY')) >
                                  SYSDATE
                            AND (email.createdbydatasourcenm IN
                                       ('PHR_UE', 'AA')
                                 OR email.UPDTDATASOURCENM IN
                                         ('PHR_UE', 'AA', 'COMMENG'))
                   -- US114429 created new view for CM after removed email preference filter condition
                   --AND email.emailpreferenceflg = 'Y'
                   UNION ALL
                   SELECT   1
                     FROM   ods.partyemailaddress email,
                            ods.supplierorganization so,
                            ods.MEMBER m
                    WHERE       mao.memberid = m.memberid
                            AND m.personid = email.partyid
                            AND email.createdbydatasourcenm = 'HDMS'
                            AND m.ahmsupplierid = so.ahmsupplierid
                            AND email.deletedbydatasourcenm IS NULL
                            AND so.emailconsentflg = 'Y'
                            AND NVL (m.effectiveenddt,
                                     TO_DATE ('12/12/9999', 'MM/DD/YYYY')) >
                                  SYSDATE                           --US112224
                                         -- US114429 created new view for CM after removed email preference filter condition
                                         /*   AND NOT EXISTS
                                                                                                                                 (SELECT   NULL
                                                     FROM   ods.partyemailaddress email
                                                    WHERE   m.personid = email.partyid
                                                            AND NVL (
                                                                  email.emailpreferenceflg,
                                                                  'Y'
                                                               ) = 'N') */
               );

/*
DROP VIEW INCV.VW_MEMBERACTIVITYOCCURRENCE;
*/

/* Formatted on 4/19/2019 12:25:25 PM (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW INCV.VW_MEMBERACTIVITYOCCURRENCE
(
   RUNDT,
   MEMBERACTIVITYOCCURRENCESKEY,
   AHMSUPPLIERID,
   MEMBERID,
   MEMBERPLANID,
   INCENTIVERUNID,
   PROGRAMID,
   REWARDID,
   ACTIVITYID,
   ACTIVITYOCCURSTATUSMNEMONIC,
   ACTIVITYOCCURRENCEDT,
   ACTIVITYCOMPLETIONDT,
   REWARDCOMPLETIONDATE,
   REDEEMEDREWARDVAL,
   BALANCEREWARDVAL,
   GOALTYPEMNEMONIC,
   MEMBERTIERMNEMONIC
)
AS
   SELECT   mao.RUNDT,
            mao.MEMBERACTIVITYOCCURRENCESKEY,
            mao.AHMSUPPLIERID,
            mao.MEMBERID,
            mao.MEMBERPLANID,
            mao.INCENTIVERUNID,
            mao.PROGRAMID,
            mao.REWARDID,
            mao.ACTIVITYID,
            mao.ACTIVITYOCCURSTATUSMNEMONIC,
            mao.ACTIVITYOCCURRENCEDT,
            mao.ACTIVITYCOMPLETIONDT,
            mao.REWARDCOMPLETIONDATE,
            maov.REDEEMEDREWARDVAL,
            maov.BALANCEREWARDVAL,
            maov.GOALTYPEMNEMONIC,
            maov.MEMBERTIERMNEMONIC
     FROM   INCV.MEMBERACTIVITYOCCURRENCE mao,
            INCV.MEMBERACTIVITYOCCURVAL maov,
            INCV.memberprogramlastrun mplr
    WHERE       mao.memberid = mplr.memberid
            AND mao.programid = mplr.programid
            AND mao.incentiverunid = mplr.incentiverunid
            AND mao.mastersupplierid = maov.mastersupplierid -- added for US98063
            AND mao.rundt = maov.rundt                    -- added for US98063
            AND mao.memberactivityoccurrenceskey =
                  maov.memberactivityoccurrenceskey       -- added for US98063
            AND mplr.VOIDFLG = 'IN'
            AND mao.VOIDFLG = 'IN'
            AND mao.invalidind = 'N'
            --    AND mao.mastersupplierid  = ods.ods_common_pkg.fgetmastersupplierid (pn_memberid_in => mao.memberid)
            AND mao.mastersupplierid = mplr.mastersupplierid
            AND EXISTS
                  (SELECT   1
                     FROM   ODS.partyemailaddress email, ods.MEMBER m
                    WHERE       mao.memberid = m.memberid
                            AND m.personid = email.partyid
                            AND m.ahmsupplierid <> 0
                            AND email.deletedbydatasourcenm IS NULL
                            AND NVL (m.effectiveenddt,
                                     TO_DATE ('12/12/9999', 'MM/DD/YYYY')) >
                                  SYSDATE
                            AND (email.createdbydatasourcenm IN
                                       ('PHR_UE', 'AA')
                                 OR email.UPDTDATASOURCENM IN
                                         ('PHR_UE', 'AA', 'COMMENG'))
                            AND email.emailpreferenceflg = 'Y'
                   UNION ALL
                   SELECT   1
                     FROM   ods.partyemailaddress email,
                            ods.supplierorganization so,
                            ods.MEMBER m
                    WHERE       mao.memberid = m.memberid
                            AND m.personid = email.partyid
                            AND email.createdbydatasourcenm = 'HDMS'
                            AND m.ahmsupplierid = so.ahmsupplierid
                            AND email.deletedbydatasourcenm IS NULL
                            AND so.emailconsentflg = 'Y'
                            AND NVL (m.effectiveenddt,
                                     TO_DATE ('12/12/9999', 'MM/DD/YYYY')) >
                                  SYSDATE                           --US112224
                            AND NOT EXISTS
                                  (SELECT   NULL
                                     FROM   ods.partyemailaddress email
                                    WHERE   m.personid = email.partyid
                                            AND NVL (
                                                  email.emailpreferenceflg,
                                                  'Y'
                                               ) = 'N'));


--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO ACTS_APPS;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO ACTS_APPS;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO ACTS_USER;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO ACTS_USER;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO AMEAPP;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO CEAPP;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO CLMFIN;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO CLMFIN;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO CM;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO CM;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO CM_APP;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO CM_APP;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO CM_USER;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO CM_USER;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO COMMENG;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO COMMENG;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO COMMENG_USER;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO COMMENG_USER;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO DM_USER;
--  HJD -- 
--  HJD -- GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON INCV.VWSTDREPORTMEMELGINCNV TO FIXER WITH GRANT OPTION;
--  HJD -- 
--  HJD -- GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO FIXER WITH GRANT OPTION;
--  HJD -- 
--  HJD -- GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO FIXER WITH GRANT OPTION;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO INCV_APP;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO INCV_APP;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO INCV_DEV;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO INCV_DEV;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO INCV_DML;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO INCV_DML;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO INCV_READ;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO INCV_READ;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO INCV_USER;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO ODS;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO ODS;
--  HJD -- 
--  HJD -- GRANT DELETE, INSERT, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO ODS_DML;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO ODS_READ;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO ODS_READ;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO ODS_READ;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VWSTDREPORTMEMELGINCNV TO ODS_USER;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_CMMEMBERACTIVITYOCCURRENCE TO ODS_USER;
--  HJD -- 
--  HJD -- GRANT SELECT ON INCV.VW_MEMBERACTIVITYOCCURRENCE TO ODS_USER;


-- EXIT;