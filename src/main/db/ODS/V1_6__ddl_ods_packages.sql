-- SET ECHO ON

--
-- CT_CORE  (Package) 
--
--  Dependencies: 
--   ORG (Table)
--   MASTERCODE (Table)
--   MEMBER (Table)
--   INSURANCEORGANIZATION (Table)
--   STANDARD (Package)
--
CREATE OR REPLACE PACKAGE ODS.ct_core
AS
   g_api_default_number        number := 999.99;
   g_api_default_char          varchar2 (1) := '@';
   g_api_default_double_char   varchar2 (2) := '@@';
   g_api_default_date          date := TO_DATE ('01/01/1900', 'MM/DD/YYYY');

   /****************************************************************************
   Description : Procedures created to handle dataservice request for CareTeam
   Date                Description         Version
   06/18/2010          Created              1.0
   *****************************************************************************/

   FUNCTION ferrorcodesct (p_errorgroup_in IN varchar2, p_errordesc_in IN varchar2)
      RETURN number;

   FUNCTION fgetproviderid (p_accountid_in          IN number,
                            p_facilityid_in         IN number,
                            p_requestorid_in        IN number,
                            p_requestortype_in      IN varchar2,
                            p_iomasterfeedflag_in   IN varchar2 DEFAULT 'Y' )
      RETURN number;

   FUNCTION get_orgid (p_oid_in IN org.orgoid%TYPE)
      RETURN number;

   FUNCTION fgetctcerunmemberactionid (p_memberid_in     IN number,
                                       p_productcd_in    IN varchar2,
                                       p_supplierid_in   IN number DEFAULT NULL )
      RETURN number;

   FUNCTION fgetref (p_type_in IN varchar2, p_id_in IN number, p_xreftypecd_in IN varchar2)
      RETURN varchar2;

   FUNCTION fgetassocstatus (p_status_cd IN varchar2)
      RETURN varchar2;

   FUNCTION fgetprovorgtype (p_requestortype_in IN varchar2)
      RETURN varchar2;

   FUNCTION fgetctmemberid (p_memberplanid_in   IN MEMBER.primarymemberplanid%TYPE,
                            p_accountorgid_in   IN org.orgid%TYPE,
                            p_procmodecd_in     IN insuranceorganization.processingmodecd%TYPE DEFAULT NULL )
      RETURN number;

   FUNCTION fvalidatesystemsource (p_systemsrc_in IN varchar2)
      RETURN number;

   FUNCTION fgetmastercode (p_mastercodemnemonic_in   IN varchar2,
                            p_mastergroupcd_in        IN varchar2,
                            p_mastercodedesc_in       IN varchar2 DEFAULT NULL )
      RETURN varchar2;

   FUNCTION fgetmastercodedesc (p_mastercode_in IN varchar2, p_mastergroupcd_in IN varchar2)
      RETURN mastercode.mastercodedesc%TYPE;

   FUNCTION fgetmastermemoniccode (p_mastercode_in IN varchar2, p_mastergroupcd_in IN varchar2)
      RETURN varchar2;

   PROCEDURE mvrefresh (p_returncode_out OUT number);

   FUNCTION fgetrefservicefilter (p_servicenm_in IN varchar2, p_datasource_in IN varchar2, p_searchstring IN varchar2)
      RETURN varchar2;

   FUNCTION fgetrefservicefilterlookup (p_servicenm_in    IN varchar2,
                                        p_datasource_in   IN varchar2,
                                        p_searchvalue     IN varchar2)
      RETURN varchar2;

   PROCEDURE getioprocessingmode (p_accountorgid_in      IN     varchar2,
                                  p_insuranceorgid_out      OUT number,
                                  p_processingmode_out      OUT varchar2,
                                  p_masterfeedflg_out       OUT varchar2);

   FUNCTION fgetaccountoidformember (p_member_id IN MEMBER.memberid%TYPE)
      RETURN org.orgoid%TYPE;

   FUNCTION fgetprovideroid (p_providerid_in IN number, p_accountorgid_in IN number)
      RETURN varchar2;


   PROCEDURE getprocessingmodefrmio (p_insuranceorgid_in    IN     number,
                                     p_acntorgid_out           OUT number,
                                     p_processingmode_out      OUT varchar2,
                                     p_masterfeedflg_out       OUT varchar2);

   FUNCTION fgetauthororgid (pn_requestorid_in IN number, pn_accountorgid_in IN number)
      RETURN number;

   PROCEDURE updatemasterpcp (pv_procmode_in   IN insuranceorganization.PROCESSINGMODECD%TYPE,
                              pn_memberid_in   IN MEMBER.memberid%TYPE);


END ct_core;
/


--
-- ODS_COMMON_PKG  (Package) 
--
--  Dependencies: 
--   ORG (Table)
--   MEMBER (Table)
--   AHMMRNSUPPLIERPRECEDENCERULE (Table)
--   SUPPLIERORGANIZATION (Table)
--   MASTERCODE (Table)
--   SUPPLIERPRODUCTRELATION (Table)
--   STANDARD (Package)
--   INSURANCEORGANIZATION (Table)
--   DATASOURCE (Table)
--   TABLE_MEMBERID (Type)
--   MEMBERPROVIDERRELATIONSHIP (Table)
--   AHMMRNBUSINESSSUPPLIER (Table)
--
CREATE OR REPLACE PACKAGE ODS.ods_common_pkg
AS
   /******************************************************************************
      name:       ods_common_pkg
      purpose:
      revisions:
      ver        date        author           description
      ---------  ----------  ---------------  ------------------------------------
      1.0        1/28/2014   sundar          procedures/functions used across all apps within ods
	  2.0		 08/01/2018  Sudharsan		 Rally  US113391 to update emailpreferenceflg for member
   ******************************************************************************/

   -- get business supplier for an ahm mrn.
   FUNCTION fgetbusinesssupplier (
      pn_ahmmrnmemberid_in   IN MEMBER.memberid%TYPE,
      pv_accountoid_in       IN org.orgoid%TYPE
   )
      RETURN supplierorganization.ahmsupplierid%TYPE;

   FUNCTION fgetbusinesssupplier_new (
      pn_ahmmrnmemberid_in   IN MEMBER.memberid%TYPE,
      pn_accountid_in        IN insuranceorganization.insuranceorgid%TYPE
   )
      RETURN supplierorganization.ahmsupplierid%TYPE;

   -- updating ce member process status with bit.
   PROCEDURE updatememberprocessstatus (pnmemberid_in   IN number,
                                        pvbits_in       IN varchar2,
                                        pvceflag_in     IN varchar2);

   -- function to determine if it's an act account.
   FUNCTION isactaccount (
      pn_insuranceorgid_in   IN insuranceorganization.insuranceorgid%TYPE
   )
      RETURN varchar2;

   -- get current winner pcp for a given ahm memberid
   PROCEDURE getcurrentwinnerpcp (
      pn_ahmmemberid_in               IN     MEMBER.memberid%TYPE,
      pv_processingmodecd_in          IN     insuranceorganization.
      processingmodecd%TYPE,
      pn_currpcpprovider_out             OUT memberproviderrelationship.
      providerid%TYPE,
      pn_currmasterpcpprovider_out       OUT memberproviderrelationship.
      mastercareproviderid%TYPE,
      pn_currmemberproviderskey_out      OUT memberproviderrelationship.
      memberproviderskey%TYPE
   );

   -- get new winner pcp for a given ahm memberid
   PROCEDURE getnewwinnerpcp (
      pn_ahmmemberid_in           IN     MEMBER.memberid%TYPE,
      pn_accountid_in             IN     insuranceorganization.insuranceorgid%
      TYPE,
      pv_processingmodecd_in      IN     insuranceorganization.
      processingmodecd%TYPE,
      pv_isactflag_in             IN     varchar2,
      pv_pcpdatasourcenm_in       IN     supplierorganization.pcpdatasourcenm%
      TYPE,
      pn_projectid_in             IN     insuranceorganization.projectid%TYPE,
      pn_newpcpprovider_out          OUT memberproviderrelationship.providerid
      %TYPE,
      pn_memberproviderskey_out      OUT memberproviderrelationship.
      memberproviderskey%TYPE
   );

   -- set winner pcp for a given ahm memberid
   PROCEDURE setwinnerpcp (
      pn_accountid_in      IN insuranceorganization.insuranceorgid%TYPE
      DEFAULT NULL
                                                                          ,
      pn_ahmmemberid_in    IN MEMBER.memberid%TYPE,
      pv_datasourcenm_in   IN datasource.datasourcenm%TYPE
   );

   -- set winner pcp for a list of member ids.
   PROCEDURE setwinnerpcp (
      pn_accountid_in         IN     insuranceorganization.insuranceorgid%TYPE
      ,
      pn_ahmmemberidlist_in   IN     table_memberid,
      pv_datasourcenm_in      IN     datasource.datasourcenm%TYPE,
      pn_returncode_out          OUT number
   );

   -- get mnemonic code from master code.
   FUNCTION fgetmastermemoniccode (p_mastercode_in      IN varchar2,
                                   p_mastergroupcd_in   IN varchar2)
      RETURN mastercode.mastercodemnemonic%TYPE;

   -- setting winner pcp for a batch.
   PROCEDURE pcpbatchrefresh (p_batchid_in        IN     number,
                              p_mprcacheflg_in    IN     varchar2,
                              p_datasourcenm_in   IN     varchar2,
                              p_returncode_out       OUT number);

   -- return account id for a given member.
   FUNCTION fgetaccountidformember (p_member_id IN MEMBER.memberid%TYPE)
      RETURN insuranceorganization.insuranceorgid%TYPE;

   FUNCTION fcheckwinnerpcpsts (p_memberid      number,
                                p_supplierid    number,
                                p_datasource    varchar2)
      RETURN varchar2;

   PROCEDURE raise_error (p_errcode_in IN number, p_errmsg_in IN varchar2);

   PROCEDURE resetchkpt;

   FUNCTION fget_acteligibilityflg (
      pn_supplierid_in   IN supplierorganization.ahmsupplierid%TYPE
   )
      RETURN varchar2;

   FUNCTION fgetdodformember (pn_memberplanid_in IN number)
      RETURN date;

   PROCEDURE sp_debuglog (p_procedurename IN varchar2, p_text IN varchar2);

   FUNCTION fchkaccount (memberid_in IN number, accountid_in IN number)
      RETURN varchar2;

   FUNCTION fchecklbsforwinnerpcp (
      p_accountid                    insuranceorganization.insuranceorgid%TYPE
      ,
      p_lastbusinessahmsupplierid    ahmmrnbusinesssupplier.
      lastbusinessahmsupplierid%TYPE,
      p_vendorsourcenm               ahmmrnsupplierprecedencerule.
      vendorsourcenm%TYPE,
      p_clinicaldoctypemnemonic      ahmmrnsupplierprecedencerule.
      clinicaldoctypemnemonic%TYPE
   )
      RETURN varchar2;

   ---to fetch members belongs to hie/payer acct
   PROCEDURE getmemberlist (
      p_seq                   IN            number,
      p_memberplanidlist_in   IN            table_memberid,
      p_processingmodecd      IN            varchar2,
      p_returncode_out           OUT NOCOPY number
   );

   FUNCTION checkproductforsupplier (
      p_ahmsupplierid   IN supplierorganization.ahmsupplierid%TYPE,
      p_productcd       IN supplierproductrelation.productcd%TYPE
   )
      RETURN varchar2;

   FUNCTION fgetmemberemailaddress (pn_memberplanid_in     IN  number)
     RETURN number;
   --to get mastersupplierid
 FUNCTION fgetmastersupplierid (
    pn_memberid_in              IN ods.MEMBER.memberid%TYPE DEFAULT NULL ,
    pn_primarymemberplanid_in   IN ods.MEMBER.primarymemberplanid%TYPE DEFAULT
      NULL ,
    pn_supplierid_in            IN ods.MEMBER.ahmsupplierid%TYPE DEFAULT NULL
      -- supplierid for 'p' ,businesssupplierid for 'h' acct
 )
  RETURN number RESULT_CACHE;
    --to get year and quarter
 FUNCTION fgetyearqtr  (pd_date_in IN date)
      RETURN number;

        --to get previous year and quarter
  FUNCTION fgetpreviousyearqtr  (pd_date_in IN date)
      RETURN number;
  -- odserrorlog set error info
 PROCEDURE seterrorinfo (pv_prcoessnm    IN varchar2 DEFAULT NULL,
       pv_parameter1   IN varchar2 DEFAULT NULL,
       pv_parameter2   IN varchar2 DEFAULT NULL,
       pv_parameter3   IN varchar2 DEFAULT NULL,
       pv_parameter4   IN varchar2 DEFAULT NULL,
       pv_parameter5   IN varchar2 DEFAULT NULL,
       pv_comments     IN varchar2 DEFAULT NULL,
       pv_errormsg     IN varchar2 DEFAULT NULL);
    FUNCTION fgetmemberarchivepersistflg (pn_memberid IN number) RETURN
      varchar2;

    PROCEDURE updateincvrunprocessstatus (
   pn_memberid_in   IN number,
   pv_incvflag_in   IN varchar2,
   pt_lastauditdate_in IN timestamp,
   p_errorcode_out       OUT number,
   p_errormsg_out       OUT varchar2
);

PROCEDURE  getincvrunprocessstatus (
   pn_memberid_in   IN number,
   pv_runflag_out OUT varchar2,
   pt_lastupddt_out OUT timestamp
) ;

 FUNCTION fGetaccountstatus(
   Pn_insuranceorgid_in              IN ods.insuranceorganization.
      insuranceorgid%TYPE
 )
      RETURN VARCHAR2  RESULT_CACHE;

FUNCTION fgetdatashareconsentflg (pn_ahmsupplierid_in NUMBER)
  RETURN VARCHAR2;


  PROCEDURE getpersonaggregatemembers (
   memberid_in        IN     NUMBER,
   ahmsupplierid_in   IN     NUMBER,
   memberid_obj_out      OUT table_memberid,
   errorcode             OUT NUMBER,
   personviewflg_in  IN  VARCHAR2 DEFAULT  'N');


 FUNCTION fgetpersonaggregateid(
   memberid_in        IN     NUMBER
)
  RETURN NUMBER ;


 FUNCTION fgetpersonviewflg
  RETURN VARCHAR2;

   FUNCTION fgetdatashareconsentformember (memberid_in IN NUMBER DEFAULT NULL,
                                         memberplanid_in IN NUMBER DEFAULT NULL)
    RETURN VARCHAR2;

FUNCTION fgetmemberplanid (pn_memberid_in IN ods.MEMBER.memberid%TYPE)
RETURN NUMBER RESULT_CACHE;

--US113391 SP to update emailpreference flag for the member
PROCEDURE updateemailpreferenceflg(
    pn_memberid_in IN NUMBER,
	pv_datasourcenm_in IN VARCHAR2,
	pv_emailpreferenceflg_in IN VARCHAR2,
    pn_errorcode_out OUT NUMBER ) ;

FUNCTION fgetphonefaxnumberforperson (pn_personid_in IN ods.member.personid%TYPE)
RETURN VARCHAR2;

FUNCTION fgetemailaddressforperson (pn_personid_in IN ods.member.personid%TYPE)
RETURN VARCHAR2;

END ods_common_pkg;
/


--
-- ODS_CORE  (Package) 
--
--  Dependencies: 
--   ODS_DELMITEDSTRING_TAB (Type)
--   DATASOURCE (Table)
--   STANDARD (Package)
--   MEMBER (Table)
--   DEBUGPROC (Table)
--
CREATE OR REPLACE PACKAGE ODS.ods_core
AS
   /****************************************************************************
   Description : Procedures created to handle dataservice request for CareTeam
   Date                Description         Version
   06/18/2010          Created              1.0
   *****************************************************************************/
   -- Trace Variables
   gt_start   timestamp;
   gt_chk1    timestamp;
   gt_chk2    timestamp;
   gt_chk3    timestamp;
   gt_chk4    timestamp;
   gt_chk5    timestamp;
   gt_chk6    timestamp;
   gt_chk7    timestamp;
   gt_chk8    timestamp;
   gt_chk9    timestamp;
   gt_chk10   timestamp;
   gt_chk11   timestamp;
   gt_chk12   timestamp;
   gt_chk13   timestamp;
   gt_chk14   timestamp;
   gt_chk15   timestamp;
   gt_chk16   timestamp;
   gt_chk17   timestamp;
   gt_chk18   timestamp;
   gt_chk19   timestamp;
   gt_chk20   timestamp;
   gt_end     timestamp;

   FUNCTION fgetdebugexecutiontime (
      pv_debugprocname_in   IN debugproc.procname%TYPE
   )
      RETURN varchar2;

   PROCEDURE resettracevariables;

   PROCEDURE loglongcall (pv_procedurenm_in      IN varchar2,
                          pv_logtable_in         IN varchar2 DEFAULT NULL ,
                          pn_logtableseq_in      IN number DEFAULT NULL ,
                          pn_procreturncode_in   IN number DEFAULT NULL ,
                          pt_start_in            IN timestamp,
                          pt_chk1_in             IN timestamp DEFAULT NULL ,
                          pt_chk2_in             IN timestamp DEFAULT NULL ,
                          pt_chk3_in             IN timestamp DEFAULT NULL ,
                          pt_chk4_in             IN timestamp DEFAULT NULL ,
                          pt_chk5_in             IN timestamp DEFAULT NULL ,
                          pt_chk6_in             IN timestamp DEFAULT NULL ,
                          pt_chk7_in             IN timestamp DEFAULT NULL ,
                          pt_chk8_in             IN timestamp DEFAULT NULL ,
                          pt_chk9_in             IN timestamp DEFAULT NULL ,
                          pt_chk10_in            IN timestamp DEFAULT NULL ,
                          pt_chk11_in            IN timestamp DEFAULT NULL ,
                          pt_chk12_in            IN timestamp DEFAULT NULL ,
                          pt_chk13_in            IN timestamp DEFAULT NULL ,
                          pt_chk14_in            IN timestamp DEFAULT NULL ,
                          pt_chk15_in            IN timestamp DEFAULT NULL ,
                          pt_chk16_in            IN timestamp DEFAULT NULL ,
                          pt_chk17_in            IN timestamp DEFAULT NULL ,
                          pt_chk18_in            IN timestamp DEFAULT NULL ,
                          pt_chk19_in            IN timestamp DEFAULT NULL ,
                          pt_chk20_in            IN timestamp DEFAULT NULL ,
                          pt_end_in              IN timestamp);

   PROCEDURE convert_delimitedstr_using_obj (
      p_delimstring   IN     varchar2,
      p_delimiter     IN     varchar2,
      p_delstring        OUT ods_delmitedstring_tab,
      p_errorcode        OUT number
   );

   FUNCTION getdelimiedstrtotbl (p_delimstring   IN varchar2,
                                 p_delimiter     IN varchar2)
      RETURN ods_delmitedstring_tab;

   FUNCTION fgetmastercode (p_mastercodemnemonic_in IN varchar2)
      RETURN varchar2;

FUNCTION fgetmastercodedesc (p_mastercodemnemonic_in IN varchar2)
      RETURN varchar2;

   FUNCTION fgetmastermemoniccode (p_mastercode_in      IN varchar2,
                                   p_mastergroupcd_in   IN varchar2)
      RETURN varchar2;

   FUNCTION fgetorgnm (p_orgid_in IN number)
      RETURN varchar2;

   PROCEDURE setmoodcdlist (p_moodcdlist_in IN varchar2);

   FUNCTION fgetunknownprovider (
      p_ahmsupplierid_in   IN MEMBER.ahmsupplierid%TYPE,
      p_systemsource_in    IN datasource.datasourcenm%TYPE
   )
      RETURN number;

   FUNCTION fgetprovtype (p_id_in IN number)
      RETURN varchar2;

   FUNCTION fvalidateuserid (p_id_in IN number, p_type_in IN varchar2)
      RETURN number;

   PROCEDURE sethealthstatefdback (
      p_healthstatetrackingid_in    IN     number,
      p_memberplanid_in             IN     number,
      p_healthstatetype_in          IN     varchar2,
      p_systemsource_in             IN     varchar2,
      p_fdbstatusid_in              IN     varchar2,
      p_fdbstatusreason_in          IN     number,
      p_fdbcomments_in              IN     varchar2,
      p_fdbdate_in                  IN     date,
      p_byuserid_in                 IN     number,
      p_byprovidertype_in           IN     varchar2,
      p_foruserid_in                IN     number,
      p_forprovidertype_in          IN     varchar2,
      p_healthstatetrackingid_out      OUT number,
      p_memberplanid_out               OUT number,
      p_returncode_out                 OUT number
   );
  FUNCTION FGetOrgOIdFromOrgId(
  pn_issuingorgid_in        IN      NUMBER)
  return varchar2;

END ods_core;
/

--
-- CT_CORE  (Package Body) 
--
CREATE OR REPLACE PACKAGE BODY ODS.ct_core
AS
   /****************************************************************************
   description : procedures created to handle dataservice request for careteam
   date                description         version
   06/18/2010          created              1.0
   08/08/2013         Mairead Higgins       Added getceproducthighlightwbitlogic
   *****************************************************************************/


   FUNCTION ferrorcodesct (p_errorgroup_in IN varchar2, p_errordesc_in IN varchar2)
      RETURN number
   AS
      verrorcode        number;
      lv_targetsystem   refdataserviceerror.targetsystemnm%TYPE;
   BEGIN
      IF UPPER (p_errorgroup_in) = 'CM'
      THEN
         lv_targetsystem := 'CT';
      ELSE
         lv_targetsystem := UPPER (p_errorgroup_in);
      END IF;

       SELECT errorcd
         INTO verrorcode
         FROM refdataserviceerror
        WHERE UPPER (targetsystemnm) = lv_targetsystem AND UPPER (errormsg) = UPPER (p_errordesc_in);

      /*verrorcode   :=
                                                                                                                                                                                                                                                                                                                                                                                                case
            when p_errordesc_in = 'successful' then 10000
            when p_errordesc_in = 'mandatory elements not found' then 10002
            when p_errordesc_in = 'not successful' then 10004
            when p_errordesc_in = 'account not found' then 10016
            when p_errordesc_in = 'facility not found' then 10017
            when p_errordesc_in = 'empiid not found' then 10018
            when p_errordesc_in = 'requestorid not found' then 10019
            when p_errordesc_in = 'product not found' then 10020
            when p_errordesc_in = 'invalid account setup' then 10021
            when p_errordesc_in = 'patient not found' then 10160
            when p_errordesc_in = 'illegal operation' then 10015
            when p_errordesc_in = 'member not found' then 10010
            when p_errordesc_in = 'partial success' then 10030
            when p_errordesc_in = 'invalid data request' then 10040
         end; */


      RETURN verrorcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         log_error ('Ferrorcodes_CT',
                    p_errorgroup_in || ' ' || p_errordesc_in,
                    SQLCODE,
                    SQLERRM,
                    SYSDATE,
                    NULL);
         RETURN NULL;
   END;

   FUNCTION fgetproviderid (p_accountid_in          IN number,
                            p_facilityid_in         IN number,
                            p_requestorid_in        IN number,
                            p_requestortype_in      IN varchar2,
                            p_iomasterfeedflag_in   IN varchar2 DEFAULT 'Y' )
      RETURN number
   IS
      lv_providerid   careprovider.careproviderid%TYPE;
      lv_provtype     provorgstaffmasterxref.provorgstafftypecd%TYPE;
      lv_exists       number;
   BEGIN
      lv_exists := 0;

      IF p_iomasterfeedflag_in = 'Y'
      THEN
         BEGIN
             SELECT prvxref.mastercareproviderid, prvxref.provorgstafftypecd
               INTO lv_providerid, lv_provtype
               FROM provorgstaffmasterxref prvxref
              WHERE prvxref.provorgstaffid = p_requestorid_in
                AND provorgstafftypecd = p_requestortype_in
                AND prvxref.exclusioncd = 'IN'
                AND prvxref.masterproviderflg = 'Y'
                AND EXISTS
                       ( SELECT 1
                           FROM orgpersonxref o
                          WHERE o.relatedpersonid = prvxref.provorgstaffid
                            AND o.accountid = p_accountid_in
                            AND o.relationtypemnemonic = 'ORGPRS_AFFL'
                            AND o.effenddt IS NULL
                            --and o.primaryflg = 'y'
                            AND NVL (o.exclusioncd, 'IN') = 'IN');


            IF p_requestortype_in = 'P'
            THEN
               BEGIN
                   SELECT cp.careproviderid
                     INTO lv_providerid
                     FROM careprovider cp
                    WHERE cp.careproviderid = lv_providerid AND NVL (cp.exclusioncode, 'IN') = 'IN'
                      AND (NVL (cp.providerfilterflag, 'N') <> 'Y'
                        OR (cp.providerfilterflag = 'Y'
                        AND (cp.sourcecareproviderid = '0' OR cp.externalsourcecareproviderid = '0')));
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     lv_providerid := NULL;
               END;
               RETURN lv_providerid;
            ELSE
               RETURN lv_providerid;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               lv_providerid := NULL;
               RETURN lv_providerid;
         END;
      ELSE
         lv_providerid := p_requestorid_in;
         BEGIN
            IF p_requestortype_in = 'P'
            THEN
                SELECT 1
                  INTO lv_exists
                  FROM careprovider cp
                 WHERE cp.careproviderid = lv_providerid AND NVL (cp.exclusioncode, 'IN') = 'IN'
                   AND (NVL (cp.providerfilterflag, 'N') <> 'Y'
                     OR (cp.providerfilterflag = 'Y'
                     AND (cp.sourcecareproviderid = '0' OR cp.externalsourcecareproviderid = '0')))
                   AND EXISTS
                          ( SELECT 1
                              FROM orgpersonxref o
                             WHERE o.relatedpersonid = cp.careproviderid
                               AND o.accountid = p_accountid_in
                               AND o.relationtypemnemonic = 'ORGPRS_AFFL'
                               AND o.effenddt IS NULL
                               --and o.primaryflg = 'y'
                               AND NVL (o.exclusioncd, 'IN') = 'IN');
            ELSIF p_requestortype_in = 'A'
            THEN
                SELECT 1
                  INTO lv_exists
                  FROM provorgadjunctstaff a
                 WHERE provorgadjunctstaffid = lv_providerid AND NVL (exclusioncd, 'IN') = 'IN'
                   AND EXISTS
                          ( SELECT 1
                              FROM orgpersonxref o
                             WHERE o.relatedpersonid = provorgadjunctstaffid
                               AND o.accountid = p_accountid_in
                               AND o.relationtypemnemonic = 'ORGPRS_AFFL'
                               AND o.effenddt IS NULL
                               --and o.primaryflg = 'y'
                               AND NVL (o.exclusioncd, 'IN') = 'IN');
            ELSIF p_requestortype_in = 'E'
            THEN
                SELECT 1
                  INTO lv_exists
                  FROM employee e
                 WHERE employeeid = lv_providerid AND NVL (exclusioncd, 'IN') = 'IN';
            --                   and exists
            --                          ( select 1
            --                              from orgpersonxref o
            --                             where o.relatedpersonid = employeeid
            --                               and o.accountid = p_accountid_in
            --                               and o.relationtypemnemonic = 'orgprs_affl'
            --                               and o.effenddt is null
            --                               and nvl (o.exclusioncd, 'in') = 'in');
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               lv_exists := 0;
         END;

         IF NVL (lv_exists, 0) = 0
         THEN
            lv_providerid := NULL;
         END IF;

         RETURN lv_providerid;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_providerid := NULL;
         RETURN lv_providerid;
   END fgetproviderid;

   FUNCTION get_orgid (p_oid_in IN org.orgoid%TYPE)
      RETURN number
   IS
      lv_org_id   org.orgid%TYPE;
   BEGIN
       /* function to get the  org id for a accountoid or facilityoid  */
       SELECT orgid
         INTO lv_org_id
         FROM org org
        WHERE org.orgoid = p_oid_in;

      RETURN lv_org_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         lv_org_id := NULL;
         RETURN lv_org_id;
      WHEN OTHERS
      THEN
         lv_org_id := NULL;
         RETURN lv_org_id;
   END get_orgid;

   FUNCTION fgetctcerunmemberactionid (p_memberid_in     IN number,
                                       p_productcd_in    IN varchar2,
                                       p_supplierid_in   IN number DEFAULT NULL )
      RETURN number
   AS
      lv_careenginerunmemberactionid   number;
      lv_supplierid                    MEMBER.ahmsupplierid%TYPE;
      lv_usagetype                     supplierorganization.usagemnemonic%TYPE;
   BEGIN
      IF p_supplierid_in IS NULL
      THEN
          SELECT m.ahmsupplierid, so.usagemnemonic
            INTO lv_supplierid, lv_usagetype
            FROM MEMBER m, supplierorganization so
           WHERE m.memberid = p_memberid_in AND so.ahmsupplierid = m.ahmsupplierid;

         IF lv_usagetype = 'L'
         THEN
             SELECT lastbusinessahmsupplierid
               INTO lv_supplierid
               FROM ahmmrnbusinesssupplier
              WHERE ahmmrnmemberid = p_memberid_in;
         ELSE
            lv_supplierid := lv_supplierid;
         END IF;
      ELSE
         lv_supplierid := p_supplierid_in;
      END IF;

       SELECT careenginerunmemberactionid
         INTO lv_careenginerunmemberactionid
         FROM csid.memberrecommendproductlastrun mrplr
        WHERE mrplr.memberid = p_memberid_in
          AND mrplr.businesssupplierid = lv_supplierid
          AND mrplr.productmnemoniccd = p_productcd_in;

      RETURN lv_careenginerunmemberactionid;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END fgetctcerunmemberactionid;

   FUNCTION fgetref (p_type_in IN varchar2, p_id_in IN number, p_xreftypecd_in IN varchar2)
      RETURN varchar2
   IS
      lv_ret_value   varchar2 (500);
   BEGIN
      /*  common function to get the reference  data */
      BEGIN
         IF p_type_in = 'PATID'
         THEN
             SELECT xref.memberxrefcd
               INTO lv_ret_value
               FROM memberxref xref
              WHERE xref.memberid = p_id_in AND xref.memberxreftypecd = p_xreftypecd_in;
         ELSIF p_type_in = 'ISSORGID'
         THEN
             SELECT xref.issuingorgid
               INTO lv_ret_value
               FROM memberxref xref
              WHERE xref.memberid = p_id_in AND xref.memberxreftypecd = p_xreftypecd_in;
         ELSIF p_type_in = 'MEMBERPLANID'
         THEN
             SELECT xref.primarymemberplanid
               INTO lv_ret_value
               FROM MEMBER xref
              WHERE xref.memberid = p_id_in;
         ELSIF p_type_in = 'MDMSKEY'
         THEN
             SELECT ct.provorgstaffmasterskey
               INTO lv_ret_value
               FROM provorgstaffmasterxref ct
              WHERE ct.provorgstaffid = p_id_in;
         --and ct.provorgstafftypecd in ('p', 'a');
         ELSIF p_type_in = 'ORGNM'
         THEN
             SELECT orgnm
               INTO lv_ret_value
               FROM org
              WHERE orgid = p_id_in;
         ELSIF p_type_in = 'ORGOID'
         THEN
             SELECT orgoid
               INTO lv_ret_value
               FROM org
              WHERE orgid = p_id_in;
         ELSIF p_type_in = 'MASTERPROVIDERID'
         THEN
             SELECT mastercareproviderid
               INTO lv_ret_value
               FROM provorgstaffmasterxref prvxref
              WHERE prvxref.provorgstaffid = p_id_in;
         ELSIF p_type_in = 'MEFEEDBACK'
         THEN
             SELECT COUNT (1)
               INTO lv_ret_value
               FROM csid.memberhealthstatefeedbackxref mhsxref
              WHERE mhsxref.clinicaloutputtrackingid = p_id_in AND mhsxref.clinicaloutputtypecd = 'COM';
         ELSIF p_type_in = 'PROVTYPE'
         THEN
             SELECT COALESCE ( ( SELECT poxref.provorgstafftypecd
                                   FROM provorgstaffmasterxref poxref
                                  WHERE poxref.provorgstaffid = p_id_in AND poxref.exclusioncd = 'IN'),
                              ( SELECT 'P'
                                  FROM careprovider cp
                                 WHERE cp.careproviderid = p_id_in AND NVL (cp.exclusioncode, 'IN') = 'IN'),
                              ( SELECT 'A'
                                  FROM provorgadjunctstaff adj
                                 WHERE adj.provorgadjunctstaffid = p_id_in AND NVL (adj.exclusioncd, 'IN') = 'IN'),
                              ( SELECT 'E'
                                  FROM employee e
                                 WHERE e.employeeid = p_id_in AND NVL (e.exclusioncd, 'IN') = 'IN'))
               INTO lv_ret_value
               FROM DUAL;
         --         elsif p_type_in = 'systemoid'
         --         then
         --             select externaloid
         --               into lv_ret_value
         --               from oidregistry o
         --              where o.oidnm = p_xreftypecd_in;
         ELSIF p_type_in = 'SYSTEMNAME'
         THEN
             SELECT oidnm
               INTO lv_ret_value
               FROM oidregistry o
              WHERE o.externaloid = p_xreftypecd_in;
         ELSIF p_type_in = 'SYSOIDSKEY'
         THEN
             SELECT oidregistryskey
               INTO lv_ret_value
               FROM oidregistry o
              WHERE o.externaloid = p_xreftypecd_in;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            lv_ret_value := NULL;
      END;

      RETURN lv_ret_value;
   END fgetref;

   FUNCTION fgetassocstatus (p_status_cd IN varchar2)
      RETURN varchar2
   IS
      lv_ret_value   varchar2 (30);
   BEGIN
      /* function to get the description for association status. ct has three types of association so far
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 vl => validated
      ch => chanllenged
      cr  => created
      */
      IF p_status_cd IS NULL
      THEN
         lv_ret_value := NULL;
      ELSIF p_status_cd = 'CR'
      THEN
         lv_ret_value := 'CREATED';
      ELSIF p_status_cd = 'CH'
      THEN
         lv_ret_value := 'CHALLENGED';
      ELSIF p_status_cd = 'VL'
      THEN
         lv_ret_value := 'VALIDATED';
      ELSE
         lv_ret_value := p_status_cd;
      END IF;

      RETURN lv_ret_value;
   END fgetassocstatus;

   FUNCTION fgetprovorgtype (p_requestortype_in IN varchar2)
      RETURN varchar2
   IS
      lv_retvalue   varchar2 (1);
   BEGIN
      IF p_requestortype_in = 'PRV'
      THEN
         lv_retvalue := 'P';
      ELSIF p_requestortype_in = 'ADJ'
      THEN
         lv_retvalue := 'A';
      ELSE
         lv_retvalue := NULL;
      END IF;

      RETURN lv_retvalue;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retvalue := NULL;
   END;

   FUNCTION fgetctmemberid (p_memberplanid_in   IN MEMBER.primarymemberplanid%TYPE,
                            p_accountorgid_in   IN org.orgid%TYPE,
                            p_procmodecd_in     IN insuranceorganization.processingmodecd%TYPE DEFAULT NULL )
      RETURN number
   IS
      lv_retvalue               number;
      lv_ioorgid                insuranceorganization.insuranceorgid%TYPE;
      lv_procmodecd             insuranceorganization.processingmodecd%TYPE;
      lv_ioprovmasterfeedflag   insuranceorganization.masterfeedflg%TYPE;
      lv_ahmflag                varchar2 (1);
   BEGIN
      /*if p_procmodecd_in is null
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     then
         getioprocessingmode (
            p_accountorgid_in      => p_accountorgid_in,
            p_insuranceorgid_out   => lv_ioorgid,
            p_processingmode_out   => lv_procmodecd,
            p_masterfeedflg_out    => lv_ioprovmasterfeedflag
         );
         if lv_ioorgid is null
         or lv_procmodecd is null
         then
            lv_retvalue := null;
            return lv_retvalue;
         end if;
      else
         lv_procmodecd := p_procmodecd_in;
      end if;
      if lv_procmodecd = 'h'
      then
         select   m.memberid
           into   lv_retvalue
           from   member m,
                  supplierorganization so,
                  insuranceorgsupplierrelation iosr,
                  insuranceorganization io
          where   m.primarymemberplanid = p_memberplanid_in
              and m.ahmsupplierid = so.ahmsupplierid
              and so.usagemnemonic = 'l'
              and iosr.supplierid = so.supplierorgid
              and iosr.insuranceorgid = io.insuranceorgid
              and io.orgid = p_accountorgid_in;
      else
         select   m.memberid
           into   lv_retvalue
           from   member m,
                  supplierorganization so,
                  insuranceorgsupplierrelation iosr,
                  insuranceorganization io
          where   m.primarymemberplanid = p_memberplanid_in
              and m.ahmsupplierid = so.ahmsupplierid
              and so.usagemnemonic <> 'l'
              and iosr.supplierid = so.supplierorgid
              and iosr.insuranceorgid = io.insuranceorgid
              and io.orgid = p_accountorgid_in;
      end if;*/
      BEGIN
          SELECT 'N'
            INTO lv_ahmflag
            FROM insuranceorganization io
           WHERE io.orgid = p_accountorgid_in;
      EXCEPTION
         WHEN OTHERS
         THEN
            lv_ahmflag := 'Y';
      END;

      IF lv_ahmflag = 'N'
      THEN
          SELECT m.memberid
            INTO lv_retvalue
            FROM MEMBER m
           WHERE m.primarymemberplanid = p_memberplanid_in
             AND EXISTS
                    ( SELECT 1
                        FROM supplierorganization so, insuranceorgsupplierrelation iosr, insuranceorganization io
                       WHERE so.ahmsupplierid = m.ahmsupplierid
                         AND so.usagemnemonic = DECODE (io.processingmodecd, 'H', 'L', so.usagemnemonic)
                         AND iosr.supplierid = so.supplierorgid
                         AND iosr.insuranceorgid = io.insuranceorgid
                         AND io.orgid = p_accountorgid_in);
      ELSIF lv_ahmflag = 'Y'
      THEN
          SELECT m.memberid
            INTO lv_retvalue
            FROM MEMBER m
           WHERE m.primarymemberplanid = p_memberplanid_in
             AND EXISTS
                    ( SELECT 1
                        FROM supplierorganization so, insuranceorgsupplierrelation iosr, insuranceorganization io
                       WHERE so.ahmsupplierid = m.ahmsupplierid
                         AND iosr.supplierid = so.supplierorgid
                         AND iosr.insuranceorgid = io.insuranceorgid
                         AND io.processingmodecd = 'P'
                         AND io.masterfeedflg = 'N');
      END IF;


      RETURN lv_retvalue;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retvalue := NULL;
         RETURN lv_retvalue;
   END fgetctmemberid;

   FUNCTION fvalidatesystemsource (p_systemsrc_in IN varchar2)
      RETURN number
   IS
      lv_exists   number;
   BEGIN
       SELECT 1
         INTO lv_exists
         FROM datasource ds
        WHERE ds.datasourcenm = p_systemsrc_in;

      RETURN (ct_core.ferrorcodesct ('CT', 'SUCCESSFUL'));
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN (ct_core.ferrorcodesct ('CT', 'NOT SUCCESSFUL'));
      WHEN OTHERS
      THEN
         RETURN (ct_core.ferrorcodesct ('CT', 'NOT SUCCESSFUL'));
   END fvalidatesystemsource;

   FUNCTION fgetmastercode (p_mastercodemnemonic_in   IN varchar2,
                            p_mastergroupcd_in        IN varchar2,
                            p_mastercodedesc_in       IN varchar2 DEFAULT NULL )
      RETURN varchar2
   IS
      lv_retcode   mastercode.mastercode%TYPE;
   BEGIN
      IF p_mastergroupcd_in IS NOT NULL AND p_mastercodemnemonic_in IS NOT NULL
      THEN
          SELECT mastercode
            INTO lv_retcode
            FROM mastercode
           WHERE mastercodemnemonic = p_mastercodemnemonic_in AND mastergroupcd = p_mastergroupcd_in;
      ELSIF p_mastergroupcd_in IS NOT NULL AND p_mastercodedesc_in IS NOT NULL
      THEN
          SELECT mastercode
            INTO lv_retcode
            FROM mastercode
           WHERE mastercodedesc = p_mastercodedesc_in AND mastergroupcd = p_mastergroupcd_in;
      ELSE
          SELECT mastercode
            INTO lv_retcode
            FROM mastercode
           WHERE mastercodemnemonic = p_mastercodemnemonic_in;
      END IF;

      RETURN lv_retcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retcode := NULL;
         RETURN lv_retcode;
   END fgetmastercode;

   FUNCTION fgetmastercodedesc (p_mastercode_in IN varchar2, p_mastergroupcd_in IN varchar2)
      RETURN mastercode.mastercodedesc%TYPE
   IS
      lv_retcode   mastercode.mastercodedesc%TYPE;
   BEGIN
       SELECT mc.mastercodedesc
         INTO lv_retcode
         FROM mastercode mc
        WHERE mc.mastercode = p_mastercode_in AND mc.mastergroupcd = p_mastergroupcd_in;

      RETURN lv_retcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retcode := NULL;
         RETURN lv_retcode;
   END fgetmastercodedesc;

   FUNCTION fgetmastermemoniccode (p_mastercode_in IN varchar2, p_mastergroupcd_in IN varchar2)
      RETURN varchar2
   IS
      lv_retcode   mastercode.mastercodemnemonic%TYPE;
   BEGIN
       SELECT mc.mastercodemnemonic
         INTO lv_retcode
         FROM mastercode mc
        WHERE mc.mastercode = p_mastercode_in AND mc.mastergroupcd = p_mastergroupcd_in;

      RETURN lv_retcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retcode := NULL;
         RETURN lv_retcode;
   END fgetmastermemoniccode;

   PROCEDURE mvrefresh (p_returncode_out OUT number)
   AS
   BEGIN
      dbms_mview.refresh ('MVELEMENTBUILDERREFDATA');
      p_returncode_out := ct_core.ferrorcodesct ('CT', 'SUCCESSFUL');
   EXCEPTION
      WHEN OTHERS
      THEN
         p_returncode_out := ct_core.ferrorcodesct ('CT', 'NOT SUCCESSFUL');
         log_error (procedurename_in    => 'CT_CORE.MVREFRESH',
                    memberid_in         => NULL,
                    errornumber_in      => SQLCODE,
                    errormessage_in     => SQLERRM,
                    errortimestamp_in   => SYSDATE,
                    jseq_in             => NULL);
         RAISE;
   END;

   FUNCTION fgetrefservicefilter (p_servicenm_in IN varchar2, p_datasource_in IN varchar2, p_searchstring IN varchar2)
      RETURN varchar2
   IS
      lv_retvalue   refservicefilterlkup.lkupvalue%TYPE;
   BEGIN
      BEGIN
          SELECT lkupvalue
            INTO lv_retvalue
            FROM refservicefilterlkup
           WHERE servicenm = p_servicenm_in AND datasourcenm = p_datasource_in AND lkupstring = p_searchstring;
      EXCEPTION
         WHEN OTHERS
         THEN
            lv_retvalue := NULL;
      END;
      RETURN lv_retvalue;
   END fgetrefservicefilter;

   FUNCTION fgetrefservicefilterlookup (p_servicenm_in    IN varchar2,
                                        p_datasource_in   IN varchar2,
                                        p_searchvalue     IN varchar2)
      RETURN varchar2
   IS
      lv_retvalue   refservicefilterlkup.lkupvalue%TYPE;
   BEGIN
      BEGIN
          SELECT lkupstring
            INTO lv_retvalue
            FROM refservicefilterlkup
           WHERE servicenm = p_servicenm_in AND datasourcenm = p_datasource_in AND lkupvalue = p_searchvalue;
      EXCEPTION
         WHEN OTHERS
         THEN
            lv_retvalue := NULL;
      END;
      RETURN lv_retvalue;
   END fgetrefservicefilterlookup;

   PROCEDURE getioprocessingmode (p_accountorgid_in      IN     varchar2,
                                  p_insuranceorgid_out      OUT number,
                                  p_processingmode_out      OUT varchar2,
                                  p_masterfeedflg_out       OUT varchar2)
   IS
      lv_ahmoid     org.orgoid%TYPE;
      lv_ahmorgid   org.orgid%TYPE;
   BEGIN
      BEGIN
          SELECT io.insuranceorgid, io.processingmodecd, io.masterfeedflg
            INTO p_insuranceorgid_out, p_processingmode_out, p_masterfeedflg_out
            FROM insuranceorganization io
           WHERE io.orgid = p_accountorgid_in;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_insuranceorgid_out := 9999;
            p_processingmode_out := 'P';
            p_masterfeedflg_out := 'N';
      END;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_insuranceorgid_out := NULL;
         p_processingmode_out := NULL;
         p_masterfeedflg_out := NULL;
   END;

   FUNCTION fgetaccountoidformember (p_member_id IN MEMBER.memberid%TYPE)
      RETURN org.orgoid%TYPE
   IS
      l_return_oid   org.orgoid%TYPE;
   BEGIN
       SELECT o.orgoid
         INTO l_return_oid
         FROM MEMBER m,
              insuranceorgsupplierrelation ioso,
              supplierorganization so,
              insuranceorganization io,
              org o
        WHERE m.ahmsupplierid = so.ahmsupplierid
          AND so.supplierorgid = ioso.supplierid
          AND ioso.effectiveenddt IS NULL
          AND so.effectiveenddt IS NULL
          AND ioso.insuranceorgid = io.insuranceorgid
          AND io.orgid = o.orgid
          AND m.memberid = p_member_id;

      RETURN l_return_oid;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END fgetaccountoidformember;

   FUNCTION fgetprovideroid (p_providerid_in IN number, p_accountorgid_in IN number)
      RETURN varchar2
   IS
      lv_retvalue   org.orgoid%TYPE;
   BEGIN
       -- always returns the lowest level oid associated to the provider

       SELECT o.orgoid
         INTO lv_retvalue
         FROM org o
        WHERE EXISTS
                 ( SELECT 1
                     FROM orgpersonxref x
                    WHERE x.orgid = o.orgid
                      AND x.relatedpersonid = p_providerid_in
                      AND x.accountid = p_accountorgid_in
                      AND x.relationtypemnemonic = 'ORGPRS_AFFL'
                      AND x.effenddt IS NULL
                      AND x.primaryflg = 'Y'
                      AND NVL (x.exclusioncd, 'IN') = 'IN');

      RETURN lv_retvalue;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retvalue := NULL;
         RETURN lv_retvalue;
   END fgetprovideroid;


   PROCEDURE getprocessingmodefrmio (p_insuranceorgid_in    IN     number,
                                     p_acntorgid_out           OUT number,
                                     p_processingmode_out      OUT varchar2,
                                     p_masterfeedflg_out       OUT varchar2)
   IS
   BEGIN
       SELECT io.orgid, io.processingmodecd, io.masterfeedflg
         INTO p_acntorgid_out, p_processingmode_out, p_masterfeedflg_out
         FROM insuranceorganization io
        WHERE io.insuranceorgid = p_insuranceorgid_in;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_acntorgid_out := NULL;
         p_processingmode_out := NULL;
         p_masterfeedflg_out := NULL;
   END getprocessingmodefrmio;

   FUNCTION fgetauthororgid (pn_requestorid_in IN number, pn_accountorgid_in IN number)
      RETURN number
   IS
      lv_retvalue   number;
   BEGIN
       SELECT CASE WHEN oa.relatedorgid = oa.accountid THEN oa.orgid ELSE oa.relatedorgid END
         INTO lv_retvalue
         FROM orgpersonxref x, orgassociation oa
        WHERE x.accountid = pn_accountorgid_in
          AND x.relatedpersonid = pn_requestorid_in
          AND x.relationtypemnemonic = 'ORGPRS_AFFL'
          AND x.effenddt IS NULL
          AND x.primaryflg = 'Y'
          AND NVL (x.exclusioncd, 'IN') = 'IN'
          AND oa.orgid = x.orgid
          AND oa.accountid = x.accountid
          AND oa.relationtypemnemonic = 'ORGREL_PARENT'
          AND NVL (oa.exclusioncd, 'IN') = 'IN'
          AND oa.effenddt IS NULL;

      RETURN lv_retvalue;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retvalue := NULL;
         RETURN lv_retvalue;
   END fgetauthororgid;

   PROCEDURE updatemasterpcp (pv_procmode_in   IN insuranceorganization.processingmodecd%TYPE,
                              pn_memberid_in   IN MEMBER.memberid%TYPE)
   IS
      ln_memberproviderskey   memberproviderrelationship.memberproviderskey%TYPE;
      lv_pcpdatasourcenm      supplierorganization.pcpdatasourcenm%TYPE;
   BEGIN
      -- get pcp datasourcenm for the supplier


      IF pv_procmode_in = 'P'
      THEN
         BEGIN
             -- if payer member get the ds for the supplierid from member
             SELECT pcpdatasourcenm
               INTO lv_pcpdatasourcenm
               FROM supplierorganization so, MEMBER m
              WHERE so.ahmsupplierid = m.ahmsupplierid AND m.memberid = pn_memberid_in;
         EXCEPTION
            WHEN OTHERS
            THEN
               lv_pcpdatasourcenm := 'ALL';
         END;

         IF lv_pcpdatasourcenm IS NULL
         THEN
            lv_pcpdatasourcenm := 'ALL';
         END IF;

          UPDATE memberproviderrelationship mpr
             SET mpr.winnerpcpflg = NULL
           WHERE memberid = pn_memberid_in;

          UPDATE memberproviderrelationship
             SET winnerpcpflg = 'Y'
           WHERE memberproviderskey =
                    ( SELECT memberproviderskey
                        FROM ( SELECT                                     /*+ index (mpr memberproviderrelation_ix01) */
                                     mpr.memberproviderskey,
                                     ROW_NUMBER () OVER (PARTITION BY mpr.memberid ORDER BY mpr.recordupdtdt DESC) rn
                                 FROM memberproviderrelationship mpr
                                WHERE mpr.ahmmemberid = pn_memberid_in AND mpr.exclusioncd = 'IN' AND mpr.pcpflg = 'Y'
                                  AND mpr.datasourcenm =
                                         DECODE (lv_pcpdatasourcenm, 'ALL', mpr.datasourcenm, lv_pcpdatasourcenm))
                       WHERE rn = 1);
      ELSIF pv_procmode_in = 'H'
      THEN
         -- if h member get the ds for the supplierid from ahmmrnbusinesssupplier
         BEGIN
             SELECT pcpdatasourcenm
               INTO lv_pcpdatasourcenm
               FROM supplierorganization so, ahmmrnbusinesssupplier lbs
              WHERE so.ahmsupplierid = lbs.lastbusinessahmsupplierid AND lbs.ahmmrnmemberid = pn_memberid_in;
         EXCEPTION
            WHEN OTHERS
            THEN
               lv_pcpdatasourcenm := 'ALL';
         END;

         IF lv_pcpdatasourcenm IS NULL
         THEN
            lv_pcpdatasourcenm := 'ALL';
         END IF;

          UPDATE memberproviderrelationship mpr
             SET mpr.winnerpcpflg = NULL
           WHERE mpr.ahmmemberid = pn_memberid_in;

          UPDATE memberproviderrelationship
             SET winnerpcpflg = 'Y'
           WHERE memberproviderskey =
                    ( SELECT memberproviderskey
                        FROM ( SELECT                                     /*+ index (mpr memberproviderrelation_ix01) */
                                     mpr.memberproviderskey,
                                     ROW_NUMBER () OVER (PARTITION BY mpr.ahmmemberid ORDER BY mpr.recordupdtdt DESC) rn
                                 FROM memberproviderrelationship mpr
                                WHERE mpr.ahmmemberid = pn_memberid_in AND mpr.exclusioncd = 'IN' AND mpr.pcpflg = 'Y'
                                  AND mpr.datasourcenm =
                                         DECODE (lv_pcpdatasourcenm, 'ALL', mpr.datasourcenm, lv_pcpdatasourcenm))
                       WHERE rn = 1);
      END IF;
   END updatemasterpcp;


END ct_core;
/


--
-- ODS_COMMON_PKG  (Package Body) 
--
CREATE OR REPLACE PACKAGE BODY ODS.ods_common_pkg
AS
   /******************************************************************************
      name:       ods_common_pkg
      purpose:
      revisions:
      ver        date        author           description
      ---------  ----------  ---------------  ------------------------------------
      1.0        1/28/2014   sundar          procedures/functions used across all apps within ods
	  2.0		 08/01/2018  Sudharsan		 Rally  US113391 to update emailpreferenceflg for member
   ******************************************************************************/
   FUNCTION fgetbusinesssupplier (
      pn_ahmmrnmemberid_in   IN MEMBER.memberid%TYPE,
      pv_accountoid_in       IN org.orgoid%TYPE
   )
      RETURN supplierorganization.ahmsupplierid%TYPE
   IS
      /****************************************************************************
                             date                description         version      author                                                                                                                                                                                    date                description         version
           11/02/2012         mantis 24080         1.1          mthiagarajan
           03/21/2013         mantis 26196          1.2         mthiagarajan
           07/17/2013         mantis 28066          1.3         sundar
           1/21/2014          pcp enhancement                   sundar
         *****************************************************************************/
      ln_accountid          number;
      ln_bussuppliercount   pls_integer;
      lv_multiplebsflg      varchar2 (1);
      ln_businesssupplier   number;
      ln_dummy              pls_integer;
      --bsflg               varchar2 (5);
      lv_datasourcenm       varchar2 (30);
      nt_lbs                getlbs_new_tab;

      TYPE t_precedencerule IS TABLE OF ahmmrnsupplierprecedencerule%ROWTYPE;

      lt_precedencerule     t_precedencerule;
      ln_employeecount      pls_integer;

      -- function to return default lbs for an account
      FUNCTION returndefaultbussupplier (
         pn_accountid   IN insuranceorganization.insuranceorgid%TYPE
      )
         RETURN supplierorganization.ahmsupplierid%TYPE
      IS
         ln_defbusinesssupplierid   supplierorganization.ahmsupplierid%TYPE;
      BEGIN
         SELECT   ahmsupplierid
           INTO   ln_defbusinesssupplierid
           FROM   supplierorganization so, insuranceorgsupplierrelation iosr
          WHERE       so.supplierorgid = iosr.supplierid
                  AND iosr.insuranceorgid = pn_accountid
                  AND usagemnemonic = 'B'
                  AND defaultbusinesssupplierflg = 'Y';

         RETURN ln_defbusinesssupplierid;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END returndefaultbussupplier;
   BEGIN
      -- initialize variables
      ln_employeecount := 0;
      ln_businesssupplier := NULL;

      -- get accountid for an account
      SELECT   io.insuranceorgid
        INTO   ln_accountid
        FROM   insuranceorganization io, org org
       WHERE   io.orgid = org.orgid AND org.orgoid = pv_accountoid_in;

      -- check if the account has multiple business suppliers
      -- if the count is 1, then return default business supplier
      --- else follow the precendence logic.
      SELECT   COUNT ( * )
        INTO   ln_bussuppliercount
        FROM   supplierorganization so, insuranceorgsupplierrelation iosr
       WHERE       so.supplierorgid = iosr.supplierid
               AND iosr.insuranceorgid = ln_accountid
               AND usagemnemonic = 'B';

      --dbms_output.put_line ('business supplier count' || ln_bussuppliercount);
      IF ln_bussuppliercount < 2
      THEN
         ln_businesssupplier := returndefaultbussupplier (ln_accountid);
         RETURN ln_businesssupplier;
      ELSE
             -- step 1 - collect all the members that decide the lbs
             -- payer members + hospital members (that has pcp and valid document type defined in precedence rule table)
             SELECT   getlbs_new_obj (memberid,
                                      ahmsupplierid,
                                      membertypecode,
                                      effectiveenddt,
                                      relatedahmbusinesssupplierid,
                                      usagemnemonic)
         BULK COLLECT INTO   nt_lbs
               FROM   (                  -- collection of active payer members
                       SELECT    m.memberid,
                                 CASE NVL (iosr.insuranceorgid, 1)
                                    WHEN 1
                                    THEN
                                       fgetattributedpayersupplier (
                                          m.memberid,
                                          ln_accountid
                                       )
                                    ELSE
                                       m.ahmsupplierid
                                 END
                                    ahmsupplierid,
                                 m.membertypecode,
                                 m.effectiveenddt,
                                 CASE NVL (iosr.insuranceorgid, 1)
                                    WHEN 1
                                    THEN
                                       fgetattributed_bus_supplier (
                                          m.memberid,
                                          ln_accountid
                                       )
                                    ELSE
                                       so.relatedahmbusinesssupplierid
                                 END
                                    relatedahmbusinesssupplierid,
                                 so.usagemnemonic
                          FROM   memberaggregation ma,
                                 MEMBER m,
                                 supplierorganization so,
                                 insuranceorgsupplierrelation iosr
                         WHERE       ma.memberid = m.memberid
                                 AND ma.ahmmrnmemberid = pn_ahmmrnmemberid_in
                                 AND m.ahmsupplierid = so.ahmsupplierid
                                 AND so.supplierorgid = iosr.supplierid(+)
                                 AND iosr.insuranceorgid(+) = ln_accountid
                                 AND so.usagemnemonic = 'P'
                                 AND ma.effectiveenddt IS NULL
                                 AND m.effectiveenddt IS NULL
                       UNION ALL
                       -- collection of hospital members with pcp and also having document type defined in precedence rule table
                       SELECT   m.memberid,
                                m.ahmsupplierid,
                                m.membertypecode,
                                m.effectiveenddt,
                                so.relatedahmbusinesssupplierid,
                                so.usagemnemonic
                         FROM   memberaggregation ma,
                                MEMBER m,
                                supplierorganization so,
                                insuranceorgsupplierrelation iosr
                        WHERE       ma.memberid = m.memberid
                                AND ma.ahmmrnmemberid = pn_ahmmrnmemberid_in
                                AND m.ahmsupplierid = so.ahmsupplierid
                                AND so.supplierorgid = iosr.supplierid
                                AND iosr.insuranceorgid = ln_accountid
                                AND so.usagemnemonic = 'H'
                                AND ma.effectiveenddt IS NULL
                                AND m.effectiveenddt IS NULL
                                AND EXISTS
                                      (SELECT   NULL
                                         FROM   memberproviderrelationship mpr
      ,
                                                memberproviderrelationshipextn
      mprxt
                                        WHERE       mpr.memberid = m.memberid
                                                AND mpr.exclusioncd = 'IN'
                                                AND mpr.pcpflg = 'Y'
                                                AND mpr.memberproviderskey =
                                                      mprxt.memberproviderskey
                                                AND (NVL (
                                                        mprxt.vendorsourcenm,
                                                        'ZZZ'
                                                     ),
                                                     NVL (
                                                        mprxt.
      clinicaldoctypemnemonic,
                                                        'ZZZ'
                                                     )) IN
                                                         (SELECT   NVL (
                                                                      vendorsourcenm
      ,
                                                                      'ZZZ'
                                                                   ),
                                                                   NVL (
                                                                      clinicaldoctypemnemonic
      ,
                                                                      'ZZZ'
                                                                   )
                                                            FROM
      ahmmrnsupplierprecedencerule
                                                           WHERE
      ahmsupplierid =
                                                                      m.
      ahmsupplierid))
                       UNION ALL
                       -- collection of hospital members with pcp and also defined in precedence rule table with no document type
                       SELECT   m.memberid,
                                m.ahmsupplierid,
                                m.membertypecode,
                                m.effectiveenddt,
                                so.relatedahmbusinesssupplierid,
                                so.usagemnemonic
                         FROM   memberaggregation ma,
                                MEMBER m,
                                supplierorganization so,
                                insuranceorgsupplierrelation iosr
                        WHERE       ma.memberid = m.memberid
                                AND ma.ahmmrnmemberid = pn_ahmmrnmemberid_in
                                AND m.ahmsupplierid = so.ahmsupplierid
                                AND so.supplierorgid = iosr.supplierid
                                AND iosr.insuranceorgid = ln_accountid
                                AND so.usagemnemonic = 'H'
                                AND ma.effectiveenddt IS NULL
                                AND m.effectiveenddt IS NULL
                                AND EXISTS
                                      (SELECT   NULL
                                         FROM   memberproviderrelationship mpr
                                        WHERE       mpr.memberid = m.memberid
                                                AND mpr.exclusioncd = 'IN'
                                                AND mpr.pcpflg = 'Y')
                                AND EXISTS
                                      (SELECT   NULL
                                         FROM   ahmmrnsupplierprecedencerule
                                        WHERE   ahmsupplierid =
                                                   m.ahmsupplierid
                                                AND vendorsourcenm IS NULL
                                                AND clinicaldoctypemnemonic IS
      NULL));

         --  dbms_output.put_line ('total member count' || nt_lbs.count);
         IF nt_lbs.COUNT = 0
         THEN
            SELECT   datasourcenm
              INTO   lv_datasourcenm
              FROM   MEMBER
             WHERE   memberid = pn_ahmmrnmemberid_in;

            IF lv_datasourcenm = 'CT'
            THEN
               BEGIN
                  -- if datasource is ct, check if any lbs has been set in the past, if not return null
                  SELECT   lastbusinessahmsupplierid
                    INTO   ln_businesssupplier
                    FROM   ahmmrnbusinesssupplier
                   WHERE   ahmmrnmemberid = pn_ahmmrnmemberid_in;

                  RETURN ln_businesssupplier;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     RETURN NULL;
               END;
            ELSE
               ln_businesssupplier := returndefaultbussupplier (ln_accountid);
               RETURN ln_businesssupplier;
            END IF;
         ELSE
            -- if more than one member in the aggregation
            -- if there is only one payer in the aggregation, return the related business supplier
            IF nt_lbs.COUNT = 1
            THEN
               ln_businesssupplier := nt_lbs (1).relatedahmbusinesssupplierid;

               IF ln_businesssupplier IS NOT NULL
               THEN
                  RETURN ln_businesssupplier;
               ELSE
                  RETURN returndefaultbussupplier (ln_accountid);
               END IF;
            ELSE                      -- count > 1 -- follow precedence logic.
                   -- collect precedence rule
                   SELECT   *
               BULK COLLECT INTO   lt_precedencerule
                     FROM   ahmmrnsupplierprecedencerule
                    WHERE   accountid = ln_accountid
                            AND precedencerulebasismnemonic LIKE
                                  'LBSPRECEDENCE%'
                 ORDER BY   precedencenbr ASC;

               FOR l_precedence_ctr IN 1 .. lt_precedencerule.COUNT
               LOOP
                  IF lt_precedencerule (
                        l_precedence_ctr
                     ).precedencerulebasismnemonic = 'LBSPRECEDENCE_EMPLOYEE'
                  THEN
                     FOR l_ctr IN 1 .. nt_lbs.COUNT
                     LOOP
                        IF nt_lbs (l_ctr).membertypecode = 'E'
                        THEN
                           ln_employeecount := ln_employeecount + 1;
                           ln_businesssupplier :=
                              nt_lbs (l_ctr).relatedahmbusinesssupplierid;
                        END IF;
                     END LOOP;

                     IF ln_employeecount = 1
                     THEN
                        IF ln_businesssupplier IS NOT NULL
                        THEN
                           RETURN ln_businesssupplier;
                        ELSE
                           RETURN returndefaultbussupplier (ln_accountid);
                        END IF;
                     ELSE
                        ln_businesssupplier := NULL;
                     END IF;
                  END IF;

                  -- if employee count is more than 2, then continue with precendence supplier rule
                  IF lt_precedencerule (
                        l_precedence_ctr
                     ).precedencerulebasismnemonic = 'LBSPRECEDENCE_SUPPLIER'
                  THEN
                     FOR l_ctr IN 1 .. nt_lbs.COUNT
                     LOOP
                        IF lt_precedencerule (l_precedence_ctr).ahmsupplierid
      =
                              nt_lbs (l_ctr).ahmsupplierid
                        THEN
                           ln_businesssupplier :=
                              nt_lbs (l_ctr).relatedahmbusinesssupplierid;

                           IF ln_businesssupplier IS NOT NULL
                           THEN
                              RETURN ln_businesssupplier;
                           ELSE
                              RETURN returndefaultbussupplier (ln_accountid);
                           END IF;
                        END IF;
                     END LOOP;                  -- looping through all members
                  END IF;                    -- supplier based precedence rule
               END LOOP;
      -- for l_precedence_ctr in 1..lt_precedencerule.count  loop

               -- if it comes here, then no business supplier found in the precendence logic -- return default bus
               ln_businesssupplier := returndefaultbussupplier (ln_accountid);
               RETURN ln_businesssupplier;
            END IF;
      -- if nt_lbs.count = 1 and nt_lbs(1).usagemnemonic = 'p' then
         END IF;                                 -- if  nt_lbs.count = 0 then;
      END IF;                               -- if ln_bussuppliercount < 2 then
   EXCEPTION
      WHEN OTHERS
      THEN
         hie_log_error (
            procedurename_in    => 'FGETBUSINESSSUPPLIER',
            memberid_in         => SUBSTR (DBMS_UTILITY.format_error_backtrace
      ,
                                           -9),
            errornumber_in      => SQLCODE,
            errormessage_in     => SUBSTR (SQLERRM, 1, 100),
            errortimestamp_in   => SYSDATE,
            jseq_in             => NULL
         );
   END fgetbusinesssupplier;

   FUNCTION fgetbusinesssupplier_new (
      pn_ahmmrnmemberid_in   IN MEMBER.memberid%TYPE,
      pn_accountid_in        IN insuranceorganization.insuranceorgid%TYPE
   )
      RETURN supplierorganization.ahmsupplierid%TYPE
   IS
      /****************************************************************************
                                                 date                description         version      author                                                                                                                                                                                    date                description         version
           11/02/2012         mantis 24080         1.1          mthiagarajan
           03/21/2013         mantis 26196          1.2         mthiagarajan
           07/17/2013         mantis 28066          1.3         sundar
           1/21/2014          pcp enhancement                   sundar
         *****************************************************************************/
      ln_accountid          number;
      ln_bussuppliercount   pls_integer;
      lv_multiplebsflg      varchar2 (1);
      ln_businesssupplier   number;
      ln_dummy              pls_integer;
      --bsflg               varchar2 (5);
      lv_datasourcenm       varchar2 (30);
      nt_lbs                getlbs_new_tab;

      TYPE t_precedencerule IS TABLE OF ahmmrnsupplierprecedencerule%ROWTYPE;

      lt_precedencerule     t_precedencerule;
      ln_employeecount      pls_integer;

      -- function to return default lbs for an account
      FUNCTION returndefaultbussupplier (
         pn_accountid   IN insuranceorganization.insuranceorgid%TYPE
      )
         RETURN supplierorganization.ahmsupplierid%TYPE
      IS
         ln_defbusinesssupplierid   supplierorganization.ahmsupplierid%TYPE;
      BEGIN
         SELECT   ahmsupplierid
           INTO   ln_defbusinesssupplierid
           FROM   supplierorganization so, insuranceorgsupplierrelation iosr
          WHERE       so.supplierorgid = iosr.supplierid
                  AND iosr.insuranceorgid = pn_accountid
                  AND usagemnemonic = 'B'
                  AND defaultbusinesssupplierflg = 'Y';

         RETURN ln_defbusinesssupplierid;
      EXCEPTION
         WHEN OTHERS
         THEN
            NULL;
      END returndefaultbussupplier;
   BEGIN
      -- initialize variables
      ln_employeecount := 0;
      ln_businesssupplier := NULL;

      -- get accountid for an account
      ln_accountid := pn_accountid_in;

      -- check if the account has multiple business suppliers
      -- if the count is 1, then return default business supplier
      --- else follow the precendence logic.
      SELECT   COUNT ( * )
        INTO   ln_bussuppliercount
        FROM   supplierorganization so, insuranceorgsupplierrelation iosr
       WHERE       so.supplierorgid = iosr.supplierid
               AND iosr.insuranceorgid = ln_accountid
               AND usagemnemonic = 'B';

      --dbms_output.put_line ('business supplier count' || ln_bussuppliercount);
      IF ln_bussuppliercount = 1                                         --< 2
      THEN
         --ln_businesssupplier := returndefaultbussupplier (ln_accountid);

         SELECT   ahmsupplierid
           INTO   ln_businesssupplier
           FROM   supplierorganization so, insuranceorgsupplierrelation iosr
          WHERE       so.supplierorgid = iosr.supplierid
                  AND iosr.insuranceorgid = ln_accountid
                  AND usagemnemonic = 'B';

         RETURN ln_businesssupplier;
      ELSE
             -- step 1 - collect all the members that decide the lbs
             -- payer members + hospital members (that has pcp and valid document type defined in precedence rule table)
             SELECT   getlbs_new_obj (memberid,
                                      ahmsupplierid,
                                      membertypecode,
                                      effectiveenddt,
                                      relatedahmbusinesssupplierid,
                                      usagemnemonic)
         BULK COLLECT INTO   nt_lbs
               FROM   (                  -- collection of active payer members
                       SELECT    m.memberid,
                                 CASE NVL (iosr.insuranceorgid, 1)
                                    WHEN 1
                                    THEN
                                       fgetattributedpayersupplier (
                                          m.memberid,
                                          ln_accountid
                                       )
                                    ELSE
                                       m.ahmsupplierid
                                 END
                                    ahmsupplierid,
                                 m.membertypecode,
                                 m.effectiveenddt,
                                 CASE NVL (iosr.insuranceorgid, 1)
                                    WHEN 1
                                    THEN
                                       fgetattributed_bus_supplier (
                                          m.memberid,
                                          ln_accountid
                                       )
                                    ELSE
                                       so.relatedahmbusinesssupplierid
                                 END
                                    relatedahmbusinesssupplierid,
                                 so.usagemnemonic
                          FROM   memberaggregation ma,
                                 MEMBER m,
                                 supplierorganization so,
                                 insuranceorgsupplierrelation iosr
                         WHERE       ma.memberid = m.memberid
                                 AND ma.ahmmrnmemberid = pn_ahmmrnmemberid_in
                                 AND m.ahmsupplierid = so.ahmsupplierid
                                 AND so.supplierorgid = iosr.supplierid(+)
                                 AND iosr.insuranceorgid(+) = ln_accountid
                                 AND so.usagemnemonic = 'P'
                                 AND ma.effectiveenddt IS NULL
                                 AND m.effectiveenddt IS NULL
                       UNION ALL
                       -- collection of hospital members with pcp and also having document type defined in precedence rule table
                       SELECT   m.memberid,
                                m.ahmsupplierid,
                                m.membertypecode,
                                m.effectiveenddt,
                                so.relatedahmbusinesssupplierid,
                                so.usagemnemonic
                         FROM   memberaggregation ma,
                                MEMBER m,
                                supplierorganization so,
                                insuranceorgsupplierrelation iosr
                        WHERE       ma.memberid = m.memberid
                                AND ma.ahmmrnmemberid = pn_ahmmrnmemberid_in
                                AND m.ahmsupplierid = so.ahmsupplierid
                                AND so.supplierorgid = iosr.supplierid
                                AND iosr.insuranceorgid = ln_accountid
                                AND so.usagemnemonic = 'H'
                                AND ma.effectiveenddt IS NULL
                                AND m.effectiveenddt IS NULL
                                AND EXISTS
                                      (SELECT   NULL
                                         FROM   memberproviderrelationship mpr
      ,
                                                memberproviderrelationshipextn
      mprxt
                                        WHERE       mpr.memberid = m.memberid
                                                AND mpr.exclusioncd = 'IN'
                                                AND mpr.pcpflg = 'Y'
                                                AND mpr.memberproviderskey =
                                                      mprxt.memberproviderskey
                                                AND (NVL (
                                                        mprxt.vendorsourcenm,
                                                        'ZZZ'
                                                     ),
                                                     NVL (
                                                        mprxt.
      clinicaldoctypemnemonic,
                                                        'ZZZ'
                                                     )) IN
                                                         (SELECT   NVL (
                                                                      vendorsourcenm
      ,
                                                                      'ZZZ'
                                                                   ),
                                                                   NVL (
                                                                      clinicaldoctypemnemonic
      ,
                                                                      'ZZZ'
                                                                   )
                                                            FROM
      ahmmrnsupplierprecedencerule
                                                           WHERE
      ahmsupplierid =
                                                                      m.
      ahmsupplierid))
                       UNION ALL
                       -- collection of hospital members with pcp and also defined in precedence rule table with no document type
                       SELECT   m.memberid,
                                m.ahmsupplierid,
                                m.membertypecode,
                                m.effectiveenddt,
                                so.relatedahmbusinesssupplierid,
                                so.usagemnemonic
                         FROM   memberaggregation ma,
                                MEMBER m,
                                supplierorganization so,
                                insuranceorgsupplierrelation iosr
                        WHERE       ma.memberid = m.memberid
                                AND ma.ahmmrnmemberid = pn_ahmmrnmemberid_in
                                AND m.ahmsupplierid = so.ahmsupplierid
                                AND so.supplierorgid = iosr.supplierid
                                AND iosr.insuranceorgid = ln_accountid
                                AND so.usagemnemonic = 'H'
                                AND ma.effectiveenddt IS NULL
                                AND m.effectiveenddt IS NULL
                                AND EXISTS
                                      (SELECT   NULL
                                         FROM   memberproviderrelationship mpr
                                        WHERE       mpr.memberid = m.memberid
                                                AND mpr.exclusioncd = 'IN'
                                                AND mpr.pcpflg = 'Y')
                                AND EXISTS
                                      (SELECT   NULL
                                         FROM   ahmmrnsupplierprecedencerule
                                        WHERE   ahmsupplierid =
                                                   m.ahmsupplierid
                                                AND vendorsourcenm IS NULL
                                                AND clinicaldoctypemnemonic IS
      NULL));

         --  dbms_output.put_line ('total member count' || nt_lbs.count);
         IF nt_lbs.COUNT = 0
         THEN
            SELECT   datasourcenm
              INTO   lv_datasourcenm
              FROM   MEMBER
             WHERE   memberid = pn_ahmmrnmemberid_in;

            IF lv_datasourcenm = 'CT'
            THEN
               BEGIN
                  -- if datasource is ct, check if any lbs has been set in the past, if not return null
                  SELECT   lastbusinessahmsupplierid
                    INTO   ln_businesssupplier
                    FROM   ahmmrnbusinesssupplier
                   WHERE   ahmmrnmemberid = pn_ahmmrnmemberid_in;

                  RETURN ln_businesssupplier;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     RETURN NULL;
               END;
            ELSE
               ln_businesssupplier := returndefaultbussupplier (ln_accountid);
               RETURN ln_businesssupplier;
            END IF;
         ELSE
            -- if more than one member in the aggregation
            -- if there is only one payer in the aggregation, return the related business supplier
            IF nt_lbs.COUNT = 1
            THEN
               ln_businesssupplier := nt_lbs (1).relatedahmbusinesssupplierid;

               IF ln_businesssupplier IS NOT NULL
               THEN
                  RETURN ln_businesssupplier;
               ELSE
                  RETURN returndefaultbussupplier (ln_accountid);
               END IF;
            ELSE                      -- count > 1 -- follow precedence logic.
                   -- collect precedence rule
                   SELECT   *
               BULK COLLECT INTO   lt_precedencerule
                     FROM   ahmmrnsupplierprecedencerule
                    WHERE   accountid = ln_accountid
                            AND precedencerulebasismnemonic LIKE
                                  'LBSPRECEDENCE%'
                 ORDER BY   precedencenbr ASC;

               FOR l_precedence_ctr IN 1 .. lt_precedencerule.COUNT
               LOOP
                  IF lt_precedencerule (
                        l_precedence_ctr
                     ).precedencerulebasismnemonic = 'LBSPRECEDENCE_EMPLOYEE'
                  THEN
                     FOR l_ctr IN 1 .. nt_lbs.COUNT
                     LOOP
                        IF nt_lbs (l_ctr).membertypecode = 'E'
                        THEN
                           ln_employeecount := ln_employeecount + 1;
                           ln_businesssupplier :=
                              nt_lbs (l_ctr).relatedahmbusinesssupplierid;
                        END IF;
                     END LOOP;

                     IF ln_employeecount = 1
                     THEN
                        IF ln_businesssupplier IS NOT NULL
                        THEN
                           RETURN ln_businesssupplier;
                        ELSE
                           RETURN returndefaultbussupplier (ln_accountid);
                        END IF;
                     ELSE
                        ln_businesssupplier := NULL;
                     END IF;
                  END IF;

                  -- if employee count is more than 2, then continue with precendence supplier rule
                  IF lt_precedencerule (
                        l_precedence_ctr
                     ).precedencerulebasismnemonic = 'LBSPRECEDENCE_SUPPLIER'
                  THEN
                     FOR l_ctr IN 1 .. nt_lbs.COUNT
                     LOOP
                        IF lt_precedencerule (l_precedence_ctr).ahmsupplierid
      =
                              nt_lbs (l_ctr).ahmsupplierid
                        THEN
                           ln_businesssupplier :=
                              nt_lbs (l_ctr).relatedahmbusinesssupplierid;

                           IF ln_businesssupplier IS NOT NULL
                           THEN
                              RETURN ln_businesssupplier;
                           ELSE
                              RETURN returndefaultbussupplier (ln_accountid);
                           END IF;
                        END IF;
                     END LOOP;                  -- looping through all members
                  END IF;                    -- supplier based precedence rule
               END LOOP;
      -- for l_precedence_ctr in 1..lt_precedencerule.count  loop

               -- if it comes here, then no business supplier found in the precendence logic -- return default bus
               ln_businesssupplier := returndefaultbussupplier (ln_accountid);
               RETURN ln_businesssupplier;
            END IF;
      -- if nt_lbs.count = 1 and nt_lbs(1).usagemnemonic = 'p' then
         END IF;                                 -- if  nt_lbs.count = 0 then;
      END IF;                               -- if ln_bussuppliercount < 2 then

      RETURN NULL;
   EXCEPTION
      WHEN OTHERS
      THEN
         hie_log_error (
            procedurename_in    => 'FGETBUSINESSSUPPLIER',
            memberid_in         => SUBSTR (DBMS_UTILITY.format_error_backtrace
      ,
                                           -9),
            errornumber_in      => SQLCODE,
            errormessage_in     => SUBSTR (SQLERRM, 1, 100),
            errortimestamp_in   => SYSDATE,
            jseq_in             => NULL
         );
   END fgetbusinesssupplier_new;

   PROCEDURE updatememberprocessstatus (pnmemberid_in   IN number,
                                        pvbits_in       IN varchar2,
                                        pvceflag_in     IN varchar2)
   IS
      vbit             varchar2 (4000);
      vcebit           varchar2 (4000);
      vprocessedflag   careenginememberprocessstatus.processedflag%TYPE;
      vbatchid         careenginememberprocessstatus.batchid%TYPE;
      vmemberid        careenginememberprocessstatus.memberid%TYPE;
   BEGIN
      vbit := pvbits_in;

      SELECT   packnumberconversion.dec2bin (NVL (processedbitind, 0)),
               processedflag,
               batchid
        INTO   vcebit, vprocessedflag, vbatchid
        FROM   careenginememberprocessstatus
       WHERE   memberid = pnmemberid_in               --for update skip locked
                                       ;

      IF (vbatchid <> 100 OR vprocessedflag <> pvceflag_in)
      THEN
         UPDATE   careenginememberprocessstatus
            SET   processedflag = pvceflag_in,
                  batchid = 100,
                  processedbitind =
                     packnumberconversion.bin2dec (
                        packnumberconversion.bitor (vcebit, vbit)
                     ),
                  processedbitupdtdt = SYSDATE,
                  recordupdtdt = SYSDATE,
                  updtdby = USER,
                  incvrunflg = 'Y',
                  incvrunflgupddt = SYSTIMESTAMP
          WHERE   memberid = pnmemberid_in;
      ELSE
         UPDATE   careenginememberprocessstatus
            SET   processedbitind =
                     packnumberconversion.bin2dec (
                        packnumberconversion.bitor (vcebit, vbit)
                     ),
                  processedbitupdtdt = SYSDATE,
                  incvrunflg = 'Y',
                  incvrunflgupddt = SYSTIMESTAMP
          WHERE   memberid = pnmemberid_in;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         hie_log_error (
            procedurename_in    => 'COM_UPDATEMEMBERPROCESSSTATUS',
            memberid_in         => pnmemberid_in,
            errornumber_in      => SQLCODE,
            errormessage_in     => SUBSTR (
                                     'Warning in updatememberprocessstatus '
                                     || SQLERRM,
                                     1,
                                     1000
                                  ),
            errortimestamp_in   => SYSDATE,
            jseq_in             => NULL
         );
   END updatememberprocessstatus;

   FUNCTION isactaccount (
      pn_insuranceorgid_in   IN insuranceorganization.insuranceorgid%TYPE
   )
      RETURN varchar2
   IS
      lv_returnflag   varchar2 (1);
   BEGIN
      SELECT   'Y'
        INTO   lv_returnflag
        FROM   ods.insuranceorganization io,
               insuranceorgsupplierrelation iosr,
               supplierproductrelation spr
       WHERE       io.orgid IS NOT NULL
               AND iosr.insuranceorgid = io.insuranceorgid
               AND spr.supplierorgid = iosr.supplierid
               AND spr.productcd = 'ACT'
               AND (spr.productterminationdt IS NULL
                    OR spr.productterminationdt >= SYSDATE)
               AND io.insuranceorgid = pn_insuranceorgid_in
               AND ROWNUM = 1;

      RETURN lv_returnflag;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 'N';
   END isactaccount;

   PROCEDURE getcurrentwinnerpcp (
      pn_ahmmemberid_in               IN     MEMBER.memberid%TYPE,
      pv_processingmodecd_in          IN     insuranceorganization.
      processingmodecd%TYPE,
      pn_currpcpprovider_out             OUT memberproviderrelationship.
      providerid%TYPE,
      pn_currmasterpcpprovider_out       OUT memberproviderrelationship.
      mastercareproviderid%TYPE,
      pn_currmemberproviderskey_out      OUT memberproviderrelationship.
      memberproviderskey%TYPE
   )
   IS
   BEGIN
      IF pv_processingmodecd_in = 'P'
      THEN
         SELECT   providerid, mastercareproviderid, memberproviderskey
           INTO   pn_currpcpprovider_out,
                  pn_currmasterpcpprovider_out,
                  pn_currmemberproviderskey_out
           FROM   memberproviderrelationship mpr
          WHERE       mpr.memberid = pn_ahmmemberid_in
                  AND mpr.winnerpcpflg = 'Y'
                  AND mpr.exclusioncd = 'IN';
      ELSIF pv_processingmodecd_in = 'H'
      THEN
         SELECT   providerid, mastercareproviderid, memberproviderskey
           INTO   pn_currpcpprovider_out,
                  pn_currmasterpcpprovider_out,
                  pn_currmemberproviderskey_out
           FROM   memberproviderrelationship mpr
          WHERE       mpr.ahmmemberid = pn_ahmmemberid_in
                  AND mpr.winnerpcpflg = 'Y'
                  AND mpr.exclusioncd = 'IN';
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         NULL;
   END getcurrentwinnerpcp;

   FUNCTION fgetmastermemoniccode (p_mastercode_in      IN varchar2,
                                   p_mastergroupcd_in   IN varchar2)
      RETURN mastercode.mastercodemnemonic%TYPE
   IS
      lv_retcode   mastercode.mastercodemnemonic%TYPE;
   BEGIN
      SELECT   mc.mastercodemnemonic
        INTO   lv_retcode
        FROM   ods.mastercode mc
       WHERE   mc.mastercode = p_mastercode_in
               AND mc.mastergroupcd = p_mastergroupcd_in;

      RETURN lv_retcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retcode := NULL;
         RETURN lv_retcode;
   END fgetmastermemoniccode;

   PROCEDURE resetwinnerpcpflg (
      pn_ahmmemberid_in               memberproviderrelationship.ahmmemberid%
      TYPE,
      pn_oldpcpproviderid_in          memberproviderrelationship.providerid%
      TYPE,
      pn_oldmasterpcpproviderid_in    memberproviderrelationship.
      mastercareproviderid%TYPE,
      pn_newpcpproviderid_in          memberproviderrelationship.providerid%
      TYPE,
      pv_processingmodecd_in          insuranceorganization.processingmodecd%
      TYPE,
      pn_accountid_in                 insuranceorganization.insuranceorgid%
      TYPE,
      pv_datasourcenm_in              datasource.datasourcenm%TYPE,
      pn_memberproviderskey_in        memberproviderrelationship.
      memberproviderskey%TYPE,
      pn_oldmemberproviderskey        memberproviderrelationship.
      memberproviderskey%TYPE,
      pv_isactflag                    varchar2,
      pn_checkptstart                 number DEFAULT NULL
   )
   IS
      ln_newmasterpcpproviderid   memberproviderrelationship.
      mastercareproviderid%TYPE;
   BEGIN
      DBMS_OUTPUT.put_line ('New MPRskey ' || pn_memberproviderskey_in);
      DBMS_OUTPUT.put_line ('New PCP ' || pn_newpcpproviderid_in);

      -- if pcp has changed, then set the ce bit 1024
      IF NVL (pn_oldpcpproviderid_in, -1) <> NVL (pn_newpcpproviderid_in, -1)
      THEN
         ods_common_pkg.updatememberprocessstatus (pn_ahmmemberid_in,
                                                   '10000000000',
                                                   'N');
      END IF;

      IF pn_checkptstart IS NOT NULL
      THEN
         ods_core.gt_chk6 := SYSTIMESTAMP;
      END IF;

      -- if new pcp is passed, then terminate the old pcp record
      IF pv_processingmodecd_in = 'P'
      THEN
         IF pn_oldmemberproviderskey IS NOT NULL
         THEN
            -- reset winner pcpflag to null
            UPDATE   memberproviderrelationship
               SET   winnerpcpflg = NULL,
                     updtdby = pv_datasourcenm_in || '_WINNERPCP'
             WHERE       memberid = pn_ahmmemberid_in
                     AND exclusioncd = 'IN'
                     AND winnerpcpflg = 'Y';

            UPDATE   memberpcprelationshiphist
               SET   effenddt = SYSTIMESTAMP,
                     recordupdatedt = SYSTIMESTAMP,
                     updatedby = pv_datasourcenm_in
             WHERE   memberid = pn_ahmmemberid_in AND effenddt IS NULL;
         END IF;

         IF pn_checkptstart IS NOT NULL
         THEN
            ods_core.gt_chk7 := SYSTIMESTAMP;
         END IF;

         -- if new winner found, then update mpr and insert into history
         IF pn_newpcpproviderid_in IS NOT NULL
            AND pn_memberproviderskey_in IS NOT NULL
         THEN
            -- set the winner pcp flag to the new provider.
            UPDATE   memberproviderrelationship mpr
               SET   winnerpcpflg = 'Y',
                     updtdby = pv_datasourcenm_in || '_WINNERPCP'
             WHERE   memberproviderskey = pn_memberproviderskey_in;

            -- insert record for the new pcp
            INSERT INTO memberpcprelationshiphist (memberpcphistskey,
                                                   memberproviderskey,
                                                   memberid,
                                                   providerid,
                                                   effstartdt,
                                                   effenddt,
                                                   pcpflg,
                                                   datasourcenm,
                                                   vendorsourcenm,
                                                   clinicaldoctypemnemonic,
                                                   recordinsertdt,
                                                   recordupdatedt,
                                                   insertedby,
                                                   updatedby)
               SELECT   ods_mbrprovhist_seq.NEXTVAL,
                        memberproviderskey,
                        memberid,
                        providerid,
                        SYSDATE,
                        NULL,
                        winnerpcpflg,
                        datasourcenm,
                        NULL,
                        NULL,
                        SYSTIMESTAMP,
                        SYSTIMESTAMP,
                        pv_datasourcenm_in || '_WINNERPCP',
                        pv_datasourcenm_in || '_WINNERPCP'
                 FROM   memberproviderrelationship mpr
                WHERE   mpr.memberproviderskey = pn_memberproviderskey_in;

            ods_core.gt_chk8 := SYSTIMESTAMP;
         END IF;                 -- if pn_newpcpproviderid_in is not null then
      ELSIF pv_processingmodecd_in = 'H'
      THEN
         IF pn_oldpcpproviderid_in IS NOT NULL
         THEN
            UPDATE   memberproviderrelationship
               SET   winnerpcpflg = NULL,
                     updtdby = pv_datasourcenm_in || '_WINNERPCP'
             WHERE       ahmmemberid = pn_ahmmemberid_in
                     AND exclusioncd = 'IN'
                     AND winnerpcpflg = 'Y';

            UPDATE   memberpcprelationshiphist
               SET   effenddt = SYSTIMESTAMP,
                     recordupdatedt = SYSTIMESTAMP,
                     updatedby = pv_datasourcenm_in
             WHERE   memberid = pn_ahmmemberid_in AND effenddt IS NULL;
         END IF;

         IF pn_checkptstart IS NOT NULL
         THEN
            ods_core.gt_chk7 := SYSTIMESTAMP;
         END IF;

         IF pn_newpcpproviderid_in IS NOT NULL
         THEN
            UPDATE   memberproviderrelationship mpr
               SET   winnerpcpflg = 'Y',
                     updtdby = pv_datasourcenm_in || '_WINNERPCP'
             WHERE   memberproviderskey = pn_memberproviderskey_in;

            INSERT INTO memberpcprelationshiphist (memberpcphistskey,
                                                   memberproviderskey,
                                                   memberid,
                                                   providerid,
                                                   effstartdt,
                                                   effenddt,
                                                   pcpflg,
                                                   datasourcenm,
                                                   vendorsourcenm,
                                                   clinicaldoctypemnemonic,
                                                   recordinsertdt,
                                                   recordupdatedt,
                                                   insertedby,
                                                   updatedby)
               SELECT   ods_mbrprovhist_seq.NEXTVAL,
                        mpr.memberproviderskey,
                        mpr.ahmmemberid,
                        mpr.providerid,
                        SYSDATE,
                        NULL,
                        mpr.winnerpcpflg,
                        mpr.datasourcenm,
                        extn.vendorsourcenm,
                        extn.clinicaldoctypemnemonic,
                        SYSTIMESTAMP,
                        SYSTIMESTAMP,
                        pv_datasourcenm_in || '_WINNERPCP',
                        pv_datasourcenm_in || '_WINNERPCP'
                 FROM   memberproviderrelationship mpr,
                        memberproviderrelationshipextn extn
                WHERE   mpr.memberproviderskey = pn_memberproviderskey_in
                        AND mpr.memberproviderskey =
                              extn.memberproviderskey(+);

            ods_core.gt_chk8 := SYSTIMESTAMP;
         END IF;                 -- if pn_newpcpproviderid_in is not null then
      END IF;                                        -- usagemnemonic in (p,h)

      -- common code for both usage mnemonic
      IF pv_isactflag = 'Y'
      THEN
         -- if there is an open incident for the earlier pcp, it needs to be closed.
         IF pn_oldpcpproviderid_in IS NOT NULL
            AND NVL (pn_oldpcpproviderid_in, -1) <>
                  NVL (pn_newpcpproviderid_in, -1)
         THEN
            DBMS_OUTPUT.put_line (
               'Closing incident for Old PCP ' || pn_oldpcpproviderid_in
            );

            -- if change in pcp, closing pcp challenged status
            UPDATE   mprincidenttrack
               SET   incidentstatusmnemonic =
                        ods_common_pkg.fgetmastermemoniccode ('CLOSED',
                                                              'INCDSTATUS'),
                     updatedby = pv_datasourcenm_in || '_WINNERPCP',
                     updatedbydatasourcenm = pv_datasourcenm_in,
                     updateddt = SYSTIMESTAMP
             WHERE   accountid = pn_accountid_in
                     AND serviceproviderid IN
                              (pn_oldmasterpcpproviderid_in,
                               pn_oldpcpproviderid_in)
                     AND memberid = pn_ahmmemberid_in
                     AND exclusioncd = 'IN'
                     AND incidentstatusmnemonic =
                           ods_common_pkg.fgetmastermemoniccode (
                              'OPEN',
                              'INCDSTATUS'
                           )
                     AND incidentstatemnemonic IN
                              (ods_common_pkg.fgetmastermemoniccode (
                                  'APPROVED',
                                  'INCDSTATE'
                               ),
                               ods_common_pkg.fgetmastermemoniccode (
                                  'SUBMITTED',
                                  'INCDSTATE'
                               ),
                               ods_common_pkg.fgetmastermemoniccode (
                                  'NEW',
                                  'INCDSTATE'
                               ))
                     AND incidenttypemnemonic =
                           ods_common_pkg.fgetmastermemoniccode ('PCPCHLG',
                                                                 'RLTNRSNCD');

            ods_core.gt_chk9 := SYSTIMESTAMP;

            -- closing pcprelchng status.
            UPDATE   mprincidenttrack
               SET   incidentstatusmnemonic =
                        ods_common_pkg.fgetmastermemoniccode ('CLOSED',
                                                              'INCDSTATUS'),
                     updatedby = pv_datasourcenm_in || '_WINNERPCP',
                     updatedbydatasourcenm = pv_datasourcenm_in,
                     updateddt = SYSTIMESTAMP
             WHERE   accountid = pn_accountid_in
                     AND serviceproviderid IN
                              (pn_oldmasterpcpproviderid_in,
                               pn_oldpcpproviderid_in)
                     AND memberid = pn_ahmmemberid_in
                     AND exclusioncd = 'IN'
                     AND incidentstatusmnemonic =
                           ods_common_pkg.fgetmastermemoniccode (
                              'OPEN',
                              'INCDSTATUS'
                           )
                     AND incidentstatemnemonic IN
                              (ods_common_pkg.fgetmastermemoniccode (
                                  'APPROVED',
                                  'INCDSTATE'
                               ),
                               ods_common_pkg.fgetmastermemoniccode (
                                  'SUBMITTED',
                                  'INCDSTATE'
                               ),
                               ods_common_pkg.fgetmastermemoniccode (
                                  'NEW',
                                  'INCDSTATE'
                               ))
                     AND incidenttypemnemonic =
                           ods_common_pkg.fgetmastermemoniccode (
                              'PCPRELCHLG',
                              'RLTNRSNCD'
                           );

            ods_core.gt_chk10 := SYSTIMESTAMP;

            -- addition to above, need to insert into mpr with ch status.
            IF sql%ROWCOUNT > 0 AND pn_oldmasterpcpproviderid_in IS NOT NULL
            THEN
               INSERT INTO memberproviderrelationship (
                                                          memberproviderskey,
                                                          memberid,
                                                          providerid,
                                                          datasourcenm,
                                                          pcpflg,
                                                          providertypecd,
                                                          relationstatuscd,
                                                          relationstatuschangedt
      ,
                                                          exclusioncd,
                                                          recordinsertdt,
                                                          recordupdtdt,
                                                          insertedby,
                                                          updtdby,
                                                          odsclindocskey,
                                                          accountid,
                                                          mastercareproviderid
      ,
                                                          ahmmemberid,
                                                          winnerpcpflg
                          )
                 VALUES   (ods_mbrprov_seq.NEXTVAL,
                           pn_ahmmemberid_in,
                           pn_oldmasterpcpproviderid_in,
                           'CT',
                           'N',
                           'P',
                           'CH',
                           SYSDATE,
                           'IN',
                           SYSTIMESTAMP,
                           SYSTIMESTAMP,
                           pv_datasourcenm_in || '_WINNERPCP',
                           pv_datasourcenm_in || '_WINNERPCP',
                           NULL,
                           pn_accountid_in,
                           pn_oldmasterpcpproviderid_in,
                           pn_ahmmemberid_in,
                           NULL);

               ods_core.gt_chk11 := SYSTIMESTAMP;
            END IF;
         END IF;
      END IF;                                    -- if pv_isactflag = 'y' then

      -- if there is an open incident for the new pcp, it needs to be closed.
      IF pn_newpcpproviderid_in IS NOT NULL
         AND NVL (pn_oldpcpproviderid_in, -1) <>
               NVL (pn_newpcpproviderid_in, -1)
      THEN
         IF pv_isactflag = 'Y'
         THEN
            -- get masterprovider for the new pcp
            BEGIN
               SELECT   mastercareproviderid
                 INTO   ln_newmasterpcpproviderid
                 FROM   provorgstaffmasterxref ps
                WHERE   ps.provorgstaffid = pn_newpcpproviderid_in
                        AND ps.exclusioncd = 'IN';
            EXCEPTION
               WHEN OTHERS
               THEN
                  ln_newmasterpcpproviderid := NULL;
            END;

            ods_core.gt_chk12 := SYSTIMESTAMP;

            UPDATE   mprincidenttrack
               SET   incidentstatusmnemonic =
                        ods_common_pkg.fgetmastermemoniccode ('CLOSED',
                                                              'INCDSTATUS'),
                     updatedby = pv_datasourcenm_in || '_WINNERPCP',
                     updatedbydatasourcenm = pv_datasourcenm_in,
                     updateddt = SYSTIMESTAMP
             WHERE   accountid = pn_accountid_in
                     AND serviceproviderid IN
                              (ln_newmasterpcpproviderid,
                               pn_newpcpproviderid_in)
                     AND memberid = pn_ahmmemberid_in
                     AND exclusioncd = 'IN'
                     AND incidentstatusmnemonic =
                           ods_common_pkg.fgetmastermemoniccode (
                              'OPEN',
                              'INCDSTATUS'
                           )
                     AND incidentstatemnemonic IN
                              (ods_common_pkg.fgetmastermemoniccode (
                                  'APPROVED',
                                  'INCDSTATE'
                               ),
                               ods_common_pkg.fgetmastermemoniccode (
                                  'SUBMITTED',
                                  'INCDSTATE'
                               ),
                               ods_common_pkg.fgetmastermemoniccode (
                                  'NEW',
                                  'INCDSTATE'
                               ))
                     AND incidenttypemnemonic IN
                              (ods_common_pkg.fgetmastermemoniccode (
                                  'PCPREL',
                                  'RLTNRSNCD'
                               ),
                               ods_common_pkg.fgetmastermemoniccode (
                                  'PCP',
                                  'RLTNRSNCD'
                               ));

            ods_core.gt_chk14 := SYSTIMESTAMP;
         END IF;                                 -- if pv_isactflag = 'y' then
      END IF;                     -- if pn_newpcpproviderid_in is not null and
   END resetwinnerpcpflg;

   PROCEDURE getnewwinnerpcp (
      pn_ahmmemberid_in           IN     MEMBER.memberid%TYPE,
      pn_accountid_in             IN     insuranceorganization.insuranceorgid%
      TYPE,
      pv_processingmodecd_in      IN     insuranceorganization.
      processingmodecd%TYPE,
      pv_isactflag_in             IN     varchar2,
      pv_pcpdatasourcenm_in       IN     supplierorganization.pcpdatasourcenm%
      TYPE,
      pn_projectid_in             IN     insuranceorganization.projectid%TYPE,
      pn_newpcpprovider_out          OUT memberproviderrelationship.providerid
      %TYPE,
      pn_memberproviderskey_out      OUT memberproviderrelationship.
      memberproviderskey%TYPE
   )
   IS
   BEGIN
      DBMS_OUTPUT.put_line (' AHM ID' || pn_ahmmemberid_in);
      DBMS_OUTPUT.put_line (
         ' pv_processingmodecd_in ' || pv_processingmodecd_in
      );
      DBMS_OUTPUT.put_line (' pv_isactflag_in_in ' || pv_isactflag_in);
      DBMS_OUTPUT.put_line (
         ' pv_pcpdatasourcenm_in ' || pv_pcpdatasourcenm_in
      );

      /******************************************************************************
                                                                                          ----- processing mode - p
      *******************************************************************************/
      IF pv_processingmodecd_in = 'P'
      THEN
         IF pv_pcpdatasourcenm_in = 'ALL'
         THEN
            IF pv_isactflag_in = 'N'
            THEN
               -- fetch the latest valid pcp across datasources.
               SELECT   MAX(mpr.providerid)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     mpr.recordupdtdt DESC),
                        MAX(mpr.memberproviderskey)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     mpr.recordupdtdt DESC)
                 INTO   pn_newpcpprovider_out, pn_memberproviderskey_out
                 FROM   memberproviderrelationship mpr,
                        careprovider cp,
                        careproviderxref cpx,
                        MEMBER m
                WHERE       mpr.memberid = pn_ahmmemberid_in
                        AND mpr.memberid = m.memberid
                        AND m.effectiveenddt IS NULL
                        AND mpr.exclusioncd = 'IN'
                        AND NVL (cp.exclusioncode, 'IN') = 'IN'
                        AND mpr.pcpflg = 'Y'
                        AND cp.careproviderid = mpr.providerid
                        AND cp.careproviderid = cpx.careproviderid
                        AND cpx.projectid = pn_projectid_in
                        AND NVL (cp.providerfilterflag, 'ZZ') <> 'Y'
                        AND NVL (cp.provideroptoutflag, 'ZZ') <> 'Y'
                        AND NVL (mpr.relationstatuscd, 'ZZZ') <> 'CH';
            ELSE                                    -- 'all' and actflag = 'y'
               SELECT   MAX(mpr.providerid)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     mpr.recordupdtdt DESC),
                        MAX(mpr.memberproviderskey)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     mpr.recordupdtdt DESC)
                 INTO   pn_newpcpprovider_out, pn_memberproviderskey_out
                 FROM   memberproviderrelationship mpr,
                        userfact uf,
                        careprovider cp,
                        MEMBER m
                WHERE       mpr.providerid = uf.userid
                        AND mpr.memberid = pn_ahmmemberid_in
                        AND mpr.memberid = m.memberid
                        AND m.effectiveenddt IS NULL
                        AND uf.accountid = pn_accountid_in
                        AND mpr.exclusioncd = 'IN'
                        AND NVL (cp.exclusioncode, 'IN') = 'IN'
                        AND mpr.pcpflg = 'Y'
                        AND uf.userid = cp.careproviderid
                        AND NVL (cp.providerfilterflag, 'ZZ') <> 'Y'
                        AND NVL (cp.provideroptoutflag, 'ZZ') <> 'Y'
                        AND NVL (mpr.relationstatuscd, 'ZZZ') <> 'CH';
            END IF;
      -- pv_pcpdatasourcenm_in = 'all' and if pv_processingmodecd_in = 'p' and pv_isactflag_in_in = 'n'
         ELSIF pv_pcpdatasourcenm_in = 'PRC'
         THEN
            IF pv_isactflag_in = 'N'
            THEN
               SELECT   MAX(providerid)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     prc.precedencenbr,
                                                     mpr.recordupdtdt DESC),
                        MAX(mpr.memberproviderskey)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     prc.precedencenbr,
                                                     mpr.recordupdtdt DESC)
                 INTO   pn_newpcpprovider_out, pn_memberproviderskey_out
                 FROM   memberproviderrelationship mpr,
                        MEMBER m,
                        ahmmrnsupplierprecedencerule prc,
                        mastercode mc,
                        careprovider cp,
                        careproviderxref cpx,
                        insuranceorganization io
                WHERE       mpr.memberid = pn_ahmmemberid_in
                        AND mpr.memberid = m.memberid
                        AND m.effectiveenddt IS NULL
                        AND m.ahmsupplierid = prc.ahmsupplierid
                        AND prc.precedencerulebasismnemonic LIKE 'PCPPRC%'
                        AND prc.precedencerulebasismnemonic =
                              mc.mastercodemnemonic
                        AND mc.mastercode = mpr.datasourcenm
                        AND cp.careproviderid = mpr.providerid
                        AND cp.careproviderid = cpx.careproviderid
                        AND cpx.projectid = io.projectid
                        AND io.insuranceorgid = pn_accountid_in
                        AND NVL (cp.providerfilterflag, 'ZZ') <> 'Y'
                        AND NVL (cp.provideroptoutflag, 'ZZ') <> 'Y'
                        AND mpr.exclusioncd = 'IN'
                        AND NVL (cp.exclusioncode, 'IN') = 'IN'
                        AND mpr.pcpflg = 'Y'
                        AND NVL (mpr.relationstatuscd, 'ZZZ') <> 'CH';
            ELSE                                      -- prc and actflag = 'y'
               SELECT   MAX(providerid)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     prc.precedencenbr,
                                                     mpr.recordupdtdt DESC),
                        MAX(mpr.memberproviderskey)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     prc.precedencenbr,
                                                     mpr.recordupdtdt DESC)
                 INTO   pn_newpcpprovider_out, pn_memberproviderskey_out
                 FROM   memberproviderrelationship mpr,
                        MEMBER m,
                        ahmmrnsupplierprecedencerule prc,
                        mastercode mc,
                        userfact uf,
                        careprovider cp
                WHERE       mpr.memberid = pn_ahmmemberid_in
                        AND mpr.memberid = m.memberid
                        AND m.effectiveenddt IS NULL
                        AND m.ahmsupplierid = prc.ahmsupplierid
                        AND prc.precedencerulebasismnemonic LIKE 'PCPPRC%'
                        AND prc.precedencerulebasismnemonic =
                              mc.mastercodemnemonic
                        AND mc.mastercode = mpr.datasourcenm
                        AND uf.userid = mpr.providerid
                        AND uf.accountid = pn_accountid_in
                        AND uf.userid = cp.careproviderid
                        AND NVL (cp.exclusioncode, 'IN') = 'IN'
                        AND NVL (cp.providerfilterflag, 'ZZ') <> 'Y'
                        AND NVL (cp.provideroptoutflag, 'ZZ') <> 'Y'
                        AND mpr.exclusioncd = 'IN'
                        AND mpr.pcpflg = 'Y'
                        AND NVL (mpr.relationstatuscd, 'ZZZ') <> 'CH';
            END IF;
      -- pv_pcpdatasourcenm_in = 'all' and if pv_processingmodecd_in = 'p' and pv_isactflag_in in (y,n)
         END IF;
      -- pv_pcpdatasourcenm_in in ('all','prc') and if pv_processingmodecd_in = 'p'
      /******************************************************************************
                                                                                                            ----- processing mode - h
      *******************************************************************************/
      ELSIF pv_processingmodecd_in = 'H'
      THEN
         IF pv_pcpdatasourcenm_in = 'ALL'
         THEN
            IF pv_isactflag_in = 'N'
            THEN
               SELECT   MAX(mpr.providerid)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     mpr.recordupdtdt DESC),
                        MAX(mpr.memberproviderskey)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     mpr.recordupdtdt DESC)
                 INTO   pn_newpcpprovider_out, pn_memberproviderskey_out
                 FROM   memberproviderrelationship mpr,
                        careprovider cp,
                        careproviderxref cpx,
                        insuranceorganization io,
                        MEMBER m
                WHERE       mpr.ahmmemberid = pn_ahmmemberid_in
                        AND mpr.exclusioncd = 'IN'
                        AND mpr.memberid = m.memberid
                        AND m.effectiveenddt IS NULL
                        AND mpr.pcpflg = 'Y'
                        AND cp.careproviderid = mpr.providerid
                        AND cp.careproviderid = cpx.careproviderid
                        AND cpx.projectid = io.projectid
                        AND io.insuranceorgid = pn_accountid_in
                        AND NVL (cp.exclusioncode, 'IN') = 'IN'
                        AND NVL (cp.providerfilterflag, 'ZZ') <> 'Y'
                        AND NVL (cp.provideroptoutflag, 'ZZ') <> 'Y'
                        AND NVL (mpr.relationstatuscd, 'ZZZ') <> 'CH';
            ELSE                                     --'all' and actflag = 'y'
               SELECT   MAX(mpr.providerid)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     mpr.recordupdtdt DESC),
                        MAX(mpr.memberproviderskey)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     mpr.recordupdtdt DESC)
                 INTO   pn_newpcpprovider_out, pn_memberproviderskey_out
                 FROM   memberproviderrelationship mpr,
                        userfact uf,
                        careprovider cp,
                        MEMBER m
                WHERE       mpr.providerid = uf.userid
                        AND mpr.ahmmemberid = pn_ahmmemberid_in
                        AND mpr.memberid = m.memberid
                        AND m.effectiveenddt IS NULL
                        AND uf.accountid = pn_accountid_in
                        AND mpr.exclusioncd = 'IN'
                        AND NVL (cp.exclusioncode, 'IN') = 'IN'
                        AND mpr.pcpflg = 'Y'
                        AND uf.userid = cp.careproviderid
                        AND NVL (cp.providerfilterflag, 'ZZ') <> 'Y'
                        AND NVL (cp.provideroptoutflag, 'ZZ') <> 'Y'
                        AND NVL (mpr.relationstatuscd, 'ZZZ') <> 'CH';
            END IF;
         ELSIF pv_pcpdatasourcenm_in = 'PRC'
         THEN
            IF pv_isactflag_in = 'Y'
            THEN
               SELECT   MAX(providerid)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     precedencenbr,
                                                     recordupdtdt DESC),
                        MAX(memberproviderskey)
                           KEEP (DENSE_RANK FIRST ORDER BY
                                                     precedencenbr,
                                                     recordupdtdt DESC)
                 INTO   pn_newpcpprovider_out, pn_memberproviderskey_out
                 FROM   (
      -- all the providers from the precedence with no vendorsourcenm or doctype defined
                          --                       select mpr.providerid
                          --                             ,prc.precedencenbr
                          --                             ,mpr.recordupdtdt
                          --                         from memberproviderrelationship mpr
                          --                             ,ahmmrnbusinesssupplier lbs
                          --                             ,ahmmrnsupplierprecedencerule prc
                          --                             ,mastercode mc
                          --                             ,userfact uf
                          --                             ,careprovider cp
                          --                        where mpr.ahmmemberid = pn_ahmmemberid_in
                          --                          and mpr.ahmmemberid = lbs.ahmmrnmemberid
                          --                          and lbs.lastbusinessahmsupplierid = prc.ahmsupplierid
                          --                          and prc.precedencerulebasismnemonic like '%prc%'
                          --                          and prc.precedencerulebasismnemonic = mc.mastercodemnemonic
                          --                          and prc.vendorsourcenm is null
                          --                          and prc.clinicaldoctypemnemonic is null
                          --                          and mc.mastercode = mpr.datasourcenm
                          --                          and uf.userid = mpr.providerid
                          --                          and uf.accountid = pn_accountid_in
                          --                          and uf.userid = cp.careproviderid
                          --                          and nvl (cp.providerfilterflag
                          --                                  ,'zz'
                          --                                  ) <> 'y'
                          --                          and nvl (cp.provideroptoutflag
                          --                                  ,'zz'
                          --                                  ) <> 'y'
                          --                          and mpr.exclusioncd = 'in'
                          --                          and nvl(cp.exclusioncode,'in') = 'in'
                          --                          and mpr.pcpflg = 'y'
                          --                          and nvl (mpr.relationstatuscd
                          --                                  ,'zzz'
                          --                                  ) not in ('vl', 'ch')
                          SELECT   mpr.providerid,
                                   prc.precedencenbr,
                                   mpr.recordupdtdt,
                                   mpr.memberproviderskey
                            FROM   memberproviderrelationship mpr,
                                   ahmmrnbusinesssupplier lbs,
                                   ahmmrnsupplierprecedencerule prc,
                                   mastercode mc,
                                   userfact uf,
                                   careprovider cp,
                                   MEMBER m,
                                   supplierorganization so
                           WHERE   mpr.ahmmemberid = pn_ahmmemberid_in
                                   AND mpr.ahmmemberid = lbs.ahmmrnmemberid
                                   AND lbs.lastbusinessahmsupplierid =
                                         prc.ahmsupplierid
                                   AND lbs.lastbusinessahmsupplierid =
                                         so.relatedahmbusinesssupplierid
                                   AND so.ahmsupplierid = m.ahmsupplierid
                                   AND mpr.memberid = m.memberid
                                   AND m.effectiveenddt IS NULL
                                   AND prc.precedencerulebasismnemonic LIKE
                                         'PCPPRC%'
                                   AND prc.precedencerulebasismnemonic =
                                         mc.mastercodemnemonic
                                   AND prc.vendorsourcenm IS NULL
                                   AND prc.clinicaldoctypemnemonic IS NULL
                                   AND mc.mastercode = mpr.datasourcenm
                                   AND uf.userid = mpr.providerid
                                   AND uf.accountid = pn_accountid_in
                                   AND uf.userid = cp.careproviderid
                                   AND NVL (cp.providerfilterflag, 'ZZ') <>
                                         'Y'
                                   AND NVL (cp.provideroptoutflag, 'ZZ') <>
                                         'Y'
                                   AND mpr.exclusioncd = 'IN'
                                   AND NVL (cp.exclusioncode, 'IN') = 'IN'
                                   AND mpr.pcpflg = 'Y'
                                   AND NVL (mpr.relationstatuscd, 'ZZZ') <>
                                         'CH'
                         UNION ALL
                         -- for attributed suppliers where vendorsource and doctype are not defined.
                         SELECT   mpr.providerid,
                                  prc.precedencenbr,
                                  mpr.recordupdtdt,
                                  mpr.memberproviderskey
                           FROM   memberproviderrelationship mpr,
                                  ahmmrnbusinesssupplier lbs,
                                  ahmmrnsupplierprecedencerule prc,
                                  mastercode mc,
                                  userfact uf,
                                  careprovider cp,
                                  attributedmember am,
                                  supplierorganization so,
                                  MEMBER m
                          WHERE   mpr.ahmmemberid = pn_ahmmemberid_in
                                  AND mpr.ahmmemberid = lbs.ahmmrnmemberid
                                  AND lbs.lastbusinessahmsupplierid =
                                        prc.ahmsupplierid
                                  AND lbs.lastbusinessahmsupplierid =
                                        so.relatedahmbusinesssupplierid
                                  AND so.ahmsupplierid =
                                        am.attributedpayersupplierid
                                  AND mpr.memberid = am.memberid
                                  AND mpr.memberid = m.memberid
                                  AND m.effectiveenddt IS NULL
                                  AND am.projectid = pn_projectid_in
                                  AND am.effectiveenddt IS NULL
                                  AND prc.precedencerulebasismnemonic LIKE
                                        'PCPPRC%'
                                  AND prc.precedencerulebasismnemonic =
                                        mc.mastercodemnemonic
                                  AND prc.vendorsourcenm IS NULL
                                  AND prc.clinicaldoctypemnemonic IS NULL
                                  AND mc.mastercode = mpr.datasourcenm
                                  AND uf.userid = mpr.providerid
                                  AND uf.accountid = pn_accountid_in
                                  AND uf.userid = cp.careproviderid
                                  AND NVL (cp.providerfilterflag, 'ZZ') <>
                                        'Y'
                                  AND NVL (cp.provideroptoutflag, 'ZZ') <>
                                        'Y'
                                  AND mpr.exclusioncd = 'IN'
                                  AND NVL (cp.exclusioncode, 'IN') = 'IN'
                                  AND mpr.pcpflg = 'Y'
                                  AND NVL (mpr.relationstatuscd, 'ZZZ') <>
                                        'CH'
                         UNION ALL
                         -- all the providers from the precendence where vendorsourcenm or doctype are defined
                         SELECT   mpr.providerid,
                                  prc.precedencenbr,
                                  mpr.recordupdtdt,
                                  mpr.memberproviderskey
                           FROM   memberproviderrelationship mpr,
                                  memberproviderrelationshipextn ext,
                                  ahmmrnbusinesssupplier lbs,
                                  ahmmrnsupplierprecedencerule prc,
                                  mastercode mc,
                                  userfact uf,
                                  careprovider cp
                          WHERE   mpr.memberproviderskey =
                                     ext.memberproviderskey
                                  AND mpr.ahmmemberid = lbs.ahmmrnmemberid
                                  AND mpr.ahmmemberid = pn_ahmmemberid_in
                                  AND lbs.lastbusinessahmsupplierid =
                                        prc.ahmsupplierid
                                  AND prc.precedencerulebasismnemonic LIKE
                                        'PCPPRC%'
                                  AND prc.precedencerulebasismnemonic =
                                        mc.mastercodemnemonic
                                  AND NVL (prc.vendorsourcenm, 'ZZZ') =
                                        NVL (ext.vendorsourcenm, 'ZZZ')
                                  AND NVL (prc.clinicaldoctypemnemonic,
                                           'ZZZ') =
                                        NVL (ext.clinicaldoctypemnemonic,
                                             'ZZZ')
                                  AND mc.mastercode = mpr.datasourcenm
                                  AND uf.userid = mpr.providerid
                                  AND uf.accountid = pn_accountid_in
                                  AND uf.userid = cp.careproviderid
                                  AND NVL (cp.providerfilterflag, 'ZZ') <>
                                        'Y'
                                  AND NVL (cp.provideroptoutflag, 'ZZ') <>
                                        'Y'
                                  AND mpr.exclusioncd = 'IN'
                                  AND NVL (cp.exclusioncode, 'IN') = 'IN'
                                  AND mpr.pcpflg = 'Y'
                                  AND NVL (mpr.relationstatuscd, 'ZZZ') <>
                                        'CH'
                         UNION ALL
                         SELECT   mpr.providerid,
                                  prc.precedencenbr,
                                  mpr.recordupdtdt,
                                  mpr.memberproviderskey
                           FROM   memberproviderrelationship mpr,
                                  memberproviderrelationshipextn ext,
                                  ahmmrnbusinesssupplier lbs,
                                  ahmmrnsupplierprecedencerule prc,
                                  mastercode mc,
                                  userfact uf,
                                  careprovider cp,
                                  MEMBER m,
                                  supplierorganization so
                          WHERE   mpr.ahmmemberid = pn_ahmmemberid_in
                                  AND mpr.ahmmemberid = lbs.ahmmrnmemberid
                                  AND mpr.memberproviderskey =
                                        ext.memberproviderskey(+)
                                  AND lbs.lastbusinessahmsupplierid =
                                        prc.ahmsupplierid
                                  AND prc.ahmsupplierid = so.ahmsupplierid
                                  AND so.defaultbusinesssupplierflg = 'Y'
                                  AND mpr.memberid = m.memberid
                                  AND m.effectiveenddt IS NULL
                                  AND prc.precedencerulebasismnemonic LIKE
                                        'PCPPRC%'
                                  AND prc.precedencerulebasismnemonic =
                                        mc.mastercodemnemonic
                                  AND NVL (prc.vendorsourcenm, 'ZZZ') =
                                        NVL (ext.vendorsourcenm, 'ZZZ')
                                  AND NVL (prc.clinicaldoctypemnemonic,
                                           'ZZZ') =
                                        NVL (ext.clinicaldoctypemnemonic,
                                             'ZZZ')
                                  AND mc.mastercode = mpr.datasourcenm
                                  AND uf.userid = mpr.providerid
                                  AND uf.accountid = pn_accountid_in
                                  AND uf.userid = cp.careproviderid
                                  AND NVL (cp.providerfilterflag, 'ZZ') <>
                                        'Y'
                                  AND NVL (cp.provideroptoutflag, 'ZZ') <>
                                        'Y'
                                  AND mpr.exclusioncd = 'IN'
                                  AND NVL (cp.exclusioncode, 'IN') = 'IN'
                                  AND mpr.pcpflg = 'Y'
                                  AND NVL (mpr.relationstatuscd, 'ZZZ') <>
                                        'CH');
            END IF;                           -- if pv_isactflag_in in 'y','n'
         END IF;
      --   pv_pcpdatasourcenm_in  in ('all','prc') and if pv_processingmodecd_in = 'h'
      END IF;                          -- if processing mode code in ('p','h')
   END getnewwinnerpcp;

   PROCEDURE setwinnerpcp (
      pn_accountid_in      IN insuranceorganization.insuranceorgid%TYPE
      DEFAULT NULL
                                                                          ,
      pn_ahmmemberid_in    IN MEMBER.memberid%TYPE,
      pv_datasourcenm_in   IN datasource.datasourcenm%TYPE
   )
   IS
      ln_accountid                insuranceorganization.insuranceorgid%TYPE;
      lv_processingmodecd         insuranceorganization.processingmodecd%TYPE;
      lv_actflag                  varchar2 (1);
      lv_pcpdatasourcenm          supplierorganization.pcpdatasourcenm%TYPE;
      lv_providerassignationcd    supplierorganization.providerassignationcd%
      TYPE;
      ln_oldpcpproviderid         memberproviderrelationship.providerid%TYPE;
      ln_oldmasterpcpproviderid   memberproviderrelationship.
      mastercareproviderid%TYPE;
      ln_newpcpproviderid         memberproviderrelationship.providerid%TYPE;
      ln_newmasterpcpproviderid   memberproviderrelationship.
      mastercareproviderid%TYPE;
      ln_projectid                insuranceorganization.projectid%TYPE;
      ln_memberproviderskey       memberproviderrelationship.
      memberproviderskey%TYPE;
      ln_currmemberproviderskey   memberproviderrelationship.
      memberproviderskey%TYPE;
   BEGIN
      ods_common_pkg.resetchkpt;
      ods_core.gt_start := SYSTIMESTAMP;

      -- if account id is not passed, derive from memberid
      IF pn_accountid_in IS NULL
      THEN
         -- ln_accountid                 := ods_common_pkg.fgetaccountidformember (pn_ahmmemberid_in);
         -- derive from member id
         BEGIN
            SELECT   vw.processingmodecd, vw.projectid, vw.accountid
              INTO   lv_processingmodecd, ln_projectid, ln_accountid
              FROM   MEMBER m, vw_project_account_rel vw
             WHERE   m.ahmsupplierid = vw.ahmsupplierid
                     AND m.memberid = pn_ahmmemberid_in;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20005,
                  'Unable to retrive account id for member '
                  || pn_ahmmemberid_in
               );
         END;
      ELSE
         ln_accountid := pn_accountid_in;

         BEGIN
            SELECT   processingmodecd, projectid
              INTO   lv_processingmodecd, ln_projectid
              FROM   vw_project_account_rel io
             WHERE   io.accountid = ln_accountid AND ROWNUM = 1;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               raise_application_error (-20005,
                                        'Invalid IO id ' || ln_accountid);
         END;
      END IF;

      ods_core.gt_chk1 := SYSTIMESTAMP;
      -- get the processingmodecd for the account

      -- check if the account is act or non-act
      lv_actflag := ods_common_pkg.isactaccount (ln_accountid);
      ods_core.gt_chk2 := SYSTIMESTAMP;

      IF lv_processingmodecd = 'P'
      THEN
         -- no aggregation. instance id is the ahm member id.
         -- get the pcpdatasourcenm, provider assignation code for member supplier
         BEGIN
            SELECT   pcpdatasourcenm, providerassignationcd
              INTO   lv_pcpdatasourcenm, lv_providerassignationcd
              FROM   supplierorganization so, MEMBER m
             WHERE   so.ahmsupplierid = m.ahmsupplierid
                     AND m.memberid = pn_ahmmemberid_in;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               raise_application_error (
                  -20005,
                  'No record in supplierorganization for the memberid '
                  || pn_ahmmemberid_in
               );
         END;
      ELSIF lv_processingmodecd = 'H'
      THEN
         -- get the pcpdatasourcenm, provider assignation code for member supplier
         BEGIN
            SELECT   pcpdatasourcenm, providerassignationcd
              INTO   lv_pcpdatasourcenm, lv_providerassignationcd
              FROM   supplierorganization so, ahmmrnbusinesssupplier lbs
             WHERE   so.ahmsupplierid = lbs.lastbusinessahmsupplierid
                     AND lbs.ahmmrnmemberid = pn_ahmmemberid_in;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               raise_application_error (
                  -20005,
                  'Unable to retrieve PCP datasourcenm for the memberid '
                  || pn_ahmmemberid_in
               );
         END;
      END IF;

      ods_core.gt_chk3 := SYSTIMESTAMP;
      DBMS_OUTPUT.put_line ('pcpdatasourcenm ' || lv_pcpdatasourcenm);
      DBMS_OUTPUT.put_line (
         'providerassignationcd ' || lv_providerassignationcd
      );
      -- get existing pcp.
      ods_common_pkg.getcurrentwinnerpcp (
         pn_ahmmemberid_in               => pn_ahmmemberid_in,
         pv_processingmodecd_in          => lv_processingmodecd,
         pn_currpcpprovider_out          => ln_oldpcpproviderid,
         pn_currmasterpcpprovider_out    => ln_oldmasterpcpproviderid,
         pn_currmemberproviderskey_out   => ln_currmemberproviderskey
      );
      DBMS_OUTPUT.put_line ('Old PCP ' || ln_oldpcpproviderid);
      ods_core.gt_chk4 := SYSTIMESTAMP;

      -- if pcp datasource is na or the provider assignation is not pcp, then no need to set winner flag
      --- terminate if any pcp exists currently
      IF lv_pcpdatasourcenm = 'NA'
         OR NVL (lv_providerassignationcd, 'ZZ') <> 'PCP'
      THEN
         -- if record found then reset the mpr winner pcp flag
         IF ln_oldpcpproviderid IS NOT NULL
         THEN
            resetwinnerpcpflg (
               pn_ahmmemberid_in              => pn_ahmmemberid_in,
               pn_oldpcpproviderid_in         => ln_oldpcpproviderid,
               pn_oldmasterpcpproviderid_in   => ln_oldmasterpcpproviderid,
               pn_newpcpproviderid_in         => NULL,
               pv_processingmodecd_in         => lv_processingmodecd,
               pn_accountid_in                => ln_accountid,
               pv_datasourcenm_in             => pv_datasourcenm_in,
               pn_memberproviderskey_in       => NULL,
               pn_oldmemberproviderskey       => ln_currmemberproviderskey,
               pv_isactflag                   => lv_actflag
            );
         END IF;

         ods_core.gt_chk5 := SYSTIMESTAMP;
         RETURN;
      ELSE
         -- else get the new pcp. if it's different, then need to terminate old pcp and add the new one.

         -- get new pcp
         ods_common_pkg.getnewwinnerpcp (
            pn_ahmmemberid_in           => pn_ahmmemberid_in,
            pn_accountid_in             => ln_accountid,
            pv_processingmodecd_in      => lv_processingmodecd,
            pv_isactflag_in             => lv_actflag,
            pv_pcpdatasourcenm_in       => lv_pcpdatasourcenm,
            pn_projectid_in             => ln_projectid,
            pn_newpcpprovider_out       => ln_newpcpproviderid,
            pn_memberproviderskey_out   => ln_memberproviderskey
         );
         DBMS_OUTPUT.put_line ('ln_newpcpproviderid ' || ln_newpcpproviderid);
         ods_core.gt_chk5 := SYSTIMESTAMP;

         IF NVL (ln_memberproviderskey, -1) <>
               NVL (ln_currmemberproviderskey, -1)
         THEN
            -- reset the winner pcp flag
            resetwinnerpcpflg (
               pn_ahmmemberid_in              => pn_ahmmemberid_in,
               pn_oldpcpproviderid_in         => ln_oldpcpproviderid,
               pn_oldmasterpcpproviderid_in   => ln_oldmasterpcpproviderid,
               pn_newpcpproviderid_in         => ln_newpcpproviderid,
               pv_processingmodecd_in         => lv_processingmodecd,
               pn_accountid_in                => ln_accountid,
               pv_datasourcenm_in             => pv_datasourcenm_in,
               pn_memberproviderskey_in       => ln_memberproviderskey,
               pn_oldmemberproviderskey       => ln_currmemberproviderskey,
               pv_isactflag                   => lv_actflag,
               pn_checkptstart                => 7
            );
            ods_core.gt_chk15 := SYSTIMESTAMP;
         END IF;         -- if ln_oldpcpproviderid =  ln_newpcpproviderid then
      END IF;            -- if    lv_pcpdatasourcenm in ('na','prc','all' etc)

      ods_core.gt_end := SYSTIMESTAMP;

      IF (ods_core.gt_end - ods_core.gt_start) >
            ods_core.fgetdebugexecutiontime ('SETWINNERPCP')
      THEN
         ods_core.loglongcall (pv_procedurenm_in   => 'SETWINNERPCP',
                               pv_logtable_in      => NULL,
                               pn_logtableseq_in   => NULL,
                               pt_start_in         => ods_core.gt_start,
                               pt_chk1_in          => ods_core.gt_chk1,
                               pt_chk2_in          => ods_core.gt_chk2,
                               pt_chk3_in          => ods_core.gt_chk3,
                               pt_chk4_in          => ods_core.gt_chk4,
                               pt_chk5_in          => ods_core.gt_chk5,
                               pt_chk6_in          => ods_core.gt_chk6,
                               pt_chk7_in          => ods_core.gt_chk7,
                               pt_chk8_in          => ods_core.gt_chk8,
                               pt_chk9_in          => ods_core.gt_chk9,
                               pt_chk10_in         => ods_core.gt_chk10,
                               pt_chk11_in         => ods_core.gt_chk11,
                               pt_chk12_in         => ods_core.gt_chk12,
                               pt_chk13_in         => ods_core.gt_chk13,
                               pt_chk14_in         => ods_core.gt_chk14,
                               pt_chk15_in         => ods_core.gt_chk15,
                               pt_end_in           => ods_core.gt_end);
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         hie_log_error (
            procedurename_in    => 'SETWINNERPCP',
            memberid_in         => SUBSTR (DBMS_UTILITY.format_error_backtrace
      ,
                                           -9),
            errornumber_in      => SQLCODE,
            errormessage_in     =>   'Error for MRN '
                                  || pn_ahmmemberid_in
                                  || ':'
                                  || SUBSTR (SQLERRM, 1, 200),
            errortimestamp_in   => SYSDATE,
            jseq_in             => NULL
         );
         RAISE;
   END setwinnerpcp;

   PROCEDURE setwinnerpcp (
      pn_accountid_in         IN     insuranceorganization.insuranceorgid%TYPE
      ,
      pn_ahmmemberidlist_in   IN     table_memberid,
      pv_datasourcenm_in      IN     datasource.datasourcenm%TYPE,
      pn_returncode_out          OUT number
   )
   IS
   BEGIN
      IF pn_ahmmemberidlist_in IS NOT NULL
      THEN
         FOR l_ctr IN 1 .. pn_ahmmemberidlist_in.COUNT
         LOOP
            BEGIN
               ods_common_pkg.setwinnerpcp (
                  pn_accountid_in      => pn_accountid_in,
                  pn_ahmmemberid_in    => pn_ahmmemberidlist_in (l_ctr),
                  pv_datasourcenm_in   => pv_datasourcenm_in
               );
            EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
            END;
         END LOOP;
      END IF;

      pn_returncode_out := ct_core.ferrorcodesct ('CT', 'SUCCESSFUL');
   END setwinnerpcp;

   PROCEDURE pcpbatchrefresh (p_batchid_in        IN     number,
                              p_mprcacheflg_in    IN     varchar2,
                              p_datasourcenm_in   IN     varchar2,
                              p_returncode_out       OUT number)
   IS
      lv_accountid           userpatienttracker.accountid%TYPE;
      lv_memberidlist        table_memberid;
      lv_memberplanidlist    table_memberid;
      lv_limit               number;
      lv_returncode          number;
      lv_err_line            varchar2 (4000);
      lv_tran_id             number;
      lv_memberstslist       mbrrefreshsts_tab := mbrrefreshsts_tab ();
      -- changed to get the sucess/error
      lv_count               number;
      ln_existingwinnerpcp   memberproviderrelationship.providerid%TYPE;
      ln_existingmasterpcp   memberproviderrelationship.mastercareproviderid%
      TYPE;
      ln_newwinnerpcp        memberproviderrelationship.providerid%TYPE;
      ln_newmasterpcp        memberproviderrelationship.mastercareproviderid%
      TYPE;

      CURSOR cur1
      IS
         SELECT   DISTINCT UP.memberid, UP.memberplanid
           FROM   userpatienttracker UP
          WHERE       UP.userpatienttrackerid = p_batchid_in
                  AND processstatus = 'PENDING'
                  AND UP.actionflag IN ('A', 'C');
      -- do we need to check <> 'd' instead

      PROCEDURE setdebuginfo (lp_batchid_in        IN number,
                              lp_mprcacheflg_in    IN varchar2,
                              lp_datasourcenm_in   IN varchar2)
      IS
         PRAGMA AUTONOMOUS_TRANSACTION;
      BEGIN
         SELECT   transaction_seq.NEXTVAL INTO lv_tran_id FROM DUAL;

         INSERT INTO dbug_pcpbatchrefresh (batchid,
                                           mprcacheflag,
                                           datasourcenm,
                                           recordinsertdt,
                                           log_seq)
           VALUES   (lp_batchid_in,
                     lp_mprcacheflg_in,
                     lp_datasourcenm_in,
                     SYSTIMESTAMP,
                     lv_tran_id);

         COMMIT;
      END;
   BEGIN
      ods_core.gt_start := SYSTIMESTAMP;

      IF fdebug ('PCPBATCHREFRESH') = 'Y'
      THEN
         setdebuginfo (lp_batchid_in        => p_batchid_in,
                       lp_mprcacheflg_in    => p_mprcacheflg_in,
                       lp_datasourcenm_in   => p_datasourcenm_in);
      END IF;

      BEGIN
         SELECT   UP.accountid
           INTO   lv_accountid
           FROM   userpatienttracker UP
          WHERE   UP.userpatienttrackerid = p_batchid_in AND ROWNUM < 2;
      EXCEPTION
         WHEN OTHERS
         THEN
            lv_accountid := NULL;
      END;

      lv_limit :=
         ct_core.fgetrefservicefilter (p_servicenm_in    => 'PCPBATCHREFRESH',
                                       p_datasource_in   => 'CT',
                                       p_searchstring    => 'FETCHLIMIT');
      lv_limit := NVL (lv_limit, 1000);
      ods_core.gt_chk1 := SYSTIMESTAMP;

      OPEN cur1;

      LOOP
         FETCH cur1
            BULK COLLECT INTO   lv_memberidlist, lv_memberplanidlist
            LIMIT lv_limit;

         EXIT WHEN lv_memberidlist.COUNT = 0;

         FOR i IN lv_memberidlist.FIRST .. lv_memberidlist.LAST
      -- changed to get the sucess/error
         LOOP                               -- changed to get the sucess/error
            BEGIN
               IF (p_mprcacheflg_in = 'Y')
               THEN
                  -- get existing winner pcp
                  BEGIN
                     SELECT   providerid, mastercareproviderid
                       INTO   ln_existingwinnerpcp, ln_existingmasterpcp
                       FROM   memberproviderrelationship mpr
                      WHERE       mpr.ahmmemberid = lv_memberidlist (i)
                              AND mpr.winnerpcpflg = 'Y'
                              AND mpr.pcpflg = 'Y'
                              AND mpr.exclusioncd = 'IN';
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        ln_existingwinnerpcp := NULL;
                        ln_existingmasterpcp := NULL;
                  END;
               END IF;

               ods_common_pkg.setwinnerpcp (
                  pn_accountid_in      => lv_accountid,
                  pn_ahmmemberid_in    => lv_memberidlist (i)
      -- changed to get the sucess/error
                                                             ,
                  pv_datasourcenm_in   => p_datasourcenm_in
               );

               IF (p_mprcacheflg_in = 'Y')
               THEN
                  -- get new winner pcp
                  BEGIN
                     SELECT   providerid, mastercareproviderid
                       INTO   ln_newwinnerpcp, ln_newmasterpcp
                       FROM   memberproviderrelationship mpr
                      WHERE       mpr.ahmmemberid = lv_memberidlist (i)
                              AND mpr.winnerpcpflg = 'Y'
                              AND mpr.pcpflg = 'Y'
                              AND mpr.exclusioncd = 'IN';
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        ln_newwinnerpcp := NULL;
                        ln_newmasterpcp := NULL;
                  END;

                  -- if different, then both these ids should be in the upt table for this member
                  IF NVL (ln_existingwinnerpcp, -1) <>
                        NVL (ln_newwinnerpcp, -1)
                  THEN
                     INSERT INTO userpatienttracker (userpatienttrackerid,
                                                     accountid,
                                                     memberid,
                                                     memberplanid,
                                                     providerid,
                                                     masterflag,
                                                     associationsource,
                                                     associationstatus,
                                                     pcpindicator,
                                                     pcpsource,
                                                     pcpdate,
                                                     actionflag,
                                                     processdt,
                                                     processstatus,
                                                     insertedby,
                                                     inserteddt,
                                                     updatedby,
                                                     updateddt)
                        SELECT   p_batchid_in,
                                 lv_accountid,
                                 lv_memberidlist (i),
                                 lv_memberplanidlist (i),
                                 p.providerid,
                                 p.masterflag,
                                 NULL               --  associationsource    ,
                                     ,
                                 NULL                -- associationstatus    ,
                                     ,
                                 NULL                -- pcpindicator         ,
                                     ,
                                 NULL                -- pcpsource            ,
                                     ,
                                 NULL                -- pcpdate              ,
                                     ,
                                 actionflag,
                                 SYSDATE,
                                 processstatus,
                                 'PCPBATCHREFRESH',
                                 SYSTIMESTAMP,
                                 'PCPBATCHREFRESH',
                                 SYSTIMESTAMP
                          FROM   (SELECT   ln_existingwinnerpcp providerid,
                                           'N' masterflag,
                                           (CASE
                                               WHEN ln_existingmasterpcp IS
      NOT NULL
                                               THEN
                                                  'D'
                                               ELSE
                                                  'A'
                                            END)
                                              actionflag,
                                           (CASE
                                               WHEN ln_existingmasterpcp IS
      NOT NULL
                                               THEN
                                                  'PROCESSED'
                                               ELSE
                                                  'PENDING'
                                            END)
                                              processstatus
                                    FROM   DUAL
                                   WHERE   ln_existingwinnerpcp IS NOT NULL
                                  UNION ALL
                                  SELECT   ln_existingmasterpcp providerid,
                                           'Y' masterflag,
                                           'A',
                                           'PENDING'
                                    FROM   DUAL
                                   WHERE   ln_existingmasterpcp IS NOT NULL
                                  UNION ALL
                                  SELECT   ln_newwinnerpcp providerid,
                                           'N' masterflag,
                                           (CASE
                                               WHEN ln_newmasterpcp IS NOT
      NULL
                                               THEN
                                                  'D'
                                               ELSE
                                                  'A'
                                            END),
                                           (CASE
                                               WHEN ln_newmasterpcp IS NOT
      NULL
                                               THEN
                                                  'PROCESSED'
                                               ELSE
                                                  'PENDING'
                                            END)
                                              processstatus
                                    FROM   DUAL
                                   WHERE   ln_newwinnerpcp IS NOT NULL
                                  UNION ALL
                                  SELECT   ln_newmasterpcp providerid,
                                           'Y' masterflag,
                                           'A',
                                           'PENDING'
                                    FROM   DUAL
                                   WHERE   ln_newmasterpcp IS NOT NULL) p
                         WHERE   NOT EXISTS
                                    (SELECT   NULL
                                       FROM   userpatienttracker upt
                                      WHERE   upt.userpatienttrackerid =
                                                 p_batchid_in
                                              AND upt.memberid =
                                                    lv_memberidlist (i)
                                              AND upt.providerid =
                                                    p.providerid);
                  END IF;
               END IF;

               IF (p_mprcacheflg_in = 'N')
               THEN
                  lv_memberstslist.EXTEND (1);
                  lv_memberstslist (lv_memberstslist.LAST) :=
                     mbrrefreshsts_obj (lv_memberidlist (i), 'SUCCESS');
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  lv_memberstslist.EXTEND (1);
                  lv_memberstslist (lv_memberstslist.LAST) :=
                     mbrrefreshsts_obj (lv_memberidlist (i), 'ERROR');
            END;
         -- changed to get the sucess/error
         END LOOP;
      -- changed to get the sucess/error
      END LOOP;

      CLOSE cur1;

      ods_core.gt_chk2 := SYSTIMESTAMP;

      IF (p_mprcacheflg_in = 'Y')
      THEN
         actuserpatientbatchrefresh (
            p_userpatienttrackerid_in   => p_batchid_in
         );
      ELSIF (p_mprcacheflg_in = 'N')
      THEN
         FORALL idx IN 1 .. lv_memberstslist.COUNT
            UPDATE   userpatienttracker upt
               SET   upt.processstatus =
                        DECODE (lv_memberstslist (idx).processstatus,
                                'SUCCESS', 'COMPLETED',
                                'ERROR', 'EXCEPTION',
                                'NOTPROCESSED'),
                     updatedby = USER || '_WINNERPCP',
                     updateddt = SYSTIMESTAMP,
                     processdt = SYSDATE
             -- pojo flag
             WHERE       upt.userpatienttrackerid = p_batchid_in
                     AND upt.memberid = lv_memberstslist (idx).memberid
                     AND upt.actionflag IN ('A', 'C');
      END IF;

      ods_core.gt_end := SYSTIMESTAMP;

      IF (ods_core.gt_end - ods_core.gt_start) >
            ods_core.fgetdebugexecutiontime ('PCPBATCHREFRESH')
      THEN
         ods_core.loglongcall (pv_procedurenm_in      => 'PCPBATCHREFRESH',
                               pn_procreturncode_in   => NULL,
                               pn_logtableseq_in      => lv_tran_id,
                               pt_start_in            => ods_core.gt_start,
                               pt_chk1_in             => ods_core.gt_chk1,
                               pt_chk2_in             => ods_core.gt_chk2,
                               pt_end_in              => ods_core.gt_end);
      END IF;

      p_returncode_out := ct_core.ferrorcodesct ('CT', 'SUCCESSFUL');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         p_returncode_out := ct_core.ferrorcodesct ('CT', 'NOT SUCCESSFUL');
      WHEN OTHERS
      THEN
         p_returncode_out := ct_core.ferrorcodesct ('CT', 'NOT SUCCESSFUL');
         lv_err_line := DBMS_UTILITY.format_error_backtrace;
         log_error ('PCPBATCHREFRESH',
                    SUBSTR (lv_err_line, -9),
                    SQLCODE,
                    SQLERRM,
                    SYSDATE,
                    NULL);
   END pcpbatchrefresh;

   FUNCTION fgetaccountidformember (p_member_id IN MEMBER.memberid%TYPE)
      RETURN insuranceorganization.insuranceorgid%TYPE
   IS
      l_accountid   insuranceorganization.insuranceorgid%TYPE;
   BEGIN
      SELECT   io.insuranceorgid
        INTO   l_accountid
        FROM   MEMBER m,
               insuranceorgsupplierrelation iosr,
               supplierorganization so,
               insuranceorganization io
       WHERE       m.ahmsupplierid = so.ahmsupplierid
               AND so.supplierorgid = iosr.supplierid
               AND iosr.insuranceorgid = io.insuranceorgid
               AND m.memberid = p_member_id;

      RETURN l_accountid;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END fgetaccountidformember;

   FUNCTION fcheckwinnerpcpsts (p_memberid      number,
                                p_supplierid    number,
                                p_datasource    varchar2)
      RETURN varchar2
   IS
      ln_supplierid          MEMBER.ahmsupplierid%TYPE;
      lv_processmodecd       insuranceorganization.processingmodecd%TYPE;
      lv_pcpdatasourcenm     supplierorganization.pcpdatasourcenm%TYPE;
      lv_provassignationcd   supplierorganization.providerassignationcd%TYPE;
      ln_prccount            number;
   BEGIN
      IF (p_supplierid IS NULL)
      THEN
         SELECT   io.processingmodecd, m.ahmsupplierid
           INTO   lv_processmodecd, ln_supplierid
           FROM   insuranceorganization io,
                  insuranceorgsupplierrelation iosr,
                  supplierorganization so,
                  MEMBER m
          WHERE       io.insuranceorgid = iosr.insuranceorgid
                  AND so.supplierorgid = iosr.supplierid
                  AND so.ahmsupplierid = m.ahmsupplierid
                  AND m.memberid = p_memberid;

         /*select io.processingmodecd
                                                                   into lv_processmodecd
          from insuranceorganization io, insuranceorgsupplierrelation iosr
         where io.insuranceorgid = iosr.insuranceorgid
           and iosr.supplierid =
               (select so.supplierorgid
                  from supplierorganization so
                 where so.ahmsupplierid = (select m.ahmsupplierid
          from member m
         where m.memberid = p_memberid));*/
         IF (lv_processmodecd = 'H')
         THEN
            SELECT   lbs.lastbusinessahmsupplierid
              INTO   ln_supplierid
              FROM   ahmmrnbusinesssupplier lbs
             WHERE   lbs.ahmmrnmemberid = p_memberid;
         END IF;
      ELSE
         ln_supplierid := p_supplierid;
      END IF;

      SELECT   so.pcpdatasourcenm, so.providerassignationcd
        INTO   lv_pcpdatasourcenm, lv_provassignationcd
        FROM   supplierorganization so
       WHERE   so.ahmsupplierid = ln_supplierid;

      IF (lv_provassignationcd <> 'PCP')
      THEN
         RETURN 'N';
      END IF;

      IF (lv_pcpdatasourcenm = 'ALL')
      THEN
         RETURN 'Y';
      ELSIF (lv_pcpdatasourcenm = 'PRC')
      THEN
         SELECT   COUNT (1)
           INTO   ln_prccount
           FROM   ahmmrnsupplierprecedencerule pr
          WHERE   pr.ahmsupplierid = ln_supplierid
                  AND pr.precedencerulebasismnemonic LIKE
                        'PCPPRC%' || p_datasource || '%';

         IF ln_prccount > 0
         THEN
            RETURN 'Y';
         ELSE
            RETURN 'N';
         END IF;
      ELSE
         RETURN 'N';
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         log_error ('FCHECKWINNERPCPSTS',
                    p_memberid,
                    SQLCODE,
                    SQLERRM,
                    SYSDATE,
                    NULL);
         RETURN 'N';                                          -- need to check
   END fcheckwinnerpcpsts;

   PROCEDURE raise_error (p_errcode_in IN number, p_errmsg_in IN varchar2)
   IS
      ln_dummy   varchar2 (1);
   BEGIN
      -- check if the errorcode passed is one of the retry error codes.
      SELECT   'Y'
        INTO   ln_dummy
        FROM   refservicefilterlkup
       WHERE       servicenm = 'RETRYERRORCODES'
               AND datasourcenm = 'HIE'
               AND lkupstring = 'RETRYERRORCODES'
               AND lkupvalue = p_errcode_in;

      raise_application_error (-20899, p_errcode_in || p_errmsg_in);
   EXCEPTION
      WHEN OTHERS
      THEN
         IF p_errcode_in BETWEEN -20999 AND -20001
         THEN
            raise_application_error (p_errcode_in, p_errmsg_in);
         ELSE
            raise_application_error (-20001, p_errmsg_in);
         END IF;
   END raise_error;

   PROCEDURE resetchkpt
   IS
   BEGIN
      ods_core.gt_start := NULL;
      ods_core.gt_chk1 := NULL;
      ods_core.gt_chk2 := NULL;
      ods_core.gt_chk3 := NULL;
      ods_core.gt_chk4 := NULL;
      ods_core.gt_chk5 := NULL;
      ods_core.gt_chk6 := NULL;
      ods_core.gt_chk7 := NULL;
      ods_core.gt_chk8 := NULL;
      ods_core.gt_chk9 := NULL;
      ods_core.gt_chk10 := NULL;
      ods_core.gt_chk11 := NULL;
      ods_core.gt_chk12 := NULL;
      ods_core.gt_chk13 := NULL;
      ods_core.gt_chk14 := NULL;
      ods_core.gt_chk15 := NULL;
      ods_core.gt_chk16 := NULL;
      ods_core.gt_chk17 := NULL;
      ods_core.gt_chk18 := NULL;
      ods_core.gt_chk19 := NULL;
      ods_core.gt_chk20 := NULL;
   END resetchkpt;

   FUNCTION fget_acteligibilityflg (
      pn_supplierid_in   IN supplierorganization.ahmsupplierid%TYPE
   )
      RETURN varchar2
   AS
      vflag   varchar2 (10);
   BEGIN
      SELECT   'Y'
        INTO   vflag
        FROM   ods.supplierorganization so, ods.supplierproductrelation spr
       WHERE       spr.supplierorgid = so.supplierorgid
               AND so.ahmsupplierid = pn_supplierid_in
               AND spr.productcd = 'ACT'
               AND (spr.productterminationdt IS NULL
                    OR spr.productterminationdt >= SYSDATE)
               AND ROWNUM < 2;

      RETURN vflag;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 'N';
   END fget_acteligibilityflg;

   FUNCTION fgetdodformember (pn_memberplanid_in IN number)
      RETURN date
   AS
      lv_deceaseddt   date;
   BEGIN
      SELECT   MAX (pe.deceaseddt)
                  KEEP (DENSE_RANK FIRST ORDER BY pe.updateddt DESC)
        INTO   lv_deceaseddt
        FROM   personext pe, MEMBER m
       WHERE       m.primarymemberplanid = pn_memberplanid_in
               AND m.ahmsupplierid <> 0
               AND pe.personid = m.personid
               AND ( (pe.deceasedflg = 'Y'
                      AND pe.createdbydatasourcenm = 'CT')
                    OR (pe.deceasedflg = 'Y'
                        AND pe.createdbydatasourcenm <> 'CT'
                        AND NOT EXISTS
                              (SELECT   1
                                 FROM   ods.personext pe1
                                WHERE   pe1.personid = pe.personid
                                        AND pe1.createdbydatasourcenm = 'CT'))
      )
               AND pe.deceaseddt IS NOT NULL;

      RETURN lv_deceaseddt;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END fgetdodformember;

   PROCEDURE sp_debuglog (p_procedurename IN varchar2, p_text IN varchar2)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      INSERT INTO debuglog (procedurename, debugtext, runtime)
        VALUES   (p_procedurename, p_text, SYSTIMESTAMP);

      COMMIT;
   END sp_debuglog;

   FUNCTION fchkaccount (memberid_in IN number, accountid_in IN number)
      RETURN varchar2
   AS
      vflag   varchar2 (5);
   BEGIN
      SELECT   'Y'
        INTO   vflag
        FROM   MEMBER mbr,
               supplierorganization so,
               insuranceorgsupplierrelation iosr
       WHERE       mbr.memberid = memberid_in
               AND mbr.ahmsupplierid = so.ahmsupplierid
               AND so.supplierorgid = iosr.supplierid
               AND iosr.insuranceorgid = accountid_in;

      RETURN vflag;
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            SELECT   'Y'
              INTO   vflag
              FROM   MEMBER mbr,
                     ods.attributedmember ats,
                     vw_project_account_rel par
             WHERE       mbr.memberid = memberid_in
                     AND ats.memberid = mbr.memberid
                     AND ats.projectid = par.projectid
                     AND par.accountid = accountid_in
                     AND ats.effectiveenddt IS NULL
                     AND ROWNUM < 2;

            RETURN vflag;
         EXCEPTION
            WHEN OTHERS
            THEN
               RETURN 'N';
         END;
   END fchkaccount;

   FUNCTION fchecklbsforwinnerpcp (
      p_accountid                    insuranceorganization.insuranceorgid%TYPE
      ,
      p_lastbusinessahmsupplierid    ahmmrnbusinesssupplier.
      lastbusinessahmsupplierid%TYPE,
      p_vendorsourcenm               ahmmrnsupplierprecedencerule.
      vendorsourcenm%TYPE,
      p_clinicaldoctypemnemonic      ahmmrnsupplierprecedencerule.
      clinicaldoctypemnemonic%TYPE
   )
      RETURN varchar2
   IS
      lv_returnvalue   varchar2 (1);
   BEGIN
      SELECT   'Y'
        INTO   lv_returnvalue
        FROM   ahmmrnsupplierprecedencerule
       WHERE       accountid = p_accountid
               AND vendorsourcenm = p_vendorsourcenm
               AND clinicaldoctypemnemonic = p_clinicaldoctypemnemonic
               AND precedencerulebasismnemonic LIKE 'PCP%'
               AND ahmsupplierid = p_lastbusinessahmsupplierid;

      RETURN lv_returnvalue;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 'N';
   END fchecklbsforwinnerpcp;

   PROCEDURE getmemberlist (
      p_seq                   IN            number,
      p_memberplanidlist_in   IN            table_memberid,
      p_processingmodecd      IN            varchar2,
      p_returncode_out           OUT NOCOPY number
   )
   IS
      lv_txn_seq            number;
      lv_memberid           number;
      lv_return_code        number;
      lv_processingmodecd   varchar2 (1);
   BEGIN
      lv_return_code := ct_core.ferrorcodesct ('CT', 'SUCCESSFUL');
      lv_processingmodecd := p_processingmodecd;

      --delete from global_ct_temp_member_list;
      EXECUTE IMMEDIATE 'Truncate table global_ct_temp_member_list';

      ---select transaction_seq.nextval into lv_txn_seq from dual;

      IF (lv_processingmodecd = 'H')
      THEN
         INSERT INTO global_ct_temp_member_list (transactionseq,
                                                 mastermemberid,
                                                 mastermemberplanid,
                                                 mastermbrclpatid,
                                                 mastermbrissorgid,
                                                 ahmmrnmemberid,
                                                 ahmmrnmemberplanid,
                                                 ahmmrnclpatid,
                                                 ahmmrnissorgid,
                                                 memberid,
                                                 memberplanid,
                                                 memberclpatid,
                                                 memberissorgid,
                                                 memberaggregate)
            SELECT   p_seq seq_no,
                     ma.mastermemberid,
                     NULL mastermemberplanid,
                     NULL mastermbrclpatid,
                     NULL mastermbrissorgid,
                     ma.ahmmrnmemberid localmrnmemberid,
                     primarymemberplanid AS localmrnmemberplanid,
                     NULL localmrnclpatid,
                     NULL localmrnissorgid,
                     ma.memberid,
                     ct_core.fgetref ('MEMBERPLANID', ma.memberid, 'CLPATID')
                        mbrplanid,
                     -- added nvl(<>,0) for clpatid and issorgid. 6/28/11
                     ct_core.fgetref ('PATID', ma.memberid, 'CLPATID') patid,
                     ct_core.fgetref ('ISSORGID', ma.memberid, 'CLPATID')
                        issorgid,
                     'Y' agg_flag
              FROM   memberaggregation ma, MEMBER m
             WHERE   m.primarymemberplanid IN
                           (SELECT   * FROM table (p_memberplanidlist_in))
                     AND ma.ahmmrnmemberid = m.memberid
                     AND ma.effectiveenddt IS NULL;
      END IF;

      IF (lv_processingmodecd = 'P')
      THEN
         INSERT INTO global_ct_temp_member_list (transactionseq,
                                                 mastermemberid,
                                                 mastermemberplanid,
                                                 mastermbrclpatid,
                                                 mastermbrissorgid,
                                                 ahmmrnmemberid,
                                                 ahmmrnmemberplanid,
                                                 ahmmrnclpatid,
                                                 ahmmrnissorgid,
                                                 memberid,
                                                 memberplanid,
                                                 memberclpatid,
                                                 memberissorgid,
                                                 memberaggregate)
            SELECT   p_seq AS seq_no,
                     mbr.memberid AS mastermemberid,
                     NULL AS mastermemberplanid,
                     NULL AS mastermbrclpatid,
                     NULL AS mastermbrissorgid,
                     mbr.memberid localmrnmemberid,
                     primarymemberplanid AS localmrnmemberplanid,
                     NULL localmrnclpatid,
                     NULL localmrnissorgid,
                     mbr.memberid,
                     TO_CHAR (mbr.primarymemberplanid) AS mbrplanid,
                     ct_core.fgetref ('PATID', mbr.memberid, 'CLPATID')
                        AS patid,
                     ct_core.fgetref ('ISSORGID', mbr.memberid, 'CLPATID')
                        AS issorgid,
                     'N' AS agg_flag
              FROM   MEMBER mbr
             WHERE   mbr.primarymemberplanid IN
                           (SELECT   * FROM table (p_memberplanidlist_in));
      END IF;

     <<finish>>
      p_returncode_out := lv_return_code;
   END getmemberlist;

   FUNCTION checkproductforsupplier (
      p_ahmsupplierid   IN supplierorganization.ahmsupplierid%TYPE,
      p_productcd       IN supplierproductrelation.productcd%TYPE
   )
      RETURN varchar2
   IS
      lv_returnvalue   varchar2 (1);
   BEGIN
      SELECT   'Y'
        INTO   lv_returnvalue
        FROM   supplierorganization so, supplierproductrelation spr
       WHERE       spr.supplierorgid = so.supplierorgid
               AND spr.productcd = p_productcd
               AND so.ahmsupplierid = p_ahmsupplierid
               AND (spr.productterminationdt IS NULL
                    OR spr.productterminationdt >= SYSDATE);

      RETURN lv_returnvalue;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 'N';
   END checkproductforsupplier;

   FUNCTION fgetmemberemailaddress (pn_memberplanid_in IN number)
      RETURN number
   IS
      ln_emailskey   number;
      lv_emailconsentflg ods.supplierorganization.emailconsentflg%TYPE;
   BEGIN
	SELECT emailid
		INTO ln_emailskey
		FROM (
				SELECT pea.partyid,
					pea.emailid,
							  pea.emailaddr,
							  ROW_NUMBER () --  get the latest email addresss
							  OVER (
									PARTITION BY pea.partyid
									ORDER BY
									CASE
										WHEN pea.updtdatasourcenm IN ('PHR_UE','AA')
										THEN
											'A'
										ELSE
											'B'
									END ASC
								) email_rn
						 FROM ods.partyemailaddress pea, ods.member m
						WHERE pea.partyid = m.personid
						AND m.primarymemberplanid = pn_memberplanid_in
				) WHERE email_rn = 1;
		RETURN ln_emailskey;
	/*

      SELECT   p1.emailid
        INTO   ln_emailskey
        FROM   ods.MEMBER m1, ods.partyemailaddress p1
       WHERE       m1.primarymemberplanid = pn_memberplanid_in
               AND m1.ahmsupplierid <> 0
               AND m1.personid = p1.partyid
               AND p1.emailpreferenceflg = 'Y'
               AND p1.createdbydatasourcenm IN ('PHR_UE', 'AA','HDMS') -- US101550
               AND p1.updtdatasourcenm IN ('PHR_UE', 'AA','HDMS','COMMENG')  -- US101550,US113391
               AND p1.deletedbydatasourcenm IS NULL
			   AND NOT EXISTS
					(SELECT 1
					FROM ods.partyemailaddress p2
					WHERE m1.personid                  = p2.partyid
					AND NVL(p2.emailpreferenceflg,'Y') = 'N'
					AND p2.deletedbydatasourcenm IS NULL
					) --US113391 added to remove supplier override member preference
               AND ROWNUM = 1;
      RETURN ln_emailskey;
   EXCEPTION
       WHEN NO_DATA_FOUND THEN  -- US86154
      BEGIN
            SELECT NVL(emailconsentflg,'N')
            INTO lv_emailconsentflg
            FROM ods.supplierorganization so, ods.MEMBER m1
            WHERE m1.primarymemberplanid = pn_memberplanid_in
             AND so.ahmsupplierid = m1.ahmsupplierid;
             IF lv_emailconsentflg ='Y' THEN
               SELECT   p1.emailid
               INTO   ln_emailskey
               FROM   ods.MEMBER m1, ods.partyemailaddress p1
               WHERE   m1.primarymemberplanid = pn_memberplanid_in
                   AND m1.personid = p1.partyid
                   AND p1.createdbydatasourcenm = 'HDMS'
                   AND p1.deletedbydatasourcenm IS NULL
                   AND NOT EXISTS (SELECT 1 FROM ods.partyemailaddress p1
                                   WHERE  m1.personid = p1.partyid
                                          AND NVL(p1.emailpreferenceflg,'Y') =
      'N')
                   AND ROWNUM = 1;

                    END IF;
                     RETURN ln_emailskey;
                    EXCEPTION
                       WHEN NO_DATA_FOUND  THEN
                         ln_emailskey := NULL;
                    RETURN ln_emailskey;
                     END; */
EXCEPTION
   WHEN OTHERS
      THEN
         ln_emailskey := NULL;
         RETURN ln_emailskey;
   END fgetmemberemailaddress;

  FUNCTION fgetyearqtr  (pd_date_in IN date)
      RETURN number
   AS
      ln_fyearqtr   number;
   BEGIN
      SELECT   TO_CHAR (pd_date_in, 'YYYYQ')
        INTO   ln_fyearqtr
        FROM   DUAL;

      RETURN ln_fyearqtr;
   END fgetyearqtr;

   -- to get previous 4th quarter
   FUNCTION fgetpreviousyearqtr  (pd_date_in IN date)
      RETURN number
   AS
    --( ex current quarter  20162 then  previous quarter  20153)
      ln_fyearqtr   number;
   BEGIN
      SELECT   TO_CHAR (ADD_MONTHS(pd_date_in,-9),'YYYYQ')
        INTO   ln_fyearqtr
        FROM   DUAL;

      RETURN ln_fyearqtr;
   END fgetpreviousyearqtr;


 FUNCTION fgetmastersupplierid (
    pn_memberid_in              IN ods.MEMBER.memberid%TYPE DEFAULT NULL ,
    pn_primarymemberplanid_in   IN ods.MEMBER.primarymemberplanid%TYPE DEFAULT
      NULL,
    pn_supplierid_in            IN ods.MEMBER.ahmsupplierid%TYPE DEFAULT NULL
      -- supplierid for 'p' ,businesssupplierid for 'h' acct
 )
    RETURN number RESULT_CACHE
 AS
    /****************************************************************************
            date                description         version      author                                                                                                                                                                                    date                description         version
            6/23/2016              to get masstersupplierid      1.0   chitra
          *****************************************************************************/
    ln_mastersupplierid   ods.mastersuppliersupplierrelation.mastersupplierid%
      TYPE;
    ln_ahmmrnmemberid     ods.memberaggregation.ahmmrnmemberid%TYPE;
    lv_processingmodecd   varchar2 (2);
    ln_ahmsupplierid      ods.MEMBER.ahmsupplierid%TYPE;
 BEGIN
    IF pn_supplierid_in IS NULL
    AND (pn_memberid_in IS NOT NULL
      OR pn_primarymemberplanid_in IS NOT NULL)
    THEN

      IF pn_memberid_in IS NOT NULL THEN
         SELECT   ahmsupplierid
           INTO   ln_ahmsupplierid
           FROM   ods.MEMBER
          WHERE   memberid = pn_memberid_in
          AND ahmsupplierid <>0;
       ELSIF    pn_primarymemberplanid_in IS NOT NULL
        THEN
         SELECT   ahmsupplierid
           INTO   ln_ahmsupplierid
           FROM   ods.MEMBER
          WHERE   primarymemberplanid = pn_primarymemberplanid_in
          AND ahmsupplierid <>0;
       END IF;

    -- check 'h' or 'p' acct
    SELECT   processingmodecd
   INTO   lv_processingmodecd
   FROM   vw_project_account_rel
     WHERE   ahmsupplierid = ln_ahmsupplierid;

    IF lv_processingmodecd = 'H'  -- if 'h' acct then get businesssupplierid
    THEN
    BEGIN
    SELECT   lastbusinessahmsupplierid
      INTO   ln_ahmsupplierid
      FROM   ods.ahmmrnbusinesssupplier
     WHERE   ahmmrnmemberid IN
          (SELECT   ahmmrnmemberid
          FROM   ods.memberaggregation
         WHERE   memberid = pn_memberid_in
           AND effectiveenddt IS NULL);
    EXCEPTION
    WHEN OTHERS
    THEN
       NULL;
    END;
    END IF;                           -- end of if lv_processingmodecd = 'h'
    ELSE
    ln_ahmsupplierid := pn_supplierid_in;
    END IF;
      -- end of   if pn_supplierid_in is null

    SELECT   mastersupplier
   INTO   ln_mastersupplierid
   FROM   vw_projectsupplier
  WHERE  supplier = ln_ahmsupplierid;

    RETURN ln_mastersupplierid;
 EXCEPTION
    WHEN OTHERS
    THEN
    RETURN NULL;
 END fgetmastersupplierid;

   PROCEDURE seterrorinfo (pv_prcoessnm    IN varchar2 DEFAULT NULL,
                        pv_parameter1   IN varchar2 DEFAULT NULL,
                        pv_parameter2   IN varchar2 DEFAULT NULL,
                        pv_parameter3   IN varchar2 DEFAULT NULL,
                        pv_parameter4   IN varchar2 DEFAULT NULL,
                        pv_parameter5   IN varchar2 DEFAULT NULL,
                        pv_comments     IN varchar2 DEFAULT NULL,
                        pv_errormsg     IN varchar2 DEFAULT NULL)
 IS
    PRAGMA AUTONOMOUS_TRANSACTION;
 BEGIN
    INSERT INTO odserrorlog (err_seq,
        processnm,
        parameter1,
        parameter2,
        parameter3,
        parameter4,
        parameter5,
        parameter_comments,
        errormsg,
        insertdt)
    SELECT   error_seq.NEXTVAL,
       pv_prcoessnm,
       pv_parameter1,
       pv_parameter2,
       pv_parameter3,
       pv_parameter4,
       pv_parameter5,
       pv_comments,
       pv_errormsg,
       SYSTIMESTAMP
   FROM   DUAL;

    COMMIT;
 EXCEPTION
    WHEN OTHERS
    THEN
    NULL;
 END seterrorinfo;

FUNCTION fgetmemberarchivepersistflg (pn_memberid IN number) RETURN
      varchar2 IS
    lv_flg char(1);
 BEGIN
    SELECT archpersistflg
     INTO lv_flg
    FROM careenginememberprocessstatus
  WHERE memberid = pn_memberid;

  RETURN lv_flg;

  EXCEPTION
  WHEN NO_DATA_FOUND  THEN
    RETURN 'Y';
  WHEN OTHERS THEN
    RETURN 'N';
END fgetmemberarchivepersistflg;
PROCEDURE updateincvrunprocessstatus (
   pn_memberid_in   IN number,
   pv_incvflag_in   IN varchar2,
   pt_lastauditdate_in IN timestamp,
   p_errorcode_out       OUT number,
   p_errormsg_out       OUT varchar2
) AS
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

   IF pv_incvflag_in ='Y' THEN
      UPDATE   ods.careenginememberprocessstatus
         SET   incvrunflgupddt = SYSTIMESTAMP,
               updtdby = USER,
               incvrunflg = pv_incvflag_in
       WHERE   memberid = pn_memberid_in          ;

         p_errorcode_out     := 0;
         p_errormsg_out       := 'Success';
    ELSIF pv_incvflag_in ='N' THEN
       UPDATE   ods.careenginememberprocessstatus
          SET   incvrunflgupddt = SYSTIMESTAMP,
                updtdby = USER,
                incvrunflg = pv_incvflag_in
         WHERE   memberid = pn_memberid_in
         --AND NVL(incvrunflg,'Y') ='Y'
         AND NVL(incvrunflgupddt,pt_lastauditdate_in) <= pt_lastauditdate_in;

         IF sql%ROWCOUNT =0 THEN
           p_errorcode_out     := -2;
           p_errormsg_out       :=
      'Warning ! Member Last Incv update date may be different' ;
         ELSE
            p_errorcode_out     := 0;
            p_errormsg_out       := 'Success';
         END IF;

    END IF;




   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
     log_error ('UPDATEINCVRUNPROCESSSTATUS',
                 pn_memberid_in,
                 SQLCODE,
                 SQLERRM,
                 SYSDATE,
                 NULL);
  p_errorcode_out     := -1;
   p_errormsg_out       := SUBSTR(SQLERRM,1,2000);

END updateincvrunprocessstatus;

PROCEDURE  getincvrunprocessstatus (
   pn_memberid_in   IN number,
   pv_runflag_out OUT varchar2,
   pt_lastupddt_out OUT timestamp
)
IS
BEGIN

   SELECT NVL(incvrunflg,'Y'),NVL(incvrunflgupddt,SYSTIMESTAMP)
     INTO pv_runflag_out,pt_lastupddt_out
     FROM ods.careenginememberprocessstatus
    WHERE memberid = pn_memberid_in;


EXCEPTION
   WHEN OTHERS THEN
      pv_runflag_out := 'N';
      pt_lastupddt_out := NULL;
END getincvrunprocessstatus;

FUNCTION fGetaccountstatus(
    Pn_insuranceorgid_in              IN ods.insuranceorganization.
      insuranceorgid%
      TYPE
 )
    RETURN VARCHAR2  RESULT_CACHE

AS
  ln_productcount  NUMBER;
 BEGIN
     SELECT   COUNT(1) INTO   ln_productcount
                FROM   ods.VW_PROJECT_ACCOUNT_REL par,
                              ods.supplierproductrelation spr
                      WHERE     spr.supplierorgid = par.supplierorgid
                              AND par.accountid  = Pn_insuranceorgid_in
                              AND (productterminationdt IS NULL
                                   OR productterminationdt > TRUNC (SYSDATE));

  IF ln_productcount  > 0 THEN
         RETURN  'A';   -- Active
    ELSE
         RETURN  'T'; -- Termed
END IF;

EXCEPTION
    WHEN OTHERS THEN
          RETURN   NULL;
END fGetaccountstatus;


FUNCTION fgetdatashareconsentflg (pn_ahmsupplierid_in NUMBER)
  RETURN VARCHAR2
  AS
     lv_datashareconsentflg varchar2(1);
  BEGIN

        SELECT  NVL(datashareconsentflg,(SELECT LKUPVALUE
									FROM REFSERVICEFILTERLKUP
									WHERE LKUPSTRING = 'NULLVALUE'
									AND SERVICENM    = 'DATASHARECONSENTFLG'
									))
            INTO lv_datashareconsentflg
            FROM ODS.supplierorganization
        WHERE ahmsupplierid = pn_ahmsupplierid_in;
        RETURN lv_datashareconsentflg;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN  NULL;
  END fgetdatashareconsentflg;

 PROCEDURE getpersonaggregatemembers (
   memberid_in        IN     NUMBER,
   ahmsupplierid_in   IN     NUMBER,
   memberid_obj_out      OUT table_memberid,
   errorcode             OUT NUMBER,
   personviewflg_in  IN  VARCHAR2 DEFAULT  'N'
)
AS
   --
   --******************************************************************************
   --$Workfile:   sp_getaggregatemembersforphr.sql  $ (File name)
   --$Author:   MThiagarajan  $ (Last modified user)
   --$Modtime:   18 Jun 2013 $ (Last modified time)
   --$Revision:   1.1 (Revision number)
   --Owner:  ODS
   ---Mantis 27275
   --******************************************************************************
   --
 vprocessingmodecd   insuranceorganization.processingmodecd%TYPE;
 lv_datashareconsentflg   supplierorganization.datashareconsentflg %TYPE;
 ln_aggregatememberid  personaggregation.aggregatememberid%TYPE;
BEGIN

 IF   personviewflg_in = 'N' THEN
       getaggregatemembersforphr_esb (memberid_in,
                                 ahmsupplierid_in,
                                 memberid_obj_out,
                                 errorcode);
   ELSE
      BEGIN   -- Personview starts

          SELECT aggregatememberid INTO ln_aggregatememberid
                FROM  ods.personaggregation  m
               WHERE  m.memberid = memberid_in
                 AND m.effectiveenddt IS NULL
				 AND ROWNUM = 1;

            SELECT   memberid
        BULK COLLECT INTO   memberid_obj_out
            FROM   (SELECT   a.memberid
                FROM   ods.personaggregation A,
                       ods.MEMBER M
               WHERE       m.memberid = A.MEMBERID
                     AND A.effectiveenddt IS NULL
                       AND A.aggregatememberid = ln_aggregatememberid
                       AND A.AGGREGATEMEMBERID <> A.MEMBERID
                       AND ods.ods_common_pkg.fgetdatashareconsentflg(pn_ahmsupplierid_in => M.AHMSUPPLIERID )='Y'
              UNION
                  SELECT  memberid_in FROM DUAL);
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  SELECT   memberid_in
                              BULK COLLECT INTO   memberid_obj_out
                                    FROM   DUAL;
         END;  -- Personview Ends
          errorcode := 0;
   END IF ;  -- personviewflg_in = 'N'

  <<FINISH>>
   NULL;
EXCEPTION
   WHEN OTHERS
   THEN
      errorcode := 1;
END getpersonaggregatemembers;

 FUNCTION fgetpersonaggregateid(
   memberid_in        IN     NUMBER
)
  RETURN NUMBER
AS
  ln_aggregatememberid     personaggregation.aggregatememberid%TYPE;

BEGIN
       SELECT aggregatememberid INTO ln_aggregatememberid
                FROM  ods.personaggregation  m
            WHERE  m.memberid = memberid_in
                  AND m.effectiveenddt IS NULL
				  AND ROWNUM  = 1;
   RETURN ln_aggregatememberid;
      EXCEPTION
             WHEN NO_DATA_FOUND THEN
                RETURN NULL;
END fgetpersonaggregateid;


FUNCTION fgetpersonviewflg
  RETURN VARCHAR2

 AS
lv_LKUPVALUE  REFSERVICEFILTERLKUP.LKUPVALUE%TYPE;
BEGIN
    SELECT LKUPVALUE INTO lv_LKUPVALUE FROM REFSERVICEFILTERLKUP
                WHERE LKUPSTRING = 'PERSONVIEWENABLEFLG'
                                         AND SERVICENM = 'PERSONVIEW';

RETURN lv_LKUPVALUE ;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
   RETURN 'N';
END fgetpersonviewflg;


 FUNCTION fgetdatashareconsentformember (memberid_in IN NUMBER DEFAULT NULL,
                                       memberplanid_in IN NUMBER  DEFAULT NULL)
    RETURN VARCHAR2
	AS
	lv_datashareconsentflg  varchar2(1);

  BEGIN



	IF memberid_in IS NOT NULL THEN
      SELECT  NVL(datashareconsentflg,(SELECT LKUPVALUE
									FROM REFSERVICEFILTERLKUP
									WHERE LKUPSTRING = 'NULLVALUE'
									AND SERVICENM    = 'DATASHARECONSENTFLG'
									))
            INTO lv_datashareconsentflg
            FROM ODS.supplierorganization so,ods.member m
        WHERE so.ahmsupplierid = m.ahmsupplierid
		      AND m.memberid = memberid_in;

	ELSIF memberplanid_in IS NOT NULL THEN
      SELECT  NVL(datashareconsentflg,(SELECT LKUPVALUE
									FROM REFSERVICEFILTERLKUP
									WHERE LKUPSTRING = 'NULLVALUE'
									AND SERVICENM    = 'DATASHARECONSENTFLG'
									))
            INTO lv_datashareconsentflg
            FROM ODS.supplierorganization so,ods.member m
        WHERE so.ahmsupplierid = m.ahmsupplierid
		      AND m.primarymemberplanid = memberplanid_in;
    END IF;
      RETURN lv_datashareconsentflg;
  END fgetdatashareconsentformember;

  FUNCTION fgetmemberplanid (pn_memberid_in IN ods.MEMBER.memberid%TYPE)
RETURN NUMBER RESULT_CACHE
IS
ln_memberplanid     ods.MEMBER.primarymemberplanid%TYPE;
BEGIN
SELECT   PRIMARYMEMBERPLANID
INTO ln_memberplanid
  FROM   ODS.MEMBER
 WHERE   memberid = pn_memberid_in;
    RETURN ln_memberplanid;
 EXCEPTION
    WHEN OTHERS
    THEN
    RETURN NULL;
 END ;

 --US113391 SP to update emailpreference flag for the member
 PROCEDURE updateemailpreferenceflg(
    pn_memberid_in IN NUMBER,
	pv_datasourcenm_in IN VARCHAR2,
	pv_emailpreferenceflg_in IN VARCHAR2,
    pn_errorcode_out OUT NUMBER )
AS
	 lv_emailaddr ods.partyemailaddress.emailaddr%TYPE;
	 lv_emailconsentflg ods.supplierorganization.emailconsentflg%TYPE;
/****************************************************************************
    date                description         version      author                                                                                                                                                                                    date                description         version
    08/01/2018           US113391           1.0          Sudharsan
   *****************************************************************************/
PROCEDURE debug_emailpreferenceflg(
    memberid IN NUMBER,
	datasourcenm IN VARCHAR2,
	emailpreferenceflg IN VARCHAR2 )
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  INSERT
  INTO DBUG_UPDATEEMAILPREFERENCEFLG
    (
      memberid,
	  datasourcenm,
	  emailpreferenceflg,
      inserteddt,
      insertedby
    )
    VALUES
    (
      pn_memberid_in,
	  pv_datasourcenm_in,
	  pv_emailpreferenceflg_in,
      systimestamp,
      USER
    );
  COMMIT;
END;
BEGIN

	IF fdebug ('UPDATEEMAILPREFERENCEFLG') = 'Y' THEN
		debug_emailpreferenceflg(pn_memberid_in,pv_datasourcenm_in,pv_emailpreferenceflg_in);
	END IF;

	BEGIN

		SELECT NVL(emailconsentflg,'N')
            INTO lv_emailconsentflg
        FROM ods.supplierorganization so, ods.MEMBER m1
        WHERE m1.memberid = pn_memberid_in
        AND so.ahmsupplierid = m1.ahmsupplierid;
        IF lv_emailconsentflg ='Y' THEN
			SELECT   p1.emailaddr
				INTO   lv_emailaddr
			FROM   ods.MEMBER m1, ods.partyemailaddress p1
			WHERE   m1.memberid = pn_memberid_in
			AND m1.personid = p1.partyid
			AND p1.createdbydatasourcenm = 'HDMS'
			AND p1.deletedbydatasourcenm IS NULL
			AND NOT EXISTS (SELECT 1 FROM ods.partyemailaddress p1
							WHERE  m1.personid = p1.partyid
								AND NVL(p1.emailpreferenceflg,'Y') =
			'N')
			AND ROWNUM = 1;
		END IF;

	EXCEPTION
		WHEN OTHERS THEN
		lv_emailaddr := NULL;
	END;

  --check if member exists for AA and PHR_UE else add member as PHR_UE createdbydatasourcenm and  'commeng' as updtdatasourcenm for emailpreferenceflg
	IF pv_datasourcenm_in = 'COMMENG' THEN

		MERGE INTO partyemailaddress pe USING
		(SELECT personid FROM member m WHERE m.MEMBERID = pn_memberid_in
		) mbr ON (pe.partyid = mbr.personid AND pe.CREATEDBYDATASOURCENM IN ('PHR_UE','AA'))
		WHEN MATCHED THEN
		UPDATE
		SET pe.EMAILPREFERENCEFLG         = pv_emailpreferenceflg_in,
			pe.UPDTDBY                    = USER,
			pe.RECORDUPDTDT               = systimestamp,
			pe.UPDTDATASOURCENM           = pv_datasourcenm_in
		-- WHERE pe.CREATEDBYDATASOURCENM IN ('PHR_UE','AA')
		WHEN NOT MATCHED THEN
		INSERT
			(
			pe.emailid,
			pe.partyid,
			pe.effectivestartdt,
			pe.recordinsertdt,
			pe.recordupdtdt,
			pe.insertedby,
			pe.updtdby,
			pe.updtdatasourcenm,
			pe.createdbydatasourcenm,
			pe.EMAILPREFERENCEFLG,
			pe.emailaddr
			)
			VALUES
			(
			ods_email_seq.NEXTVAL,
			mbr.personid,
			sysdate,
			systimestamp,
			systimestamp,
			USER,
			USER,
			pv_datasourcenm_in,
			'PHR_UE',
			pv_emailpreferenceflg_in,
			lv_emailaddr
			);

	END IF;

  pn_errorcode_out          := 0;
EXCEPTION
WHEN OTHERS THEN
  log_error ('UPDATEEMAILPREFERENCEFLG', pn_memberid_in, SQLCODE, SQLERRM, SYSDATE, NULL);
  pn_errorcode_out := SQLCODE;
END updateemailpreferenceflg;

FUNCTION fgetphonefaxnumberforperson (pn_personid_in IN ods.member.personid%TYPE)
  RETURN VARCHAR2
AS
/****************************************************************************
    Date                Description         Version      Author                                                                                                                                                                                    date                description         version
    11/14/2018          US113724            1.0          Kader
*****************************************************************************/
   lv_phonefaxnumber ods.partyphonefax.phonefaxdisplaynumber%TYPE;
BEGIN
   SELECT phonefaxdisplaynumber
     INTO lv_phonefaxnumber
	 FROM (SELECT ppf.partyid,
				  ppf.phonefaxdisplaynumber,
				  ROW_NUMBER () --  get the latest phone number
				  OVER (
						PARTITION BY ppf.partyid
						ORDER BY
						CASE
						    WHEN ppf.UPDTDATASOURCENM IN ('PHR_UE','AA')
							THEN
								'A'
							ELSE
							    'B'
						END ASC
					) phone_rn
             FROM ods.partyphonefax ppf
			WHERE ppf.partyid = pn_personid_in )
    WHERE phone_rn = 1;

   	RETURN lv_phonefaxnumber;

EXCEPTION
WHEN OTHERS THEN
  RETURN NULL;
END fgetphonefaxnumberforperson;

FUNCTION fgetemailaddressforperson (pn_personid_in IN ods.member.personid%TYPE)
  RETURN VARCHAR2
AS
/****************************************************************************
    Date                Description         Version      Author                                                                                                                                                                                    date                description         version
    11/14/2018          US113724            1.0          Kader
*****************************************************************************/
 lv_emailaddress ods.partyemailaddress.emailaddr%TYPE;
BEGIN
   SELECT emailaddr
     INTO lv_emailaddress
	 FROM (SELECT pea.partyid,
				  pea.emailaddr,
				  ROW_NUMBER () --  get the latest email addresss
				  OVER (
						PARTITION BY pea.partyid
						ORDER BY
						CASE
						    WHEN pea.updtdatasourcenm IN ('PHR_UE','AA')
							THEN
								'A'
							ELSE
							    'B'
						END ASC
					) email_rn
             FROM ods.partyemailaddress pea
			WHERE pea.partyid = pn_personid_in )
    WHERE email_rn = 1;

  RETURN lv_emailaddress;

EXCEPTION
WHEN OTHERS THEN
  RETURN NULL;
END fgetemailaddressforperson;

END ods_common_pkg;
/


--
-- ODS_CORE  (Package Body) 
--
CREATE OR REPLACE PACKAGE BODY ODS.ods_core
AS
   PROCEDURE resettracevariables
   IS
   BEGIN
      gt_start := NULL;
      gt_chk1 := NULL;
      gt_chk2 := NULL;
      gt_chk3 := NULL;
      gt_chk4 := NULL;
      gt_chk5 := NULL;
      gt_chk6 := NULL;
      gt_chk7 := NULL;
      gt_chk8 := NULL;
      gt_chk9 := NULL;
      gt_chk10 := NULL;
      gt_chk11 := NULL;
      gt_chk12 := NULL;
      gt_chk13 := NULL;
      gt_chk14 := NULL;
      gt_chk15 := NULL;
      gt_chk16 := NULL;
      gt_chk17 := NULL;
      gt_chk18 := NULL;
      gt_chk19 := NULL;
      gt_chk20 := NULL;
      gt_end := NULL;
   END resettracevariables;

   FUNCTION fgetdebugexecutiontime (pv_debugprocname_in IN debugproc.procname%TYPE)
      RETURN varchar2
   AS
      lt_time   varchar2 (30);
   BEGIN
      IF pv_debugprocname_in IS NOT NULL
      THEN
          SELECT exceptiontimelimit
            INTO lt_time
            FROM ods.debugproc d
           WHERE d.procname = pv_debugprocname_in;
      ELSE
         lt_time := '000 00:00:03';
      END IF;

      RETURN lt_time;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         lt_time := '000 00:00:03';
         RETURN lt_time;
      WHEN OTHERS
      THEN
         lt_time := '000 00:00:03';
         RETURN lt_time;
   END;

   PROCEDURE loglongcall (pv_procedurenm_in      IN varchar2,
                          pv_logtable_in         IN varchar2 DEFAULT NULL ,
                          pn_logtableseq_in      IN number DEFAULT NULL ,
                          pn_procreturncode_in   IN number DEFAULT NULL ,
                          pt_start_in            IN timestamp,
                          pt_chk1_in             IN timestamp DEFAULT NULL ,
                          pt_chk2_in             IN timestamp DEFAULT NULL ,
                          pt_chk3_in             IN timestamp DEFAULT NULL ,
                          pt_chk4_in             IN timestamp DEFAULT NULL ,
                          pt_chk5_in             IN timestamp DEFAULT NULL ,
                          pt_chk6_in             IN timestamp DEFAULT NULL ,
                          pt_chk7_in             IN timestamp DEFAULT NULL ,
                          pt_chk8_in             IN timestamp DEFAULT NULL ,
                          pt_chk9_in             IN timestamp DEFAULT NULL ,
                          pt_chk10_in            IN timestamp DEFAULT NULL ,
                          pt_chk11_in            IN timestamp DEFAULT NULL ,
                          pt_chk12_in            IN timestamp DEFAULT NULL ,
                          pt_chk13_in            IN timestamp DEFAULT NULL ,
                          pt_chk14_in            IN timestamp DEFAULT NULL ,
                          pt_chk15_in            IN timestamp DEFAULT NULL ,
                          pt_chk16_in            IN timestamp DEFAULT NULL ,
                          pt_chk17_in            IN timestamp DEFAULT NULL ,
                          pt_chk18_in            IN timestamp DEFAULT NULL ,
                          pt_chk19_in            IN timestamp DEFAULT NULL ,
                          pt_chk20_in            IN timestamp DEFAULT NULL ,
                          pt_end_in              IN timestamp)
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      INSERT INTO debugexception (procname,
                                  logtable,
                                  logtableseq,
                                  procreturncode,
                                  startat,
                                  checkpt01,
                                  checkpt02,
                                  checkpt03,
                                  checkpt04,
                                  checkpt05,
                                  checkpt06,
                                  checkpt07,
                                  checkpt08,
                                  checkpt09,
                                  checkpt10,
                                  checkpt11,
                                  checkpt12,
                                  checkpt13,
                                  checkpt14,
                                  checkpt15,
                                  checkpt16,
                                  checkpt17,
                                  checkpt18,
                                  checkpt19,
                                  checkpt20,
                                  endat)
       VALUES (pv_procedurenm_in,
               pv_logtable_in,
               pn_logtableseq_in,
               pn_procreturncode_in,
               pt_start_in,
               pt_chk1_in,
               pt_chk2_in,
               pt_chk3_in,
               pt_chk4_in,
               pt_chk5_in,
               pt_chk6_in,
               pt_chk7_in,
               pt_chk8_in,
               pt_chk9_in,
               pt_chk10_in,
               pt_chk11_in,
               pt_chk12_in,
               pt_chk13_in,
               pt_chk14_in,
               pt_chk15_in,
               pt_chk16_in,
               pt_chk17_in,
               pt_chk18_in,
               pt_chk19_in,
               pt_chk20_in,
               pt_end_in);

      COMMIT;
   END loglongcall;

   PROCEDURE convert_delimitedstr_using_obj (p_delimstring   IN     varchar2,
                                             p_delimiter     IN     varchar2,
                                             p_delstring        OUT ods_delmitedstring_tab,
                                             p_errorcode        OUT number)
   IS
      lv_ret                number;
      lv_pos                number;
      lv_search_str         varchar2 (32767);
      lv_index              binary_integer := 0;
      lv_count              integer;
      lv_temp               varchar2 (32767);
      lv_value              varchar2 (32767);
      lv_delimiter_length   number;
   BEGIN
      p_errorcode := 0;
      p_delstring := ods_delmitedstring_tab ();
      lv_delimiter_length := LENGTH (p_delimiter);

      IF p_delimstring IS NOT NULL
      THEN
         lv_search_str := p_delimstring;
         lv_pos := 1;
         lv_ret := INSTR (lv_search_str, p_delimiter);

         WHILE lv_ret > 0 OR LENGTH (lv_search_str) > 0
         LOOP
            lv_value := NULL;

            IF lv_ret <= 0
            THEN
               lv_value := TRIM (lv_search_str);
               lv_search_str := NULL;
            ELSE
               lv_value := TRIM (SUBSTR (lv_search_str, lv_pos, lv_ret - 1));
            END IF;

            lv_index := lv_index + 1;
            lv_temp := LENGTH (lv_value);
            p_delstring.EXTEND;
            p_delstring (p_delstring.LAST) := lv_value;
            lv_search_str := SUBSTR (lv_search_str, lv_ret + lv_delimiter_length);
            lv_ret := INSTR (lv_search_str, p_delimiter, lv_pos);
         END LOOP;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errorcode := SQLCODE;
   END;

   FUNCTION getdelimiedstrtotbl (p_delimstring IN varchar2, p_delimiter IN varchar2)
      RETURN ods_delmitedstring_tab
   AS
      lv_string      ods_delmitedstring_tab := ods_delmitedstring_tab ();
      lv_errorcode   number;
   BEGIN
      ods_core.convert_delimitedstr_using_obj (p_delimstring   => p_delimstring,
                                               p_delimiter     => p_delimiter,
                                               p_delstring     => lv_string,
                                               p_errorcode     => lv_errorcode);

      IF NVL (lv_errorcode, 0) <> 0
      THEN
         lv_string := ods_delmitedstring_tab ();
      END IF;

      RETURN lv_string;
   /* SELECT ROWNUM, TRIM (COLUMN_VALUE) col_val
   FROM the( SELECT CAST (
                      bsfm_tokenize_str_to_tbl (
                         '306J_^^_J1062J_^^_JNew fields are added for Sep releaese, mediaPath and mediaTitleJ_^^_JNOTCOMPLETEDJ_^^_J2010-08-23T00:00:00.000ZJ_^^_JJ_^^_JFUCASPJ_^^_JPDFJ_^^_Jwww.activeadvise.com/media/patientPhoto/recentJ_^^_JTitle has beeen changed to New MediaJ_^^_J2010-08-23T00:00:00.000ZJ_^^_JKEEPJ_##_J',
                         'J_^^_J'
                      ) AS str_tokens_tab
                   )
               FROM DUAL) */
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_string := ods_delmitedstring_tab ();
         RETURN lv_string;
   END;

   FUNCTION fgetmastercode (p_mastercodemnemonic_in IN varchar2)
      RETURN varchar2
   IS
      lv_retcode   mastercode.mastercode%TYPE;
   BEGIN
       SELECT mastercode
         INTO lv_retcode
         FROM ods.mastercode
        WHERE mastercodemnemonic = p_mastercodemnemonic_in;

      RETURN lv_retcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retcode := NULL;
         RETURN lv_retcode;
   END fgetmastercode;

   FUNCTION fgetmastercodedesc (p_mastercodemnemonic_in IN varchar2)
      RETURN varchar2
   IS
      lv_retcode   mastercode.mastercodedesc%TYPE;
   BEGIN
       SELECT mastercodedesc
         INTO lv_retcode
         FROM ods.mastercode
        WHERE mastercodemnemonic = p_mastercodemnemonic_in;

      RETURN lv_retcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retcode := NULL;
         RETURN lv_retcode;
   END fgetmastercodedesc;

   FUNCTION fgetmastermemoniccode (p_mastercode_in IN varchar2, p_mastergroupcd_in IN varchar2)
      RETURN varchar2
   IS
      lv_retcode   mastercode.mastercodemnemonic%TYPE;
   BEGIN
       SELECT mc.mastercodemnemonic
         INTO lv_retcode
         FROM ods.mastercode mc
        WHERE mc.mastercode = p_mastercode_in AND mc.mastergroupcd = p_mastergroupcd_in;

      RETURN lv_retcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retcode := NULL;
         RETURN lv_retcode;
   END fgetmastermemoniccode;

   FUNCTION fgetorgnm (p_orgid_in IN number)
      RETURN varchar2
   IS
      lv_retcode   org.orgnm%TYPE;
   BEGIN
       SELECT orgnm
         INTO lv_retcode
         FROM org
        WHERE orgid = p_orgid_in;

      RETURN lv_retcode;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retcode := NULL;
         RETURN lv_retcode;
   END fgetorgnm;

   PROCEDURE setmoodcdlist (p_moodcdlist_in IN varchar2)
   IS
   BEGIN
      IF p_moodcdlist_in IS NULL
      THEN
         INSERT INTO ods.global_temp_moodcdlist (moodcd)
             SELECT TRIM (mastercodemnemonic)
               FROM mastercode
              WHERE mastergroupcd = 'MOOD';
      ELSE
         INSERT INTO ods.global_temp_moodcdlist (moodcd)
            ( SELECT ods_core.fgetmastermemoniccode (col_val, 'MOOD')
                FROM ( SELECT TRIM (COLUMN_VALUE) col_val
                         FROM the( SELECT CAST (
                                            ods_core.getdelimiedstrtotbl (p_moodcdlist_in, 'J_##_J') AS ods_delmitedstring_tab
                                         )
                                     FROM DUAL)));
      END IF;
   END;

   FUNCTION fgetunknownprovider (p_ahmsupplierid_in   IN MEMBER.ahmsupplierid%TYPE,
                                 p_systemsource_in    IN datasource.datasourcenm%TYPE)
      RETURN number
   IS
      lv_retvalue     careprovider.careproviderid%TYPE;
      ln_acntorgid    org.orgid%TYPE;
      ln_providerid   careprovider.careproviderid%TYPE;
   BEGIN
       SELECT io.orgid
         INTO ln_acntorgid
         FROM ods.insuranceorganization io, ods.insuranceorgsupplierrelation iosr, ods.supplierorganization so
        WHERE io.insuranceorgid = iosr.insuranceorgid
          AND iosr.supplierid = so.supplierorgid
          AND so.ahmsupplierid = p_ahmsupplierid_in;

      IF ln_acntorgid IS NOT NULL
      THEN
          SELECT cp.careproviderid
            INTO lv_retvalue
            FROM careprovider cp
           WHERE (cp.sourcecareproviderid = '0' OR cp.externalsourcecareproviderid = '0')
             AND NVL (cp.exclusioncode, 'IN') = 'IN'
             AND cp.providerfilterflag = 'Y'
             AND cp.datasourcenm = p_systemsource_in
             AND EXISTS
                    ( SELECT 1
                        FROM orgpersonxref x
                       WHERE x.orgid = ln_acntorgid
                         AND x.relatedpersonid = cp.careproviderid
                         AND x.accountid = ln_acntorgid
                         AND x.relationtypemnemonic = 'ORGPRS_AFFL'
                         AND x.effenddt IS NULL
                         AND x.PRIMARYFLG = 'Y'
                         AND x.exclusioncd = 'IN');
      ELSE
          SELECT cp.careproviderid
            INTO lv_retvalue
            FROM careprovider cp
           WHERE (cp.sourcecareproviderid = '0' OR cp.externalsourcecareproviderid = '0')
             AND NVL (cp.exclusioncode, 'IN') = 'IN'
             AND cp.providerfilterflag = 'Y'
             AND cp.datasourcenm = p_systemsource_in;
      END IF;

      RETURN lv_retvalue;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         -- Create the Unknown Provider for that account
         SELECT ods_party_seq.NEXTVAL INTO ln_providerid FROM DUAL;

         INSERT INTO party (partyid, partytypecode)
          VALUES (ln_providerid, 'P');

         INSERT INTO careprovider (careproviderid,
                                   careprovidertype,
                                   nationalproviderid,
                                   sourcecareproviderid,
                                   recordinsertdt,
                                   recordupdtdt,
                                   insertedby,
                                   updtdby,
                                   providerfilterflag,
                                   taxid,
                                   provideroptoutflag,
                                   provideruniqueid,
                                   providermasterid,
                                   exclusioncode,
                                   projectid,
                                   datasourcenm,
                                   externalsourcecareproviderid,
                                   primaryrolecd,
                                   secondaryrolecd,
                                   deliverytypetxt,
                                   sourceissuingorgid)
          VALUES (ln_providerid                                                                       -- CAREPROVIDERID,
                               ,
                  'UNKNOWN'                                                                          --CAREPROVIDERTYPE,
                           ,
                  NULL,                                                                             --nationalproviderid
                  '0'                                                                            --SOURCECAREPROVIDERID,
                     ,
                  SYSDATE                                                                              --RECORDINSERTDT,
                         ,
                  SYSDATE                                                                                --RECORDUPDTDT,
                         ,
                  p_systemsource_in                                                                        --INSERTEDBY,
                                   ,
                  p_systemsource_in                                                                           --UPDTDBY,
                                   ,
                  'Y',                                                                             -- providerfilterflag
                  NULL                                                                                          --TAXID,
                      ,
                  'Y'                                                                              --PROVIDEROPTOUTFLAG,
                     ,
                  NULL                                                                               --PROVIDERUNIQUEID,
                      ,
                  NULL                                                                               --PROVIDERMASTERID,
                      ,
                  'IN'                                                                                  --EXCLUSIONCODE,
                      ,
                  NULL                                                                                      --PROJECTID,
                      ,
                  p_systemsource_in                                                                      --DATASOURCENM,
                                   ,
                  '0',                                                                   -- externalsourcecareproviderid
                  NULL                                                                                  --PRIMARYROLENM,
                      ,
                  NULL                                                                                --SECONDARYROLENM,
                      ,
                  NULL                                                                                --DELIVERYTYPETXT,
                      ,
                  NULL                                                                                   -- IssuingOrgid
                      );

         IF ln_acntorgid IS NOT NULL
         THEN
            INSERT INTO ods.orgpersonxref (orgpersonxrefskey,
                                           orgid,
                                           accountid,
                                           relatedpersonid,
                                           relationtypemnemonic,
                                           effstartdt,
                                           insertedby,
                                           inserteddt,
                                           updatedby,
                                           updateddt,
                                           createdbydatasourcenm,
                                           PRIMARYFLG)
             VALUES (orgpersonxref_seq.NEXTVAL,
                     ln_acntorgid,
                     ln_acntorgid,
                     ln_providerid,
                     hie_core.fgetmastermemoniccode ('AFFL', 'ORGPRS'),
                     SYSDATE,
                     p_systemsource_in,
                     SYSTIMESTAMP,
                     p_systemsource_in,
                     SYSTIMESTAMP,
                     p_systemsource_in,
                     'Y');
         END IF;

         INSERT INTO ods.person (personid,
                                 firstnm,
                                 middleinitial,
                                 lastnm,
                                 salutation,
                                 suffix,
                                 fullnm,
                                 gender,
                                 ssn,
                                 dtofbirth,
                                 ethnicrace,
                                 maritalstatusmnemonic,
                                 effectivestartdt,
                                 effectiveenddt,
                                 recordinsertdt,
                                 recordupdtdt,
                                 insertedby,
                                 updtdby,
                                 last4ssn,
                                 exclusioncode,
                                 title,
                                 persontype)
          VALUES (ln_providerid,
                  NULL                                                                                        --firstnm,
                      ,
                  NULL                                                                     --             middleinitial,
                      ,
                  NULL                                                                                    --     lastnm,
                      ,
                  NULL                                                                                 --    salutation,
                      ,
                  NULL                                                                                      --   suffix,
                      ,
                  'UNKNOWN'                                                                                  -- Fullname
                           ,
                  NULL                                                                                      --   gender,
                      ,
                  NULL                                                                                         --   ssn,
                      ,
                  NULL                                                                                   --   dtofbirth,
                      ,
                  NULL                                                                                  --   ethnicrace,
                      ,
                  NULL                                                                       --   maritalstatusmnemonic,
                      ,
                  SYSDATE                                                                         --   effectivestartdt,
                         ,
                  NULL                                                                              --   effectiveenddt,
                      ,
                  SYSDATE                                                                           --   recordinsertdt,
                         ,
                  SYSDATE                                                                             --   recordupdtdt,
                         ,
                  p_systemsource_in                                                                     --   insertedby,
                                   ,
                  p_systemsource_in                                                                        --   updtdby,
                                   ,
                  NULL                                                                                    --   last4ssn,
                      ,
                  'IN'                                                                               --   exclusioncode,
                      ,
                  NULL                                                                                       --   title,
                      ,
                  'P'                                                                                    --   persontype
                     );

         lv_retvalue := ln_providerid;
         RETURN lv_retvalue;
      WHEN OTHERS
      THEN
         lv_retvalue := NULL;
         RETURN lv_retvalue;
   END fgetunknownprovider;

   FUNCTION fgetprovtype (p_id_in IN number)
      RETURN varchar2
   IS
      lv_ret_value   varchar2 (1);
   BEGIN
      BEGIN
          SELECT poxref.provorgstafftypecd
            INTO lv_ret_value
            FROM ods.provorgstaffmasterxref poxref
           WHERE poxref.provorgstaffid = p_id_in AND NVL (poxref.exclusioncd, 'IN') = 'IN';
      EXCEPTION
         WHEN OTHERS
         THEN
            lv_ret_value := NULL;
      END;

      RETURN lv_ret_value;
   END fgetprovtype;

   FUNCTION fvalidateuserid (p_id_in IN number, p_type_in IN varchar2)
      RETURN number
   IS
      lv_retvalue   number;
   BEGIN
      IF p_type_in = 'P'
      THEN
          SELECT COUNT ( * )
            INTO lv_retvalue
            FROM careprovider
           WHERE careproviderid = p_id_in AND NVL (exclusioncode, 'IN') = 'IN'
             AND (NVL (providerfilterflag, 'N') <> 'Y'
               OR (providerfilterflag = 'Y' AND (sourcecareproviderid = '0' OR externalsourcecareproviderid = '0')));
      ELSIF p_type_in = 'A'
      THEN
          SELECT COUNT ( * )
            INTO lv_retvalue
            FROM ods.provorgadjunctstaff
           WHERE provorgadjunctstaffid = p_id_in AND NVL (exclusioncd, 'IN') = 'IN';
      ELSIF p_type_in = 'E'
      THEN
          SELECT COUNT ( * )
            INTO lv_retvalue
            FROM ods.employee
           WHERE employeeid = p_id_in AND NVL (exclusioncd, 'IN') = 'IN';
      END IF;

      RETURN lv_retvalue;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_retvalue := 0;
         RETURN lv_retvalue;
   END;

   PROCEDURE sethealthstatefdback (p_healthstatetrackingid_in    IN     number,
                                   p_memberplanid_in             IN     number,
                                   p_healthstatetype_in          IN     varchar2,
                                   p_systemsource_in             IN     varchar2,
                                   p_fdbstatusid_in              IN     varchar2,
                                   p_fdbstatusreason_in          IN     number,
                                   p_fdbcomments_in              IN     varchar2,
                                   p_fdbdate_in                  IN     date,
                                   p_byuserid_in                 IN     number,
                                   p_byprovidertype_in           IN     varchar2,
                                   p_foruserid_in                IN     number,
                                   p_forprovidertype_in          IN     varchar2,
                                   p_healthstatetrackingid_out      OUT number,
                                   p_memberplanid_out               OUT number,
                                   p_returncode_out                 OUT number)
   IS
      lv_return_code        number;
      lv_memberid           MEMBER.memberid%TYPE;
      lv_ahmsupplierid      MEMBER.ahmsupplierid%TYPE;
      lv_statecomponentid   csid.memberhealthstate.statecomponentid%TYPE;
      lv_feedbackseq        number;
      lv_statetypecd        csid.memberhealthstate.statetypecd%TYPE;
      lv_fdbxreftypcd       csid.memberhealthstatefeedbackxref.clinicaloutputtypecd%TYPE;
      lv_provtype           varchar2 (30);
      lv_forid              number;
      lv_byid               number;
      lv_userexists         number;

      ln_episodeid          number;

	  ln_mastersupplierid         csid.memberhealthstate.mastersupplierid%TYPE;
      ln_Yrqtr_low                  csid.memberhealthstate.yearqtr%TYPE;
	  ln_Yrqtr_High              csid.memberhealthstate.yearqtr%TYPE;
	  --Personview changes start--
      ln_personmemberid	         csid.memberhealthstate.memberid%TYPE;
	  ln_personmastersupplierid  csid.memberhealthstate.mastersupplierid%TYPE;
	  ln_memberhealthstateskey  csid.memberhealthstate.memberhealthstateskey%TYPE;
	    --Personview changes End--
   BEGIN

      /* 17.4  chitra v personview change US102412  */
      /* Service to set the feedback from various sources. This service is being called by CT/CCFeedback/TMV. Future it will be used by PHR also.
                                                                   Feedback can be Set by Member (M) /Provider (P) /Adjunct (A) /Unknown (U).
      M  Type  =>   FOR and BY usertype will be M and the Id  receive to this service is the memberplanid.System validates
                    only if the the memberplanid exists in ODS.
      P/A Type =>   Check if the  FOR/BY type is valid  against the XREF table.
      U Type   =>   In case of U type if the FOR/BY id is either Null or 0, derive the unknown provider for the account that belong to the
                    supplier of the given member. For Every account there is a Unknown provider setup will be available which is identified by
                    SourceCareProviderid =0 and ExternalSourceCareproviderid = 0 and Datasource - HIE_UE for HIEaccount and HDMS for non-hie account.
      */
      ods_core.gt_start := SYSTIMESTAMP;

      IF fdebug ('SETHEALTHSTATEFDBACK') = 'Y'
      THEN
         INSERT INTO ods.jsethsfeedback (healthstatetrackingid,
                                         memberplanid,
                                         healthstatetype,
                                         systemsource,
                                         fdbstatusid,
                                         fdbstatusreason,
                                         fdbcomments,
                                         fdbdate,
                                         byuserid,
                                         byprovidertype,
                                         foruserid,
                                         forprovidertype,
                                         recordinsertdt)
          VALUES (p_healthstatetrackingid_in,
                  p_memberplanid_in,
                  p_healthstatetype_in,
                  p_systemsource_in,
                  p_fdbstatusid_in,
                  p_fdbstatusreason_in,
                  p_fdbcomments_in,
                  p_fdbdate_in,
                  p_byuserid_in,
                  p_byprovidertype_in,
                  p_foruserid_in,
                  p_forprovidertype_in,
                  SYSTIMESTAMP);
      END IF;

      lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'SUCCESSFUL');

      IF p_healthstatetrackingid_in IS NULL
      OR p_memberplanid_in IS NULL
      OR NVL (p_healthstatetype_in, 'X') NOT IN ('MK', 'ME', 'QM')
      OR p_systemsource_in IS NULL
      OR p_fdbstatusid_in IS NULL
      OR p_fdbstatusreason_in IS NULL
      OR p_fdbdate_in IS NULL
      THEN
         lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'MANDATORY ELEMENTS NOT FOUND');
         GOTO finish;
      END IF;

      BEGIN
          SELECT memberid, ahmsupplierid
            INTO lv_memberid, lv_ahmsupplierid
            FROM ods.MEMBER
           WHERE primarymemberplanid = p_memberplanid_in;
      EXCEPTION
         WHEN OTHERS
         THEN
            lv_memberid := NULL;
      END;

      IF lv_memberid IS NULL
      THEN
         lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'MEMBER NOT FOUND');
         GOTO finish;
      END IF;

      lv_provtype := NULL;
      lv_forid := NULL;
      lv_byid := NULL;
      lv_userexists := 0;



      IF p_byprovidertype_in = 'U'
      THEN
         IF p_byuserid_in <> 0
         THEN
            lv_userexists := ods_core.fvalidateuserid (p_byuserid_in, 'P');

            IF lv_userexists = 0
            THEN
               lv_byid := NULL;
            END IF;
         ELSE
            lv_byid :=
               ods_core.fgetunknownprovider (
                  lv_ahmsupplierid,
                  CASE WHEN p_systemsource_in = 'HIE_UE' THEN 'HIE' ELSE p_systemsource_in END
               );
         END IF;

         IF lv_byid IS NULL
         THEN
            lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'NOT A VALID REQUESTOR');
            GOTO finish;
         END IF;
      ELSIF p_byprovidertype_in IN ('M', 'A', 'P', 'E')
      THEN
         IF p_byuserid_in IS NOT NULL
         THEN
            IF p_byprovidertype_in = 'M'
            THEN
               BEGIN
                   SELECT memberid
                     INTO lv_byid
                     FROM ods.MEMBER
                    WHERE primarymemberplanid = p_byuserid_in;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'MEMBER NOT FOUND');
                     GOTO finish;
               END;
            ELSE
               /*
                IF p_systemsource_in = 'CT'
               -- For careteam we need to check the Type against Xref table
               THEN
                  lv_provtype := ods_core.fgetprovtype (p_byuserid_in);

                  IF (lv_provtype IS NULL OR (lv_provtype <> NVL (p_byprovidertype_in, 'X')))
                  THEN
                     lv_userexists := 0;
                  ELSE
                     lv_userexists := 1;
                  END IF;
               ELSE
                  lv_userexists := ods_core.fvalidateuserid (p_byuserid_in, p_byprovidertype_in);
               END IF;
               */

               lv_userexists := ods_core.fvalidateuserid (p_byuserid_in, p_byprovidertype_in);

               IF lv_userexists = 0
               THEN
                  lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'NOT A VALID REQUESTOR');
                  GOTO finish;
               ELSE
                  lv_byid := p_byuserid_in;
               END IF;
            END IF;
         END IF;
      END IF;

      -- Validating FOR Userid and FOR Type
      lv_provtype := NULL;
      lv_userexists := 0;

      IF p_forprovidertype_in = 'U'
      THEN
         IF p_foruserid_in <> 0
         THEN
            lv_userexists := ods_core.fvalidateuserid (p_foruserid_in, 'P');

            IF lv_userexists = 0
            THEN
               lv_forid := NULL;
            END IF;
         ELSE
            lv_forid :=
               ods_core.fgetunknownprovider (
                  lv_ahmsupplierid,
                  CASE WHEN p_systemsource_in = 'HIE_UE' THEN 'HIE' ELSE p_systemsource_in END
               );
         END IF;

         IF lv_forid IS NULL
         THEN
            lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'NOT A VALID REQUESTOR');
            GOTO finish;
         END IF;
      ELSIF p_forprovidertype_in IN ('M', 'P', 'A', 'E')
      THEN
         IF p_foruserid_in IS NOT NULL
         THEN
            IF p_forprovidertype_in = 'M'
            THEN
               BEGIN
                   SELECT memberid
                     INTO lv_forid
                     FROM ods.MEMBER
                    WHERE primarymemberplanid = p_foruserid_in;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'MEMBER NOT FOUND');
                     GOTO finish;
               END;
            ELSE

             /*IF p_systemsource_in = 'CT'
               -- For careteam we need to check the Type against Xref table
               THEN
                  lv_provtype := ods_core.fgetprovtype (p_foruserid_in);

                  IF (lv_provtype IS NULL OR (lv_provtype <> NVL (p_forprovidertype_in, 'X')))
                  THEN
                     lv_userexists := 0;
                  ELSE
                     lv_userexists := 1;
                  END IF;
               ELSE
                  lv_userexists := ods_core.fvalidateuserid (p_foruserid_in, p_forprovidertype_in);
               END IF;
               */

               lv_userexists := ods_core.fvalidateuserid (p_foruserid_in, p_forprovidertype_in);

               IF lv_userexists = 0
               THEN
                  lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'NOT A VALID REQUESTOR');
                  GOTO finish;
               ELSE
                  lv_forid := p_foruserid_in;
               END IF;
            END IF;
         END IF;
      END IF;


      ods_core.gt_chk1 := SYSTIMESTAMP;

	  	         --For Data Management
	    ln_mastersupplierid  := ods_common_pkg.fgetmastersupplierid(pn_memberid_in => lv_memberid);
		ln_Yrqtr_low    := ods_common_pkg.fgetpreviousyearqtr(sysdate);
	    ln_Yrqtr_High   := ods_common_pkg.fgetyearqtr(sysdate);

		      /*mhs,mhscommm,mhscommdtl ,mhsactionxref  -- memberid and mastersupplierid  is in  aggregate or instance level based on constent 'Y'
	     memberid and mastersupplierid  is in Memberinstance level for all other csid tables   */

        /* personview starts */
    IF ODS.ODS_COMMON_PKG.fgetpersonviewflg ='Y'
       Then

        IF ODS.ODS_COMMON_PKG.fgetdatashareconsentformember(memberid_in=> lv_memberid ,memberplanid_in => NULL) ='Y'  -- check the shared consent,If yes personmode
            Then
                ln_personmemberid   := ODS.ODS_COMMON_PKG.FGETPERSONAGGREGATEID (memberid_in => lv_memberid);      ---  get the personaggregatgeid
                ln_personmastersupplierid :=  ODS.ODS_COMMON_PKG.fgetmastersupplierid (pn_memberid_in => ln_personmemberid);  -- get the personmastersupplierid

            ELSE
			     ln_personmemberid := lv_memberid;
				 ln_personmastersupplierid := ln_mastersupplierid;
            END IF;

        ELSE
		    ln_personmemberid := lv_memberid;
			ln_personmastersupplierid := ln_mastersupplierid;
     END IF;
     /* Preson View ends */




      BEGIN
         IF p_healthstatetype_in IN ('MK', 'QM')
         THEN
            lv_statetypecd :=
               CASE
                  WHEN p_healthstatetype_in = 'MK' THEN 'MK'
                  WHEN p_healthstatetype_in = 'QM' THEN 'ME'
               END;
            lv_fdbxreftypcd := 'MHS';

             BEGIN

			 SELECT mhs.statecomponentid, mhs.episodeid, mhs.memberhealthstateskey
               INTO lv_statecomponentid, ln_episodeid,ln_memberhealthstateskey
               FROM csid.memberhealthstate mhs
              WHERE mhs.memberhealthstateskey = p_healthstatetrackingid_in
                AND mhs.memberid = ln_personmemberid
                AND mhs.statetypecd = lv_statetypecd
                AND mhs.voidflg = 'IN'
				AND mhs.mastersupplierid = ln_personmastersupplierid;

				EXCEPTION
				   WHEN NO_DATA_FOUND THEN

				 SELECT mhs.statecomponentid, mhs.episodeid, mhs.memberhealthstateskey
				   INTO lv_statecomponentid, ln_episodeid, ln_memberhealthstateskey
				   FROM csid.memberhealthstate mhs
				  WHERE mhs.memberhealthstateskey = p_healthstatetrackingid_in
					AND mhs.memberid = lv_memberid
					AND mhs.statetypecd = lv_statetypecd
					AND mhs.voidflg = 'IN'
					AND mhs.mastersupplierid = ln_mastersupplierid;
             END;


         ELSIF p_healthstatetype_in = 'ME'
         THEN
            lv_statetypecd := 'ME';
            lv_fdbxreftypcd := 'COM';
            BEGIN
             SELECT mhs.statecomponentid, mhs.episodeid, mhs.memberhealthstateskey
               INTO lv_statecomponentid, ln_episodeid, ln_memberhealthstateskey
               FROM csid.memberhealthstate mhs, csid.memberhealthstatecomm mhsc, csid.memberhealthstatecommdtl mhscd
              WHERE mhs.memberid = ln_personmemberid
                AND mhs.statetypecd = lv_statetypecd
                AND mhs.voidflg = 'IN'
                AND mhsc.memberhealthstateskey = mhs.memberhealthstateskey
                AND mhsc.voidflg = 'IN'
                AND mhscd.memberhealthstatecommskey = mhsc.memberhealthstatecommskey
                AND mhscd.memberhealthstatecommdtlskey = p_healthstatetrackingid_in
                AND mhscd.voidflg = 'IN'
				AND mhs.mastersupplierid = ln_personmastersupplierid
				AND mhs.mastersupplierid = mhsc.mastersupplierid
				AND mhsc.mastersupplierid = mhscd.mastersupplierid;
            EXCEPTION
			   WHEN NO_DATA_FOUND THEN
			  SELECT mhs.statecomponentid, mhs.episodeid,  mhs.memberhealthstateskey
               INTO lv_statecomponentid, ln_episodeid,ln_memberhealthstateskey
               FROM csid.memberhealthstate mhs, csid.memberhealthstatecomm mhsc, csid.memberhealthstatecommdtl mhscd
              WHERE mhs.memberid = lv_memberid
                AND mhs.statetypecd = lv_statetypecd
                AND mhs.voidflg = 'IN'
                AND mhsc.memberhealthstateskey = mhs.memberhealthstateskey
                AND mhsc.voidflg = 'IN'
                AND mhscd.memberhealthstatecommskey = mhsc.memberhealthstatecommskey
                AND mhscd.memberhealthstatecommdtlskey = p_healthstatetrackingid_in
                AND mhscd.voidflg = 'IN'
				AND mhs.mastersupplierid = ln_mastersupplierid
				AND mhs.mastersupplierid = mhsc.mastersupplierid
				AND mhsc.mastersupplierid = mhscd.mastersupplierid;

            END;
        END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'NOT SUCCESSFUL');
            GOTO finish;
         WHEN OTHERS
         THEN
            lv_return_code := ods_debugpkg.ferrorcodesforhie ('ALL', 'NOT SUCCESSFUL');
            GOTO finish;
      END;

      ods_core.gt_chk2 := SYSTIMESTAMP;

      -- Delete the old data from Feedback Table
      DELETE FROM csid.memberhealthstatefeedback mhsf
        WHERE EXISTS
                 ( SELECT 1
                     FROM csid.memberhealthstatefeedbackxref mhsfxref
                    WHERE mhsfxref.memberhealthstatefeedbackskey = mhsf.memberhealthstatefeedbackskey
                      AND mhsfxref.clinicaloutputtypecd = lv_fdbxreftypcd
                      AND mhsfxref.clinicaloutputtrackingid = p_healthstatetrackingid_in);

      ods_core.gt_chk3 := SYSTIMESTAMP;

      --- Insert into Feedback
      SELECT csid.memberhealthstatefeedback_seq.NEXTVAL INTO lv_feedbackseq FROM DUAL;

      INSERT INTO csid.memberhealthstatefeedback (memberhealthstatefeedbackskey,
                                                  feedbackstatusreasoncd,
                                                  feedbackstatuscd,
                                                  feedbackdt,
                                                  feedbackdatasourcenm,
                                                  commmethodmnemonic,
                                                  comments,
                                                  insertedby,
                                                  inserteddt,
                                                  updatedby,
                                                  updateddt,
                                                  memberid,
                                                  statetypecd,
                                                  statecomponentid,
                                                  feedbackprovidedbytypecd,
                                                  feedbackprovidedbyid,
                                                  feedbackonbehalfoftypecd,
                                                  feedbackonbehalfofid,
                                                  EPISODEID
                                                  )
       VALUES (lv_feedbackseq,
               p_fdbstatusreason_in,
               p_fdbstatusid_in,
               p_fdbdate_in,
               p_systemsource_in,
               'PHRACC',
               p_fdbcomments_in,
               USER,
               SYSTIMESTAMP,
               USER,
               SYSTIMESTAMP,
               lv_memberid,
               lv_statetypecd,
               lv_statecomponentid,
               p_byprovidertype_in,
               lv_byid,
               p_forprovidertype_in,
               lv_forid,
               ln_episodeid
               );

      ods_core.gt_chk4 := SYSTIMESTAMP;

      --- Insert into Feedback History
      INSERT INTO csid.memberhealthstatefeedbackhist (memberhealthstatefdbkhistskey,
                                                      memberhealthstatefeedbackskey,
                                                      feedbackstatusreasoncd,
                                                      feedbackstatuscd,
                                                      feedbackdt,
                                                      feedbackdatasourcenm,
                                                      commmethodmnemonic,
                                                      comments,
                                                      insertedby,
                                                      inserteddt,
                                                      updatedby,
                                                      updateddt,
                                                      memberid,
                                                      statetypecd,
                                                      statecomponentid,
                                                      feedbackprovidedbytypecd,
                                                      feedbackprovidedbyid,
                                                      feedbackonbehalfoftypecd,
                                                      feedbackonbehalfofid,
                                                      EPISODEID
                                                      )
       VALUES (csid.memberhealthstatefdbkhist_seq.NEXTVAL,
               lv_feedbackseq,
               p_fdbstatusreason_in,
               p_fdbstatusid_in,
               p_fdbdate_in,
               p_systemsource_in,
               'PHRACC',
               p_fdbcomments_in,
               USER,
               SYSTIMESTAMP,
               USER,
               SYSTIMESTAMP,
               lv_memberid,
               lv_statetypecd,
               lv_statecomponentid,
               p_byprovidertype_in,
               lv_byid,
               p_forprovidertype_in,
               lv_forid,
               ln_episodeid
               );

      ods_core.gt_chk5 := SYSTIMESTAMP;

      --- Insert into Feedback Xref
      INSERT INTO csid.memberhealthstatefeedbackxref (memberhealthstatefeedbackskey,
                                                      clinicaloutputtypecd,
                                                      clinicaloutputtrackingid,
                                                      insertedby,
                                                      inserteddt,
                                                      updatedby,
                                                      updateddt,
													  memberhealthstateskey)
       VALUES (lv_feedbackseq,
               lv_fdbxreftypcd,
               p_healthstatetrackingid_in,
               USER,
               SYSDATE,
               USER,
               SYSDATE,
			   ln_memberhealthstateskey);

      ods_core.gt_chk6 := SYSTIMESTAMP;

      -- Set the Feedback bit for sucessfull operation (Success code = 10000)
      IF lv_return_code = 10000
      THEN
         updatecememberprocessstatus (pnmemberid_in => lv_memberid, pvbits_in => '000100000', -- BIT for the FDBK
                                                                                              pvceflag_in => 'N');
      END IF;

     <<finish>>
      p_healthstatetrackingid_out := p_healthstatetrackingid_in;
      p_memberplanid_out := p_memberplanid_in;
      p_returncode_out := lv_return_code;
      ods_core.gt_end := SYSTIMESTAMP;

      -- Trace Long Call execution
      IF (ods_core.gt_end - ods_core.gt_start) > ods_core.fgetdebugexecutiontime ('SETHEALTHSTATEFDBACK')
      THEN
         ods_core.loglongcall (pv_procedurenm_in      => 'SETHEALTHSTATEFDBACK',
                               pn_procreturncode_in   => lv_return_code,
                               pt_start_in            => ods_core.gt_start,
                               pt_chk1_in             => ods_core.gt_chk1,
                               pt_chk2_in             => ods_core.gt_chk2,
                               pt_chk3_in             => ods_core.gt_chk3,
                               pt_chk4_in             => ods_core.gt_chk4,
                               pt_chk5_in             => ods_core.gt_chk5,
                               pt_chk6_in             => ods_core.gt_chk6,
                               pt_end_in              => ods_core.gt_end);
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_returncode_out := ods_debugpkg.ferrorcodesforhie ('ALL', 'ILLEGAL OPERATION');
         ods.log_error ('SETHEALTHSTATEFDBACK',
                        NULL,
                        SQLCODE,
                        SQLERRM,
                        SYSDATE,
                        NULL);
         RAISE;
   END sethealthstatefdback;

   FUNCTION fgetorgoidfromorgid (pn_issuingorgid_in IN number)
      RETURN varchar2
   AS
      vissuingoid   varchar2 (64);
   BEGIN
       SELECT orgoid
         INTO vissuingoid
         FROM org
        WHERE orgid = pn_issuingorgid_in;

      RETURN vissuingoid;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END;
END ods_core;
/

-- EXIT;