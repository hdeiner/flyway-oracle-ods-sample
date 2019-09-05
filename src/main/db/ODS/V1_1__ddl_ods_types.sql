-- SET ECHO ON

--
-- AANURSE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.AANURSE_OBJ AS OBJECT   (
           AAUserID             VARCHAR2 (20),
           AAUserName           VARCHAR2 (150),
           AAMainPhone          VARCHAR2 (10),
           AAPhone              VARCHAR2 (10),
           AAPhoneExt           VARCHAR2 (10),
           AAloginname          VARCHAR2 (50), --15.3##S2#WAC47#US57643#Added Nurse Login Name by Vijay
           AAPrimaryFlg         varchar2  (1));



--
-- AANURSE_TAB  (Type) 
--
--  Dependencies: 
--   AANURSE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.AANURSE_TAB as TABLE OF ODS.AANURSE_OBJ;




--
-- AAPARTICIPATIONSTATUS_OBJ  (Type) 
--
--  Dependencies: 
--   AANURSE_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.AAPARTICIPATIONSTATUS_OBJ
AS
   OBJECT (cmsID                NUMBER,
           cmsType              VARCHAR2 (12),
           cmsStatus            VARCHAR2 (12),
           aaStatusChangeDate   DATE,
           caseStartDate        DATE,
           caseEndDate          DATE,
           patientTrackFlag     CHAR(1),
           patientTrackType     VARCHAR2 (12),
           patientTrackPhase    VARCHAR2 (12),
           patientTrackStatus   VARCHAR2 (12),
           AANurselist          AANURSE_TAB,
           eligibilitycode      NUMBER,
           returncode           VARCHAR2(10),
		       cmsReasonCd          VARCHAR2 (20));-- Q4-S2 added by VJ



--
-- AAPARTICIPATIONSTATUS_TAB  (Type) 
--
--  Dependencies: 
--   AAPARTICIPATIONSTATUS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.AAPARTICIPATIONSTATUS_TAB
IS
  TABLE OF AAPARTICIPATIONSTATUS_OBJ;




--
-- AAPARTICIPATION_OBJ  (Type) 
--
--  Dependencies: 
--   AANURSE_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.AAPARTICIPATION_OBJ
IS OBJECT (
   eligibilitycode number,
   cmsid number,
   cmstype VARCHAR2 (12 Byte),
   CMSSTATUS VARCHAR2 (12 Byte),
   Intensity VARCHAR2 (10),
   aastatuschangedt date,
   casestartdt date,
   caseenddt date,
   PatientTrackFlag char(1),
   PatientTracktype VARCHAR2 (12 Byte),
   PatientTrackPHASE VARCHAR2 (12 Byte),
   PatientTrackSTATUS VARCHAR2 (12 Byte),
   AANurselist          AANURSE_TAB
);




--
-- AAPARTICIPATION_TAB  (Type) 
--
--  Dependencies: 
--   AAPARTICIPATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.AAPARTICIPATION_TAB as TABLE OF ODS.AAPARTICIPATION_OBJ;




--
-- AA_EMPLOYEEMEMBER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.aa_employeemember_obj IS OBJECT
(
employeeid VARCHAR2(50),
memberplanid NUMBER,
alternatepatientid VARCHAR2(50)
)



--
-- AA_EMPLOYEEMEMBER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   AA_EMPLOYEEMEMBER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.aa_employeemember_tab IS TABLE OF aa_employeemember_obj;



--
-- AA_HRA_ANS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."AA_HRA_ANS_OBJ" 
IS
   OBJECT (ANSWERINDEXID NUMBER, RESPONSETEXT VARCHAR2 (4000)); 



--
-- AA_HRA_ANS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   AA_HRA_ANS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."AA_HRA_ANS_TAB" 
IS table of aa_hra_ans_obj; 



--
-- ACTPATIENTCACHE_OBJ  (Type) 
--
--  Dependencies: 
--   PATIENTCACHE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ACTPATIENTCACHE_OBJ
IS
   OBJECT (patientlist patientcache_obj);



--
-- ACTPATIENTCACHE_TAB  (Type) 
--
--  Dependencies: 
--   ACTPATIENTCACHE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ACTPATIENTCACHE_TAB
IS
   TABLE OF actpatientcache_obj;



--
-- ACTUSERPATIENT_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.actuserpatient_req_obj
IS
   OBJECT (MemberPlanid number, memberid number, providerid number, masterflag varchar2 (1), actionflag varchar2 (50));



--
-- ACTUSERPATIENT_REQ_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   ACTUSERPATIENT_REQ_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.actuserpatient_req_tab IS TABLE OF actuserpatient_req_obj;



--
-- ACTUSERPATIENT_RES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.actuserpatient_res_obj IS OBJECT (MemberPlanid number,
                                                         Providerid number,
                                                         AssociationSource varchar2 (50),
                                                         AssociationStatus varchar2 (100),
                                                         PCPIndicator varchar2 (1),
                                                         PCPSource varchar2 (50),
                                                         PCPDate date,
                                                         ActionFlag varchar2 (1),
                                                         masterflag varchar2 (1));



--
-- ACTUSERPATIENT_RES_TAB  (Type) 
--
--  Dependencies: 
--   ACTUSERPATIENT_RES_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.actuserpatient_res_tab IS TABLE OF actuserpatient_res_obj;



--
-- ADDRLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ADDRLIST_OBJ IS OBJECT (
   odstrackingid       NUMBER,
   addressline1        VARCHAR2 (50),
   addrline2           VARCHAR2 (50),
   city                VARCHAR2 (50),
   state               VARCHAR2 (2),
   zipcode             VARCHAR2 (20),
   country             CHAR (2),
   addresstype         VARCHAR2 (20),
   preferredflg        CHAR (1),
   updatedsourcename   VARCHAR2 (20),
   updateddate         DATE,
   channel             VARCHAR2 (10),
   deletedbysource     VARCHAR2 (20)
);




--
-- ADDRLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   ADDRLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ADDRLIST_TAB AS TABLE OF ADDRLIST_OBJ;



--
-- ADDR_INFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."ADDR_INFO_OBJ"
AS
   OBJECT (AddressLine1        varchar2 (50),
           AddressLine2        varchar2 (50),
           CityName            varchar2 (50),
           StateCode           varchar2 (2),
           CountryCode         varchar2 (50),
           ZipCode             varchar2 (5),
           ADDRPREFERENCESEQ   NUMBER,
           ADDRUSAGETYPE       VARCHAR2 (20)
           );




--
-- ADDR_INFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   ADDR_INFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."ADDR_INFO_TAB" IS TABLE OF addr_info_obj;




--
-- AETNAMEMBERIDENTIFICATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.AetnaMemberIdentification_OBJ AS OBJECT
(
EDWMemberId         VARCHAR2(50 BYTE),
CUMBId              VARCHAR2(9 BYTE),
ProxyId             VARCHAR2(20 BYTE)
);



--
-- AHMPRODUCT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ahmproduct_obj AS OBJECT
(
ceproductmnemoniccd VARCHAR2(200),
ahmsupplierid NUMBER
)



--
-- AHMPRODUCT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   AHMPRODUCT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ahmproduct_tab IS TABLE OF ahmproduct_obj



--
-- ARRAY_ELEMENT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."ARRAY_ELEMENT" AS TABLE OF number;



--
-- ARRAY_MEMBERID  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."ARRAY_MEMBERID"
  AS VARRAY(1000) OF NUMBER;



--
-- ATOM_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ATOM_OBJECT as object(
  ATOMCODE           VARCHAR2(50 Byte),
  ATOMNAME    VARCHAR2(500 Byte),
  ELEMENTID         NUMBER); 



--
-- ATOM_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   ATOM_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.ATOM_OBJECT_ARRAY   as table of ATOM_OBJECT; 



--
-- BATCH_MEMBER_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   BATCH_MEMBER_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.BATCH_MEMBER_ARRAY
  as table of batch_member_object;



--
-- BATCH_MEMBER_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.BATCH_MEMBER_OBJECT
  as object(
memberid     NUMBER);



--
-- CALCTRACKERVALUELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CALCTRACKERVALUELIST_OBJ
as object (
HealthTrackerName VARCHAR2(12),
MemberReportedMeasurementType VARCHAR2(40),
UpdateSourceName VARCHAR2(20),
FeedSourceNm   VARCHAR2(20),
MeasurementDate TIMESTAMP(6),
MemberReportedDeviceType VARCHAR2(255),
HealthTrackerComponentName VARCHAR2(12),
SubTypeName VARCHAR2(30),
UnitOfMeasurement  VARCHAR2(30),
Calculatedperiod    VARCHAR2(30),
Calculatedvalue1 NUMBER,
Calculatedvalue2 NUMBER
)



--
-- CALCTRACKERVALUELIST_TAB  (Type) 
--
--  Dependencies: 
--   CALCTRACKERVALUELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CALCTRACKERVALUELIST_TAB is table of CalcTrackerValueList_obj



--
-- CAMPAIGNPROGRAMDETAILS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CAMPAIGNPROGRAMDETAILS_OBJ IS OBJECT (
CampaignIdentifier	NUMBER,
CampaignName	VARCHAR2(255),
TTCampaignID	VARCHAR2(100),
CoachingProgramIdentifier	NUMBER,
ProgramName	VARCHAR2(255),
TTProgramID	VARCHAR2(100),
ProgramType	VARCHAR2(50),
AccountId	NUMBER
);




--
-- CAMPAIGNPROGRAMDETAILS_TAB  (Type) 
--
--  Dependencies: 
--   CAMPAIGNPROGRAMDETAILS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CAMPAIGNPROGRAMDETAILS_TAB AS TABLE OF CAMPAIGNPROGRAMDETAILS_OBJ;




--
-- CARECONSIDERATIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CARECONSIDERATIONLIST_OBJ
AS
   OBJECT
( caserecommendationid         NUMBER,
  severity                     VARCHAR2(2 BYTE),
  recommendationcode           VARCHAR2(200 BYTE),
  recommendationdescription    VARCHAR2(4000 BYTE),
  reportingfirstsenddt         DATE,
  caserecommendsubstatus       VARCHAR2(30 BYTE),
  careprovideridentifier       NUMBER,
  providername                 VARCHAR2(200 BYTE),
  vbfmessage                   VARCHAR2(4000 BYTE),
  recommendationtype           VARCHAR2(2 BYTE),
  cctypecode                   VARCHAR2(12 BYTE),
  appendtext 				   varchar2 (2000 BYTE)
);



--
-- CARECONSIDERATIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   CARECONSIDERATIONLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CARECONSIDERATIONLIST_TAB IS TABLE OF CARECONSIDERATIONLIST_OBJ;



--
-- CARMEMBER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CARMEMBER_OBJ
AS OBJECT
(
       payermemberid                    NUMBER,
       ahmmrnmemberid                   NUMBER,
       ahmmrnmemberplanid               NUMBER,
       ahmmrnsupplierid                 NUMBER,
       ahmmrnsuppliername               VARCHAR2(200),
       LASTBUSINESSAHMSUPPLIERID        NUMBER,
       lastbusinesssuppliername         VARCHAR2(200),
       lbsattributedflag                CHAR(1)
)



--
-- CARMEMBER_TAB  (Type) 
--
--  Dependencies: 
--   CARMEMBER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.carmember_tab as table of carmember_obj;



--
-- CASECLAIMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CASECLAIMLIST_OBJ IS OBJECT (
   MEMBERCLAIMSID NUMBER,
   MEMBERCLAIMDESCRIPTION VARCHAR2(4000),
   MEDICALCODE VARCHAR2 (20),
   CLAIMTYPE VARCHAR2(4),
   CODESYSTEMNM VARCHAR2(200),
   SERVICEDATE DATE,
   PRIMARYFLAG CHAR(1),
   PROVIDERID VARCHAR2 (30),
   EXCLUSIONFLAG VARCHAR2(2),
   CREATIONDATE DATE
) 



--
-- CASECLAIMLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CASECLAIMLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CASECLAIMLIST_TAB IS TABLE OF CASECLAIMLIST_OBJ 



--
-- CASELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CASECLAIMLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."CASELIST_OBJ" IS OBJECT (
                                                  membercaseid number,
                                                  sourcecaseid varchar2 (25),
                                                  servicedate date,
                                                  casetypedescr VARCHAR2 (255 BYTE),
                                                  statusdescr VARCHAR2 (255 BYTE),
                                                  closedate date,
                                                  approvaldate date,
                                                  claimlist caseclaimlist_tab,
                                                  exclusionflag char (1),
                                                  returncode number
                                               );



--
-- CASELIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CASELIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."CASELIST_TAB" IS TABLE OF caselist_obj;



--
-- CCDA_ALLERGY_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ccda_allergy_obj AS OBJECT (
   allergyid             dt_ii_obj
  ,allergycode           dt_ce_obj
  ,allergystartdate      TIMESTAMP
  ,allergyenddate		     TIMESTAMP
  ,allergystatus         dt_ce_obj
  ,allergen              dt_ce_obj
  ,reaction              dt_ce_obj
  ,severity              dt_ce_obj
  ,treatingprov          dt_ii_obj
  ,assocprovorg          dt_ii_obj
  ,servicinglocation     dt_ii_obj
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype           dt_ce_obj
  ,negationind           VARCHAR2 (5)
  ,reporteddate          DATE
  ,annotation            dt_annotation_tab
  ,odsencounterid		     NUMBER
  ,datasourcenm			     VARCHAR2(20)
);



--
-- CCDA_ALLERGY_TAB  (Type) 
--
--  Dependencies: 
--   CCDA_ALLERGY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ccda_allergy_tab IS TABLE OF ccda_allergy_obj;



--
-- CCDA_CLAIMHEADER_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   DT_ADDR_TAB (Type)
--   DT_CE_OBJ (Type)
--   DT_TEL_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ccda_claimheader_obj AS OBJECT ( 
   claimheaderid         dt_ii_obj, 
   facilityid            dt_ii_obj, 
   facilityaddr          dt_addr_tab,
   facilityfhone         dt_tel_tab,
   Feedsourcenm          varchar2(20),
   Claimcode             dt_ce_obj,
   Claimstartdate        date,
   Claimenddate          date,
   operatingproviderid   dt_ii_obj,
   attendingproviderid   dt_ii_obj,
   otherproviderid       dt_ii_obj,
   Vendorsourcenm        varchar2(100),
   datasourcenm          varchar2(20) ); 



--
-- CCDA_CLAIMHEADER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CCDA_CLAIMHEADER_OBJ (Type)
--
CREATE OR REPLACE type ODS.ccda_claimheader_tab is table of ccda_claimheader_obj; 



--
-- CCDA_CLINICALNOTESIN_TAB  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ccda_clinicalnotesin_tab IS TABLE OF dt_ii_obj; 



--
-- CCDA_CLINICALNOTES_OBJ  (Type) 
--
--  Dependencies: 
--   NOTEITEMLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CCDA_CLINICALNOTES_OBJ AS OBJECT
  (
    datasource   VARCHAR2 (20) ,
    notecategory VARCHAR2 (255) ,
    notelist     ods.noteitemlist_tab );



--
-- CCDA_CLINICALNOTES_TAB  (Type) 
--
--  Dependencies: 
--   CCDA_CLINICALNOTES_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CCDA_CLINICALNOTES_TAB IS TABLE OF ods.CCDA_CLINICALNOTES_OBJ;



--
-- CCDA_DIAGNOSIS_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_INFORMANT_OBJ (Type)
--   DT_CE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ccda_diagnosis_obj AS OBJECT (
   diagnosisid             dt_ii_obj
  ,diagnosiscode           dt_ce_obj
  ,diagnosisdate           TIMESTAMP
  ,diagnosisphase          dt_ce_obj
  ,priority                dt_ce_obj
  ,diagnosingclinician     dt_ii_obj
  ,diagnosisclassification dt_ce_obj
  ,confidentiality         dt_ce_obj
  ,diagnosisstatus         dt_ce_obj
  ,odsencounterid		       NUMBER
  ,annotation              dt_annotation_tab
  ,diagnosisenddate        TIMESTAMP
  ,reporteddt              DATE
  ,informant               hie_informant_obj
  ,docauthor               hie_iiextn_obj
  ,sectiontype             dt_ce_obj
  ,negationind             VARCHAR2 (5)
  ,datasourcenm		         VARCHAR2(20)
 );



--
-- CCDA_DIAGNOSIS_TAB  (Type) 
--
--  Dependencies: 
--   CCDA_DIAGNOSIS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ccda_diagnosis_tab IS TABLE OF ccda_diagnosis_obj;



--
-- CCDA_ID_XREF_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ccda_id_xref_obj 
IS OBJECT
(
documentid          VARCHAR2(50),
documenttype          VARCHAR2(30),
externalreferenceid VARCHAR2(100),
severity            varchar2(20),
processtatus        varchar2(30),
numeratorflag       varchar2(20),
healthstatuscd      varchar2(30),
statuschangedt      date
) 



--
-- CCDA_LABRESULTS_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_IIEXTN_OBJ (Type)
--   STANDARD (Package)
--   HIE_RELTYPE_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_LABRESVALUE_OBJ (Type)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ccda_labresults_obj AS OBJECT (
   labresultid           dt_ii_obj
  ,moodcode              VARCHAR2 (100)
  ,labresultcode         dt_ce_obj
  ,sequelnumber			     number
  ,labresultvalue        hie_labresvalue_obj
  ,efftime               timestamp
  ,labresultstatus       dt_ce_obj
  ,referencerange        VARCHAR2(100)
  ,interpretationcode    dt_ce_obj
  ,natureofabnormalcode  dt_ce_obj
  ,assocperformer        dt_ii_obj
  ,servicinglocation     dt_ii_obj
  ,annotation            dt_annotation_tab
  ,assocproviderorg      dt_ii_obj
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,replacedresultid      hie_reltype_obj
  ,reporteddate          timestamp
  ,relatedencounterid    dt_ii_obj
  ,response              hie_sectionresponse_obj
  ,producerid			       VARCHAR2(200)
  ,sectiontype           dt_ce_obj
  ,datasourcenm		       VARCHAR2(20)
);



--
-- CCDA_LABRESULTS_TAB  (Type) 
--
--  Dependencies: 
--   CCDA_LABRESULTS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ccda_labresults_tab IS TABLE OF ccda_labresults_obj;



--
-- CCDA_MEDICATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CCDA_DIAGNOSIS_TAB (Type)
--   DT_II_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_DOSAGE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_RELTYPE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_MEDADMINTIMING_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ccda_medication_obj AS OBJECT (
   medicationid                            dt_ii_obj,
   classcode                               dt_ce_obj,
   moodcode                                VARCHAR2 (100),
   medservicedt                            dt_ivl_ts_obj,
   medstartdate                            TIMESTAMP,
   medenddate                              TIMESTAMP,
   medadmintiming                          hie_medadmintiming_obj,
   routecode                               dt_ce_obj,
   dosage                                  dt_dosage_obj,
   productform                             dt_ce_obj,
   deliverymethod                          VARCHAR2 (100),
   medtypecode                             dt_ce_obj,
   meddrugname                             VARCHAR2 (100),
   meddrugcode                             dt_ce_obj,
   medstatus                               dt_ce_obj,
   assocperformer                          dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   servicinglocation                       dt_ii_obj,
   sectiontype                             dt_ce_obj,
   informant                               hie_informant_obj,
   recordtarget                            dt_ii_obj,
   negationind                             VARCHAR2 (5),
   docauthor                               hie_iiextn_obj,
   replacedmedid                           hie_reltype_obj,
   relatedencounterid                      dt_ii_obj,
   reporteddate                            DATE,
   annotation                              dt_annotation_tab,
   repeatnumber                            NUMBER,
   lotnumber                               VARCHAR2(50),
   approachsite                            dt_ce_obj,
   maxdosageqty                            NUMBER,
   pharmacyinstruction                     VARCHAR2(500),
   administrativeinstruction               varchar2(500),
   odsencounterid                          number,
   associateddiagnosis  				           ccda_diagnosis_tab,
   datasourcenm		                         VARCHAR2(20)
);



--
-- CCDA_MEDICATION_TAB  (Type) 
--
--  Dependencies: 
--   CCDA_MEDICATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ccda_medication_tab is table of ccda_medication_obj;



--
-- CCDA_OBSERVATIONDETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."CCDA_OBSERVATIONDETAIL_OBJ" force IS OBJECT
(
detailcode                              dt_ce_obj,
actionnegationind                       VARCHAR2 (1),
valuetype                               VARCHAR2(20),
valueuom                                dt_ce_obj,
valuelow                                NUMBER,
valuehigh                               NUMBER,
valuetext                               VARCHAR2(255),
valuecd                                 dt_ce_obj
)



--
-- CCDA_OBSERVATIONDETAIL_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CCDA_OBSERVATIONDETAIL_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."CCDA_OBSERVATIONDETAIL_TAB" force is table of ccda_observationdetail_obj



--
-- CCDA_OBSERVATION_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_INFORMANT_OBJ (Type)
--   CCDA_OBSERVATIONDETAIL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."CCDA_OBSERVATION_OBJ" force IS OBJECT
(
observationdtlskey                      NUMBER,
ID                                      dt_ii_obj,
moodcode                                VARCHAR2 (100),
classification                          VARCHAR2(12),
observationtypecode                     dt_ce_obj,
status                                  dt_ce_obj,
startdate                               VARCHAR2(20),
enddate                                 VARCHAR2(20),
assocperformer                          dt_ii_obj, -- hie_iiextn_obj,
assocproviderorg                        dt_ii_obj,
servicinglocation                       dt_ii_obj,
author                                  hie_iiextn_obj,
informant                               hie_informant_obj,
reporteddate                            DATE,
annotation                              dt_annotation_tab,
relatedencounterid                      dt_ii_obj,
replacedobservationid                   NUMBER ,
sectiontype                             dt_ce_obj,
vendorsourcenm                          VARCHAR2(100),
datasourcenm                            VARCHAR2 (20),
observationdetail                       ccda_observationdetail_obj
)



--
-- CCDA_OBSERVATION_TAB  (Type) 
--
--  Dependencies: 
--   CCDA_OBSERVATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."CCDA_OBSERVATION_TAB" force is table of ccda_observation_obj



--
-- CCDA_PATIENT_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_TAB (Type)
--   DT_II_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_PERSON_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ccda_patient_obj AS
OBJECT (account_oid DT_II_OBJ,
       issuing_oid DT_II_OBJ,
       patient_ConfidentialityCode DT_CE_TAB,
       patient_VIPCode DT_CE_OBJ,
       patient_Person dt_Person_obj
       );



--
-- CCDA_PROCEDURE_OBJ  (Type) 
--
--  Dependencies: 
--   CCDA_DIAGNOSIS_TAB (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CCDA_PROCEDURE_OBJ IS OBJECT (
  procedureid            dt_ii_obj
  ,moodcode              VARCHAR2 (100)
  ,procedurecode         dt_ce_obj
  ,procedurestatus       dt_ce_obj
  ,procstarttime         TIMESTAMP
  ,procendtime           TIMESTAMP
  ,facilitytype          dt_ce_obj
  ,targetsite            dt_ce_obj
  ,proctype              dt_ce_obj
  ,drgtype               VARCHAR2(50)
  ,anesthesiologist      dt_ii_obj
  ,anesthesiacd          dt_ce_obj
  ,anesthesiaminutes     NUMBER
  ,surgeon               dt_ii_obj
  ,prioritycd            dt_ce_obj
  ,treatingprov          dt_ii_obj
  ,assocprovorg          dt_ii_obj
  ,servicinglocation     dt_ii_obj
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype           dt_ce_obj
  ,negationind           VARCHAR2 (5)
  ,units                 VARCHAR2(20)
  ,quantity              NUMBER
  ,procedureamount       NUMBER
  ,procedureminutes      NUMBER
  ,consentcode           dt_ce_obj
  ,modifier1             VARCHAR2(255)
  ,modifier2             VARCHAR2(255)
  ,modifier3             VARCHAR2(255)
  ,modifier4             VARCHAR2(255)
  ,annotation            dt_annotation_tab
  ,approachsite          dt_ce_obj
  ,odsencounterid        NUMBER
  ,reporteddt            DATE
  ,assocperformer        dt_ii_obj
  ,associateddiagnosis   ccda_diagnosis_tab
  ,datasourcenm		       VARCHAR2(20)
);



--
-- CCDA_PROCEDURE_TAB  (Type) 
--
--  Dependencies: 
--   CCDA_PROCEDURE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CCDA_PROCEDURE_TAB IS TABLE OF CCDA_PROCEDURE_OBJ;



--
-- CCDA_PROVIDERINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ccda_providerinfo_obj
AS OBJECT (
  providerid            dt_ii_obj ,
  type                  VARCHAR2(1) ,
  role                  VARCHAR2(30) ,
  firstnm               VARCHAR2(50) ,
  lastnm                VARCHAR2(50) ,
  addrline1             VARCHAR2(255) ,
  zipcd                 VARCHAR2(20) ,
  state                 VARCHAR2(5) ,
  emailaddress          VARCHAR2(255) ,
  phonefaxdisplaynumber NUMBER ,
  currentflag           VARCHAR2(1) ,
  providerspecialty1    VARCHAR2(100) ,
  suffix                VARCHAR2(10) ,
  city                  VARCHAR2(50) ,
  country               CHAR(2) ,
  practicename          VARCHAR2(200) ,
  addr_use              varchar2(2),
  tele_use              varchar2(2),
  externalproviderid    dt_ii_obj
  ); 



--
-- CCDA_PROVIDERINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CCDA_PROVIDERINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ccda_providerinfo_tab IS TABLE OF ccda_providerinfo_obj; 



--
-- CCDA_PROVNPI_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ccda_provnpi_obj IS OBJECT
(
careproviderid NUMBER,
npi dt_ii_obj,
externalproviderid dt_ii_obj,
changeflag VARCHAR2(1)
); 



--
-- CCDA_PROVNPI_TAB  (Type) 
--
--  Dependencies: 
--   CCDA_PROVNPI_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ccda_provnpi_tab IS TABLE OF ccda_provnpi_obj; 



--
-- CCUSER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ccuser_obj as object
(userid                     varchar2(64),
clinicianid             varchar2(64),
issuprovorgoid     varchar2(64),
provfirstnm             varchar2(64),
provlastnm                varchar2(64),
provrole             varchar2(64)
);



--
-- CEAPP_MEMBERPROVIDER  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CEAPP_MEMBERPROVIDER IS OBJECT (CAREPROVIDERID NUMBER,SOURCECAREPROVIDERID VARCHAR2(200),RECORDUPDDT DATE);



--
-- CEAPP_MEMBERPROVIDER_120  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CEAPP_MEMBERPROVIDER_120 IS OBJECT (
                                                      CAREPROVIDERID NUMBER,
                                                      SOURCECAREPROVIDERID VARCHAR2 (200),
                                                      RECORDUPDDT DATE
                                                   );



--
-- CE_PRECERT_CASE_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CE_PRECERT_CASE_OBJECT
as object(
  memberid               NUMBER,
  dateofevent            DATE,
  effectivechangedate    DATE,
  code                   VARCHAR2(20),
  caseid                 NUMBER,
  casetype               NUMBER  
 ); 



--
-- CE_PRECERT_CASE_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   CE_PRECERT_CASE_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CE_PRECERT_CASE_OBJECT_ARRAY   as table of CE_PRECERT_CASE_OBJECT; 



--
-- CE_PRECERT_CLAIM_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CE_PRECERT_CLAIM_OBJECT
as object(
  memberid          NUMBER,
  dateofevent       DATE,
  effectivechangedate   DATE,
  code              VARCHAR2(20),
  instanceid        NUMBER,
  caseid            NUMBER,
  sourceproviderid  VARCHAR2(30),
  primaryflag       VARCHAR2(1)
 ); 



--
-- CE_PRECERT_CLAIM_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   CE_PRECERT_CLAIM_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CE_PRECERT_CLAIM_OBJECT_ARRAY   as table of CE_PRECERT_CLAIM_OBJECT; 



--
-- CLAIMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CLAIMLIST_OBJ
AS
   OBJECT (claimtype VARCHAR2 (20),
           claimid NUMBER,
           claimcode VARCHAR2 (20),
           ClaimCodeSystemNm VARCHAR2 (20),
           claimdescription VARCHAR2 (500),
           StartDate DATE,
           EndDate DATE,
           ufclaimcodename VARCHAR2 (100),
           codedescription VARCHAR2 (4000),
           feedsourcenm VARCHAR2 (20)                     --returncode  NUMBER
                                     );



--
-- CLAIMLIST_TAB  (Type) 
--
--  Dependencies: 
--   CLAIMLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CLAIMLIST_TAB AS TABLE OF CLAIMLIST_OBJ;



--
-- CLOB_HLTH  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CLOB_HLTH as
  OBJECT (
sethlthid           NUMBER,
sourcetrackingid   NUMBER,
vodstrackingid     NUMBER,
healthtrackername  VARCHAR2(35),
healthtrackercomponentname    VARCHAR2(35),
healthtrackervalue NUMBER,
unitofmeasure      VARCHAR2(30),
COMMENTS           VARCHAR2(4000),
LASTUPDATEDATE     DATE,
ACTION             VARCHAR2(10));



--
-- CLOB_HLTH_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CLOB_HLTH (Type)
--
CREATE OR REPLACE type ODS.CLOB_HLTH_TAB AS
TABLE OF CLOB_HLTH;



--
-- CLOB_HOMEWORK  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CLOB_HOMEWORK as
  OBJECT (
sethomeworkid      NUMBER,
sourcetrackingid   NUMBER,
vodstrackingid     NUMBER,
COMMENTS           VARCHAR2(4000),
STATUS             VARCHAR2(50),
STATUSDT           DATE,
HOMEWORKVALUE      VARCHAR2(200),
HOMEWORKTEXTCD     VARCHAR2 (12),
LASTUPDATEDATE     DATE,
ACTION             VARCHAR2(10));



--
-- CLOB_HOMEWORK_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CLOB_HOMEWORK (Type)
--
CREATE OR REPLACE type ODS.CLOB_HOMEWORK_TAB AS
TABLE OF CLOB_HOMEWORK;



--
-- CLOB_LAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CLOB_LAB as
  OBJECT (
setlabid           NUMBER,
sourcetrackingid   NUMBER,
vodstrackingid     NUMBER,
COMMENTS           VARCHAR2(4000),
LASTUPDATEDATE     DATE);



--
-- CLOB_LAB_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CLOB_LAB (Type)
--
CREATE OR REPLACE type ODS.CLOB_LAB_TAB AS
TABLE OF CLOB_LAB;



--
-- CLOB_MED  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CLOB_MED as
  OBJECT (
setmedid           NUMBER,
sourcetrackingid   NUMBER,
vodstrackingid     NUMBER,
drugtradename      VARCHAR2(50),
ndccode            VARCHAR2(20),
drugstrength       VARCHAR2(30),
COMMENTS           VARCHAR2(4000),
STATUS             VARCHAR2(50),
STATUSREASON       VARCHAR2(255),
LASTUPDATEDATE     DATE,
ACTION             VARCHAR2(10));



--
-- CLOB_MED_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CLOB_MED (Type)
--
CREATE OR REPLACE type ODS.CLOB_MED_TAB AS
TABLE OF CLOB_MED;



--
-- CLOB_UELAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CLOB_UELAB as
  OBJECT (
setuelabid            NUMBER,
sourcetrackingid   NUMBER,
vodstrackingid     NUMBER,
LOINC                 VARCHAR2(10),
LABTESTNM             VARCHAR2(256),
SERVICEDT             DATE,
LABTESTNUMERICRESULT  NUMBER,
LABTESTNONNUMERICRESULT    VARCHAR2(20),
DRUGUNITOFMEASURE          VARCHAR2(30),
LABTESTNONNUMERICIND       VARCHAR2(20),
COMMENTS           VARCHAR2(4000),
LASTUPDATEDATE     DATE,
ACTION             VARCHAR2(10));



--
-- CLOB_UELAB_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CLOB_UELAB (Type)
--
CREATE OR REPLACE type ODS.CLOB_UELAB_TAB AS
TABLE OF CLOB_UELAB;



--
-- CLOB_UEMED  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CLOB_UEMED as
  OBJECT (
setueid            NUMBER,
sourcetrackingid   NUMBER,
vodstrackingid     NUMBER,
drugtradename      VARCHAR2(50),
ndccode            VARCHAR2(20),
drugdosage         VARCHAR2(30),
COMMENTS           VARCHAR2(4000),
STATUS             VARCHAR2(50),
STATUSREASON       VARCHAR2(255),
LASTUPDATEDATE     DATE,
SERVICEDATE        DATE,
ACTION             VARCHAR2(10));



--
-- CLOB_UEMED_TAB  (Type) 
--
--  Dependencies: 
--   CLOB_UEMED (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CLOB_UEMED_TAB AS
TABLE OF CLOB_UEMED;



--
-- COCRECOMMENDATIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.COCRECOMMENDATIONLIST_OBJ IS OBJECT (
   CASERECOMMENDATIONID NUMBER,
   RECOMMENDATIONID NUMBER,
   SEVERITY VARCHAR2 (2),
   RECOMMENDATIONCODE VARCHAR2 (200),
   RECOMMENDATIONDESCRIPTION VARCHAR2 (4000),
   REPORTINGFIRSTSENDDT VARCHAR2 (20),
   CAREPROVIDERIDENTIFIER NUMBER,
   PROVIDERNAME VARCHAR2 (200),
   CCTYPEDESC VARCHAR2 (200),
   VBIDTYPE VARCHAR2 (4),
   SENSITIVEFLAG VARCHAR2 (1),
   NOTIFY VARCHAR2 (1)
   ); 



--
-- COCRECOMMENDATIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   COCRECOMMENDATIONLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.COCRECOMMENDATIONLIST_TAB IS TABLE OF COCRECOMMENDATIONLIST_OBJ; 



--
-- COMMTARGETLIST1_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MELIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.commtargetlist1_obj
AS
   OBJECT (mecommtarget varchar2 (200),
           cerunactonid number,
           productcd varchar2 (50),
           melist melist_tab);



--
-- COMMTARGETLIST1_TAB  (Type) 
--
--  Dependencies: 
--   COMMTARGETLIST1_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.commtargetlist1_tab IS TABLE OF commtargetlist1_obj;



--
-- COMMTARGETLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MELIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.COMMTARGETLIST_OBJ as
object(
MECommTarget varchar2(200),
MEList    MEList_tab);




--
-- COMMTARGETLIST_TAB  (Type) 
--
--  Dependencies: 
--   COMMTARGETLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.COMMTARGETLIST_TAB IS TABLE OF CommTargetList_obj;




--
-- COM_ACCIDENTS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_ACCIDENT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_accidents_tab AS TABLE OF com_accident_obj;



--
-- COM_ACCIDENTS_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_ACCIDENT_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_accidents_tab_v2 AS TABLE OF com_accident_obj_v2;



--
-- COM_ACCIDENT_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_accident_obj AS OBJECT (
   accidentid            dt_ii_obj
  ,efftime               TIMESTAMP
  ,accidenttype          dt_ce_obj
  ,accidentlocation      VARCHAR2 (50)
  ,deathindicator        VARCHAR2 (50)
  ,jobrelatedflag	     VARCHAR2(1)
);



--
-- COM_ACCIDENT_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_accident_obj_v2 AS OBJECT (
   accidentid            dt_ii_obj
  ,efftime               TIMESTAMP
  ,accidenttype          dt_ce_obj
  ,accidentlocation      VARCHAR2 (50)
  ,deathindicator        VARCHAR2 (50)
  ,jobrelatedflag	     VARCHAR2(1)
);



--
-- COM_ADVANCEDIRECTIVE_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_IIEXTN_OBJ (Type)
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_advancedirective_obj_v2 IS OBJECT (
   advancedirectiveid                     dt_ii_obj
  ,advancedirectivecode                   dt_ce_obj
  ,advancedirectivestatus                 dt_ce_obj
  ,startdate                               VARCHAR2 (20)
  ,enddate                                 VARCHAR2 (20)
  ,valuecd                                 dt_ce_obj
  ,custodian                               dt_ii_obj
  ,verifier                                dt_ii_obj
  ,referencedocumentid                     VARCHAR2 (100)
  ,referencedocumenturl                    VARCHAR2 (2000)
  ,referencedocumenttype                   VARCHAR2 (100)
  ,reporteddt                              DATE
  ,datasourcenm                            VARCHAR2 (20)
  ,annotation                              dt_annotation_tab
  ,docauthor                               hie_iiextn_obj
  ,sectiontype                             dt_ce_obj
)



--
-- COM_ADVANCEDIRECTIVE_TAB_V2  (Type) 
--
--  Dependencies: 
--   COM_ADVANCEDIRECTIVE_OBJ_V2 (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_advancedirective_tab_v2 IS TABLE OF com_advancedirective_obj_v2



--
-- COM_ALLERGIES_TAB  (Type) 
--
--  Dependencies: 
--   COM_ALLERGY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_allergies_tab AS TABLE OF com_allergy_obj;



--
-- COM_ALLERGIES_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_ALLERGY_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_allergies_tab_v2 AS TABLE OF com_allergy_obj_v2;



--
-- COM_ALLERGY_OBJ  (Type) 
--
--  Dependencies: 
--   DT_ANNOTATION_TAB (Type)
--   STANDARD (Package)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_allergy_obj AS OBJECT (
   allergyid             dt_ii_obj
  ,allergycode           dt_ce_obj
  ,allergystartdate      TIMESTAMP
  ,allergyenddate		 TIMESTAMP
  ,allergystatus         dt_ce_obj
  ,allergen              dt_ce_obj
  ,reaction              dt_ce_obj
  ,severity              dt_ce_obj
  ,treatingprov          dt_ii_obj
  ,assocprovorg          dt_ii_obj
  ,servicinglocation     dt_ii_obj
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype           dt_ce_obj
  ,negationind           VARCHAR2 (5)
  ,reporteddate          DATE
  ,annotation            dt_annotation_tab
  ,odsencounterid		 NUMBER
);



--
-- COM_ALLERGY_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   DT_CE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.com_allergy_obj_v2 AS OBJECT (
   allergyid             dt_ii_obj
  ,allergycode           dt_ce_obj
  ,allergystartdate      TIMESTAMP
  ,allergyenddate		 TIMESTAMP
  ,allergystatus         dt_ce_obj
  ,allergen              dt_ce_obj
  ,reaction              dt_ce_obj
  ,severity              dt_ce_obj
  ,treatingprov          dt_ii_obj
  ,assocprovorg          dt_ii_obj
  ,servicinglocation     dt_ii_obj
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype           dt_ce_obj
  ,negationind           VARCHAR2 (5)
  ,reporteddate          DATE
  ,annotation            dt_annotation_tab
  ,odsencounterid		 NUMBER
);



--
-- COM_CLINDOCSUMMARY_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_ENCOMPENC_OBJ (Type)
--   STANDARD (Package)
--   HIE_RECORDTARGET_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_CE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_clindocsummary_obj AS OBJECT (       
   accountoid            dt_ii_obj            
  ,docid                 dt_ii_obj            
  ,doccode               dt_ce_obj            
  ,docformat             dt_ce_obj            
  ,doctitle              VARCHAR2 (250)       
  ,docefftime            TIMESTAMP            
  ,docsource             hie_informant_obj    
  ,doccustodian          dt_ii_obj            
  ,docrelparentid        hie_reltype_obj      
  ,docsetid              dt_ii_obj            
  ,docversionid          NUMBER               
  ,encompenc             hie_encompenc_obj    
  ,recordtarget          hie_recordtarget_obj 
  ,confidentialitycode   dt_ce_obj            
  ,memberplanid          NUMBER               
  ,sourcesystem          VARCHAR2 (50)        
  ,docauthor             hie_iiextn_obj       
  ,odsencounterid        NUMBER               
  ,ahmflag               VARCHAR2 (20)        
  ,claimamounttotal      NUMBER               
  ,patientamountpaid     NUMBER               
  ,custodiansourceid     VARCHAR2 (50)        
  ,custodiansourcename   VARCHAR2 (100)       
  ,healthplan            VARCHAR2 (50)        
  ,groupnumber           VARCHAR2 (50)        
  ,taxonomy              dt_ii_obj            
  ,claimfrequencytype    NUMBER               
  ,originalreferenceid   VARCHAR2 (25)        
); 



--
-- COM_CLINDOCSUMMARY_OBJ_V2  (Type) 
--
--  Dependencies: 
--   HIE_RECORDTARGET_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   HIE_ENCOMPENC_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_clindocsummary_obj_v2 AS OBJECT (
   accountoid            dt_ii_obj
  ,docid                 dt_ii_obj
  ,doccode               dt_ce_obj
  ,docformat             dt_ce_obj
  ,doctitle              VARCHAR2 (100)
  ,docefftime            TIMESTAMP
  ,docsource             hie_informant_obj
  ,doccustodian          dt_ii_obj
  ,docrelparentid        hie_reltype_obj
  ,docsetid              dt_ii_obj
  ,docversionid          NUMBER
  ,encompenc             hie_encompenc_obj
  ,recordtarget          hie_recordtarget_obj
  ,confidentialitycode   dt_ce_obj
  ,memberplanid          NUMBER
  ,sourcesystem          VARCHAR2 (50)
  ,docauthor             hie_iiextn_obj
  ,odsencounterid        NUMBER
  ,ahmflag               VARCHAR2 (20)
  ,claimamounttotal      NUMBER
  ,patientamountpaid     NUMBER
  ,custodiansourceid     VARCHAR2 (50)
  ,custodiansourcename   VARCHAR2 (100)
  ,healthplan            VARCHAR2 (50)
  ,groupnumber           VARCHAR2 (50)
  ,taxonomy              dt_ii_obj
  ,claimfrequencytype    NUMBER
  ,originalreferenceid   VARCHAR2 (25)
);



--
-- COM_CONDITIONS_OBJ_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_conditions_obj_v2 IS OBJECT
( conditioncd                             dt_ce_obj
  ,age                                     NUMBER
  ,startdate                               VARCHAR2(20)
  ,enddate                                 VARCHAR2(20)
  ,causeddeathflg                          CHAR (1)
  ,annotation                              dt_annotation_tab
)



--
-- COM_CONDITIONS_TAB_V2  (Type) 
--
--  Dependencies: 
--   COM_CONDITIONS_OBJ_V2 (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_conditions_tab_v2 IS TABLE OF com_conditions_obj_v2



--
-- COM_DEMOGRAPHICS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_demographics_obj
IS OBJECT
(
firstnm VARCHAR2(50),
lastnm  VARCHAR2(50),
middleinitial VARCHAR2(25),
ssn    VARCHAR2(50),
dtofbirth  DATE     ,
gender VARCHAR2(10),
addressline1 VARCHAR2(4000),
city VARCHAR2(255),
zipcd VARCHAR2(20),
homephone  VARCHAR2(20)
);



--
-- COM_DIAGNOSIS_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_diagnosis_obj AS OBJECT (
   diagnosisid           dt_ii_obj
  ,diagnosiscode         dt_ce_obj
  ,diagnosisdate         TIMESTAMP
  ,diagnosisphase        dt_ce_obj
  ,priority              dt_ce_obj
  ,diagnosingclinician   dt_ii_obj
  ,diagnosisclassification dt_ce_obj
  ,confidentiality       dt_ce_obj
  ,diagnosisstatus       dt_ce_obj
  ,odsencounterid		 NUMBER
  ,annotation            dt_annotation_tab
  ,diagnosisenddate      TIMESTAMP
  ,reporteddt            DATE
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype           dt_ce_obj
  ,negationind           VARCHAR2 (5)
 );



--
-- COM_DIAGNOSIS_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_ANNOTATION_TAB (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_diagnosis_obj_v2 AS OBJECT (
   diagnosisid           dt_ii_obj
  ,diagnosiscode         dt_ce_obj
  ,diagnosisdate         TIMESTAMP
  ,diagnosisphase        dt_ce_obj
  ,priority              dt_ce_obj
  ,diagnosingclinician   dt_ii_obj
  ,diagnosisclassification dt_ce_obj
  ,confidentiality       dt_ce_obj
  ,diagnosisstatus       dt_ce_obj
  ,odsencounterid		 NUMBER
  ,annotation            dt_annotation_tab
  ,diagnosisenddate      TIMESTAMP
  ,reporteddt            DATE
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype           dt_ce_obj
  ,negationind           VARCHAR2 (5)
 );



--
-- COM_DIAGNOSIS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_DIAGNOSIS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_diagnosis_tab AS TABLE OF com_diagnosis_obj;



--
-- COM_DIAGNOSIS_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_DIAGNOSIS_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_diagnosis_tab_v2 AS TABLE OF com_diagnosis_obj_v2;



--
-- COM_DIAGRELATEDGROUP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_diagrelatedgroup_obj AS OBJECT
(
   diagrelatedgroup      dt_ce_obj
  ,drgapprovalindicator  VARCHAR2 (50)
  ,drgreviewcode         dt_ce_obj
  ,outliertype           dt_ce_obj
  ,outlierdays           VARCHAR2 (100)
  ,outliercost           VARCHAR2 (100)
  ,majorcategory         dt_ce_obj
  ,attestationdate       TIMESTAMP
);



--
-- COM_DIAGRELATEDGROUP_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_diagrelatedgroup_obj_v2 AS OBJECT
(
   diagrelatedgroup      dt_ce_obj
  ,drgapprovalindicator  VARCHAR2 (50)
  ,drgreviewcode         dt_ce_obj
  ,outliertype           dt_ce_obj
  ,outlierdays           VARCHAR2 (100)
  ,outliercost           VARCHAR2 (100)
  ,majorcategory         dt_ce_obj
  ,attestationdate       TIMESTAMP
);



--
-- COM_DOSAGE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_dosage_obj AS OBJECT (
   dosage_qty                              VARCHAR2(50),
   dosage_value                            VARCHAR2(50),
   dosage_unit                             VARCHAR2 (100),
   dosage_oid                              VARCHAR2 (100)
);



--
-- COM_DOSAGE_OBJ_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_dosage_obj_v2 AS OBJECT (
   dosage_qty                              VARCHAR2(50),
   dosage_value                            VARCHAR2(50),
   dosage_unit                             VARCHAR2 (100),
   dosage_oid                              VARCHAR2 (100)
);



--
-- COM_ENCOUNTERDETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   COM_ENCOUNTER_FIN_OBJ (Type)
--   COM_PROVIDER_TAB (Type)
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--   COM_PATIENTLOCATION_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.COM_ENCOUNTERDETAIL_OBJ AS OBJECT (
   assignedpatientlocation com_patientlocation_obj
  ,attendingdoctor       dt_ii_obj
  ,referringdoctor       dt_ii_obj
  ,consultingdoctor      dt_ii_obj
  ,hospitalservice       dt_ce_obj
  ,servicingfacility     VARCHAR2 (64)
  ,diettype              dt_ce_obj
  ,financialdetails      com_encounter_fin_obj
  ,comments                 dt_annotation_tab
  ,providers             com_provider_tab
); 



--
-- COM_ENCOUNTERDETAIL_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--   COM_PROVIDER_TAB (Type)
--   COM_PATIENTLOCATION_OBJ_V2 (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   COM_ENCOUNTER_FIN_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_encounterdetail_obj_v2 AS OBJECT (
   assignedpatientlocation com_patientlocation_obj_v2
  ,attendingdoctor       dt_ii_obj
  ,referringdoctor       dt_ii_obj
  ,consultingdoctor      dt_ii_obj
  ,hospitalservice       dt_ce_obj
  ,servicingfacility     VARCHAR2 (64)
  ,diettype              dt_ce_obj
  ,financialdetails      com_encounter_fin_obj_v2
  ,comments				 dt_annotation_tab
  ,providers			 com_provider_tab
);



--
-- COM_ENCOUNTER_CLAIMINFO  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_encounter_claiminfo AS OBJECT
(
 contracttype		dt_ce_obj
,contractid			VARCHAR2(50)
,contractversionid	VARCHAR2(30)
,contractamt		NUMBER
,allowancepct		NUMBER
,termdiscountpct	NUMBER
);



--
-- COM_ENCOUNTER_FIN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_encounter_fin_obj AS OBJECT (
   contractcode          VARCHAR2 (50)
  ,contracteffdate       TIMESTAMP
  ,contractamount        NUMBER
  ,contractperiod        VARCHAR2 (50)
  ,totalcharges          NUMBER
  ,totaladjustments      NUMBER
  ,totalpayments         NUMBER
);



--
-- COM_ENCOUNTER_FIN_OBJ_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_encounter_fin_obj_v2 AS OBJECT (
   contractcode          VARCHAR2 (50)
  ,contracteffdate       TIMESTAMP
  ,contractamount        NUMBER
  ,contractperiod        VARCHAR2 (50)
  ,totalcharges          NUMBER
  ,totaladjustments      NUMBER
  ,totalpayments         NUMBER
);



--
-- COM_ENCOUNTER_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   STANDARD (Package)
--   DT_CE_TAB (Type)
--   DT_II_OBJ (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.COM_ENCOUNTER_OBJ AS OBJECT (
   encounterid           dt_ii_obj
  ,encountertype         dt_ce_obj
  ,admitdate             TIMESTAMP
  ,admissiontype         dt_ce_obj
  ,admitsource           dt_ce_obj
  ,admitreason           VARCHAR2(200)
  ,dischargedate         TIMESTAMP
  ,readmissionindicator  VARCHAR2 (5)
  ,dischargedisposition  dt_ce_obj
  ,dischargedtolocation  dt_ce_obj
  ,vipindicator          dt_ce_obj
  ,patientaccountnumber  VARCHAR2(100)
  ,preadmissiontestindicator VARCHAR2(1)
  ,encompassingcareprovider   dt_ii_obj
  ,reporteddt            DATE
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype           dt_ce_obj
  ,msgseqnbr             NUMBER
  ,additionalfactors     dt_ce_tab
  ,visitprotectionflg     VARCHAR2(20)
  ,moodcode            VARCHAR2 (100)
  ,replacedencounterid    dt_ii_obj
  -- For 837i
 * ,releaseinfocd        dt_ce_obj
  ,specialprogramcd        dt_ce_obj
  ,nursinghomestatuscd    dt_ce_obj
  ,claiminfo            com_encounter_claiminfo
  *
); 



--
-- COM_ENCOUNTER_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_CE_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.com_encounter_obj_v2 AS OBJECT (
   encounterid           dt_ii_obj
  ,encountertype         dt_ce_obj
  ,admitdate             TIMESTAMP
  ,admissiontype         dt_ce_obj
  ,admitsource           dt_ce_obj
  ,admitreason           VARCHAR2(200)
  ,dischargedate         TIMESTAMP
  ,readmissionindicator  VARCHAR2 (5)
  ,dischargedisposition  dt_ce_obj
  ,dischargedtolocation  dt_ce_obj
  ,vipindicator          dt_ce_obj
  ,patientaccountnumber  VARCHAR2(100)
  ,preadmissiontestindicator VARCHAR2(1)
  ,encompassingcareprovider   dt_ii_obj
  ,reporteddt            DATE
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype           dt_ce_obj
  ,msgseqnbr             NUMBER
  ,additionalfactors     dt_ce_tab
  ,visitprotectionflg     VARCHAR2(20)
  ,moodcode            VARCHAR2 (100)
  ,replacedencounterid    dt_ii_obj
  -- For 837i
 * ,releaseinfocd        dt_ce_obj
  ,specialprogramcd        dt_ce_obj
  ,nursinghomestatuscd    dt_ce_obj
  ,claiminfo            com_encounter_claiminfo
  *
);



--
-- COM_FAMILYHISTORY_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   DT_EXTENDEDPERSON_OBJ (Type)
--   COM_CONDITIONS_TAB_V2 (Type)
--   DT_CE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_familyhistory_obj_v2 IS OBJECT (
   familyhistoryid                         dt_ii_obj
  ,relation                                dt_extendedperson_obj
  ,conditions                              com_conditions_tab_v2
  ,reporteddt                              DATE
  ,datasourcenm                            VARCHAR2 (20)
  ,docauthor                               hie_iiextn_obj
  ,sectiontype                             dt_ce_obj
)



--
-- COM_FAMILYHISTORY_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_FAMILYHISTORY_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_familyhistory_tab_v2 IS TABLE OF com_familyhistory_obj_v2;



--
-- COM_GUARANTOR_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_PN_OBJ (Type)
--   DT_ADDR_OBJ (Type)
--   STANDARD (Package)
--   DT_TEL_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_guarantor_obj IS OBJECT (
   guarantornumber       dt_ii_obj
  ,guarantorname         dt_pn_obj
  ,guarantoraddress      dt_addr_obj
  ,guarantorhomephone    dt_tel_obj
  ,guarantorbusphone     dt_tel_obj
  ,guarantordob          DATE
  ,guarantorstartdate	 DATE
  ,gender                dt_ce_obj
  ,guarantortype         dt_ce_obj
  ,relationtype          dt_ce_obj	-- VARCHAR2 (50)
  ,publicityindicator    VARCHAR2 (20)
  ,protectionindicator   VARCHAR2 (20)
  ,religion              dt_ce_obj
  ,race                  dt_ce_obj
  ,guarantoremployeeid	 VARCHAR2(250)
  ,guarantoremployerid	 VARCHAR2(250)
  ,maritalstatuscd       dt_ce_obj -- VARCHAR2(30)
  ,restrictedaccessflg   VARCHAR2(1)
  ,publicitydesc		 VARCHAR2(100)
);



--
-- COM_GUARANTOR_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_ADDR_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_TEL_OBJ (Type)
--   DT_PN_OBJ (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_guarantor_obj_v2 IS OBJECT (
   guarantornumber       dt_ii_obj
  ,guarantorname         dt_pn_obj
  ,guarantoraddress      dt_addr_obj
  ,guarantorhomephone    dt_tel_obj
  ,guarantorbusphone     dt_tel_obj
  ,guarantordob          DATE
  ,guarantorstartdate	 DATE
  ,gender                dt_ce_obj
  ,guarantortype         dt_ce_obj
  ,relationtype          dt_ce_obj	-- VARCHAR2 (50)
  ,publicityindicator    VARCHAR2 (20)
  ,protectionindicator   VARCHAR2 (20)
  ,religion              dt_ce_obj
  ,race                  dt_ce_obj
  ,guarantoremployeeid	 VARCHAR2(250)
  ,guarantoremployerid	 VARCHAR2(250)
  ,maritalstatuscd       dt_ce_obj -- VARCHAR2(30)
  ,restrictedaccessflg   VARCHAR2(1)
  ,publicitydesc		 VARCHAR2(100)
);



--
-- COM_GUARANTOR_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_GUARANTOR_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_guarantor_tab IS TABLE OF com_guarantor_obj;



--
-- COM_GUARANTOR_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_GUARANTOR_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_guarantor_tab_v2 IS TABLE OF com_guarantor_obj_v2;



--
-- COM_INSURANCE_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_PERSON_OBJ (Type)
--   DT_ADDR_OBJ (Type)
--   STANDARD (Package)
--   DT_TEL_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.COM_INSURANCE_OBJ IS OBJECT (
   personid	    		 dt_ii_obj
  ,relationcd           dt_ce_obj
  ,subscriber           dt_person_obj
  ,subscriberorg		 dt_ii_obj
   -- Insurance related fields
  ,policynumber          VARCHAR2(15)
  ,planid                VARCHAR2 (50)
  ,plantype              VARCHAR2(100)
  ,policyeffectivedate   DATE
  ,policytermdate        DATE
  ,policyacctnumber      VARCHAR2(50)
  ,groupnumber       VARCHAR2(50)
  ,groupname         VARCHAR2(100)
  ,coveragetype          dt_ce_obj
  ,pcp					 dt_ii_obj
  ,coordinationofbenefits VARCHAR2 (1)
  ,cobpriority           NUMBER
  ,insuranceconame       VARCHAR2 (255)
  -- Below fields are not used by MCOM.
  ,plangroupemployerid   VARCHAR2(30)
  ,plangroupemployername VARCHAR2(100)
  ,insurancecoaddress    dt_addr_obj
  ,insurancecotel         dt_tel_obj
  ,authorizationnumber   VARCHAR2(30)
  ,authorizationdate     DATE
  ,noticeadminflag       VARCHAR2(1)
  ,noticeadmissiondate   DATE
  ,reporteligcd          VARCHAR2(1)
  ,reporteligdate        DATE
  ,releaseinfocd         dt_ce_obj
  ,preadmitcertification VARCHAR2(15)
  ,policylimitmaxdays    NUMBER
  ,insuredempstatus      dt_ce_obj -- VARCHAR2(24)
  ,verificationstatus    VARCHAR2 (50)
  ,priorinsuranceplanid  VARCHAR2 (100)
  ,insuranceid     dt_ii_obj
);



--
-- COM_INSURANCE_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_ADDR_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_TEL_OBJ (Type)
--   DT_PERSON_OBJ (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_insurance_obj_v2 IS OBJECT (
   personid	    		 dt_ii_obj
  ,relationcd           dt_ce_obj
  ,subscriber           dt_person_obj
  ,subscriberorg		 dt_ii_obj   -- Insurance related fields
  ,policynumber          VARCHAR2(15)
  ,planid                VARCHAR2 (50)
  ,plantype              VARCHAR2(10)
  ,policyeffectivedate   DATE
  ,policytermdate        DATE
  ,policyacctnumber      VARCHAR2(50)
  ,groupnumber       VARCHAR2(50)
  ,groupname         VARCHAR2(100)
  ,coveragetype          dt_ce_obj
  ,pcp					 dt_ii_obj
  ,coordinationofbenefits VARCHAR2 (1)
  ,cobpriority           NUMBER
  ,insuranceconame       VARCHAR2 (255)  -- Below fields are not used by MCOM.
  ,plangroupemployerid   VARCHAR2(30)
  ,plangroupemployername VARCHAR2(100)
  ,insurancecoaddress    dt_addr_obj
  ,insurancecotel         dt_tel_obj
  ,authorizationnumber   VARCHAR2(30)
  ,authorizationdate     DATE
  ,noticeadminflag       VARCHAR2(1)
  ,noticeadmissiondate   DATE
  ,reporteligcd          VARCHAR2(1)
  ,reporteligdate        DATE
  ,releaseinfocd         dt_ce_obj
  ,preadmitcertification VARCHAR2(15)
  ,policylimitmaxdays    NUMBER
  ,insuredempstatus      dt_ce_obj -- VARCHAR2(24)
  ,verificationstatus    VARCHAR2 (50)
  ,priorinsuranceplanid  VARCHAR2 (100)
  ,insuranceid     dt_ii_obj
  ,insurancecoid     dt_ii_obj
)



--
-- COM_INSURANCE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_INSURANCE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.COM_INSURANCE_TAB IS TABLE OF com_insurance_obj;



--
-- COM_INSURANCE_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_INSURANCE_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_insurance_tab_v2 IS TABLE OF com_insurance_obj_v2



--
-- COM_LABRESULTS_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_RELTYPE_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   STANDARD (Package)
--   HIE_LABRESVALUE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_labresults_obj AS OBJECT (
   labresultid           dt_ii_obj
  ,moodcode              VARCHAR2 (100)
  ,labresultcode         dt_ce_obj
  ,sequelnumber			 number
  ,labresultvalue        hie_labresvalue_obj
  ,efftime               timestamp
  ,labresultstatus       dt_ce_obj
  ,referencerange        VARCHAR2(100)
  ,interpretationcode    dt_ce_obj
  ,natureofabnormalcode  dt_ce_obj
  ,assocperformer        dt_ii_obj
  ,servicinglocation     dt_ii_obj
  ,annotation            dt_annotation_tab
  ,assocproviderorg      dt_ii_obj
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,replacedresultid      hie_reltype_obj
  ,reporteddate          timestamp
  ,relatedencounterid    dt_ii_obj
  ,response              hie_sectionresponse_obj
  ,producerid			 VARCHAR2(200)
  ,sectiontype           dt_ce_obj
);



--
-- COM_LABRESULTS_OBJ_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_LABRESVALUE_OBJ_V2 (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_RELTYPE_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_labresults_obj_v2 AS OBJECT (
   labresultid           dt_ii_obj
  ,moodcode              VARCHAR2 (100)
  ,labresultcode         dt_ce_obj
  ,sequelnumber			 number
  ,labresultvalue        hie_labresvalue_obj_v2
  ,efftime               timestamp
  ,labresultstatus       dt_ce_obj
  ,referencerange        VARCHAR2(100)
  ,interpretationcode    dt_ce_obj
  ,natureofabnormalcode  dt_ce_obj
  ,assocperformer        dt_ii_obj
  ,servicinglocation     dt_ii_obj
  ,annotation            dt_annotation_tab
  ,assocproviderorg      dt_ii_obj
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,replacedresultid      hie_reltype_obj
  ,reporteddate          timestamp
  ,relatedencounterid    dt_ii_obj
  ,response              hie_sectionresponse_obj
  ,producerid			 VARCHAR2(200)
  ,sectiontype           dt_ce_obj
);



--
-- COM_LABRESULTS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_LABRESULTS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_labresults_tab IS TABLE OF com_labresults_obj;



--
-- COM_LABRESULTS_TAB_V2  (Type) 
--
--  Dependencies: 
--   COM_LABRESULTS_OBJ_V2 (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_labresults_tab_v2 IS TABLE OF com_labresults_obj_v2;



--
-- COM_MEDICATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   COM_DOSAGE_OBJ (Type)
--   COM_DIAGNOSIS_TAB (Type)
--   HIE_MEDADMINTIMING_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.COM_MEDICATION_OBJ AS OBJECT (
   medicationid                            dt_ii_obj,
   classcode                               dt_ce_obj,
   moodcode                                VARCHAR2 (100),
   medservicedt                            dt_ivl_ts_obj,
   medstartdate                            TIMESTAMP,
   medenddate                                TIMESTAMP,
   medadmintiming                            hie_medadmintiming_obj,
   routecode                               dt_ce_obj,
   dosage                                  com_dosage_obj,
   productform                             dt_ce_obj,
   deliverymethod                          VARCHAR2 (100),
   medtypecode                             dt_ce_obj,
   meddrugname                             VARCHAR2 (100),
   meddrugcode                             dt_ce_obj,
   medstatus                               dt_ce_obj,
   assocperformer                          dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   servicinglocation                       dt_ii_obj,
   sectiontype                             dt_ce_obj,
   informant                               hie_informant_obj,
   recordtarget                            dt_ii_obj,
   negationind                             VARCHAR2 (5),
   docauthor                               hie_iiextn_obj,
   replacedmedid                           hie_reltype_obj,
   relatedencounterid                       dt_ii_obj,
   reporteddate                            DATE,
   annotation                              dt_annotation_tab,
   repeatnumber                               NUMBER,
   lotnumber                               VARCHAR2(50),
   approachsite                             dt_ce_obj,
   maxdosageqty                               NUMBER,
   pharmacyinstruction                       VARCHAR2(500),
   administrativeinstruction               VARCHAR2(500),
   odsencounterid                             NUMBER
    ,associateddiagnosis                  com_diagnosis_tab
); 



--
-- COM_MEDICATION_OBJ_V2  (Type) 
--
--  Dependencies: 
--   HIE_RELTYPE_OBJ (Type)
--   COM_DOSAGE_OBJ_V2 (Type)
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   DT_IVL_TS_OBJ (Type)
--   COM_DIAGNOSIS_TAB_V2 (Type)
--   DT_II_OBJ (Type)
--   HIE_MEDADMINTIMING_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_IIEXTN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_medication_obj_v2 AS OBJECT (
   medicationid                            dt_ii_obj,
   classcode                               dt_ce_obj,
   moodcode                                VARCHAR2 (100),
   medservicedt                            dt_ivl_ts_obj,
   medstartdate                            TIMESTAMP,
   medenddate                                TIMESTAMP,
   medadmintiming                            hie_medadmintiming_obj,
   routecode                               dt_ce_obj,
   dosage                                  com_dosage_obj_v2,
   productform                             dt_ce_obj,
   deliverymethod                          VARCHAR2 (100),
   medtypecode                             dt_ce_obj,
   meddrugname                             VARCHAR2 (100),
   meddrugcode                             dt_ce_obj,
   medstatus                               dt_ce_obj,
   assocperformer                          dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   servicinglocation                       dt_ii_obj,
   sectiontype                             dt_ce_obj,
   informant                               hie_informant_obj,
   recordtarget                            dt_ii_obj,
   negationind                             VARCHAR2 (5),
   docauthor                               hie_iiextn_obj,
   replacedmedid                           hie_reltype_obj,
   relatedencounterid                       dt_ii_obj,
   reporteddate                            DATE,
   annotation                              dt_annotation_tab,
   repeatnumber                               NUMBER,
   lotnumber                               VARCHAR2(50),
   approachsite                             dt_ce_obj,
   maxdosageqty                               NUMBER,
   pharmacyinstruction                       VARCHAR2(500),
   administrativeinstruction               VARCHAR2(500),
   odsencounterid                             NUMBER
    ,associateddiagnosis  				com_diagnosis_tab_v2
);



--
-- COM_MEDICATION_TAB  (Type) 
--
--  Dependencies: 
--   COM_MEDICATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.COM_MEDICATION_TAB IS TABLE OF com_medication_obj; 



--
-- COM_MEDICATION_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_MEDICATION_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_medication_tab_v2 IS TABLE OF com_medication_obj_v2;



--
-- COM_NEXTOFKIN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_nextofkin_obj IS OBJECT (
   firstname             VARCHAR2 (50)
  ,lastname              VARCHAR2 (40)
  ,contactrole           dt_ce_obj
  ,relationtypecd        dt_ce_obj -- VARCHAR2 (100)
  ,nokaddr               VARCHAR2 (500)
  ,nokphone              NUMBER
  ,nokstartdt            TIMESTAMP
  ,protectionindicator   VARCHAR2 (50)
);



--
-- COM_NEXTOFKIN_OBJ_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_nextofkin_obj_v2 IS OBJECT (
   firstname             VARCHAR2 (50)
  ,lastname              VARCHAR2 (40)
  ,contactrole           dt_ce_obj
  ,relationtypecd        dt_ce_obj -- VARCHAR2 (100)
  ,nokaddr               VARCHAR2 (500)
  ,nokphone              NUMBER
  ,nokstartdt            TIMESTAMP
  ,protectionindicator   VARCHAR2 (50)
);



--
-- COM_NEXTOFKIN_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_NEXTOFKIN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_nextofkin_tab IS TABLE OF com_nextofkin_obj;



--
-- COM_NEXTOFKIN_TAB_V2  (Type) 
--
--  Dependencies: 
--   COM_NEXTOFKIN_OBJ_V2 (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_nextofkin_tab_v2 IS TABLE OF com_nextofkin_obj_v2;



--
-- COM_NUMBER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_number_tab IS TABLE OF NUMBER; 



--
-- COM_OBSERVATION_DETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_observation_detail_obj IS OBJECT
(
id dt_ii_obj,
code dt_ce_obj,
valuecode dt_ce_obj
);



--
-- COM_OBSERVATION_DETAIL_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_OBSERVATION_DETAIL_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_observation_detail_tab IS TABLE OF com_observation_detail_obj;



--
-- COM_OBSERVATION_HEADER_OBJ  (Type) 
--
--  Dependencies: 
--   DT_ANNOTATION_TAB (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_observation_header_obj IS OBJECT
(
id dt_ii_obj,
moodcode VARCHAR2(50),
code dt_ce_obj,
status  dt_ce_obj,
author dt_ii_obj,
provider dt_ii_obj,
onbehalfby dt_ii_obj,
observationdate TIMESTAMP,
observationlocation dt_ii_obj,
annotation dt_annotation_tab
);



--
-- COM_OBSERVATION_HEADER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_OBSERVATION_HEADER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_observation_header_tab IS TABLE OF com_observation_header_obj;



--
-- COM_OBSERVATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_ANNOTATION_TAB (Type)
--   DT_II_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_CE_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_observation_obj AS OBJECT 
(
ID                                      dt_ii_obj,                                      
moodcode                                VARCHAR2 (100), 
classification                          VARCHAR2(12),
observationtypecode                     dt_ce_obj,                                    
status                                  dt_ce_obj,  
startdate                               timestamp,
enddate                                 timestamp,
assocperformer                          dt_ii_obj, -- hie_iiextn_obj,                               
assocproviderorg                        dt_ii_obj,                                    
servicinglocation                       dt_ii_obj,                                    
author                                  hie_iiextn_obj,                        
informant                               hie_informant_obj,                            
reporteddate                            DATE,                                         
annotation                              dt_annotation_tab,                            
relatedencounterid                      dt_ii_obj,                                    
replacedobservationid                   NUMBER ,                                       
sectiontype                             dt_ce_obj,
vendorsourcenm                          VARCHAR2(100),
-- detail columns
detailcode					            dt_ce_obj,
actionnegationind                       VARCHAR2 (1),
valuetype                               VARCHAR2(20),
valueuom                                dt_ce_obj,
valuelow                                NUMBER,
valuehigh                               NUMBER,
valuetext                               VARCHAR2(255),
valuecd                                 dt_ce_obj
) 



--
-- COM_OBSERVATION_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   HIE_IIEXTN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_observation_obj_v2 AS OBJECT
(
ID                                      dt_ii_obj,
moodcode                                VARCHAR2 (100),
classification                          VARCHAR2(12),
observationtypecode                     dt_ce_obj,
status                                  dt_ce_obj,
startdate                               VARCHAR2(20),
enddate                                 VARCHAR2(20),
assocperformer                          dt_ii_obj, -- hie_iiextn_obj,
assocproviderorg                        dt_ii_obj,
servicinglocation                       dt_ii_obj,
author                                  hie_iiextn_obj,
informant                               hie_informant_obj,
reporteddate                            DATE,
annotation                              dt_annotation_tab,
relatedencounterid                      dt_ii_obj,
replacedobservationid                   NUMBER ,
sectiontype                             dt_ce_obj,
vendorsourcenm                          VARCHAR2(100),
-- detail columns
detailcode					            dt_ce_obj,
actionnegationind                       VARCHAR2 (1),
valuetype                               VARCHAR2(20),
valueuom                                dt_ce_obj,
valuelow                                NUMBER,
valuehigh                               NUMBER,
valuetext                               VARCHAR2(255),
valuecd                                 dt_ce_obj
)



--
-- COM_OBSERVATION_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_OBSERVATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_observation_tab AS TABLE OF com_observation_obj 



--
-- COM_OBSERVATION_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_OBSERVATION_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_observation_tab_v2 AS TABLE OF com_observation_obj_v2



--
-- COM_ORDER_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_order_obj IS OBJECT (
   orderid               dt_ii_obj
  ,ordercode             dt_ce_obj
  ,placerorderid   		 VARCHAR2(100)
  ,fillerid      		 VARCHAR2(100)
  ,placergroupid         VARCHAR2(100)
  ,orderstatus           dt_ce_obj
  ,efftime               TIMESTAMP
  ,assocperformer        dt_ii_obj
  ,ordertype             VARCHAR2 (50)
  ,custodianorg			 VARCHAR2(64)
  ,confidentialitycode   dt_ce_obj
  ,annotation            dt_annotation_tab
  ,relatedencounterid    dt_ii_obj
  ,msgseqnbr			 NUMBER
);



--
-- COM_ORDER_OBJ_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_order_obj_v2 IS OBJECT (
   orderid               dt_ii_obj
  ,ordercode             dt_ce_obj
  ,placerorderid   		 VARCHAR2(100)
  ,fillerid      		 VARCHAR2(100)
  ,placergroupid         VARCHAR2(100)
  ,orderstatus           dt_ce_obj
  ,efftime               TIMESTAMP
  ,assocperformer        dt_ii_obj
  ,ordertype             VARCHAR2 (50)
  ,custodianorg			 VARCHAR2(64)
  ,confidentialitycode   dt_ce_obj
  ,annotation            dt_annotation_tab
  ,relatedencounterid    dt_ii_obj
  ,msgseqnbr			 NUMBER
);



--
-- COM_ORDER_TAB  (Type) 
--
--  Dependencies: 
--   COM_ORDER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_order_tab IS TABLE OF com_order_obj;



--
-- COM_ORDER_TAB_V2  (Type) 
--
--  Dependencies: 
--   COM_ORDER_OBJ_V2 (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_order_tab_v2 IS TABLE OF com_order_obj_v2;



--
-- COM_ORGANIZER_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   COM_SPECIMEN_OBJ (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_organizer_obj IS OBJECT (
   organizerid              dt_ii_obj
  ,classcode               VARCHAR2(50)
  ,moodcode                VARCHAR2 (100)
  ,labpanelcode            dt_ce_obj
  ,labpanelstatus          dt_ce_obj
  ,efftime                 TIMESTAMP
  ,diagnosticservicesection varchar2(20)
  ,reasoncode              varchar2(200)
  ,assocperformer          dt_ii_obj
  ,resultcopytoproviderid   dt_ii_obj
  ,servicinglocation       dt_ii_obj
  ,assocproviderorg        dt_ii_obj
  ,informant               hie_informant_obj
  ,docauthor               hie_iiextn_obj
  ,replacedresultid        hie_reltype_obj
  ,reporteddate            TIMESTAMP
  ,annotation              dt_annotation_tab
  ,relatedencounterid      dt_ii_obj
  ,response                hie_sectionresponse_obj
  ,specimen				   com_specimen_obj
);



--
-- COM_ORGANIZER_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_IIEXTN_OBJ (Type)
--   COM_SPECIMEN_OBJ_V2 (Type)
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_organizer_obj_v2 IS OBJECT (
   organizerid              dt_ii_obj
  ,classcode               VARCHAR2(50)
  ,moodcode                VARCHAR2 (100)
  ,labpanelcode            dt_ce_obj
  ,labpanelstatus          dt_ce_obj
  ,efftime                 TIMESTAMP
  ,diagnosticservicesection varchar2(20)
  ,reasoncode              varchar2(200)
  ,assocperformer          dt_ii_obj
  ,resultcopytoproviderid   dt_ii_obj
  ,servicinglocation       dt_ii_obj
  ,assocproviderorg        dt_ii_obj
  ,informant               hie_informant_obj
  ,docauthor               hie_iiextn_obj
  ,replacedresultid        hie_reltype_obj
  ,reporteddate            TIMESTAMP
  ,annotation              dt_annotation_tab
  ,relatedencounterid      dt_ii_obj
  ,response                hie_sectionresponse_obj
  ,specimen				   com_specimen_obj_v2
);



--
-- COM_ORGANIZER_TAB  (Type) 
--
--  Dependencies: 
--   COM_ORGANIZER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_organizer_tab IS TABLE OF com_organizer_obj;



--
-- COM_ORGANIZER_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_ORGANIZER_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_organizer_tab_v2 IS TABLE OF com_organizer_obj_v2;



--
-- COM_PATIENTIDS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.com_patientids_obj is object
(
member_type               varchar2(1),
memberid                  number,
member_root               varchar2 (64),
member_extn               varchar2 (200),
reference_type            varchar2(20)
)



--
-- COM_PATIENTIDS_TAB  (Type) 
--
--  Dependencies: 
--   COM_PATIENTIDS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.com_patientids_tab
is table of com_patientids_obj



--
-- COM_PATIENTLOCATION_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.COM_PATIENTLOCATION_OBJ AS OBJECT (
   pointofcareid         VARCHAR2 (50)
  ,room                  VARCHAR2 (20)
  ,bed                   VARCHAR2 (20)
  ,bedstatus             dt_ce_obj
  ,building                 VARCHAR2(100)
  ,locationfacilityid    VARCHAR2 (64)
  ,locationfacilityname  VARCHAR2(255)
  ,floor                 VARCHAR2 (50)
  ,locationtypecd        dt_ce_obj
); 



--
-- COM_PATIENTLOCATION_OBJ_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_patientlocation_obj_v2 AS OBJECT (
   pointofcareid         VARCHAR2 (50)
  ,room                  VARCHAR2 (20)
  ,bed                   VARCHAR2 (20)
  ,bedstatus        	 dt_ce_obj
  ,building			     VARCHAR2(50)
  ,locationfacilityid    VARCHAR2 (64)
  ,locationfacilityname  VARCHAR2(255)
  ,floor				 VARCHAR2 (50)
  ,locationtypecd        dt_ce_obj
);



--
-- COM_PATIENTMATCHRULES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.com_patientmatchrules_obj is object
(
masterpatientmatchrulesskey number,
accountid 					number,
feednm 						varchar2(20),
ruleseqnbr 					number,
lastnmflg 					varchar2(1),
calculatedlastnmflg 		varchar2(1),
firstnmflg 					varchar2(1),
calculatedfirstnmflg 		varchar2(1),
middleinitialflg 			varchar2(1),
ssnflg 						varchar2(1),
dtofbirthflg 				varchar2(1),
yearofbirthflg 				varchar2(1),
genderflg 					varchar2(1),
addressline1flg 			varchar2(1),
housenbrflg 				varchar2(1),
streetnmflg 				varchar2(1),
cityflg 					varchar2(1),
zipcdflg 					varchar2(1),
homephoneflg 				varchar2(1)
)



--
-- COM_PROCEDURES_TAB  (Type) 
--
--  Dependencies: 
--   COM_PROCEDURE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.COM_PROCEDURES_TAB IS TABLE OF com_procedure_obj; 



--
-- COM_PROCEDURES_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_PROCEDURE_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_procedures_tab_v2 IS TABLE OF com_procedure_obj_v2;



--
-- COM_PROCEDURE_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   COM_DIAGNOSIS_TAB (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.COM_PROCEDURE_OBJ IS OBJECT (
  procedureid            dt_ii_obj
  ,moodcode            VARCHAR2 (100)
  ,procedurecode         dt_ce_obj
  ,procedurestatus         dt_ce_obj
  ,procstarttime         TIMESTAMP
  ,procendtime             TIMESTAMP
  ,facilitytype          dt_ce_obj      -- Only for EDI (future)
  ,targetsite             dt_ce_obj
  ,proctype              dt_ce_obj
  ,drgtype               VARCHAR2(50)
  ,anesthesiologist      dt_ii_obj
  ,anesthesiacd          dt_ce_obj
  ,anesthesiaminutes     NUMBER
  ,surgeon               dt_ii_obj
  ,prioritycd            dt_ce_obj
  ,treatingprov          dt_ii_obj
  ,assocprovorg          dt_ii_obj
  ,servicinglocation     dt_ii_obj
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype          dt_ce_obj
  ,negationind           VARCHAR2 (5)
  ,units                VARCHAR2(20)
  ,quantity                NUMBER
  ,procedureamount        NUMBER
  ,procedureminutes     NUMBER
  ,consentcode          dt_ce_obj
  ,modifier1            VARCHAR2(255)
  ,modifier2            VARCHAR2(255)
  ,modifier3            VARCHAR2(255)
  ,modifier4            VARCHAR2(255)
  ,annotation            dt_annotation_tab
  ,approachsite          dt_ce_obj
  ,odsencounterid         NUMBER
  ,reporteddt            DATE
  ,assocperformer        dt_ii_obj
  ,associateddiagnosis  com_diagnosis_tab
); 



--
-- COM_PROCEDURE_OBJ_V2  (Type) 
--
--  Dependencies: 
--   DT_ANNOTATION_TAB (Type)
--   COM_DIAGNOSIS_TAB_V2 (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_procedure_obj_v2 IS OBJECT (
  procedureid            dt_ii_obj
  ,moodcode            VARCHAR2 (100)
  ,procedurecode         dt_ce_obj
  ,procedurestatus         dt_ce_obj
  ,procstarttime         TIMESTAMP
  ,procendtime             TIMESTAMP
  ,facilitytype          dt_ce_obj      -- Only for EDI (future)
  ,targetsite             dt_ce_obj
  ,proctype              dt_ce_obj
  ,drgtype               VARCHAR2(50)
  ,anesthesiologist      dt_ii_obj
  ,anesthesiacd          dt_ce_obj
  ,anesthesiaminutes     NUMBER
  ,surgeon               dt_ii_obj
  ,prioritycd            dt_ce_obj
  ,treatingprov          dt_ii_obj
  ,assocprovorg          dt_ii_obj
  ,servicinglocation     dt_ii_obj
  ,informant             hie_informant_obj
  ,docauthor             hie_iiextn_obj
  ,sectiontype          dt_ce_obj
  ,negationind           VARCHAR2 (5)
  ,units                VARCHAR2(20)
  ,quantity                NUMBER
  ,procedureamount        NUMBER
  ,procedureminutes     NUMBER
  ,consentcode          dt_ce_obj
  ,modifier1            VARCHAR2(255)
  ,modifier2            VARCHAR2(255)
  ,modifier3            VARCHAR2(255)
  ,modifier4            VARCHAR2(255)
  ,annotation            dt_annotation_tab
  ,approachsite          dt_ce_obj
  ,odsencounterid         NUMBER
  ,reporteddt            DATE
  ,assocperformer        dt_ii_obj
  ,associateddiagnosis  com_diagnosis_tab_v2
);



--
-- COM_PROVIDER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_provider_obj AS OBJECT (
   ID                                      dt_ii_obj,
   TYPE                                    VARCHAR2 (30)
   );



--
-- COM_PROVIDER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_PROVIDER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_provider_tab IS TABLE OF com_provider_obj;



--
-- COM_RELATIONSHIP_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_relationship_obj
IS OBJECT
(
   entryrelationshipid                     dt_ii_obj,
   typecode                                VARCHAR2 (100),
   sourceactid                             dt_ii_obj,
   sourceactclasscode                      VARCHAR2 (100),
   targetactid                             dt_ii_obj,
   targetactclasscode                      VARCHAR2 (100),
   action                                  VARCHAR2 (20),
   effectivestartdate                      DATE,
   effectiveenddate                        DATE,
   replacementid                           hie_iiextn_obj,
   response                                hie_sectionresponse_obj
);



--
-- COM_RELATIONSHIP_OBJ_V2  (Type) 
--
--  Dependencies: 
--   HIE_IIEXTN_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_relationship_obj_v2
IS OBJECT
(
   entryrelationshipid                     dt_ii_obj,
   typecode                                VARCHAR2 (100),
   sourceactid                             dt_ii_obj,
   sourceactclasscode                      VARCHAR2 (100),
   targetactid                             dt_ii_obj,
   targetactclasscode                      VARCHAR2 (100),
   action                                  VARCHAR2 (20),
   effectivestartdate                      DATE,
   effectiveenddate                        DATE,
   replacementid                           hie_iiextn_obj,
   response                                hie_sectionresponse_obj
);



--
-- COM_RELATIONSHIP_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_RELATIONSHIP_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_relationship_tab IS TABLE OF com_relationship_obj;



--
-- COM_RELATIONSHIP_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_RELATIONSHIP_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_relationship_tab_v2 IS TABLE OF com_relationship_obj_v2;



--
-- COM_SENDINGORG_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_sendingorg_obj IS OBJECT
(
 orgname VARCHAR2(255)
,orgoid  VARCHAR2(64)
,patientid VARCHAR2(100)
);



--
-- COM_SENDINGORG_TAB  (Type) 
--
--  Dependencies: 
--   COM_SENDINGORG_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_sendingorg_tab IS TABLE OF com_sendingorg_obj;



--
-- COM_SPECIMEN_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.com_specimen_obj
IS OBJECT
(
specimenid 			dt_ii_obj,
specimencd			dt_ce_obj,
specimenmodifier 	dt_ce_obj,
specimensource		dt_ce_obj,
specimendesc		VARCHAR2(400),
effectivetime		TIMESTAMP,
receivedtime		TIMESTAMP
);



--
-- COM_SPECIMEN_OBJ_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_specimen_obj_v2
IS OBJECT
(
specimenid 			dt_ii_obj,
specimencd			dt_ce_obj,
specimenmodifier 	dt_ce_obj,
specimensource		dt_ce_obj,
specimendesc		VARCHAR2(400),
effectivetime		TIMESTAMP,
receivedtime		TIMESTAMP
);



--
-- COM_VITALS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_VITAL_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_vitals_tab IS TABLE OF  com_vital_obj;



--
-- COM_VITALS_TAB_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   COM_VITAL_OBJ_V2 (Type)
--
CREATE OR REPLACE TYPE ODS.com_vitals_tab_v2 IS TABLE OF  com_vital_obj_v2;



--
-- COM_VITAL_OBJ  (Type) 
--
--  Dependencies: 
--   COM_ORGANIZER_TAB (Type)
--   DT_CE_OBJ (Type)
--   COM_LABRESULTS_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.com_vital_obj AS OBJECT
(
sectiontype     dt_ce_obj,
vitalorganizer	com_organizer_tab,
vitalobservations com_labresults_tab
);



--
-- COM_VITAL_OBJ_V2  (Type) 
--
--  Dependencies: 
--   COM_ORGANIZER_TAB_V2 (Type)
--   COM_LABRESULTS_TAB_V2 (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.com_vital_obj_v2 AS OBJECT
(
sectiontype     dt_ce_obj,
vitalorganizer	com_organizer_tab_v2,
vitalobservations com_labresults_tab_v2
);



--
-- CONSENTRULE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   RELCONDITION_TAB (Type)
--
CREATE OR REPLACE type ODS.consentrule_obj
 as object
(  ruleid                   varchar2(100),
   rulestatus               varchar2(100),
   ruleorderposition        number,
   relatedcondition         relcondition_tab
);



--
-- CONSENTRULE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CONSENTRULE_OBJ (Type)
--
CREATE OR REPLACE type ODS.consentrule_tab is table of  consentrule_obj;



--
-- CORLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CORLIST_OBJ IS OBJECT (
   CORTRACKINGID NUMBER,
   CORID NUMBER,
   CORTITLE VARCHAR2 (200),
   QMTITLE VARCHAR2 (500),
   CORDENOMINATORTXT VARCHAR2 (500),
   CORNUMERATORTXT VARCHAR2 (500),
   CONDITIONCLASSNM NUMBER,
   CONDITIONCLASSTITLE VARCHAR2 (200),
   CORBENCHVALUE NUMBER,
   CORSOURCE VARCHAR2 (50),
   ISPATIENTCOMPLIANT VARCHAR2 (1),
   LASTEVALUATIONDT DATE,
   PGFLG VARCHAR2 (1)
); 



--
-- CORLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CORLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CORLIST_TAB IS TABLE OF CORLIST_OBJ; 



--
-- CTLBACTHSUPPLIER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ctlbacthsupplier_obj IS OBJECT
(
suppliercontrolskey NUMBER,
supplierbatchskey NUMBER,
ahmsupplierid       NUMBER
)



--
-- CTLBACTHSUPPLIER_TAB  (Type) 
--
--  Dependencies: 
--   CTLBACTHSUPPLIER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ctlbacthsupplier_tab IS TABLE OF ctlbacthsupplier_obj;



--
-- CT_ADTDETAILS_OBJ  (Type) 
--
--  Dependencies: 
--   CT_ADTPROVIDER_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_adtdetails_obj IS OBJECT (odsencounterid number,
                                                    encountertype varchar2 (255),
                                                    facilityname varchar2 (255),
                                                    datasourcenm varchar2 (20),
                                                    principaldiagnosis varchar2 (50),
                                                    diagnosiscodesystem varchar2 (50),
                                                    admitdt date,
                                                    dischargedt date,
                                                    providerlist ct_adtprovider_tab);



--
-- CT_ADTDETAILS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_ADTDETAILS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_adtdetails_tab IS TABLE OF ct_adtdetails_obj;



--
-- CT_ADTDIAGDTLS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_adtdiagdtls_obj
AS
   OBJECT (diagnosiscode varchar2 (100),
           diagnosiscodesystem varchar2 (200),
           diagnosiscategory varchar2 (200),
           diagnosislevel varchar2 (50),
           shortname varchar2 (500),
           longname varchar2 (500),
           fullname varchar2 (2000),
           sensitiveflag varchar2 (1));



--
-- CT_ADTDIAGDTLS_TAB  (Type) 
--
--  Dependencies: 
--   CT_ADTDIAGDTLS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_adtdiagdtls_tab AS TABLE OF ct_adtdiagdtls_obj;



--
-- CT_ADTMOREDETAILS_OBJ  (Type) 
--
--  Dependencies: 
--   CT_ADTPROVIDER_TAB (Type)
--   CT_ADTDIAGDTLS_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_adtmoredetails_obj
AS
   OBJECT (datasourcenm varchar2 (20),
           odsencounterid number,
           encountertype varchar2 (255),
           facilityname varchar2 (255),
           ProviderDetailList ct_adtprovider_tab,
           DiagnosisDetailList ct_adtdiagdtls_tab,
           admitdt date,
           dischargedt date,
           vendorsourcenm varchar2(30)
           );



--
-- CT_ADTMOREDETAILS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_ADTMOREDETAILS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_adtmoredetails_tab IS TABLE OF ct_adtmoredetails_obj;



--
-- CT_ADTPROVIDER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_ADTPROVIDER_OBJ IS OBJECT (providerid number,
                                                     firstname varchar2 (50),
                                                     lastname varchar2 (50),
                                                     adtprovtype varchar2 (100),
                                                     fullnm varchar2 (200)) 



--
-- CT_ADTPROVIDER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_ADTPROVIDER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_ADTPROVIDER_TAB AS TABLE OF ct_adtprovider_obj 



--
-- CT_ALERTDETAILS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_alertdetails_obj
AS
   OBJECT (mhskey VARCHAR2 (100),
           alertid VARCHAR2 (50),
           alertstatus VARCHAR2 (30),
           severity VARCHAR2 (20),
           alertdesc VARCHAR2 (4000),
           alerttitle VARCHAR2 (255)) 



--
-- CT_ALERTDETAILS_TAB  (Type) 
--
--  Dependencies: 
--   CT_ALERTDETAILS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_alertdetails_tab IS TABLE OF ct_alertdetails_obj 



--
-- CT_ALERTLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_ALERTDETAILS_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_alertlist_obj
AS OBJECT (accountid        NUMBER
          ,memberplanid     NUMBER
		  ,alertdetaillist  ct_alertdetails_tab) 



--
-- CT_ALERTLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_ALERTLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_alertlist_tab IS TABLE OF ct_alertlist_obj 



--
-- CT_ALLERGYDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_CLAIMSCOMMENTS_TAB (Type)
--   STANDARD (Package)
--   CT_PATIENTREACTIONLIST_TAB (Type)
--
CREATE OR REPLACE type ODS.CT_ALLERGYDETAILLIST_OBJ is object
(
 MEMBERPLANID            NUMBER,
 CLIENTPATID             VARCHAR2 (50),
 PATIENTISSUINGORGID        VARCHAR2 (64),
 ODSINSTANCEID            NUMBER,
 ODSINSTANCEQUALIFIER        VARCHAR2 (50),
 STARTDATE            DATE,
 ENDDATE            DATE,
 REPORTEDDT            DATE,
 ALLERGYSTATUS            VARCHAR2 (255),
 SERVICINGORGID            VARCHAR2 (64),
 SERVICINGORGNAME        VARCHAR2 (255),
 POPROVIDERID            NUMBER,
 CPPROVIDERID            NUMBER,
 SOURCEPROVIDERID        VARCHAR2 (200),
 PROVIDERISSUINGORGID        VARCHAR2 (64),
 PROVIDERFNAME            VARCHAR2 (50),
 PROVIDERLNAME            VARCHAR2 (50),
 DATASOURCENM            VARCHAR2 (50),
 AUTHORID            NUMBER,
 AUTHOROID            VARCHAR2 (64),
 AUTHORTYPE            VARCHAR2 (1),
 INFORMANTID            NUMBER,
 INFORMANTOID            VARCHAR2 (64),
 INFORMANTTYPE            VARCHAR2 (1),
 COMMENTSTXT            CT_CLAIMSCOMMENTS_TAB, 
 PATIENTREACTION        CT_PATIENTREACTIONLIST_TAB, 
 INTOLERANCEFLG            VARCHAR2(1), 
 NEGATIONFLG            VARCHAR2(1), 
 VENDORSOURCENM            VARCHAR2 (30),
 ALLERGYSEVERITY        VARCHAR2(255)
) 



--
-- CT_ALLERGYDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_ALLERGYDETAILLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CT_ALLERGYDETAILLIST_TAB is table of CT_ALLERGYDETAILLIST_OBJ 



--
-- CT_ALLERGYLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_ALLERGYDETAILLIST_TAB (Type)
--
CREATE OR REPLACE type ODS.CT_ALLERGYLIST_OBJ is object
(
 ALLERGYCODE        VARCHAR2 (256),
 ALLERGYCODETYPE    VARCHAR2 (200),
 GCN            VARCHAR2 (20),
 GENERICNAME        VARCHAR2 (35),
 DRUGTRADENAME        VARCHAR2 (255),
 STRENGTHROUTE        VARCHAR2 (255),
 OTCINDICATOR        VARCHAR2 (20),
 SENSITIVEFLAG        VARCHAR2 (1),
 ALLERGYDETAILLIST    CT_ALLERGYDETAILLIST_TAB,
 ALLERGYTYPE        VARCHAR2(255),
 ALLERGEN        VARCHAR2(500),
 CODEVALIDATED        VARCHAR2(1)
) 



--
-- CT_ALLERGYLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_ALLERGYLIST_OBJ (Type)
--
CREATE OR REPLACE type ODS.CT_ALLERGYLIST_TAB is table of CT_ALLERGYLIST_OBJ 



--
-- CT_ALTID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_altid_obj IS OBJECT (instancememberplanid number,
                                               odstrackingid number,
                                               altidtype varchar2 (50),
                                               altidvalue varchar2 (50),
                                               idsource varchar2 (20),
                                               idstartdt date,
                                               idenddt date,
                                               updateddate date,
                                               winnerflag varchar2 (1));



--
-- CT_ALTID_TAB  (Type) 
--
--  Dependencies: 
--   CT_ALTID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_altid_tab IS TABLE OF ct_altid_obj;



--
-- CT_ASSOCIATEDORG_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_associatedorg_obj IS OBJECT
(
accountid NUMBER,
orgoid VARCHAR2(64),
effectivestartdate DATE,
effectiveenddate DATE,
primaryflag VARCHAR2(1)
);



--
-- CT_ASSOCIATEDORG_TAB  (Type) 
--
--  Dependencies: 
--   CT_ASSOCIATEDORG_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_associatedorg_tab IS TABLE OF ct_associatedorg_obj;



--
-- CT_ASSOCIATIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_associationlist_obj
AS
   OBJECT (memberplanid number,
           requestorid number,
           requestortype varchar2 (50),
           associationstatus varchar2 (50),
           pcpstatus varchar2 (1));



--
-- CT_ASSOCIATIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_ASSOCIATIONLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_associationlist_tab IS TABLE OF ct_associationlist_obj;



--
-- CT_ASSOCIATIONSETLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_associationsetlist_obj
AS
   OBJECT (memberplanid number,
           requestorid varchar2 (50),
           requestortype varchar2 (50),
           returncode number)



--
-- CT_ASSOCIATIONSETLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_ASSOCIATIONSETLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_associationsetlist_tab
IS
   TABLE OF ct_associationsetlist_obj



--
-- CT_BIOMETRICLABDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_CLAIMSCOMMENTSLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_BIOMETRICLABDETAILLIST_OBJ                      
AS                                                      
   OBJECT (MEMBERPLANID NUMBER,                         
           CLIENTPATID VARCHAR2 (50),                   
           PATIENTISSUINGORGID VARCHAR2 (64),           
           ODSINSTANCEID NUMBER,                        
           ODSINSTANCEQUALIFIER VARCHAR2 (50),          
           LABRESULT VARCHAR2 (200),                    
           LABUM VARCHAR2 (30),                         
           MAXVALUE NUMBER,                             
           MINVALUE NUMBER,                             
           SERVICEDATE DATE,                            
           REPORTEDDT DATE,                             
           SERVICINGORGID VARCHAR2 (64),                
           SERVICINGORGNAME VARCHAR2 (255),             
           POPROVIDERID NUMBER,                         
           CPPROVIDERID NUMBER,                         
           SOURCEPROVIDERID VARCHAR2 (200),             
           PROVIDERISSUINGORGID VARCHAR2 (64),          
           PROVIDERFNAME VARCHAR2 (50),                 
           PROVIDERLNAME VARCHAR2 (50),                 
           DATASOURCENM VARCHAR2 (20),                  
           AUTHORID NUMBER,                             
           AUTHOROID VARCHAR2 (64),                     
           AUTHORTYPE VARCHAR2 (1),                     
           INFORMANTID NUMBER,                          
           INFORMANTOID VARCHAR2 (64),                  
           INFORMANTTYPE VARCHAR2 (1),                  
           COMMENTSOURCELIST CT_CLAIMSCOMMENTSLIST_TAB, 
           VENDORSOURCENM VARCHAR2 (30),
		   STATUS                    VARCHAR2(24)-- Q3 Sprint3 added by VJ on 07102014*Status*
		   ) 



--
-- CT_BIOMETRICLABDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_BIOMETRICLABDETAILLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_BIOMETRICLABDETAILLIST_TAB IS TABLE OF CT_BIOMETRICLABDETAILLIST_OBJ 



--
-- CT_BIOMETRICLABLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_BIOMETRICLABDETAILLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.CT_BIOMETRICLABLIST_OBJ                                      
AS                                                                
   OBJECT (MEDICALCODE VARCHAR2 (20),                             
           MEDICALCODETYPE VARCHAR2 (200),-- Q3 SPRINT3 MODIFIED BY VJ ON 07102014*FROM 50 TO 200*                         
           RESULTTYPE VARCHAR2 (50),                              
           TARGET VARCHAR2 (50),                                  
           SHORTNAME VARCHAR2 (500),                              
           LONGNAME VARCHAR2 (500),                               
           FULLNAME VARCHAR2 (2000),                              
           SENSITIVEFLAG VARCHAR2 (1),                            
           BIOMETRICLABDETAILLIST CT_BIOMETRICLABDETAILLIST_TAB,
           CODEVALIDATED             VARCHAR2(1)-- Q3 Sprint3 added by VJ on 07102014*Code Validated*
           ) 



--
-- CT_BIOMETRICLABLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_BIOMETRICLABLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_BIOMETRICLABLIST_TAB
IS
   TABLE OF CT_BIOMETRICLABLIST_OBJ 



--
-- CT_CLAIMSCOMMENTSLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_claimscommentslist_obj
AS
   OBJECT (commentsource varchar2 (50));



--
-- CT_CLAIMSCOMMENTSLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_CLAIMSCOMMENTSLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_claimscommentslist_tab
IS
   TABLE OF ct_claimscommentslist_obj;



--
-- CT_CLAIMSCOMMENTS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."CT_CLAIMSCOMMENTS_OBJ" 
AS
   OBJECT (commenttxt varchar2 (4000),
		   authorid number,
           inserteddt date 
   ); 



--
-- CT_CLAIMSCOMMENTS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_CLAIMSCOMMENTS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."CT_CLAIMSCOMMENTS_TAB"                                          
IS
   TABLE OF ct_claimscomments_obj; 



--
-- CT_CLINICALNOTEITEMTXT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_clinicalnoteitemtxt_obj
IS
   OBJECT (noteitemtrackingid number, noteitemtxt NCLOB)



--
-- CT_CLINICALNOTEITEMTXT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_CLINICALNOTEITEMTXT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_clinicalnoteitemtxt_tab
IS
   TABLE OF ct_clinicalnoteitemtxt_obj



--
-- CT_CLINICALNOTEITEM_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_clinicalnoteitem_obj  IS OBJECT (
                                                     noteitemtrackingid number,
                                                     noteitemcreatedt date,
                                                     noteitemcreatorid number,
                                                     noteitemcreatortype varchar2 (1),
                                                     noteitemcreatorfn varchar2 (50),
                                                     noteitemcreatorln varchar2 (50),
                                                     noteitemstatusdate date,
                                                     notestatustype varchar2 (1),
                                                     noteitemtypecd varchar2 (30),
                                                     encounterskey number,
													 activeflag   varchar2(1)
                                                  -- modecode varchar2 (1)
                                                  )



--
-- CT_CLINICALNOTEITEM_TAB  (Type) 
--
--  Dependencies: 
--   CT_CLINICALNOTEITEM_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_clinicalnoteitem_tab
IS
   TABLE OF ct_clinicalnoteitem_obj



--
-- CT_COMPLIANCELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_compliancelist_obj
AS
   OBJECT (providerid number,
           compliancepercent number,
           totaldenominator number,
           totalnumerator number);



--
-- CT_COMPLIANCELIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_COMPLIANCELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_compliancelist_tab
AS
   TABLE OF ct_compliancelist_obj;



--
-- CT_DRMARKERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_SEVERITYLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_drmarkerlist_obj IS OBJECT (
   markerid       NUMBER,
   markertitle    VARCHAR2 (2000),
   membercount    NUMBER,
   severitylist   ct_severitylist_tab
);



--
-- CT_DRMARKERLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_DRMARKERLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_drmarkerlist_tab IS TABLE OF ct_drmarkerlist_obj;



--
-- CT_DRMEMBERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_drmemberlist_obj AS OBJECT (
   memberplanid          NUMBER,
   clientpatid           VARCHAR2 (50),
   patientissuingorgid   VARCHAR2 (64),
   fname                 VARCHAR2 (50),
   lname                 VARCHAR2 (50),
   dob                   DATE,
   gender                VARCHAR2 (1),
   qmcompliance          VARCHAR2 (1),
   mkseverity            VARCHAR2 (12)
);



--
-- CT_DRMEMBERLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_DRMEMBERLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_drmemberlist_tab IS TABLE OF ct_drmemberlist_obj;



--
-- CT_ENCOUNTERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_encounterlist_obj IS OBJECT (memberplanid number,
                                                           odsencounterid number,
                                                           clientpatid varchar2 (50),
                                                           patientissuingorgid varchar2 (64),
                                                           enccode varchar2 (100),
                                                           enccodesysname varchar2 (200),
                                                           enccodesysoid varchar2 (64),
                                                           statuscd varchar2 (24),
                                                           statussysname varchar2 (200),
                                                           statussysoid varchar2 (64),
                                                           sectiontypecd varchar2 (24),
                                                           moodcd varchar2 (30),
                                                           startdate date,
                                                           enddate date,
                                                           datasourcenm varchar2 (20),
                                                           authorid number,
                                                           authortype varchar2 (1),
                                                           authororgoid varchar2 (64),
                                                           informantid number,
                                                           informanttype varchar2 (1),
                                                           informantorgoid varchar2 (64),
                                                           vendorsourcenm varchar2 (30));



--
-- CT_ENCOUNTERLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_ENCOUNTERLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_encounterlist_tab IS TABLE OF ODS.ct_encounterlist_obj;



--
-- CT_EVIDENCELIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_MODIFIERS_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_EVIDENCELIST_OBJ
AS
   OBJECT (codetype varchar2 (20),
           code varchar2 (50),
           codesystem varchar2 (50),
           name varchar2 (2000),
           clinicaldatavalue varchar2 (50),
           clinicaldataunits varchar2 (50),
           servicedate date,
           sensitiveflag varchar2 (1),
           datasource varchar2 (20),
           informantid number,
           informantoid varchar2 (64),
           informanttype varchar2 (10),
           authorid number,
           authoroid varchar2 (64),
           authortype varchar2 (1),
           cptmodifiers ct_modifiers_tab,
           vendorsourcenm varchar2 (50));



--
-- CT_EVIDENCELIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_EVIDENCELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_EVIDENCELIST_TAB IS TABLE OF ct_evidencelist_obj;



--
-- CT_EXTENDERASSOC_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_extenderassoc_req_obj IS OBJECT (sourcetrackingid number,
                                                           requestorid number,
                                                           requestortype varchar2 (10),
                                                           associateduserid number,
                                                           associatedusertype varchar2 (10),
                                                           effectivestartdate date,
                                                           effectiveenddate date,
                                                           actionflag varchar2 (2));



--
-- CT_EXTENDERASSOC_REQ_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_EXTENDERASSOC_REQ_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_extenderassoc_req_tab IS TABLE OF ct_extenderassoc_req_obj;



--
-- CT_EXTENDERASSOC_RESP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_extenderassoc_resp_obj
IS
   OBJECT (sourcetrackingid number, returncode number);



--
-- CT_EXTENDERASSOC_RESP_TBL  (Type) 
--
--  Dependencies: 
--   CT_EXTENDERASSOC_RESP_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_extenderassoc_resp_tbl IS TABLE OF ct_extenderassoc_resp_obj;



--
-- CT_GETCOMMENTS_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_getcomments_req_obj is object
(
odssectioninstanceid number,
odssectionqualifier varchar2(30)
);



--
-- CT_GETCOMMENTS_REQ_TAB  (Type) 
--
--  Dependencies: 
--   CT_GETCOMMENTS_REQ_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_getcomments_req_tab is table of ct_getcomments_req_obj;



--
-- CT_GETCOMMENTS_RESP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_getcomments_resp_obj is object
(
odssectioninstanceid number,
odssectionqualifier varchar2(30),
odscommentid number,
systemsource varchar2(10),
reporteddate date,
givenbyuserid number,
givenbyusertype varchar2(10),
givenbyuserfirstname varchar2(50),
givenbyuserlastname varchar2(50),
givenbyuseroid	varchar2(64),
comments varchar2(4000),
returncode number
);



--
-- CT_GETCOMMENTS_RESP_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_GETCOMMENTS_RESP_OBJ (Type)
--
CREATE OR REPLACE type ODS.ct_getcomments_resp_tab is table of ct_getcomments_resp_obj;



--
-- CT_GETINCDCOMMENTLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CT_GETINCDCOMMENTLIST_OBJ
is object
(
ODSSectionQualifier                  varchar2(30),
ODSCommentID                         number,
SystemSource                         varchar2(10),
ReportedDate                         date,
Commentcd                            varchar2(24),
Commenttype                          varchar2(24),
Commenttext                          varchar2(4000)
)



--
-- CT_GETINCDCOMMENTLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_GETINCDCOMMENTLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CT_GETINCDCOMMENTLIST_TAB is table of CT_GETINCDCOMMENTLIST_OBJ



--
-- CT_GETINCIDENTLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_GETINCDCOMMENTLIST_TAB (Type)
--
CREATE OR REPLACE type ODS.CT_GETINCIDENTLIST_OBJ
is object
(
odsincidentid                     number,
memberplanid                      number,
requestorid                       number,
requestortype                     varchar2(1),
reportedbyid                      number,
reportedbytype                    varchar2(1),
incidenttype                      varchar2(20),
createdsource                     varchar2(20),
createddate                       date,
associationsource                 varchar2(20),
senttoclientdate                  date,
incidentstate                     varchar2(20),
incidentstatedate                 date,
incidentstatus                    varchar2(20),
incidentstatusdate                date,
suggestedproviderid               number,
suggestedprovidername             varchar2(200),
comments                          CT_GETINCDCOMMENTLIST_TAB,
providerfirstname		  varchar2(50),
providerlastname		  varchar2(40),
providerfullname		  varchar2(200)
)



--
-- CT_GETINCIDENTLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_GETINCIDENTLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CT_GETINCIDENTLIST_TAB is table of CT_GETINCIDENTLIST_OBJ



--
-- CT_GETMEMPOPFOCUS_RES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_TAGCOLLECTIONLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.ct_getmempopfocus_res_obj IS   OBJECT (memberplanid  NUMBER,
			                                      tagcolllist   ct_tagcollectionlist_tab
		                                          );



--
-- CT_GETMEMPOPFOCUS_RES_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_GETMEMPOPFOCUS_RES_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_getmempopfocus_res_tab IS TABLE OF ct_getmempopfocus_res_obj	;



--
-- CT_GETNOTEITEMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_getnoteitemlist_obj
AS
   OBJECT (noteitemtrackingid number,
           noteitem varchar2 (4000),
           nidraftcreateddt date,
           nicreatedt date,
           nicreatorid number,
           nicreatortype varchar2 (1),
           nicreatorfn varchar2 (50),
           nicreatorln varchar2 (50),
           nisystemsource varchar2 (20),
           nicategory varchar2 (20),
           nicategoryid number,
           nimode varchar2 (10));



--
-- CT_GETNOTEITEMLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_GETNOTEITEMLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_getnoteitemlist_tab
AS
   TABLE OF ct_getnoteitemlist_obj;



--
-- CT_GETNOTELIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_GETNOTEITEMLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_getnotelist_obj
AS
   OBJECT (notetrackingid number,
           note varchar2 (100),
           notectgcd varchar2 (24),
           notesubctgcd varchar2 (24),
           notesubctgdesc varchar2 (200),
           lastnidraftdt date,
           lastnidraftcreatorid number,
           lastnidraftcreatortyp char (1),
           lastnidraftcreatorfn varchar2 (50),
           lastnidraftcreatorln varchar2 (50),
           lastnidraftcreatorsyssrc varchar2 (20),
           lastnicreatordt date,
           lastnicreatorid number,
           lastnicreatortype varchar (1),
           lastnicreatorfn varchar2 (50),
           lastnicreatorln varchar2 (50),
           lastnicreatorsyssrc varchar2 (20),
           sensitivityflag varchar2 (1),
           noteitemlist ct_getnoteitemlist_tab);



--
-- CT_GETNOTELIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_GETNOTELIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_getnotelist_tab
IS
   TABLE OF ct_getnotelist_obj;



--
-- CT_GETPATIENTINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PATIENT_PHONE_TAB (Type)
--   CT_PATIENT_MEMBERSETTING_TAB (Type)
--   CT_PATIENT_EMAIL_TAB (Type)
--   CT_PATIENT_ADDRESS_TAB (Type)
--   CT_PATIENTDECEASED_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."CT_GETPATIENTINFO_OBJ" FORCE IS OBJECT (memberplanid number,
                                                        clientpatid varchar2 (50),
                                                        patissuingorgoid varchar2 (64),
                                                        supplierid number,
                                                        suppliername varchar2 (200),
                                                        gender varchar2 (10),
                                                        dateofbirth date,
                                                        firstname varchar2 (50),
                                                        lastname varchar2 (50),
                                                        ethnicity varchar2 (50),
                                                        effenddate date,
                                                        addresslist ct_patient_address_tab,
                                                        phonelist ct_patient_phone_tab,
                                                        emaillist ct_patient_email_tab,
                                                        membersettinglist ct_patient_membersetting_tab,
                                                        deathinfo ct_patientdeceased_tab,
                                                        datasourcenm varchar2 (20),
                                                        effectivestartdate date,
                                                        insuranceid varchar2 (50),
                                                        planid varchar2 (50),
                                                        cardid varchar2 (50),
														                           aetnaemplflg  varchar2(1)) --US57878



--
-- CT_GETPATIENTINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_GETPATIENTINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."CT_GETPATIENTINFO_TAB" IS TABLE OF ct_getpatientinfo_obj



--
-- CT_GETPATIENTSUMRYINFO_OBJ  (Type) 
--
--  Dependencies: 
--   CT_PATIENTDECEASED_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."CT_GETPATIENTSUMRYINFO_OBJ" FORCE IS OBJECT (memberplanid number,
                                                             firstname varchar2 (50),
                                                             lastname varchar2 (50),
                                                             dateofbirth date,
                                                             gender varchar2 (10),
                                                             zipcode varchar2 (10),
                                                             supplierid number,
                                                             datasourcenm varchar2 (20),
                                                             effenddate date,
                                                             deathinfo ct_patientdeceased_tab,
                                                             clientpatid varchar2 (50),
                                                             aetnaemplflg  varchar2(1))



--
-- CT_GETPATIENTSUMRYINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_GETPATIENTSUMRYINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."CT_GETPATIENTSUMRYINFO_TAB" IS TABLE OF ct_getpatientsumryinfo_obj



--
-- CT_GROUPCOACHINGLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_GROUPCOACHINGLIST_OBJ AS OBJECT ( 
MEMBERPROGRAMCOACHINGID	NUMBER,
EVENTID	VARCHAR2(50),
EVENTCOLLECTIONID	VARCHAR2(50),
EVENTSCHEDULEDSTARTDATE	DATE,
EVENTACTUALSTARTDATE	DATE,
EVENTSCHEDULEDDURATION	NUMBER,
EVENTACTUALENDDATE	DATE,
EVENTTITLE	VARCHAR2(100),
EVENTTYPE	VARCHAR2(30),
EVENTATTENDFLAG	CHAR(1),
EVENTRESERVEDDATE	DATE,
UPDATEDDT TIMESTAMP(6),
PRODUCTCODE	VARCHAR2(30),
EXCLUSIONCD	CHAR(2)
); 



--
-- CT_GROUPCOACHINGLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_GROUPCOACHINGLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_GROUPCOACHINGLIST_TAB AS TABLE OF CT_GROUPCOACHINGLIST_OBJ; 



--
-- CT_IMMUNIZATIONDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_MODIFIERS_TAB (Type)
--   CT_CLAIMSCOMMENTSLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.ct_immunizationdetaillist_obj
AS
   OBJECT (memberplanid number,
           clientpatid varchar2 (50),
           patientissuingorgid varchar2 (64),
           odsinstanceid number,
           odsinstancequalifier varchar2 (50),
           startdate date,
           enddate date,
           reporteddate date,
           moodcd varchar2 (24),
           servicingorgid varchar2 (64),
           servicingorgname varchar2 (255),
           poproviderid number,
           cpproviderid number,
           sourceproviderid varchar2 (50),
           providerissuingorgid varchar2 (64),
           providerfname varchar2 (50),
           providerlname varchar2 (50),
           datasourcenm varchar2 (50),
           authorid number,
           authoroid varchar2 (64),
           authortype varchar2 (1),
           informantid number,
           informantoid varchar2 (64),
           informanttype varchar2 (1),
           commentsourcelist ct_claimscommentslist_tab,
           cptmodifiers ct_modifiers_tab,
           vendorsourcenm varchar2 (30),
           negationflag varchar2(1)) 



--
-- CT_IMMUNIZATIONDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_IMMUNIZATIONDETAILLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_immunizationdetaillist_tab IS TABLE OF ct_immunizationdetaillist_obj 



--
-- CT_IMMUNIZATIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_IMMUNIZATIONDETAILLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_immunizationlist_obj
AS
   OBJECT (medicalcode varchar2 (100),
           medicalcodetype varchar2 (200),
           shortdesc varchar2 (500),
           longdesc varchar2 (2000),
           fulldesc varchar2 (2000),
           sensitiveflag varchar2 (1),
           immunizationdetaillist ct_immunizationdetaillist_tab,
           codevalidated varchar2(1)) 



--
-- CT_IMMUNIZATIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_IMMUNIZATIONLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_immunizationlist_tab IS TABLE OF ct_immunizationlist_obj 



--
-- CT_INCIDENTMEMBER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_INCIDENTMEMBER_OBJ
IS
OBJECT (incidentid number, 
        memberid   number) 



--
-- CT_INCIDENTMEMBER_TAB  (Type) 
--
--  Dependencies: 
--   CT_INCIDENTMEMBER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CT_INCIDENTMEMBER_TAB is table of CT_INCIDENTMEMBER_OBJ 



--
-- CT_INCIDENTREQLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_INCIDENTREQLIST_OBJ
AS
   OBJECT (SOURCETRACKINGID          NUMBER,
           ODSINCIDENTID             NUMBER,
           MEMBERPLANID              NUMBER,
           USERID                    NUMBER,
           USERTYPE                  CHAR(1),
           INCIDENTTYPE              VARCHAR2(20),
           SUGGESTEDPROVIDERID       NUMBER,
           SUGGESTEDPROVIDERTYPE     CHAR(1),
           SUGGESTEDPROVIDERNM       VARCHAR2(200),
           COMMENTCD                 VARCHAR2(24),
           COMMENTDESC               VARCHAR2(4000),
           INCIDENTSTATE             VARCHAR2(20),
           INCIDENTSTATUS            VARCHAR2(20),
           COMMENTTYPE		     VARCHAR2(24) -- Q2 Sprint 2
          )



--
-- CT_INCIDENTREQLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_INCIDENTREQLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_INCIDENTREQLIST_TAB IS TABLE OF CT_INCIDENTREQLIST_OBJ



--
-- CT_INCIDENTRESLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_INCIDENTRESLIST_OBJ
AS
   OBJECT (SOURCETRACKINGID          NUMBER,
           ODSINCIDENTID             NUMBER,
           RETURNCODE                NUMBER
           ) 



--
-- CT_INCIDENTRESLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_INCIDENTRESLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_INCIDENTRESLIST_TAB IS TABLE OF CT_INCIDENTRESLIST_OBJ 



--
-- CT_MBRALTID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_ALTID_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.ct_mbraltid_obj IS OBJECT (memberplanid number, altidlist ct_altid_tab);



--
-- CT_MBRALTID_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_MBRALTID_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_mbraltid_tab IS TABLE OF ct_mbraltid_obj;



--
-- CT_MEDICATIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_MEDICATIONSDETAILLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.CT_MEDICATIONLIST_OBJ FORCE
AS  OBJECT (medicationcode varchar2 (100),
           medicationcodetype varchar2 (200),
           gcn varchar2 (50),
           genericname varchar2 (250),
           drugtradename varchar2 (2000),
           strengthroute varchar2 (255),
           otcindicator varchar2 (1),
           sensitiveflag varchar2 (1),
           medicationdetaillist ct_medicationsdetaillist_tab,
		   CodeValidated VARCHAR2(1)) 



--
-- CT_MEDICATIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_MEDICATIONLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_MEDICATIONLIST_TAB IS TABLE OF ct_medicationlist_obj; 



--
-- CT_MEDICATIONSDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_CLAIMSCOMMENTSLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.CT_MEDICATIONSDETAILLIST_OBJ  FORCE AS OBJECT
          (MEMBERPLANID             NUMBER,
           CLIENTPATID                 VARCHAR2(50),
           PATIENTISSUINGORGID         VARCHAR2(64),
           ODSINSTANCEID             NUMBER,
           ODSINSTANCEQUALIFIER     VARCHAR2(50),
           DOSAGEQTY                 VARCHAR2(50),
           DOSAGEUM                 VARCHAR2(50),
           DURATION                 NUMBER,
           DURATIONUM                 VARCHAR2(50),
           FREQUENCYNBR             NUMBER,
           FREQUENCYUM                 VARCHAR2(24),
           STARTDATE                 DATE,
           ENDDATE                     DATE,
           REPORTEDDATE             DATE,
           MOODCD                     VARCHAR2(24),
           SERVICINGORGID             VARCHAR2(64),
           SERVICINGORGNAME         VARCHAR2(255),
           POPROVIDERID             NUMBER,
           CPPROVIDERID             NUMBER,
           SOURCEPROVIDERID         VARCHAR2(200),
           PROVIDERISSUINGORGID     VARCHAR2(64),
           PROVIDERFNAME             VARCHAR2(50),
           PROVIDERLNAME             VARCHAR2(50),
           DATASOURCENM             VARCHAR2(50),
           AUTHORID                 NUMBER,
           AUTHOROID                 VARCHAR2(64),
           AUTHORTYPE                 VARCHAR2(1),
           INFORMANTID                 NUMBER,
           INFORMANTOID             VARCHAR2(64),
           INFORMANTTYPE             VARCHAR2(1),
           COMMENTSOURCELIST         CT_CLAIMSCOMMENTSLIST_TAB,
           VENDORSOURCENM             VARCHAR2 (30),
           ROUTEXCD                    VARCHAR2(24),
           ADDITIONALINFO            VARCHAR2(255),
           MEDICATIONQTY            NUMBER,
           MEDICATIONQUANTITYUOMCD  VARCHAR2(24),
           COMPLEXDOSAGEFLG            VARCHAR2(1) ,   -- Added for User Story 2.04 Complex Dosing.
           StatusCd                  VARCHAR2(50),
           StatusDesc                VARCHAR2(200),
           NUMBEROFDAYSSUPPLIED         NUMBER
           ) 



--
-- CT_MEDICATIONSDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_MEDICATIONSDETAILLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_MEDICATIONSDETAILLIST_TAB IS TABLE OF ct_medicationsdetaillist_obj; 



--
-- CT_MEFEEDBACKLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_mefeedbacklist_obj
AS
   OBJECT (fdbtrackingid number,
           fdbdate date,
           fdbstatusid varchar2 (24),
           fdbstatusreasonid number,
           fdbcomments varchar2 (4000),
           fdbdatasource varchar2 (30),
           byuserid number,
           byproviderid number,
           byrole varchar2 (20),
           byfname varchar2 (50),
           bylname varchar2 (50),
           foruserid number,
           forproviderid number,
           forrole varchar2 (20),
           forfname varchar2 (50),
           forlname varchar2 (50));



--
-- CT_MEFEEDBACKLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_MEFEEDBACKLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_mefeedbacklist_tab
IS
   TABLE OF ct_mefeedbacklist_obj;



--
-- CT_MEMBERCERUNLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_membercerunlist_obj
IS
   OBJECT (memberplanid number, cerunactionid number);



--
-- CT_MEMBERCERUNLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_MEMBERCERUNLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_membercerunlist_tab
IS
   TABLE OF ct_membercerunlist_obj



--
-- CT_MEMBERPLANIDLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_memberplanidlist_obj
IS
   OBJECT (memberplanid number);



--
-- CT_MEMBERPLANIDLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_MEMBERPLANIDLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_memberplanidlist_tab
IS
   TABLE OF ct_memberplanidlist_obj;



--
-- CT_MEMBERPROVIDER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_MEMBERPROVIDER_OBJ
IS
OBJECT (memberplanid number, 
        providerid   number) 



--
-- CT_MEMBERPROVIDER_TAB  (Type) 
--
--  Dependencies: 
--   CT_MEMBERPROVIDER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_MEMBERPROVIDER_TAB AS TABLE OF CT_MEMBERPROVIDER_OBJ 



--
-- CT_MEMBERPROVLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PROVIDERLIST_TAB (Type)
--
CREATE OR REPLACE type ODS.CT_MEMBERPROVLIST_OBJ is object
(
MEMBERPLANID                              NUMBER,
PROVIDERLIST                                   CT_PROVIDERLIST_TAB
)



--
-- CT_MEMBERPROVLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_MEMBERPROVLIST_OBJ (Type)
--
CREATE OR REPLACE type ODS.CT_MEMBERPROVLIST_TAB is table of CT_MEMBERPROVLIST_OBJ



--
-- CT_MEMPLANID_PL_OBJ  (Type) 
--
--  Dependencies: 
--   CT_PARTICIPATION_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_MEMPLANID_PL_OBJ IS OBJECT (memberplanid number, participationstatuslist CT_PARTICIPATION_TAB)



--
-- CT_MEMPLANID_PL_TAB  (Type) 
--
--  Dependencies: 
--   CT_MEMPLANID_PL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_MEMPLANID_PL_TAB IS TABLE OF CT_MEMPLANID_PL_OBJ



--
-- CT_MEMPOPFOCUSINFO_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_mempopfocusinfo_req_obj IS   OBJECT (sourcetrackingid NUMBER,
                                                    odspopfocusid    NUMBER,
			                                        activeflag       VARCHAR2 (1)
		                                            )



--
-- CT_MEMPOPFOCUSINFO_REQ_TAB  (Type) 
--
--  Dependencies: 
--   CT_MEMPOPFOCUSINFO_REQ_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_mempopfocusinfo_req_tab IS TABLE OF ct_mempopfocusinfo_req_obj



--
-- CT_MEMPOPFOCUSINFO_RES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_mempopfocusinfo_res_obj IS OBJECT (sourcetrackingid number,
                                                  ReturnCode number)



--
-- CT_MEMPOPFOCUSINFO_RES_TAB  (Type) 
--
--  Dependencies: 
--   CT_MEMPOPFOCUSINFO_RES_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_mempopfocusinfo_res_tab IS TABLE OF ct_mempopfocusinfo_res_obj



--
-- CT_MEMXREFTYPECDLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_memxreftypecdlist_obj AS
   OBJECT (memberxreftypecd VARCHAR2(20)) 



--
-- CT_MEMXREFTYPECDLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_MEMXREFTYPECDLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_memxreftypecdlist_tab IS TABLE OF ct_memxreftypecdlist_obj 



--
-- CT_ME_PRV_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_me_prv_obj
AS
   OBJECT (accountid number,
           facilityoid varchar2 (50),
           cpproviderid number,
           providertype varchar2 (10),
           assignedid number,
           providerissuingorgid varchar2 (64),
           externalsourcecareproviderid varchar2 (64),
           cpfname varchar2 (50),
           cplname varchar2 (50),
           melist ct_me_tab);



--
-- CT_ME_PRV_TAB  (Type) 
--
--  Dependencies: 
--   CT_ME_PRV_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_me_prv_tab IS TABLE OF ct_me_prv_obj;



--
-- CT_MODIFIERS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_modifiers_obj IS OBJECT (modifier varchar2 (10), modifierdesc varchar2 (600));



--
-- CT_MODIFIERS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_MODIFIERS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_modifiers_tab IS TABLE OF ct_modifiers_obj;



--
-- CT_NOTEPKGLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_CLINICALNOTEITEM_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.CT_NOTEPKGLIST_OBJ FORCE IS OBJECT (
                                                    notepkgtrackingid number,
                                                    notepkgtitle varchar2 (255),
                                                    notepkgctgmnemonic varchar2 (50),
                                                    notepkgtype varchar2 (50),
                                                    notepkgtypedesc varchar2 (255),
                                                    sensitiveflag varchar2 (1),
                                                    noteitemlist ct_clinicalnoteitem_tab,
                                                    InfoSourceCd varchar2 (50),
                                                    InfoSourceDesc varchar2 (255),
													activeflag   varchar2(1)
                                                 )



--
-- CT_NOTEPKGLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_NOTEPKGLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_NOTEPKGLIST_TAB IS TABLE OF CT_NOTEPKGLIST_OBJ; 



--
-- CT_OBSACTRELATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_obsactrelation_obj IS OBJECT (ODSInstanceID number,
                                                        SourceActODSTableQulalifier varchar2 (50),
                                                        SourceODSInstanceID number,
                                                        TargetActODSTableQulalifier varchar2 (50),
                                                        TargetODSInstanceID number,
                                                        RelationshipTypeCode varchar2 (50),
                                                        EffectiveStartDate Date,
                                                        EffectiveEndDate Date);



--
-- CT_OBSACTRELATION_TAB  (Type) 
--
--  Dependencies: 
--   CT_OBSACTRELATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_obsactrelation_tab IS TABLE OF ct_obsactrelation_obj;



--
-- CT_OBSERVATIONDETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_OBSERVATIONDETAIL_OBJ IS OBJECT (ODSInstanceID number,
                                                           ObsDetailCode varchar2 (100),
                                                           ObsDetailCodeSystemName varchar2 (200),
                                                           ObsDetailCodeSystemOID varchar2 (64),
                                                           ValueTypeCode varchar2 (24),
                                                           ValueCode varchar2 (100),
                                                           ValueCodeSystemName varchar2 (200),
                                                           ValueCodeSystemOID varchar2 (64),
                                                           ValueLow number,
                                                           ValueHigh number,
                                                           ValueFrequency number,
                                                           UOMCode varchar2 (24),
                                                           UOMCodeSystemName varchar2 (200),
                                                           UOMCodeSystemOID varchar2 (64),
                                                           ValueLowDate Date,
                                                           ValueHighDate Date,
                                                           ValueNonNumericText varchar2 (255),
                                                           startdate date,
                                                           enddate date,
                                                           status varchar2 (10),
							   ValueDesc varchar2 (2000), --Newly added for 2015-Q1-S3
							   CodeValidated varchar2 (1), --Newly added for 2015-Q1-S3
							   ObsCodeDesc varchar2 (200) -- added for US53015
							   )



--
-- CT_OBSERVATIONDETAIL_TAB  (Type) 
--
--  Dependencies: 
--   CT_OBSERVATIONDETAIL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_OBSERVATIONDETAIL_TAB IS TABLE OF CT_OBSERVATIONDETAIL_OBJ



--
-- CT_OBSERVATION_OBJ  (Type) 
--
--  Dependencies: 
--   CT_CLAIMSCOMMENTSLIST_TAB (Type)
--   STANDARD (Package)
--   CT_OBSERVATIONDETAIL_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.CT_OBSERVATION_OBJ IS OBJECT (ODSInstanceID number,
                                                     ODSEncounterID number,
                                                     MemberPlanID number,
                                                     ClientPatID varchar2 (50),
                                                     PatientIssuingOrgID varchar2 (64),
                                                     SectionTypeCode varchar2 (24),
                                                     classification varchar2 (64),
                                                     ObsCode varchar2 (100),
                                                     ObsCodeSystemName varchar2 (200),
                                                     ObsCodeSystemOID varchar2 (64),
                                                     ReportedDate Date,
                                                     CareProviderID number,
                                                     InformantID number,
                                                     InformantOID varchar2 (64),
                                                     InformantType varchar2 (1),
                                                     AuthorID number,
                                                     AuthorOID varchar2 (64),
                                                     AuthorType varchar2 (1),
                                                     DataSource varchar2 (20),
                                                     startdate date,
                                                     enddate date,
                                                     status varchar2 (10),
                                                     observationdetaillst ct_observationdetail_tab,
                                                     vendorsourcenm varchar2(30),
						     -- ObsCodeDesc varchar2 (200), --Newly added for 2015-Q1-S3 -- Commented for US53015
                                                     commentsourcelist ct_claimscommentslist_tab, --Newly added for 2015-Q1-S3
													 startdateformat varchar2(20), -- added for US53085
													 enddateformat	varchar2(20) -- added for US53085
                                                     )



--
-- CT_OBSERVATION_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_OBSERVATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_OBSERVATION_TAB IS TABLE OF CT_OBSERVATION_OBJ;



--
-- CT_ODSFOCUSIDLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_odsfocusidList_obj IS  OBJECT (odspopfocusid NUMBER)



--
-- CT_ODSFOCUSIDLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_ODSFOCUSIDLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_odsfocusidList_tab IS TABLE OF CT_odsfocusidList_obj



--
-- CT_OP_ADDRESS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_op_address_obj
AS
   OBJECT (sourcetrackingid number,
           odstrackingid number,
           returncode number,
           errormessage varchar2 (4000));



--
-- CT_OP_ADDRESS_TAB  (Type) 
--
--  Dependencies: 
--   CT_OP_ADDRESS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_op_address_tab IS TABLE OF ct_op_address_obj;



--
-- CT_OP_EMAIL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_op_email_obj
AS
   OBJECT (sourcetrackingid number,
           odstrackingid number,
           returncode number,
           errormessage varchar2 (4000));



--
-- CT_OP_EMAIL_TAB  (Type) 
--
--  Dependencies: 
--   CT_OP_EMAIL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_op_email_tab IS TABLE OF ct_op_email_obj;



--
-- CT_OP_INSURANCE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_op_insurance_obj
IS
   OBJECT (SourceTrackingID number, ODSTrackingID number, ReturnCode number, ReturnMessage varchar2 (4000));



--
-- CT_OP_INSURANCE_TAB  (Type) 
--
--  Dependencies: 
--   CT_OP_INSURANCE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_op_insurance_tab IS TABLE OF ct_op_insurance_obj;



--
-- CT_OP_MEMBERSETTING_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_op_membersetting_obj
IS
   OBJECT (SourceTrackingID number, ReturnCode number, ReturnMessage varchar2 (4000));



--
-- CT_OP_MEMBERSETTING_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_OP_MEMBERSETTING_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_op_membersetting_tab IS TABLE OF ct_op_membersetting_obj;



--
-- CT_OP_PHONE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_op_phone_obj
AS
   OBJECT (sourcetrackingid number,
           odstrackingid number,
           returncode number,
           errormessage varchar2 (4000));



--
-- CT_OP_PHONE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_OP_PHONE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_op_phone_tab IS TABLE OF ct_op_phone_obj;



--
-- CT_ORGANIZATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_organization_obj
AS
   OBJECT (servicingoid varchar2 (50), organizationname varchar2 (200));



--
-- CT_ORGANIZATION_TAB  (Type) 
--
--  Dependencies: 
--   CT_ORGANIZATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_organization_tab IS TABLE OF ct_organization_obj;



--
-- CT_ORGLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_PATIENT_PHONE_TAB (Type)
--   STANDARD (Package)
--   CT_PATIENT_ADDRESS_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.ct_orglist_obj
IS OBJECT
(
accountid NUMBER,
accountname VARCHAR2(200),
orgid NUMBER,
orgname VARCHAR2(200),
orgoid VARCHAR2(64),
orgtype	VARCHAR2(5),
orgtypemnemonic VARCHAR2(50),
orgtypedesc VARCHAR2(200),
orgnpi	VARCHAR2(10),
orgtaxid	VARCHAR2(10),
parentorgid NUMBER,
parentorgname VARCHAR2(200),
parentorgoid VARCHAR2(64),
contactfirstname VARCHAR2(50),
contactlastname VARCHAR2(40),
contactmiddlename VARCHAR2(25),
addresslist ct_patient_address_tab,
phonelist ct_patient_phone_tab,
updateddt DATE,
systemsource VARCHAR2(30),
returncode NUMBER,
effectiveenddt DATE
);



--
-- CT_ORGLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_ORGLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_orglist_tab IS TABLE OF ct_orglist_obj;



--
-- CT_ORGOIDLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_orgoidlist_obj
is object
(
orgoid   varchar2(64)
)



--
-- CT_ORGOIDLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_ORGOIDLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_orgoidlist_tab is table of ct_orgoidlist_obj



--
-- CT_PARTICIPATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_PARTICIPATION_OBJ IS OBJECT (
   cmsid				NUMBER,
   CmsTypeCd			VARCHAR2 (12 Byte),
   CmsTypeDesc			VARCHAR2 (255 Byte),
   CmsStatusCd			VARCHAR2 (12 Byte),
   CmsStatusDesc		VARCHAR2 (255 Byte),
   CMSSource			VARCHAR2 (20 Byte),
   VendorSourceNm		VARCHAR2 (20 Byte),
   StatusChangeDate		DATE,
   CaseStartDate		DATE,
   CaseEndDate			DATE,
   AAUserID				VARCHAR2 (20 Byte),
   AAUserName			VARCHAR2 (150 Byte),
   AAMainPhone			VARCHAR2 (15 Byte),
   AAPhone				VARCHAR2 (15 Byte),
   AAPhoneExt			VARCHAR2 (10 Byte)
   )



--
-- CT_PARTICIPATION_TAB  (Type) 
--
--  Dependencies: 
--   CT_PARTICIPATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_PARTICIPATION_TAB IS TABLE OF CT_PARTICIPATION_OBJ



--
-- CT_PATIENTDECEASEDINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patientdeceasedinfo_obj
IS OBJECT
(deceaseddt date,
 deceasedflag varchar2 (1),
 location varchar2 (255),
 authorid number,
 systemsource varchar2 (20),
 insertdate timestamp (6)
)



--
-- CT_PATIENTDECEASEDINFO_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENTDECEASEDINFO_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_patientdeceasedinfo_tab is table of ct_patientdeceasedinfo_obj



--
-- CT_PATIENTDECEASED_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patientdeceased_obj IS OBJECT (deceaseddt date,
                                                         deceasedflag varchar2 (1),
                                                         systemsource varchar2 (20),
                                                         updateddate timestamp (6),
                                                         deceasedloc varchar2 (255),
                                                         insertdate timestamp (6),
                                                         authorid number);



--
-- CT_PATIENTDECEASED_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENTDECEASED_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patientdeceased_tab IS TABLE OF ct_patientdeceased_obj;



--
-- CT_PATIENTINFOLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_PATIENTDECEASEDINFO_TAB (Type)
--   STANDARD (Package)
--   CT_POPULATIONFOCUSTAG_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."CT_PATIENTINFOLIST_OBJ" FORCE is object
(
FIRSTNAME                  VARCHAR2 (50),
LASTNAME                    VARCHAR2 (50),
DOB                        DATE,
GENDER                     VARCHAR2 (2),
CITY                       VARCHAR2 (50),
MEMBERPLANID               NUMBER,
ASSOCIATIONSTATE           VARCHAR2 (50),
ASSOCIATIONSOURCE          VARCHAR2 (20),
AHMSUPPLIERID              NUMBER,
AHMSUPPLIERNAME            VARCHAR2 (200),
PCPINDICATOR               VARCHAR2(1),
ASSIGNEDPROVIDERID         NUMBER,
PROVIDERFIRSTNAME          VARCHAR2(50),
PROVIDERLASTNAME           VARCHAR2(50),
EFFECTIVEENDDT             DATE,
DEATHINFO                  CT_PATIENTDECEASEDINFO_TAB,
TAGCOLLECTIONLIST          CT_POPULATIONFOCUSTAG_TAB,
INSURANCEID 			         VARCHAR2 (50),
PLANID 			               VARCHAR2 (50),
AETNAEMPLFLG               VARCHAR2 (1) --US57878
)



--
-- CT_PATIENTINFOLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENTINFOLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CT_PATIENTINFOLIST_TAB is table of CT_PATIENTINFOLIST_OBJ



--
-- CT_PATIENTLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_PCPLIST_TAB (Type)
--   CT_PATIENTDECEASED_TAB (Type)
--   CT_ALTID_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."CT_PATIENTLIST_OBJ" FORCE
AS
   OBJECT (firstname varchar2 (50),
           lastname varchar2 (50),
           dob date,
           gender varchar2 (1),
           city varchar2 (50),
           memberplanid number,
           associationstate varchar2 (50),
           associationflag varchar2 (1),
           associationsource varchar2 (30),
           pcplist ct_pcplist_tab,
           effenddt date,
           datasourcenm varchar2 (20),
           deathinfo ct_patientdeceased_tab,
           altidlist ods.ct_altid_tab,
		   supplierid number,
		   aetnaemplflg  varchar2(1))



--
-- CT_PATIENTLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENTLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patientlist_tab AS TABLE OF ct_patientlist_obj



--
-- CT_PATIENTPROVLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_PCPLIST_TAB (Type)
--   CT_PATIENTDECEASED_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_PATIENTPROVLIST_OBJ
AS
   OBJECT (firstname varchar2 (50),
           lastname varchar2 (50),
           dob date,
           gender varchar2 (1),
           city varchar2 (50),
           empiid number,
           associationstate varchar2 (50),
           associationsource varchar2 (20),
           supplierid number,
           suppliername varchar2 (200),
           pcpindicatorlist ct_pcplist_tab,
           effectiveenddt date,
           deathinfo ct_patientdeceased_tab); 



--
-- CT_PATIENTPROVLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENTPROVLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_PATIENTPROVLIST_tab IS TABLE OF CT_PATIENTPROVLIST_OBJ; 



--
-- CT_PATIENTREACTIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CT_PATIENTREACTIONLIST_OBJ is object
(
 REACTIONCD               VARCHAR2(200),
 REACTIONCDDESC           VARCHAR2(200)
) 



--
-- CT_PATIENTREACTIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENTREACTIONLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.CT_PATIENTREACTIONLIST_TAB is table of CT_PATIENTREACTIONLIST_OBJ 



--
-- CT_PATIENTRELATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patientrelation_obj IS OBJECT (
                                                       personid number,
                                                       persontype varchar2 (1),
                                                       assoicationtype varchar2 (100),
                                                       firstname varchar2 (50),
                                                       lastname varchar2 (50),
                                                       dob date,
                                                       gender varchar2 (10),
                                                       addressline1 varchar2 (500),
                                                       addressline2 varchar2 (500),
                                                       city varchar2 (50),
                                                       zipcode varchar2 (10),
                                                       state varchar2 (2),
                                                       effectivestartdate date,
                                                       effectiveenddate date,
                                                       systemsource varchar2 (20)
                                                    );



--
-- CT_PATIENTRELATION_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENTRELATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patientrelation_tab
IS
   TABLE OF ct_patientrelation_obj



--
-- CT_PATIENT_ADDRESS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_address_obj
AS
   OBJECT (sourcetrackingid number,
           odstrackingid number,
           addressline1 varchar2 (50),
           addressline2 varchar2 (50),
           city varchar2 (50),
           state varchar2 (50),
           zipcode varchar2 (10),
           zipcodeplusfour varchar2 (4),
           country varchar2 (50),
           addresstype varchar2 (20),
           preferredflag varchar2 (1),
           updatesourcename varchar2 (20),
           systemsource varchar2 (20),
           updateddate date,
           deletedbysource varchar2 (20),
           action varchar2 (20));



--
-- CT_PATIENT_ADDRESS_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENT_ADDRESS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_address_tab
IS
   TABLE OF ct_patient_address_obj;



--
-- CT_PATIENT_COMMENT_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_patient_comment_req_obj is object
(
sourcetrackingid number,
odssectioninstanceid number,
sectionqualifier varchar2(40),
reporteddt date,
comments varchar2(4000)
);



--
-- CT_PATIENT_COMMENT_REQ_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PATIENT_COMMENT_REQ_OBJ (Type)
--
CREATE OR REPLACE type ODS.ct_patient_comment_req_tab as table of ct_patient_comment_req_obj;



--
-- CT_PATIENT_COMMENT_RESP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_patient_comment_resp_obj is object
(
sourcetrackingid number,
returncode		 number
);



--
-- CT_PATIENT_COMMENT_RESP_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PATIENT_COMMENT_RESP_OBJ (Type)
--
CREATE OR REPLACE type ODS.ct_patient_comment_resp_tab as table of ct_patient_comment_resp_obj;



--
-- CT_PATIENT_EMAIL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_email_obj
AS
   OBJECT (sourcetrackingid number,
           odstrackingid number,
           emailaddress varchar2 (50),
           emailtypecode varchar2 (20),
           emailpreference varchar2 (1),
           emailformat varchar2 (10),
           preferredflag varchar2 (1),
           updatedsourcename varchar2 (20),
           systemsource varchar2 (20),
           updateddate date,
           deletedbysource varchar2 (20),
           action varchar2 (20));



--
-- CT_PATIENT_EMAIL_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENT_EMAIL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_email_tab IS TABLE OF ct_patient_email_obj;



--
-- CT_PATIENT_INSURANCE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_insurance_obj IS OBJECT (SourceTrackingID number,
                                                           ODSTrackingID number,
                                                           Insurance varchar2 (500),
                                                           InsuranceID varchar2 (500),
                                                           InsuranceStartDT Date,
                                                           InsuranceEndDT Date,
                                                           SystemSource varchar2 (20),
                                                           action varchar2 (30));



--
-- CT_PATIENT_INSURANCE_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENT_INSURANCE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_insurance_tab IS TABLE OF ct_patient_insurance_obj



--
-- CT_PATIENT_MEMBERSETTING_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_Membersetting_obj IS OBJECT (SourceTrackingID number,
                                                               SettingType varchar2 (50),
                                                               SettingValue varchar2 (50),
                                                               SystemSource varchar2 (20),
                                                               action varchar2 (30));



--
-- CT_PATIENT_MEMBERSETTING_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENT_MEMBERSETTING_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_Membersetting_tab IS TABLE OF ct_patient_Membersetting_obj;



--
-- CT_PATIENT_PHONE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_phone_obj
AS
   OBJECT (sourcetrackingid number,
           odstrackingid number,
           phonefaxnumber varchar2 (50), -- Changed from number to varchar2
           phonefaxtype varchar2 (15),
           phonefaxusagetype varchar2 (20),
           phonefaxlocationcode varchar2 (15),
           preferredflag varchar2 (1),
           updatesourcename varchar2 (20),
           systemsource varchar2 (20),
           updateddate date,
           deletedbysource varchar2 (20),
           action varchar2 (20)) 



--
-- CT_PATIENT_PHONE_TAB  (Type) 
--
--  Dependencies: 
--   CT_PATIENT_PHONE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_patient_phone_tab IS TABLE OF ct_patient_phone_obj 



--
-- CT_PCPLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_pcplist_obj
AS
   OBJECT (pcpstatus varchar2 (1), updatedate date, source varchar2 (30))



--
-- CT_PCPLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PCPLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_pcplist_tab IS TABLE OF ct_pcplist_obj



--
-- CT_POPFOCUSINFO_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_popfocusinfo_req_obj
IS   OBJECT (sourcetrackingid number,
                odspopfocusid number,
			  popfocustagname varchar2 (75),
			  popfocustagdesc varchar2 (300),
		           activeflag varchar2 (1),
		           actionflag varchar2(1))



--
-- CT_POPFOCUSINFO_REQ_TAB  (Type) 
--
--  Dependencies: 
--   CT_POPFOCUSINFO_REQ_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_popfocusinfo_req_tab IS TABLE OF ct_popfocusinfo_req_obj



--
-- CT_POPFOCUSINFO_RES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_popfocusinfo_res_obj
IS OBJECT (sourcetrackingid number,
              odspopfocusid number,
			     ReturnCode number)



--
-- CT_POPFOCUSINFO_RES_TAB  (Type) 
--
--  Dependencies: 
--   CT_POPFOCUSINFO_RES_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_popfocusinfo_res_tab IS TABLE OF ct_popfocusinfo_res_obj



--
-- CT_POPULATIONFOCUSTAG_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_PopulationFocusTag_OBJ
AS
   OBJECT (ODSPopulationFocusID NUMBER,
           PopulationFocusTagName VARCHAR2 (75),
           PopulationFocusTagDescription VARCHAR2 (300),
           ActiveFlag VARCHAR2 (1),
           AddedByID number,
           AddedOn DATE,
           LastUpdatedByID number,
           LastUpdatedOn DATE);



--
-- CT_POPULATIONFOCUSTAG_TAB  (Type) 
--
--  Dependencies: 
--   CT_POPULATIONFOCUSTAG_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_PopulationFocusTag_TAB
IS
   TABLE OF ct_PopulationFocusTag_OBJ;



--
-- CT_PREAUTHORIZATIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_PREAUTHORIZATIONLIST_OBJ
as
   object (patientpreauthcasehistskey number,
           memberphone varchar2(30),
           providerfirstname varchar2(32),
           providerlastname varchar2(40),
           facilityname varchar2(100),
           diagnosiscodesystemtype varchar2(10),
           diagnosiscode varchar2(20),
           diagnosiscodeshortdesc varchar2(200),
           diagnosiscodelongdesc varchar2(2000),
           diagnosiscodefulldesc varchar2(2000),
           procedurecodesystemtype varchar2(10),
           procedurecode varchar2(20),
           procedurecodeshortdesc varchar2(200),
           procedurecodelongdesc varchar2(2000),
           procedurecodefulldesc varchar2(2000),
           dischargedate date,
           reportingdate date,
		   admitdate     date) -- Added by Poorani



--
-- CT_PREAUTHORIZATIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PREAUTHORIZATIONLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_PREAUTHORIZATIONLIST_TAB IS TABLE OF CT_PREAUTHORIZATIONLIST_OBJ



--
-- CT_PRECERTCASEDTLSLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_precertcasedtlslist_obj IS OBJECT (CarrierCaseID varchar2 (20),
                                                  ODSCaseID number,
                                                  ODSCaseHistID number,
                                                  DiseaseCategory varchar2 (100),
                                                  InpatientOutPatientFlag varchar2 (1),
                                                  AdmitDt date,
                                                  DischargeDt date,
                                                  LengthOfStay number,
                                                  DiagnosisCode varchar2(20),
                                                  DiagnosisCodeSystemName varchar2 (20),
                                                  DiagnosisShortName varchar2 (500),
                                                  DiagnosisLongName varchar2 (500),
                                                  DiagnosisFullName varchar2 (2000),
                                                  ProcedureCode varchar2(20),
                                                  ProcedureCodeSystemName varchar2 (20),
                                                  ProcedureShortName varchar2 (500),
                                                  ProcedureLongName varchar2 (500),
                                                  ProcedureFullName varchar2 (2000),
                                                  AdmittingProviderFirstName varchar2 (50),
                                                  AdmittingProviderLastName varchar2 (50),
                                                  AdmittingProviderPhone varchar2 (15),
                                                  AdmittingProviderState varchar2 (2),
                                                  FacilityName varchar2 (50),
                                                  FacilityPhone varchar2 (15),
                                                  FacilityState varchar2 (2),
                                                  RecordInsertedDate timestamp (6),
                                                  SourceSendDt date);



--
-- CT_PRECERTCASEDTLSLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PRECERTCASEDTLSLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_precertcasedtlslist_tab IS TABLE OF ct_precertcasedtlslist_obj;



--
-- CT_PROBLEMDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_CLAIMSCOMMENTSLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_PROBLEMDETAILLIST_OBJ
AS
   OBJECT (memberplanid number,
           clientpatid varchar2 (50),
           patientissuingorgid varchar2 (64),
           odsinstanceid number,
           odsinstancequalifier varchar2 (50),
           age number,
           startdate date,
           enddate date,
           reporteddt date,
           servicingorgid varchar2 (64),
           servicingorgname varchar2 (255),
           poproviderid number,
           cpproviderid number,
           sourceproviderid varchar2 (200),
           providerissuingorgid varchar2 (64),
           providerfname varchar2 (50),
           providerlname varchar2 (50),
           datasourcenm varchar2 (50),
           authorid number,
           authoroid varchar2 (64),
           authortype varchar2 (1),
           informantid number,
           informantoid varchar2 (64),
           informanttype varchar2 (1),
           commentsourcelist ct_claimscommentslist_tab,
           vendorsourcenm varchar2 (30),
           PROBLEMPHASE         varchar2(255),
           PROBLEMSTATUS        varchar2(255)           
           ) 



--
-- CT_PROBLEMDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PROBLEMDETAILLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_PROBLEMDETAILLIST_TAB IS TABLE OF CT_PROBLEMDETAILLIST_OBJ 



--
-- CT_PROBLEMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_PROBLEMDETAILLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_PROBLEMLIST_OBJ
AS
   OBJECT (medicalcode          varchar2 (50),
           medicalcodetype      varchar2 (50),
           shortdesc            varchar2 (500),
           longdesc             varchar2 (500),
           fulldesc             varchar2 (2000),
           sensitiveflag        varchar2 (1),
           PROBLEMdetaillist    CT_PROBLEMDETAILLIST_tab,
           CODEVALIDATED        varchar2(1)
           ) 



--
-- CT_PROBLEMLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PROBLEMLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_PROBLEMLIST_TAB IS TABLE OF ODS.CT_PROBLEMLIST_OBJ 



--
-- CT_PROCEDUREDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_MODIFIERS_TAB (Type)
--   CT_CLAIMSCOMMENTSLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.ct_proceduredetaillist_obj
AS
   OBJECT (memberplanid number,
           clientpatid varchar2 (50),
           patientissuingorgid varchar2 (64),
           odsinstanceid number,
           odsinstancequalifier varchar2 (50),
           age number,
           startdate date,
           enddate date,
           reporteddt date,
           moodcd varchar2 (24),
           servicingorgid varchar2 (64),
           servicingorgname varchar2 (255),
           poproviderid number,
           cpproviderid number,
           sourceproviderid varchar2 (200),
           providerissuingorgid varchar2 (64),
           providerfname varchar2 (50),
           providerlname varchar2 (50),
           datasourcenm varchar2 (50),
           authorid number,
           authoroid varchar2 (64),
           authortype varchar2 (1),
           informantid number,
           informantoid varchar2 (64),
           informanttype varchar2 (1),
           commentsourcelist ct_claimscommentslist_tab,
           cptmodifiers ct_modifiers_tab,
           vendorsourcenm varchar2 (30),
           statuscode varchar2 (24),
           statussystemname varchar2(200),
           statussystemoid varchar2(64)
           )



--
-- CT_PROCEDUREDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PROCEDUREDETAILLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_proceduredetaillist_tab is table of ct_proceduredetaillist_obj



--
-- CT_PROCEDURELIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_PROCEDUREDETAILLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_procedurelist_obj
AS
   OBJECT (medicalcode varchar2 (50),
           medicalcodetype varchar2 (50),
           shortdesc varchar2 (500),
           longdesc varchar2 (500),
           fulldesc varchar2 (2000),
           sensitiveflag varchar2 (1),
           proceduredetaillist ct_proceduredetaillist_tab,
           validationstatus varchar2(1))



--
-- CT_PROCEDURELIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PROCEDURELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_procedurelist_tab is table of ct_procedurelist_obj



--
-- CT_PROVIDERIDLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ct_provideridlist_obj
is object
(
providerid  number,
usertypecode varchar2(1)
)



--
-- CT_PROVIDERIDLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PROVIDERIDLIST_OBJ (Type)
--
CREATE OR REPLACE type ODS.ct_provideridlist_tab is table of ct_provideridlist_obj



--
-- CT_PROVIDERINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PROVIDER_SPECIALTY_TAB (Type)
--   CT_ASSOCIATEDORG_TAB (Type)
--   CT_PATIENT_ADDRESS_TAB (Type)
--   CT_PATIENT_PHONE_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.ct_providerinfo_obj IS OBJECT
(
providerid NUMBER,
usertypecode VARCHAR2(1),
masterflag VARCHAR2(1),
firstnm VARCHAR2(50),
middlenm VARCHAR2(25),
lastnm VARCHAR2(40),
title VARCHAR2(20),
namesuffix VARCHAR2(10),
nameprefix  VARCHAR2(5),
sourceuserid VARCHAR2(200),
sourceissuingorgoid VARCHAR2(64),
effectivestartdt DATE,
effectiveenddt DATE,
primaryrole VARCHAR2(24),
secondaryrole  VARCHAR2(24),
emailaddress VARCHAR2(50),
providernpi	VARCHAR2(10),
providertin VARCHAR2(9),
associatedoidlist  ct_associatedorg_tab,
addresslist ct_patient_address_tab,
phonelist ct_patient_phone_tab,
specialtylist ct_provider_specialty_tab,
returncode NUMBER
);



--
-- CT_PROVIDERINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PROVIDERINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_providerinfo_tab IS TABLE OF ct_providerinfo_obj;



--
-- CT_PROVIDERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PCPLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.CT_PROVIDERLIST_OBJ
AS
   OBJECT (requestorid number,
           requestortype varchar2 (50),
           cpproviderid number,
           sourceproviderid varchar2 (200),
           providerissuingorgid varchar2 (64),
           cpfname varchar2 (50),
           cplname varchar2 (50),
           cpspeciality1 varchar2 (100),
           cpspeciality2 varchar2 (100),
           cpspeciality3 varchar2 (100),
           associationsource varchar2 (20),
           associationstate varchar2 (50),
           pcpindicatorlist ct_pcplist_tab,
           cpfullname varchar2 (200)) 



--
-- CT_PROVIDERLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_PROVIDERLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_PROVIDERLIST_TAB AS TABLE OF CT_PROVIDERLIST_OBJ 



--
-- CT_PROVIDER_SPECIALTY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_provider_specialty_obj
IS OBJECT
(
specialtycodesystem VARCHAR2(64),
specialtycode VARCHAR2(100),
specialtydesc VARCHAR2(100)
);



--
-- CT_PROVIDER_SPECIALTY_TAB  (Type) 
--
--  Dependencies: 
--   CT_PROVIDER_SPECIALTY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_provider_specialty_tab IS TABLE OF ct_provider_specialty_obj;



--
-- CT_PRVLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_prvlist_obj
IS
   OBJECT (providerid number, facilityoid varchar2 (64));



--
-- CT_PRVLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_PRVLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_prvlist_tab IS TABLE OF ct_prvlist_obj



--
-- CT_QMDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   CT_QMFEEDBACKLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_QMDETAILLIST_OBJ
AS
   OBJECT (QMTrackingID number,
           AccountOID varchar2 (50),
           FacilityOID varchar2 (64),
           CPProviderID number,
           ProviderType varchar2 (10),
           AssignedID number,
           SourceProviderID varchar2 (64),
           ProviderIssuingOrgID varchar2 (64),
           CPFName varchar2 (50),
           CPLName varchar2 (50),
           QMID number,
           QMTitle varchar2 (500),
           ConditionClassID number,
           ConditionClassTitle varchar2 (500),
           QMBenchValue number,
           QMSource varchar2 (50),
           IsPatientComplaint varchar2 (1),
           QMFeedbackList ct_QMfeedbacklist_tab,
           CPFULLName varchar2 (200)) 



--
-- CT_QMDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_QMDETAILLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_QMDETAILLIST_TAB AS TABLE OF CT_QMDETAILLIST_OBJ 



--
-- CT_QMFEEDBACKLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_QMFEEDBACKLIST_OBJ
AS
   OBJECT (fdbtrackingid NUMBER,
           fdbdate DATE,
           fdbstatusid VARCHAR2 (24),
           fdbstatusreasonid NUMBER,
           fdbcomments VARCHAR2 (4000),
           fdbdatasource VARCHAR2 (30),
           byuserid NUMBER,
           byproviderid NUMBER,
           byrole VARCHAR2 (20),
           byfname VARCHAR2 (50),
           bylname VARCHAR2 (50),
           foruserid NUMBER,
           forproviderid NUMBER,
           forrole VARCHAR2 (20),
           forfname VARCHAR2 (50),
           forlname VARCHAR2 (50),
           byfullname VARCHAR2 (200),
           forfullname VARCHAR2 (200)) 



--
-- CT_QMFEEDBACKLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_QMFEEDBACKLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_QMFEEDBACKLIST_TAB AS TABLE OF CT_QMFEEDBACKLIST_OBJ 



--
-- CT_QMPATIENTLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_QMFEEDBACKLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.CT_QMPATIENTLIST_OBJ
AS
   OBJECT (qmtrackingid number,
           memberplanid number,
           clientpatid varchar2 (50),
           issuingorgid varchar2 (64),
           fname varchar2 (50),
           lname varchar2 (50),
           dob date,
           gender varchar2 (1),
           iscomplaint varchar2 (1),
           lastcomm_createddt date,
           qmfeedbacklist ct_qmfeedbacklist_tab);



--
-- CT_QMPATIENTLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_QMPATIENTLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_QMPATIENTLIST_TAB
IS
   TABLE OF ct_qmpatientlist_obj;



--
-- CT_QMPRVLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_qmprvlist_obj AS OBJECT (providerid number);



--
-- CT_QMPRVLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_QMPRVLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_qmprvlist_tab AS TABLE OF ct_qmprvlist_obj;



--
-- CT_SETNOTEITEMLISTIN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_setnoteitemlistin_obj
AS
   OBJECT (noteitemtrackingid number,
           noteitem varchar2 (4000),
           nidraftcreatedt date,
           nicreatedt date,
           creatorid number,
           creatortype varchar2 (1),
           nisection varchar2 (24),
           nisectionid number,
           systemsource varchar2 (20),
           nimode varchar2 (1));



--
-- CT_SETNOTEITEMLISTIN_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_SETNOTEITEMLISTIN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_setnoteitemlistin_tab
IS
   TABLE OF ct_setnoteitemlistin_obj;



--
-- CT_SETNOTEITEMLISTOUT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_setnoteitemlistout_obj
AS
   OBJECT (noteitemtrackingid number);



--
-- CT_SETNOTEITEMLISTOUT_TAB  (Type) 
--
--  Dependencies: 
--   CT_SETNOTEITEMLISTOUT_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_setnoteitemlistout_tab
IS
   TABLE OF ct_setnoteitemlistout_obj;



--
-- CT_SEVERITYLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_severitylist_obj IS OBJECT (
   markerseverity   VARCHAR2 (12),
   severitycount    NUMBER
);



--
-- CT_SEVERITYLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_SEVERITYLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_severitylist_tab AS TABLE OF ct_severitylist_obj;



--
-- CT_TAGCOLLECTIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_tagcollectionlist_obj
IS   OBJECT ( odspopfocusid number,
			  popfocustagname varchar2 (75),
			  popfocustagdesc varchar2 (300),
		           activeflag varchar2 (1),
		           addedbyid number,
				   addedon date,
				   lastupdatedbyid number,
				   lastupdatedon date)



--
-- CT_TAGCOLLECTIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   CT_TAGCOLLECTIONLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_tagcollectionlist_tab IS TABLE OF ct_tagcollectionlist_obj



--
-- CT_USERINFO_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_userinfo_req_obj 
IS
   OBJECT (sourcetrackingid number, 
                     userid number, 
                   usertype varchar2 (1), 
                stafftypecd varchar2 (12),
          employerorgtypecd varchar2 (12),
             employerorgoid varchar2(64)) 



--
-- CT_USERINFO_REQ_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_USERINFO_REQ_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_userinfo_req_tab IS TABLE OF ct_userinfo_req_obj 



--
-- CT_USERINFO_RES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ct_userinfo_res_obj IS OBJECT (sourcetrackingid number, returncode number);



--
-- CT_USERINFO_RES_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_USERINFO_RES_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ct_userinfo_res_tab IS TABLE OF ct_userinfo_res_obj;



--
-- CT_USERORGLIST_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_USERORGLIST_REQ_OBJ IS OBJECT
(
SOURCETRACKINGID	NUMBER,
USERID			NUMBER,
USERTYPE		VARCHAR2(1),
ORGOID			VARCHAR2(64),
ACTIONFLAG		VARCHAR2(1)
)



--
-- CT_USERORGLIST_REQ_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CT_USERORGLIST_REQ_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.CT_USERORGLIST_REQ_TAB IS TABLE OF CT_USERORGLIST_REQ_OBJ



--
-- CT_USERORGLIST_RESP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_USERORGLIST_RESP_OBJ IS OBJECT
(
SOURCETRACKINGID      NUMBER,
USERID		      NUMBER,
ORGID		      NUMBER,
RETURNCODE            NUMBER
)



--
-- CT_USERORGLIST_RESP_TAB  (Type) 
--
--  Dependencies: 
--   CT_USERORGLIST_RESP_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.CT_USERORGLIST_RESP_TAB IS TABLE OF CT_USERORGLIST_RESP_OBJ



--
-- DASHBOARDDETAILS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DASHBOARDDETAILS_OBJ
as
object
(
COMPONENTMNEMONIC  VARCHAR2(24),
CURRDASHBOARDID    VARCHAR2(50),
CURRDASHBOARDTYPE  VARCHAR2(20),
CURRDATASOURCE     VARCHAR2(20),
CURRFEEDSOURCE     VARCHAR2(20),
CURRENTVALUEDATE   TIMESTAMP(6),
CURRENTVALUE       VARCHAR2(200),
PREVDASHBOARDID    VARCHAR2(50),
PREVDASHBOARDTYPE  VARCHAR2(20),
PREVDATASOURCE     VARCHAR2(20),
PREVFEEDSOURCE     VARCHAR2(20),
PREVVALUEDATE      TIMESTAMP(6),
PREVVALUE          VARCHAR2(200)
)



--
-- DASHBOARDDETAILS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DASHBOARDDETAILS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DASHBOARDDETAILS_TAB as table of DASHBOARDDETAILS_OBJ



--
-- DEPENDENTLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DEPENDENTLIST_OBJ IS OBJECT (
   memberplanid                NUMBER,
   firstname                   VARCHAR2 (50),
   lastname                    VARCHAR2 (50),
   dob                         DATE,
   gender                      VARCHAR2 (24),
   addressline1                VARCHAR2 (50),
   addressline2                VARCHAR2 (50),
   city                        VARCHAR2 (50),
   zipcode                     VARCHAR2 (20),
   state                       VARCHAR2 (2),
   ssn                         VARCHAR2 (11),
   effectivestartdate          DATE,
   effectiveenddate            DATE,
   dependenttype               VARCHAR2 (20),
   supplierid                  NUMBER,
   employergenerateduniqueid   VARCHAR2 (50),
   maritalstatus               VARCHAR2 (24),
   memberid                    VARCHAR2(30),
   phonedisplaynumber          VARCHAR2 (50)
);




--
-- DEPENDENTLIST_TAB  (Type) 
--
--  Dependencies: 
--   DEPENDENTLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DEPENDENTLIST_TAB IS TABLE OF ODS.DEPENDENTLIST_OBJ;



--
-- DEVICETRACKERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.DeviceTrackerList_obj force
as object (
ODSTrackingID NUMBER,
SourceTrackingID NUMBER,
HealthTrackerComponentName VARCHAR2(12),
UOM VARCHAR2(30),
SubTypeName VARCHAR2(30),
SubTypeNumeric NUMBER,
SubTypeNonNumeric VARCHAR2(200),
Comments VARCHAR2(4000)
)



--
-- DEVICETRACKERLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DEVICETRACKERLIST_OBJ (Type)
--
CREATE OR REPLACE type ODS.DeviceTrackerList_Tab force
as table of DeviceTrackerList_obj



--
-- DEVICETRACKERVALUELIST_OBJ  (Type) 
--
--  Dependencies: 
--   DEVICETRACKERLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.DeviceTrackerValueList_obj force
as object (
HealthTrackerName VARCHAR2(12),
MemberReportedMeasurementType VARCHAR2(40),
UpdateSourceName VARCHAR2(20),
FeedSourceNm   VARCHAR2(20),
RecordInsertedDt TIMESTAMP(6),
LastUpdateDate TIMESTAMP(6),
DeletedBySource VARCHAR2(20),
MeasurementDate TIMESTAMP(6),
MemberReportedDeviceType VARCHAR2(255),
MedHelpID VARCHAR2(60),
HealthTrackerList DeviceTrackerList_Tab
)



--
-- DEVICETRACKERVALUELIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DEVICETRACKERVALUELIST_OBJ (Type)
--
CREATE OR REPLACE type ODS.DeviceTrackerValueList_Tab is table of DeviceTrackerValueList_obj



--
-- DEVTRACKER_SUBTYPE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.devtracker_subtype_obj AS OBJECT (
   tracker_subtype         VARCHAR2 (40),
   tracker_subtype_value   VARCHAR2 (20),
   errorcode               NUMBER,
   errormsg                VARCHAR2 (2000)
)



--
-- DEVTRACKER_SUBTYPE_TAB  (Type) 
--
--  Dependencies: 
--   DEVTRACKER_SUBTYPE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.devtracker_subtype_tab IS TABLE OF devtracker_subtype_obj



--
-- DEVTRACKER_TYPE_OBJ  (Type) 
--
--  Dependencies: 
--   DEVTRACKER_SUBTYPE_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.devtracker_type_obj AS OBJECT (
   tracker_id                   VARCHAR2 (60),
   tracker_type                 VARCHAR2 (40),
   tracker_ind                  CHAR,
   tracker_date                 DATE,
   device_tracker_subtype_tab   devtracker_subtype_tab
)



--
-- DEVTRACKER_TYPE_TAB  (Type) 
--
--  Dependencies: 
--   DEVTRACKER_TYPE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.devtracker_type_tab IS TABLE OF devtracker_type_obj



--
-- DIAGNOSIS_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DIAGNOSIS_OBJECT
as object(
  memberid       NUMBER,
  dateofevent    DATE,
  code           VARCHAR2(20),
  instanceid     NUMBER,
  careproviderid NUMBER, 
  sourceproviderid VARCHAR2(30)); 



--
-- DIAGNOSIS_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   DIAGNOSIS_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DIAGNOSIS_OBJECT_ARRAY as table of diagnosis_object; 



--
-- DIGITALCOACHINGLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DIGITALCOACHINGLIST_OBJ AS
  OBJECT (ODSTRACKINGID                  NUMBER,
          MEMBERPLANID                   NUMBER,
          COMPLETIONCATEGORYID           VARCHAR2(20),
          CATEGORYNAME                   VARCHAR2(50),
          CATEGORYDATESTARTED            TIMESTAMP(6),
          LASTCOMPLETEDCATEGORYDATE      TIMESTAMP(6),
          COMPLETIONTOPICID              VARCHAR2(20),
          TOPICNAME                      VARCHAR2(100),
          TOPICDATESTARTED               TIMESTAMP(6),
          LASTCOMPLETEDTOPICDATE         TIMESTAMP(6),
          DATAFIELD1                     VARCHAR2(255),
          DATAFIELD2                     VARCHAR2(255),
          DATAFIELD3                     VARCHAR2(255),
          DATAFIELD4                     VARCHAR2(255),
          DATAFIELD5                     VARCHAR2(255),
          DATAFIELD6                     VARCHAR2(255),
          DATAFIELD7                     VARCHAR2(255),
          DATAFIELD8                     VARCHAR2(255),
          DATAFIELD9                     VARCHAR2(255),
          DATAFIELD10                    VARCHAR2(255))



--
-- DIGITALCOACHINGLIST_TAB  (Type) 
--
--  Dependencies: 
--   DIGITALCOACHINGLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DIGITALCOACHINGLIST_TAB IS TABLE OF DIGITALCOACHINGLIST_OBJ



--
-- DRUGLIST_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DRUGLIST_OBJECT     as object(
  NDCCODE           VARCHAR2(50),
  drugtradenm    VARCHAR2(100),
  elementid         NUMBER)



--
-- DRUGLIST_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   DRUGLIST_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DRUGLIST_OBJECT_ARRAY   as table of DRUGLIST_OBJECT



--
-- DRUGSUMMARY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.drugsummary_obj AS OBJECT(
 MEMBERPLANID  NUMBER,
 DRUGNAME      VARCHAR2(50),
 UPDATETIME    DATE,
 UPDATEDATE    VARCHAR2(9),
 LASTFILLDATE  DATE,
 STATUS        VARCHAR2(50),
 REASONFORCHANGE  VARCHAR2(30),
 COMMENTS      VARCHAR2(300));



--
-- DRUG_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DRUG_OBJECT    as object(
  memberid       NUMBER,
  dateofevent    DATE,
  code           VARCHAR2(20),
  supply         INTEGER,
  instanceid     NUMBER,
  careproviderid NUMBER,
  sourceproviderid VARCHAR2(30)); 



--
-- DRUG_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   DRUG_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DRUG_OBJECT_ARRAY   as table of DRUG_OBJECT; 



--
-- DT_ADDR_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_ADDR_OBJ AS
   OBJECT (addr_use varchar2 (1000),
           addr_useableperiod varchar2 (1000),
           addr_St_Addr_Line1 varchar2 (100),
           addr_St_Addr_Line2 varchar2 (100),
           addr_St_Addr_Line3 varchar2 (100),
           addr_City varchar2 (20),
           addr_State varchar2 (20),
           addr_ZipCode varchar2 (20),
           addr_ZipPlusFour varchar2 (4),
           addr_Country varchar2 (20));




--
-- DT_ADDR_TAB  (Type) 
--
--  Dependencies: 
--   DT_ADDR_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_ADDR_TAB IS TABLE OF DT_ADDR_OBJ;




--
-- DT_ANNOTATION_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_IIEXTN_OBJ (Type)
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.dt_annotation_obj AS OBJECT (
   ID                                      dt_ii_obj,
   text                                    VARCHAR2 (3000),
   datetime                                DATE,
   author                                  hie_iiextn_obj
);



--
-- DT_ANNOTATION_TAB  (Type) 
--
--  Dependencies: 
--   DT_ANNOTATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.dt_annotation_tab IS TABLE OF dt_annotation_obj;



--
-- DT_CD_EXTN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.dt_cd_extn_obj IS OBJECT (
   cd_id                                   VARCHAR2 (100),
   cd_parentid                             VARCHAR2 (100),
   cd_code                                 VARCHAR2 (100),
   cd_codesystem                           VARCHAR2 (64),
   cd_displayname                          VARCHAR2 (200),
   cd_codesystemname                       VARCHAR2 (200),
   cd_codesystemversion                    VARCHAR2 (20),
   cd_originaltext                         VARCHAR2 (200)
);



--
-- DT_CD_EXTN_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CD_EXTN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.dt_cd_extn_tab IS TABLE OF dt_cd_extn_obj;



--
-- DT_CD_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CD_EXTN_TAB (Type)
--   DT_CD_QUALIFIER_TAB (Type)
--   DT_CD_EXTN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.dt_cd_obj IS OBJECT (
   code                                    dt_cd_extn_obj,
   qualifier                               dt_cd_qualifier_tab,
   translation                             dt_cd_extn_tab
);



--
-- DT_CD_QUALIFIER_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CD_EXTN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.dt_cd_qualifier_obj IS OBJECT (
   qualifier_name                          dt_cd_extn_obj,
   qualifier_value                         dt_cd_extn_obj
);



--
-- DT_CD_QUALIFIER_TAB  (Type) 
--
--  Dependencies: 
--   DT_CD_QUALIFIER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.dt_cd_qualifier_tab IS TABLE OF dt_cd_qualifier_obj;



--
-- DT_CE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_CE_OBJ AS
   OBJECT (CE_Code varchar2 (100),
           CE_CodeSystem varchar2 (64),
           CE_DisplayName varchar2 (200),
           CE_codeSystemName varchar2 (200),
           CE_codeSystemVersion varchar2 (20),
           CE_originalText varchar2 (200));




--
-- DT_CE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DT_CE_TAB IS TABLE OF DT_CE_OBJ;




--
-- DT_CITIZENSHIP_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_TAB (Type)
--   DT_NAT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DT_CITIZENSHIP_OBJ AS
   OBJECT (Citizenship_id Dt_II_TAB, Citizenship_Nation dt_Nat_obj);




--
-- DT_CITIZENSHIP_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CITIZENSHIP_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DT_CITIZENSHIP_TAB IS TABLE OF dt_Citizenship_obj;




--
-- DT_DOSAGE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.dt_dosage_obj AS OBJECT (
   dosage_qty                              NUMBER,
   dosage_value                            NUMBER,
   dosage_unit                             VARCHAR2 (100),
   dosage_oid                              VARCHAR2 (100)
);



--
-- DT_EMPLOYMENT_OBJ  (Type) 
--
--  Dependencies: 
--   DT_SCO_OBJ (Type)
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_EMPLOYMENT_OBJ AS
   OBJECT (Employment_OccupationCode DT_CE_OBJ,
           Employment_statusCode VARCHAR2 (100),
           Employment_Employer dt_SCO_obj);




--
-- DT_EMPLOYMENT_TAB  (Type) 
--
--  Dependencies: 
--   DT_EMPLOYMENT_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_EMPLOYMENT_TAB IS TABLE OF dt_Employment_obj;




--
-- DT_ENXP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_ENXP_OBJ AS
   OBJECT (ENXP_Part_Type varchar2 (20),
           ENXP_Qualifier varchar2 (1000),
           ENXP_value varchar2 (200));




--
-- DT_EN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_ENXP_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DT_EN_OBJ AS
   OBJECT (EN_use varchar2 (1000),
           EN_useableperiod varchar2 (1000),
           EN_NameParts DT_ENXP_OBJ);




--
-- DT_EN_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_EN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DT_EN_TAB IS TABLE OF DT_EN_OBJ;




--
-- DT_EVENTCODE_OBJ  (Type) 
--
--  Dependencies: 
--   DT_OFFSET_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.dt_eventcode_obj AS OBJECT (
   eventcode                               VARCHAR2 (100),
   offset                                  dt_offset_obj
);



--
-- DT_EXTENDEDPERSON_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_TEL_TAB (Type)
--   DT_CE_OBJ (Type)
--   DT_ADDR_TAB (Type)
--   DT_PN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.dt_extendedperson_obj IS OBJECT (
   name                                    dt_pn_obj
  ,relationcode                            dt_ce_obj
  ,dtofbirth                               DATE
  ,address                                 dt_addr_tab
  ,phone                                   dt_tel_tab
  ,gender                                  dt_ce_obj
  ,deceasedflg                             VARCHAR2 (1)
  ,ageatdeath                              NUMBER
  ,datasourcenm                            VARCHAR2 (20)
  ,maritalstatus                           dt_ce_obj
  ,primarylanguage                         dt_ce_obj
  ,protectionflag                          VARCHAR2 (10)
  ,religion                                dt_ce_obj
  ,handicapcd                              dt_ce_obj
  ,race                                    dt_ce_obj
  ,ethnicity                               dt_ce_obj
  ,role									   VARCHAR2(24) -- New attribute
  ,DeceasedDate                            DATE  -- New attribute
);



--
-- DT_EXTENDEDPERSON_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_EXTENDEDPERSON_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.dt_extendedperson_tab IS TABLE OF dt_extendedperson_obj;



--
-- DT_II_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_II_OBJ AS
   OBJECT (ii_root varchar2 (64), ii_extension varchar2 (200));




--
-- DT_II_TAB  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_II_TAB IS TABLE OF DT_II_OBJ;




--
-- DT_IVL_TS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.dt_ivl_ts_obj
 as object
  ( efftimelow  date,
    efftimehigh  date);



--
-- DT_IVL_TS_STR_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."DT_IVL_TS_STR_OBJ"

is object
(
EFFTIMELOW VARCHAR2(20),
EFFTIMEHIGH  VARCHAR2(20)
)



--
-- DT_LANGUAGE_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_LANGUAGE_OBJ AS
   OBJECT (language_Code DT_CE_OBJ, Language_preferenceInd varchar2 (2));




--
-- DT_LANGUAGE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_LANGUAGE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DT_LANGUAGE_TAB IS TABLE OF dt_Language_obj;




--
-- DT_LOC_OBJ  (Type) 
--
--  Dependencies: 
--   DT_EN_OBJ (Type)
--   DT_ADDR_OBJ (Type)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.dt_loc_obj AS OBJECT (
   locationid                              dt_ii_obj,
   locationname                            dt_en_obj,
   locationaddr                            dt_addr_obj
);



--
-- DT_NAT_OBJ  (Type) 
--
--  Dependencies: 
--   DT_EN_OBJ (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DT_NAT_OBJ AS OBJECT (nat_code DT_CE_OBJ, nat_name DT_EN_OBJ);




--
-- DT_OFFSET_OBJ  (Type) 
--
--  Dependencies: 
--   DT_UNITVALUE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.dt_offset_obj AS OBJECT (
   low                                     dt_unitvalue_obj,
   width                                   dt_unitvalue_obj
);



--
-- DT_OI_OBJ  (Type) 
--
--  Dependencies: 
--   DT_SCO_OBJ (Type)
--   DT_II_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_OI_OBJ AS
   OBJECT (OI_type varchar2 (64), OI_id DT_II_TAB, OI_scopingOrg DT_SCO_OBJ);




--
-- DT_OI_TAB  (Type) 
--
--  Dependencies: 
--   DT_OI_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_OI_TAB IS TABLE OF dt_OI_obj;




--
-- DT_ORGORGRELATION_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   STANDARD (Package)
--   DT_II_TAB (Type)
--
CREATE OR REPLACE type ODS.dt_orgorgrelation_obj as
   object (id           dt_ii_tab,
           code         dt_ce_obj,
           statuscode   varchar2(100),
           efftime      dt_ivl_ts_obj);




--
-- DT_ORGORGREL_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   DT_II_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.DT_ORGORGREL_OBJ AS
   OBJECT (OrgOrgRel_id DT_II_TAB,
           OrgOrgRel_code DT_CE_OBJ,
           OrgOrgRel_statusCode VARCHAR2(100),
           OrgOrgRel_effectiveStartTime TIMESTAMP,
           OrgOrgRel_effectiveEndTime TIMESTAMP);




--
-- DT_PERSON_OBJ  (Type) 
--
--  Dependencies: 
--   DT_LANGUAGE_TAB (Type)
--   STANDARD (Package)
--   DT_PR_TAB (Type)
--   DT_OI_TAB (Type)
--   DT_EMPLOYMENT_TAB (Type)
--   DT_PN_TAB (Type)
--   DT_ADDR_TAB (Type)
--   DT_CE_OBJ (Type)
--   DT_CITIZENSHIP_TAB (Type)
--   DT_TEL_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.DT_PERSON_OBJ AS
   OBJECT (Person_name DT_PN_TAB,
           Person_telecom DT_TEL_TAB,
           Person_GenderCode DT_CE_OBJ,
           Person_birthTime timestamp,
           Person_deacesedInd varchar2 (2),
           Person_deceasedTime timestamp,
           Person_multipleBirthInd varchar2 (2),
           Person_multipleBirthOrderNbr number,
           Person_addr DT_ADDR_TAB,
           Person_maritalStatusCode DT_CE_OBJ,
           Person_religousAffliationCode DT_CE_OBJ,
           Person_raceCode DT_CE_OBJ,
           Person_EthnicCode DT_CE_OBJ,
           Person_OtherIds dT_OI_TAB,
           Person_PersonalrelationShips dT_PR_TAB,
           Person_CitizenshipDetails dt_Citizenship_TAB,
           Person_EmploymentDetails dt_Employment_TAB,
           Person_LanguageCommunication dt_Language_TAB);




--
-- DT_PHASE_OBJ  (Type) 
--
--  Dependencies: 
--   DT_UNITVALUE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.dt_phase_obj AS OBJECT (
   phase_low                               DATE,
   phase_high                              DATE,
   phase_width                             dt_unitvalue_obj
);



--
-- DT_PN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_PN_OBJ AS
   OBJECT (PN_SALUTATION VARCHAr2 (10),
           PN_FULLNM VARCHAR2 (200),
           PN_LASTNM VARCHAR2 (100),
           PN_FIRSTNM VARCHAr2 (100),
           PN_MIDDLENM VARCHAR2 (100),
           PN_MAIDEN_NAME VARCHAR2 (100),
           PN_SUFFIX VARCHAR2 (20));




--
-- DT_PN_TAB  (Type) 
--
--  Dependencies: 
--   DT_PN_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_PN_TAB IS TABLE OF dt_PN_obj;




--
-- DT_PR_OBJ  (Type) 
--
--  Dependencies: 
--   DT_SCP_OBJ (Type)
--   STANDARD (Package)
--   DT_II_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.DT_PR_OBJ AS
   OBJECT (PR_id DT_II_TAB,
           PR_code varchar2 (64),
           PR_relatedPerson DT_SCP_OBJ);




--
-- DT_PR_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_PR_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DT_PR_TAB IS TABLE OF dt_PR_obj;




--
-- DT_SCORG_OBJ  (Type) 
--
--  Dependencies: 
--   DT_ADDR_TAB (Type)
--   DT_ORGORGRELATION_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_EN_TAB (Type)
--   DT_TEL_TAB (Type)
--
CREATE OR REPLACE type ODS.dt_scorg_obj as
   object (id           dt_ii_obj,
           tel          dt_tel_tab,
           name         dt_en_tab,
           addr         dt_addr_tab,
           partoforgrel dt_orgorgrelation_obj);




--
-- DT_SCO_OBJ  (Type) 
--
--  Dependencies: 
--   DT_EN_TAB (Type)
--   DT_TEL_TAB (Type)
--   DT_II_OBJ (Type)
--   DT_ADDR_TAB (Type)
--   DT_ORGORGREL_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.DT_SCO_OBJ AS
   OBJECT (SCO_id DT_II_OBJ,
           SCO_tel DT_TEL_TAB,
           SCO_name DT_EN_TAB,
           SCO_addr DT_ADDR_TAB,
           SCO_PartOfOrgRel dt_OrgOrgRel_obj);




--
-- DT_SCP_OBJ  (Type) 
--
--  Dependencies: 
--   DT_TEL_TAB (Type)
--   DT_PN_TAB (Type)
--   DT_II_TAB (Type)
--   DT_ADDR_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.DT_SCP_OBJ AS
   OBJECT (SCP_ID DT_II_TAB,
           SCP_NAME dt_PN_TAB,
           SCP_TEL DT_TEL_TAB,
           SCP_ADDR DT_ADDR_TAB);




--
-- DT_TEL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_TEL_OBJ AS
   OBJECT (tel_use varchar2 (1000),
           tel_useableperiod varchar2 (1000),
          tel_value varchar2 (50));




--
-- DT_TEL_TAB  (Type) 
--
--  Dependencies: 
--   DT_TEL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.DT_TEL_TAB IS TABLE OF DT_TEL_OBJ;




--
-- DT_UNITVALUE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.dt_unitvalue_obj AS OBJECT (
   VALUE                                   NUMBER,
   unit                                    dt_ce_obj
);



--
-- ECC_JUSTIFICATIONS  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ECC_JUSTIFICATIONS AS OBJECT (
  justificationsequence    NUMBER,
  justificationcode        varchar2(50),
  justificationdescription varchar2(300),
  justificationoccurs      NUMBER,
  justificationstartdate   varchar2(30),
  justificationenddate     varchar2(30));



--
-- ECC_JUSTIFICATION_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   ECC_JUSTIFICATIONS (Type)
--
CREATE OR REPLACE type ODS.ECC_JUSTIFICATION_ARRAY
		as table of ECC_JUSTIFICATIONS ;



--
-- ECC_REFERENCE_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ECC_REFERENCE_ARRAY AS TABLE OF varchar2(300);



--
-- EMAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.emaillist_obj IS OBJECT (
   odstrackingid       NUMBER,
   emailaddress        VARCHAR2 (50),
   emailtypecode       VARCHAR2 (20),
   emailpreference     CHAR (1),
   emailformat         VARCHAR2 (8),
   preferredflg        CHAR (1),
   updatedsourcename   VARCHAR2 (20),
   updateddate         DATE,
   channel             VARCHAR2 (10),
   deletedbysource     VARCHAR2 (20)
);




--
-- EMAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   EMAILLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.emaillist_tab IS TABLE OF emaillist_obj;



--
-- EMERGENCYDETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."EMERGENCYDETAIL_OBJ" AS OBJECT
    ( MEMBERID                       NUMBER,
      PHRMEMBEREMERGENCYID           NUMBER,
      EMERGENCYCONTACTNM             VARCHAR2(200),
      EMERGENCYCONTACTRELATION       VARCHAR2(35),
      CONTACTPHONENUMBER1            VARCHAR2(30),
      CONTACTPHONENUMBER2            VARCHAR2(30) ,
      LIVINGWILLFLAG                 VARCHAR2(2),
      LIVINGWILLCOMMENTS             VARCHAR2(1000),
      ORGANDONORFLAG                 VARCHAR2(2),
      ORGANDONORCOMMENTS             VARCHAR2(1000),
      RECORDINSERTDT                 DATE,
      RECORDUPDTDT                   DATE

    );




--
-- EMERGENCYDETAIL_TAB  (Type) 
--
--  Dependencies: 
--   EMERGENCYDETAIL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."EMERGENCYDETAIL_TAB" IS TABLE OF EMERGENCYDETAIL_OBJ;




--
-- EXCLUSION_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.exclusion_object AS OBJECT (
   memberid           NUMBER,
   planmembershipid   VARCHAR2 (20),
   recommendationid   NUMBER (10),
   exclusioncode      NUMBER,
   exclusiondt        DATE,
   caseid             NUMBER,
   casestatus         VARCHAR2 (15)
)



--
-- EXCLUSION_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   EXCLUSION_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.exclusion_object_array AS TABLE OF exclusion_object



--
-- FEEDBACK_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.FEEDBACK_OBJECT AS OBJECT (
   memberid                NUMBER,
   sourcememberpatientid   VARCHAR2 (20),
   recommendationid        NUMBER (10),
   crsapprovaldttime       DATE,
   feedbackdt              DATE,
   reasonid                VARCHAR2 (4),
   subreasonid             VARCHAR2 (4),
   subsubreasonid          VARCHAR2 (4),
   methodid                VARCHAR2 (4),
   successid               VARCHAR2 (4),
   outcomeid               VARCHAR2 (4),
   cocstatus               VARCHAR2 (13),
   caseid                  NUMBER,
   hdmProviderRefId VARCHAR2(30),
   manualcareproviderid VARCHAR2(30),
   sourceproviderid VARCHAR2(50),
   CASERECOMMENDATIONID NUMBER
) 



--
-- FEEDBACK_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   FEEDBACK_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.FEEDBACK_OBJECT_ARRAY AS TABLE OF feedback_object 



--
-- FHIR_ALERTDETAILS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_alertdetails_obj IS OBJECT
(
trackingid number,
alertid varchar2(50),
alerttitle varchar2(255),
alertdesc varchar2(4000),
severity varchar2(50),
alertstatus varchar2(50),
alertdate date
);



--
-- FHIR_ALERTDETAILS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_ALERTDETAILS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_alertdetails_tab IS TABLE OF fhir_alertdetails_obj;



--
-- FHIR_ALLERGY_INTOLERANCE_OBJ  (Type) 
--
--  Dependencies: 
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   PROVIDER_OBJ (Type)
--   DT_ANNOTATION_OBJ (Type)
--   STANDARD (Package)
--   FHIR_CODING_OBJ (Type)
--   FHIR_IDENTIFIER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_allergy_intolerance_obj
IS OBJECT
(
allergyid fhir_identifier_obj,
onset	date,
recordeddt date,
recorder provider_obj,
allergen fhir_codeableconcept_obj,
allergystatus fhir_coding_obj,
allergycrticality fhir_coding_obj,
allergytype fhir_coding_obj,
allergycategory fhir_coding_obj,
note dt_annotation_obj,
allergyreactioncode fhir_codeableconcept_obj,
allergyseverity fhir_coding_obj
);



--
-- FHIR_ALLERGY_INTOLERANCE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_ALLERGY_INTOLERANCE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_allergy_intolerance_tab IS TABLE OF fhir_allergy_intolerance_obj;



--
-- FHIR_CE_RUNACTIONID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_ce_runactionid_obj
IS OBJECT
(
 productcd VARCHAR2(24)
,runactionid NUMBER
);



--
-- FHIR_CE_RUNACTIONID_TBL  (Type) 
--
--  Dependencies: 
--   FHIR_CE_RUNACTIONID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_ce_runactionid_tbl IS TABLE OF fhir_ce_runactionid_obj;



--
-- FHIR_CODEABLECONCEPT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_CODING_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_codeableconcept_obj IS OBJECT
(
 coding fhir_coding_obj
,text	VARCHAR2(255)
);



--
-- FHIR_CODEABLECONCEPT_TAB  (Type) 
--
--  Dependencies: 
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_codeableconcept_tab IS TABLE OF fhir_codeableconcept_obj;



--
-- FHIR_CODE_TIMEPERIOD_OBJ  (Type) 
--
--  Dependencies: 
--   FHIR_CODING_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_code_timeperiod_obj IS OBJECT
(
 code fhir_coding_obj
,startdt timestamp
,enddt timestamp
);



--
-- FHIR_CODE_TIMEPERIOD_TBL  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_CODE_TIMEPERIOD_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_code_timeperiod_tbl IS TABLE OF fhir_code_timeperiod_obj;



--
-- FHIR_CODING_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_coding_obj IS OBJECT
(
 system			VARCHAR2(4000)
,version		VARCHAR2(100)
,code			VARCHAR2(255)
,display		VARCHAR2(4000)
,userselected	VARCHAR2(1)
);



--
-- FHIR_CODING_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_CODING_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_coding_tab IS TABLE OF fhir_coding_obj;



--
-- FHIR_CONDITION_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_TAB (Type)
--   FHIR_IDENTIFIER_OBJ (Type)
--   STANDARD (Package)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_condition_obj IS OBJECT
(
 conditionid 			fhir_identifier_obj
,conditioncode          fhir_codeableconcept_obj
,category				fhir_codeableconcept_obj
,status					fhir_codeableconcept_obj
,verificationstatus		fhir_codeableconcept_obj
,severity				fhir_codeableconcept_obj
,bodysite				fhir_codeableconcept_obj
,notes					dt_annotation_tab
,conditionstartdt		timestamp
,conditionenddt			timestamp
,reporteddt				timestamp
,stage					fhir_codeableconcept_obj
,evidence				dt_ce_tab
,encounterid			fhir_identifier_obj
);



--
-- FHIR_CONDITION_TAB  (Type) 
--
--  Dependencies: 
--   FHIR_CONDITION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_condition_tab IS TABLE OF fhir_condition_obj;



--
-- FHIR_CONTACTPOINT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_contactpoint_obj IS OBJECT
(
 system			VARCHAR2(50)
,value			VARCHAR2(255)
,use			VARCHAR2(50)
,rank			NUMBER
,startdt		TIMESTAMP
,enddt			TIMESTAMP
);



--
-- FHIR_CONTACTPOINT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_CONTACTPOINT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_contactpoint_tab IS TABLE OF fhir_contactpoint_obj;



--
-- FHIR_DEVICE_OBJ  (Type) 
--
--  Dependencies: 
--   FHIR_LOCATION_OBJ (Type)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   STANDARD (Package)
--   FHIR_ORGANIZATION_OBJ (Type)
--   FHIR_CONTACTPOINT_OBJ (Type)
--   FHIR_IDENTIFIER_OBJ (Type)
--   DT_ANNOTATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_device_obj IS OBJECT
(
 deviceid			fhir_identifier_obj
,devicetype			fhir_codeableconcept_obj
,notes				dt_annotation_obj
,status				VARCHAR2(50)
,manufacturer		VARCHAR2(100)
,model				VARCHAR2(50)
,version			VARCHAR2(50)
,manufacturedate	DATE
,expiry				DATE
,uniquedeviceid		VARCHAR2(255)
,lotnbr				VARCHAR2(50)
,owner				fhir_organization_obj
,location			fhir_location_obj
,contact			fhir_contactpoint_obj
,url				VARCHAR2(4000)
);



--
-- FHIR_DEVICE_TAB  (Type) 
--
--  Dependencies: 
--   FHIR_DEVICE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_device_tab IS TABLE OF fhir_device_obj;



--
-- FHIR_ENCOUNTERLOCATION_OBJ  (Type) 
--
--  Dependencies: 
--   FHIR_LOCATION_OBJ (Type)
--   FHIR_CODING_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_encounterlocation_obj IS OBJECT
(
 location fhir_location_obj
,status	  fhir_coding_obj
,startdt  timestamp
,enddt    timestamp
);



--
-- FHIR_ENCOUNTERLOCATION_TAB  (Type) 
--
--  Dependencies: 
--   FHIR_ENCOUNTERLOCATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_encounterlocation_tab IS TABLE OF fhir_encounterlocation_obj;



--
-- FHIR_ENCOUNTER_OBJ  (Type) 
--
--  Dependencies: 
--   FHIR_CODE_TIMEPERIOD_TBL (Type)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   FHIR_ENCOUNTERLOCATION_OBJ (Type)
--   FHIR_CONDITION_TAB (Type)
--   FHIR_CONDITION_OBJ (Type)
--   FHIR_CODING_OBJ (Type)
--   FHIR_LOCATION_OBJ (Type)
--   FHIR_ORGANIZATION_OBJ (Type)
--   FHIR_PARTICIPANT_TAB (Type)
--   FHIR_PROCEDURE_TAB (Type)
--   STANDARD (Package)
--   FHIR_IDENTIFIER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_encounter_obj AS OBJECT (
   encounterid           		fhir_identifier_obj
  ,encounterstatus		 		fhir_coding_obj
  ,encounterstatushistory		fhir_code_timeperiod_tbl
  ,encounterclass        		fhir_coding_obj
  ,encountertype		 		fhir_codeableconcept_obj
  ,priority				 		fhir_codeableconcept_obj
  ,participant			 		fhir_participant_tab
  ,admitdate             		TIMESTAMP
  ,dischargedate         		TIMESTAMP
  ,admitreason           		fhir_codeableconcept_obj
  -- Hospitalization
  ,preadmissiontestindicator    VARCHAR2(1)
  ,origin						fhir_location_obj
  ,admitsource          		fhir_codeableconcept_obj
  ,admittingdiagnosis			fhir_condition_obj
  ,readmissionindicator			fhir_codeableconcept_obj
  ,dietpreference				fhir_codeableconcept_obj
  ,vipindicator					fhir_codeableconcept_obj
  ,specialarrangement			fhir_codeableconcept_obj
  ,dischargelocation			fhir_location_obj
  ,dischargedisposition 		fhir_codeableconcept_obj
  ,dischargediagnosis			fhir_condition_obj
  -- End
  ,indicationprocedure			fhir_procedure_tab
  ,indicationcondition			fhir_condition_tab
  ,encounterlocation			fhir_encounterlocation_obj
  ,admissiontype         		fhir_codeableconcept_obj
  ,custodianorg					fhir_organization_obj
  ,replacedencounterid    		fhir_identifier_obj
);



--
-- FHIR_ENCOUNTER_TAB  (Type) 
--
--  Dependencies: 
--   FHIR_ENCOUNTER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_encounter_tab IS TABLE OF fhir_encounter_obj;



--
-- FHIR_IDENTIFIER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_CODING_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_identifier_obj IS OBJECT
(
 iduse				VARCHAR2(50)
,identifiertype		fhir_coding_obj
,system				VARCHAR2(4000)
,value				VARCHAR2(4000)
,startdt			TIMESTAMP
,enddt				TIMESTAMP
);



--
-- FHIR_IDENTIFIER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_IDENTIFIER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_identifier_tab IS TABLE OF fhir_identifier_obj;



--
-- FHIR_IMMUNIZATION_OBJ  (Type) 
--
--  Dependencies: 
--   DT_ANNOTATION_OBJ (Type)
--   FHIR_LOCATION_OBJ (Type)
--   STANDARD (Package)
--   FHIR_IDENTIFIER_OBJ (Type)
--   PROVIDER_OBJ (Type)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   FHIR_CODING_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_immunization_obj
IS OBJECT
(
immunizationid fhir_identifier_obj,
immunizationstatus fhir_coding_obj,
negationind varchar2(1),
vaccinecode fhir_codeableconcept_obj,
encounterid fhir_identifier_obj,
administereddt date,
vaccinationlocation fhir_location_obj,
lotnbr number,
bodysitecd fhir_codeableconcept_obj,
vaccinationroute fhir_codeableconcept_obj,
doseqty number,
practitioner provider_obj,
note dt_annotation_obj,
reasoncd fhir_codeableconcept_obj,
reaction  fhir_codeableconcept_obj,
reactiontime date
)



--
-- FHIR_IMMUNIZATION_TAB  (Type) 
--
--  Dependencies: 
--   FHIR_IMMUNIZATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_immunization_tab IS TABLE OF fhir_immunization_obj



--
-- FHIR_LOCATION_OBJ  (Type) 
--
--  Dependencies: 
--   DT_ADDR_TAB (Type)
--   STANDARD (Package)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   FHIR_ORGANIZATION_OBJ (Type)
--   FHIR_IDENTIFIER_OBJ (Type)
--   DT_TEL_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_location_obj IS OBJECT
(
 locationid				fhir_identifier_obj
,name					VARCHAR2(200)
,description			VARCHAR2(255)
,telecom				dt_tel_tab
,address				dt_addr_tab
,locationtype			fhir_codeableconcept_obj
,managingorganization   fhir_organization_obj
);



--
-- FHIR_LOCATION_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_LOCATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_location_tab IS TABLE OF fhir_location_obj;



--
-- FHIR_MEDICATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   FHIR_ORGANIZATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_medication_obj IS OBJECT
(
medicationcode fhir_codeableconcept_obj,
isbrandedflg VARCHAR2(1),
manufacturer fhir_organization_obj,
productform fhir_codeableconcept_obj,
amount NUMBER,
lotnbr VARCHAR2(40),
expirationdt DATE,
container fhir_codeableconcept_obj
);



--
-- FHIR_MEDICATION_ORDER_OBJ  (Type) 
--
--  Dependencies: 
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   DT_ANNOTATION_OBJ (Type)
--   STANDARD (Package)
--   FHIR_IDENTIFIER_OBJ (Type)
--   FHIR_CODING_OBJ (Type)
--   FHIR_CONDITION_OBJ (Type)
--   PROVIDER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_medication_order_obj IS OBJECT
(
medicationorderid fhir_identifier_obj,
orderauthorizeddt date,
orderstatus fhir_coding_obj,
orderenddt date,
endreason fhir_codeableconcept_obj,
prescriber provider_obj,
encounterid fhir_identifier_obj,
medicationreason fhir_condition_obj,
note dt_annotation_obj,
medicationcode fhir_codeableconcept_obj,
dosagetext varchar2(255),
dosageinstructions varchar2(4000),
dosagetiming timestamp,
asneededcode fhir_codeableconcept_obj,
bodysite  fhir_codeableconcept_obj,
route fhir_codeableconcept_obj,
medicationmethod fhir_codeableconcept_obj,
medicationdoselow number,
medicationdosehigh number,
medicationstartdt date,
medicationenddt date,
validityperioddays number,
noofrefills NUMBER,
quantity number,
expectedsupplydurationdays number,
priorprescription fhir_identifier_obj
);



--
-- FHIR_MEDICATION_ORDER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_MEDICATION_ORDER_OBJ (Type)
--
CREATE OR REPLACE type ODS.FHIR_MEDICATION_ORDER_TAB as table of fhir_medication_order_obj



--
-- FHIR_OBSERVATION_OBJ  (Type) 
--
--  Dependencies: 
--   DT_ANNOTATION_OBJ (Type)
--   PROVIDER_OBJ (Type)
--   FHIR_IDENTIFIER_OBJ (Type)
--   STANDARD (Package)
--   FHIR_CODING_OBJ (Type)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_observation_obj FORCE IS OBJECT
(
observationid fhir_identifier_obj,
observationstatus fhir_coding_obj,
observationcategory fhir_codeableconcept_obj,
observationcode fhir_codeableconcept_obj,
encounterid fhir_identifier_obj,
effectivetime timestamp,
performer provider_obj,
resultquantity number,
resultcode fhir_codeableconcept_obj,
resultstring varchar2(4000),
resultrange varchar2(50),
resultabsencereason fhir_codeableconcept_obj,
interpretationcd fhir_codeableconcept_obj,
comments dt_annotation_obj,
bodysite fhir_codeableconcept_obj,
observationmethod fhir_codeableconcept_obj
)



--
-- FHIR_OBSERVATION_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_OBSERVATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_observation_tab IS TABLE OF fhir_observation_obj



--
-- FHIR_ORGANIZATION_OBJ  (Type) 
--
--  Dependencies: 
--   DT_ADDR_TAB (Type)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   DT_TEL_TAB (Type)
--   DT_SCP_OBJ (Type)
--   FHIR_IDENTIFIER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_organization_obj IS OBJECT
(
 orgid			fhir_identifier_obj
,active			VARCHAR2(1)
,orgtype		fhir_codeableconcept_obj
,name			VARCHAR2(255)
,telecom		dt_tel_tab
,address		dt_addr_tab
,contactperson	dt_scp_obj
)
;



--
-- FHIR_ORGANIZATION_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_ORGANIZATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_organization_tab IS TABLE OF fhir_organization_obj;



--
-- FHIR_PARTICIPANT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   PROVIDER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_participant_obj IS OBJECT
(
 participanttype			fhir_codeableconcept_obj
,startdt					timestamp
,enddt						timestamp
,practitioner				provider_obj
);



--
-- FHIR_PARTICIPANT_TAB  (Type) 
--
--  Dependencies: 
--   FHIR_PARTICIPANT_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_participant_tab IS TABLE OF fhir_participant_obj;



--
-- FHIR_PROCEDURE_OBJ  (Type) 
--
--  Dependencies: 
--   DT_ANNOTATION_TAB (Type)
--   FHIR_LOCATION_OBJ (Type)
--   STANDARD (Package)
--   FHIR_IDENTIFIER_OBJ (Type)
--   FHIR_DEVICE_OBJ (Type)
--   FHIR_CODEABLECONCEPT_OBJ (Type)
--   DT_II_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_procedure_obj IS OBJECT
(
 procedureid 			fhir_identifier_obj
,status					fhir_codeableconcept_obj
,category				fhir_codeableconcept_obj
,procedurecd			fhir_codeableconcept_obj
,performedflg			VARCHAR2(1)
,reasonnotperformed		fhir_codeableconcept_obj
,bodysite				fhir_codeableconcept_obj
,reasoncd				fhir_codeableconcept_obj
,performer				dt_ii_tab
,performedtime			timestamp
,encounterid			fhir_identifier_obj
,location				fhir_location_obj
,outcome				fhir_codeableconcept_obj
,complication			fhir_codeableconcept_obj
,followup				fhir_codeableconcept_obj
,notes					dt_annotation_tab
,focaldevice			fhir_device_obj
,useddevice				fhir_device_obj
--- To be added medicationsubstance
);



--
-- FHIR_PROCEDURE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   FHIR_PROCEDURE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.fhir_procedure_tab IS TABLE OF fhir_procedure_obj;



--
-- FHIR_QUANTITY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_quantity_obj IS OBJECT
(
 value		NUMBER
,comparator	VARCHAR2(5)
,unit		VARCHAR2(50)
,system		VARCHAR2(4000)
,code		VARCHAR2(50)
);



--
-- FHIR_QUANTITY_TAB  (Type) 
--
--  Dependencies: 
--   FHIR_QUANTITY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.fhir_quantity_tab IS TABLE OF fhir_quantity_obj;



--
-- FHIR_RECOMMENDATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.fhir_recommendation_obj
AS
  object
  (
    PRODUCTNM        VARCHAR2(255),
    OVERALLSCORENBR  NUMBER,
    ProgramIntensity VARCHAR2(12),
    SEVERITYLEVEL    VARCHAR2(12))



--
-- FHIR_RECOMMENDATION_TAB  (Type) 
--
--  Dependencies: 
--   FHIR_RECOMMENDATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.fhir_recommendation_tab
AS
  TABLE OF fhir_recommendation_obj



--
-- GC_CAMPAIGNPGMSCHEDULES_OBJ  (Type) 
--
--  Dependencies: 
--   GC_SESSIONS_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GC_CAMPAIGNPGMSCHEDULES_OBJ AS OBJECT(
COACHINGCLASSSCHEDULESKEY    NUMBER,
Availablemembercount        NUMBER,
Maxmembercount          NUMBER,
programcd               VARCHAR2 (12 Byte),
externalactivityid      VARCHAR2 (255 Byte),
ClassName               VARCHAR2 (100 Byte),
ClassStartDt            TIMESTAMP(6) WITH TIME ZONE,
ClassEndDt              TIMESTAMP(6) WITH TIME ZONE,
externalprogramid       VARCHAR2 (100 Byte),
externalcampaignid      VARCHAR2 (100 Byte),
coachName               VARCHAR2 (50 Byte),
DurationInMins          NUMBER,
SessionData             ODS.GC_SESSIONS_TAB           
);




--
-- GC_CAMPAIGNPGMSCHEDULES_TAB  (Type) 
--
--  Dependencies: 
--   GC_CAMPAIGNPGMSCHEDULES_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GC_CAMPAIGNPGMSCHEDULES_TAB AS TABLE OF ODS.GC_CAMPAIGNPGMSCHEDULES_OBJ;




--
-- GC_COACH_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GC_SCHEDULE_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.gc_coach_obj AS OBJECT (
   AALoginName   VARCHAR2(50)
   ,NurseNm      VARCHAR2(150)
   ,ScheduleObj  gc_schedule_tab
);



--
-- GC_COACH_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GC_COACH_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.gc_coach_tab AS TABLE OF gc_coach_obj;



--
-- GC_PROGRAM_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GC_COACH_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.gc_program_obj AS OBJECT (
   ProgramExternalId VARCHAR2(100)   
   ,CoachObj         gc_coach_tab
);



--
-- GC_PROGRAM_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GC_PROGRAM_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.gc_program_tab AS TABLE OF gc_program_obj;



--
-- GC_SCHEDULE_OBJ  (Type) 
--
--  Dependencies: 
--   GC_SESSION_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.gc_schedule_obj AS OBJECT (
   activityExternalId    VARCHAR2(255)
   ,activityType         VARCHAR2(200)
   ,activityNm           VARCHAR2(100)
   ,activityDesc         VARCHAR2(500)
   ,startDt              TIMESTAMP WITH TIME ZONE
   ,endDt                TIMESTAMP WITH TIME ZONE
   ,NumberOfSessions     NUMBER
   ,totalCapacity        NUMBER
   ,DurationInMins       NUMBER
   ,WebexLink            VARCHAR2(255)
   ,ConferenceNumber     VARCHAR2(20)
   ,AccessCode           VARCHAR2(20)
   ,StatusCode           VARCHAR2(50)
   ,StatusDt             TIMESTAMP
   ,StatusReason         VARCHAR2(50)
   ,SessionObj           gc_session_tab
);



--
-- GC_SCHEDULE_TAB  (Type) 
--
--  Dependencies: 
--   GC_SCHEDULE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.gc_schedule_tab AS TABLE OF gc_schedule_obj;



--
-- GC_SESSIONS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GC_SESSIONS_OBJ AS OBJECT(
COACHINGSCHEDULESESSIONSKEY     NUMBER,
SESSIONNM                       VARCHAR2 (255 Byte), 
EFFSTARTDT                      TIMESTAMP(6) WITH TIME ZONE, 
EFFENDDT                        TIMESTAMP(6) WITH TIME ZONE
);




--
-- GC_SESSIONS_TAB  (Type) 
--
--  Dependencies: 
--   GC_SESSIONS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GC_SESSIONS_TAB AS TABLE OF ODS.GC_SESSIONS_OBJ;




--
-- GC_SESSION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.gc_session_obj AS OBJECT (
  sessionNm           VARCHAR2(255)
  ,sessionOrderNumber  NUMBER
  ,sessionStartDt      TIMESTAMP WITH TIME ZONE
  ,sessionEndDt        TIMESTAMP WITH TIME ZONE  
); 



--
-- GC_SESSION_TAB  (Type) 
--
--  Dependencies: 
--   GC_SESSION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.gc_session_tab AS TABLE OF gc_session_obj;



--
-- GETAAHRA_ANSWER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_ANSWER_OBJ" 
as object(Answerindexid nUMBER,
               
                  Responsetext varchar2(4000),
               responsescore NUMBER,
               TransactionDate date); 



--
-- GETAAHRA_ANSWER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETAAHRA_ANSWER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_ANSWER_TAB" 
as table of getaahra_answer_obj; 



--
-- GETAAHRA_OBJ  (Type) 
--
--  Dependencies: 
--   GETAAHRA_RESPONSE_TAB (Type)
--   GETAAHRA_UM_RESPONSE_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_OBJ" 
AS
   OBJECT (questionindexid NUMBER,
           transationdate DATE,
           datasource VARCHAR2 (20),
           responsetext getaahra_response_tab,
           um_responsetext getaahra_um_response_tab); 



--
-- GETAAHRA_QUESTION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_QUESTION_OBJ" 
AS
   object (memberplanidentifier NUMBER,
               datasourcenm VARCHAR2(20),
               questionindexid NUMBER,
               surveydt date,
               transactiondate date,
               FEEDSOURCENM varchar2(20)); 



--
-- GETAAHRA_QUESTION_TAB  (Type) 
--
--  Dependencies: 
--   GETAAHRA_QUESTION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_QUESTION_TAB" 
AS table of getaahra_question_obj; 



--
-- GETAAHRA_RESPONSE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_RESPONSE_OBJ" 
AS
   OBJECT (answerindexid NUMBER,
           responsetext varchar2 (4000),
           FEEDSOURCENM varchar2 (20)); 



--
-- GETAAHRA_RESPONSE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETAAHRA_RESPONSE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_RESPONSE_TAB" 
AS
   TABLE OF getaahra_response_obj; 



--
-- GETAAHRA_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETAAHRA_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_TAB" 
AS
   TABLE OF getaahra_obj 



--
-- GETAAHRA_UM_RESPONSE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_UM_RESPONSE_OBJ" 
AS
   OBJECT (RESPONSETEXT varchar2 (4000)); 



--
-- GETAAHRA_UM_RESPONSE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETAAHRA_UM_RESPONSE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETAAHRA_UM_RESPONSE_TAB" 
AS
   TABLE OF getaahra_um_response_obj; 



--
-- GETALLMECDARUNACTIONID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.getallmecdarunactionid_obj
IS
   OBJECT (cerunactonid number);



--
-- GETALLMECDARUNACTIONID_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETALLMECDARUNACTIONID_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.getallmecdarunactionid_tab
AS
   TABLE OF getallmecdarunactionid_obj;



--
-- GETBATCHMBRPLANID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETBATCHMBRPLANID_OBJ
IS
OBJECT
( HDMSPATIENTID VARCHAR2(50 BYTE),
 HDMSSUPPLIERID VARCHAR2(50 BYTE),
 SORGID VARCHAR2(50 BYTE),
 MEMBERPLANID NUMBER,
 RETURNCODE VARCHAR2(10 BYTE),
 aggregatememberid NUMBER
)



--
-- GETBATCHMBRPLANID_TAB  (Type) 
--
--  Dependencies: 
--   GETBATCHMBRPLANID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETBATCHMBRPLANID_tab is table of GETBATCHMBRPLANID_OBJ



--
-- GETCCREFDATA_OUT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETCCREFDATA_OUT_OBJ
AS
   OBJECT (REFERENCEABBR VARCHAR2 (40),
           REFERENCETITLE VARCHAR2 (500),
           VOLUMEPAGE VARCHAR2 (200)); 



--
-- GETCCREFDATA_OUT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETCCREFDATA_OUT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.GETCCREFDATA_OUT_TAB
AS
   TABLE OF ODS.GETCCREFDATA_OUT_OBJ; 



--
-- GETCOMM_COMMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETCOMM_FDBKLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.GETCOMM_COMMLIST_OBJ
AS
   OBJECT (commtrackingid NUMBER,
           commid NUMBER,
           mecommtype varchar2 (24),
           mecommtitle varchar2 (2000),
           mecommdesc varchar2 (4000),
           communicationcreatedate date,
           appendtext VARCHAR2 (4000),
           mefdblist getcomm_fdbklist_tab);





--
-- GETCOMM_COMMLIST_TAB  (Type) 
--
--  Dependencies: 
--   GETCOMM_COMMLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETCOMM_COMMLIST_TAB
AS
   TABLE OF getcomm_commlist_obj;




--
-- GETCOMM_FDBKLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETCOMM_FDBKLIST_OBJ"
AS
   OBJECT (commfdbdate date,
           commfdbstatus varchar2 (12),
           commfdbstatusreason NUMBER,
           comments VARCHAR2 (4000),
           commfdbsource VARCHAR2 (20 BYTE)); 



--
-- GETCOMM_FDBKLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETCOMM_FDBKLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETCOMM_FDBKLIST_TAB"
AS
   TABLE OF getcomm_fdbklist_obj; 



--
-- GETCONSENTDIRECTIVE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CONSENTRULE_TAB (Type)
--
CREATE OR REPLACE type ODS.getconsentdirective_obj
as object
(  memberplanid                 number,
   patid                        varchar2(100),
   assngauthority               varchar2(64),
   consentpolicy                varchar2(100),
   impactedinfoitem             varchar2(100),
   provorgoid                   varchar2(64),
   provorgnm                    varchar2(300),
   careprovid                   number,
   careprovnm                   varchar2(300),
   consentdirectivestatus       varchar2(100),
   consentruleslist             consentrule_tab,
   rulecombalg                  varchar2(100),
   lastupdated                  date
);



--
-- GETCONSENTDIRECTIVE_TAB  (Type) 
--
--  Dependencies: 
--   GETCONSENTDIRECTIVE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.getconsentdirective_tab is table of  getconsentdirective_obj;



--
-- GETCONSENT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETCONSENTDIRECTIVE_TAB (Type)
--
CREATE OR REPLACE type ODS.getconsent_obj
as object
(accountoid               varchar2(64),
 memberplanid             number,
 patid                    varchar2(100),
 assngauthority           varchar2(64),
 consentrequestor         varchar2(4),
 returncode               number,
 lastupdateddt            date,
 getconsentdirective      getconsentdirective_tab);



--
-- GETHIEADDRINFOFORPROV_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETHIEADDRINFOFORPROV_OBJ AS
   OBJECT (
   AddressInstanceID   NUMBER,
AddressLine1        varchar2 (50),
AddressLine2        varchar2 (50),
AddressLine3        varchar2 (50),
City                varchar2 (50),
State               varchar2 (2),
ZipCode             varchar2 (9),
Country             varchar2 (50),
AddressType         varchar2(20));




--
-- GETHIEADDRINFOFORPROV_TAB  (Type) 
--
--  Dependencies: 
--   GETHIEADDRINFOFORPROV_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETHIEADDRINFOFORPROV_TAB AS table of GETHIEADDRINFOForProv_OBJ;




--
-- GETHIEADDRINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETHIEADDRINFO_OBJ AS
   OBJECT (
AddressLine1        varchar2 (50),
AddressLine2        varchar2 (50),
AddressLine3        varchar2 (50),
City                varchar2 (50),
State               varchar2 (2),
ZipCode             varchar2 (9),
Country             varchar2 (50));




--
-- GETHIEADDRINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETHIEADDRINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.GETHIEADDRINFO_TAB IS TABLE OF gethieaddrinfo_obj




--
-- GETHIEENROLLMENTINFOINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETHIEENROLLMENTINFOINFO_OBJ
AS OBJECT
(
Component      varchar2(12),
Attribute       VARCHAR2(100),
Value           VARCHAR2(12)
);




--
-- GETHIEENROLLMENTINFOINFO_TAB  (Type) 
--
--  Dependencies: 
--   GETHIEENROLLMENTINFOINFO_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETHIEENROLLMENTINFOINFO_TAB as table of GETHIEENROLLMENTINFOINFO_OBJ;




--
-- GETHIEPHONEINFOFORPROV_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETHIEPHONEINFOFORPROV_OBJ AS
   OBJECT (PhoneInstanceID     NUMBER,
           PhoneNumber varchar2 (30),
           PhoneExt varchar2 (30),
           PhoneType varchar2 (20),
           PhoneUsageType varchar2 (20),
           PhoneLocationCode varchar2 (12)
           );




--
-- GETHIEPHONEINFOFORPROV_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETHIEPHONEINFOFORPROV_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.GETHIEPHONEINFOFORPROV_TAB IS TABLE OF GetHIEPhoneInfoForProv_Obj;




--
-- GETHIEPHONEINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETHIEPHONEINFO_OBJ AS
   OBJECT (PhoneNumber varchar2 (30),
           PhoneExt varchar2 (30),
           PhoneType varchar2 (20),
           PhoneUsageType varchar2 (20),
           PhoneLocationCode varchar2 (12)
           );




--
-- GETHIEPHONEINFO_TAB  (Type) 
--
--  Dependencies: 
--   GETHIEPHONEINFO_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETHIEPHONEINFO_TAB IS TABLE OF GetHIEPhoneInfo_Obj;




--
-- GETLBS_NEW_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.getlbs_new_obj AS OBJECT (
   memberid              NUMBER
  ,ahmsupplierid         NUMBER
  ,membertypecode        VARCHAR2 (5)
  ,effectiveenddt        DATE
  ,relatedahmbusinesssupplierid NUMBER
  ,usagemnemonic         VARCHAR2 (1)
); 



--
-- GETLBS_NEW_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETLBS_NEW_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.getlbs_new_tab AS TABLE OF getlbs_new_obj 



--
-- GETLBS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETLBS_OBJ" AS
   OBJECT
(memberid NUMBER,
  ahmsupplierid NUMBER,
  MEMBERTYPECODE varchar2(5),
 EFFECTIVEENDDT DATE,
RELATEDAHMBUSINESSSUPPLIERID NUMBER)



--
-- GETLBS_TAB  (Type) 
--
--  Dependencies: 
--   GETLBS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETLBS_TAB" as table of GETLBS_OBJ



--
-- GETMBRSSRESPTXT_OUT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETMBRSSRESPTXT_OUT_OBJ
AS
   OBJECT (ANSWERINDEXID     NUMBER,
           RESPONSETEXT      VARCHAR2(4000),
           RESPONSESCORE     NUMBER,
           TRANSACTIONDATE   DATE           
          ); 



--
-- GETMBRSSRESPTXT_OUT_TAB  (Type) 
--
--  Dependencies: 
--   GETMBRSSRESPTXT_OUT_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETMBRSSRESPTXT_OUT_TAB 
AS
  TABLE OF GETMBRSSRESPTXT_OUT_OBJ; 



--
-- GETMEMBERSSHRA_IN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETMEMBERSSHRA_IN_OBJ
AS
   OBJECT (QuestionIdxID NUMBER); 



--
-- GETMEMBERSSHRA_IN_TAB  (Type) 
--
--  Dependencies: 
--   GETMEMBERSSHRA_IN_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETMEMBERSSHRA_IN_TAB
AS
   TABLE OF ODS.GETMEMBERSSHRA_IN_OBJ; 



--
-- GETMEMBERSSHRA_OUT_OBJ  (Type) 
--
--  Dependencies: 
--   GETMBRSSRESPTXT_OUT_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETMEMBERSSHRA_OUT_OBJ
AS
   OBJECT (TRANSACTIONDATE DATE,
           QUESTIONINDEXID NUMBER,
           RESPONSELIST    GETMBRSSRESPTXT_OUT_TAB); 



--
-- GETMEMBERSSHRA_OUT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETMEMBERSSHRA_OUT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.GETMEMBERSSHRA_OUT_TAB
AS
   TABLE OF ODS.GETMEMBERSSHRA_OUT_OBJ; 



--
-- GETMESSAGELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETMESSAGELIST_OBJ force
AS
   OBJECT (MessageTrackingID number,
           message  varchar2(4000),
           MessageCreateDT date,
           MessageReadFlag  varchar2(1),
           MessageSystemSource varchar2 (20),
           NURSEUSERID varchar2 (20),
           NURSENM varchar2 (150),
           AAPhone varchar2(10),
           AAMAINPHONEEXTNBR varchar2 (10),
           MessageTypeIndicator char(1),
           TopicCode varchar2(4),
           TopicDescription varchar2(300)
           ) 



--
-- GETMESSAGELIST_TAB  (Type) 
--
--  Dependencies: 
--   GETMESSAGELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.getmessagelist_tab FORCE 
as table of getmessagelist_obj 



--
-- GETMESSAGE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETMESSAGELIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.getmessage_obj FORCE
as object (SubjectTrackingID number,
SUBJECTTXT  varchar2(100),
LastUpdate date,
SubjectCreateDT date,
SubjectSystemSource varchar2(20),
MessageList getmessagelist_tab
) 



--
-- GETMESSAGE_TAB  (Type) 
--
--  Dependencies: 
--   GETMESSAGE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.getmessage_tab FORCE
as table of getmessage_obj 



--
-- GETMHSJUSTIFICATIONFORDATA_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETMHSJUSTIFICATIONFORDATA_OBJ"
AS
   OBJECT (MEDICALCODETYPE VARCHAR2 (20 BYTE),
           MEDICALCODE VARCHAR2 (100 BYTE),
           CODESYSTEM VARCHAR2 (200 BYTE),
           codeName VARCHAR2 (2000 BYTE),
           startdate date,
           enddate date,
           SOURCETRACKINGID NUMBER,
           ClinicalDataValue varchar2 (50),
           ClinicalDataUnits varchar2 (50),
           DATASOURCE VARCHAR2 (50 BYTE)); 



--
-- GETMHSJUSTIFICATIONFORDATA_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETMHSJUSTIFICATIONFORDATA_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETMHSJUSTIFICATIONFORDATA_TAB"
AS
   TABLE OF getmhsjustificationfordata_obj; 



--
-- GETMHSJUSTIFICATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETMHSJUSTIFICATION_OBJ"
AS
   OBJECT (mhs_tracking_id NUMBER,
           returncode varchar2 (5),
           MEMBERDERIVEDFACTID NUMBER); 



--
-- GETMHSJUSTIFICATION_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETMHSJUSTIFICATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETMHSJUSTIFICATION_TAB"
AS
   TABLE OF getmhsjustification_obj; 



--
-- GETMHS_DATA_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETMHS_DATA_REQ_OBJ"
AS
   OBJECT (MHSTRACKINGID NUMBER, MHSTYPE VARCHAR2 (50 BYTE)); 



--
-- GETMHS_DATA_REQ_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETMHS_DATA_REQ_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETMHS_DATA_REQ_TAB"
AS
   TABLE OF getmhs_data_req_obj; 



--
-- GETMHS_DATA_RESP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETMHSJUSTIFICATIONFORDATA_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."GETMHS_DATA_RESP_OBJ"
AS
   OBJECT (MHSTrackingID NUMBER,
           ReturnCode NUMBER,
           JustificationList getmhsjustificationfordata_tab); 



--
-- GETMHS_DATA_RESP_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETMHS_DATA_RESP_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETMHS_DATA_RESP_TAB"
AS
   TABLE OF getmhs_data_resp_obj; 



--
-- GETPERSONELDTLSADDRINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETPERSONELDTLSADDRINFO_OBJ"
AS
   OBJECT (addressinstanceid number,
           addressline1 varchar2 (50),
           addressline2 varchar2 (50),
           addressline3 varchar2 (50),
           city varchar2 (50),
           state varchar2 (2),
           zipcode varchar2 (9),
           country varchar2 (50),
           addresstype varchar2 (20),
           datasourcename varchar2 (20),
           updateddate date,
           effectiveenddt date);




--
-- GETPERSONELDTLSADDRINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPERSONELDTLSADDRINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETPERSONELDTLSADDRINFO_TAB"
IS
   TABLE OF getpersoneldtlsaddrinfo_obj;




--
-- GETPERSONELDTLSPHONEINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETPERSONELDTLSPHONEINFO_OBJ"
AS
   OBJECT (phoneinstanceid number,
           phonenumber varchar2 (30),
           phoneext varchar2 (30),
           phonetype varchar2 (20),
           phoneusagetype varchar2 (20),
           phonelocationcode varchar2 (12),
           datasourcename varchar2 (20),
           updateddate date,
           effectiveenddt date);




--
-- GETPERSONELDTLSPHONEINFO_TAB  (Type) 
--
--  Dependencies: 
--   GETPERSONELDTLSPHONEINFO_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETPERSONELDTLSPHONEINFO_TAB"
IS
   TABLE OF getpersoneldtlsphoneinfo_obj




--
-- GETPHRHRAQA_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETPHRHRAQA_OBJ
as
OBJECT
( QUESTIONINDEXID  NUMBER,
  ANSWERINDEXID    NUMBER,
  RESPONSETEXT     VARCHAR2(4000),
  RESPONSEDT       TIMESTAMP(6),
  RECORDUPDTDT     TIMESTAMP(6)
)



--
-- GETPHRHRAQA_TAB  (Type) 
--
--  Dependencies: 
--   GETPHRHRAQA_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETPHRHRAQA_TAB AS TABLE OF GETPHRHRAQA_OBJ



--
-- GETPHRHRA_ANS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GETPHRHRA_ANS_OBJ
as
object
( ANSWERINDEXID    NUMBER,
  TRANSACTIONDATE  DATE,
  SYSTEMSOURCE     VARCHAR2(20 BYTE),
  RESPONSETEXT     VARCHAR2(4000 BYTE),
  FEEDSOURCENM     VARCHAR2(20 BYTE));



--
-- GETPHRHRA_ANS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPHRHRA_ANS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.GETPHRHRA_ANS_TAB AS TABLE OF GETPHRHRA_ANS_OBJ;



--
-- GETPHRHRA_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPHRHRA_ANS_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.GETPHRHRA_OBJ
AS
   OBJECT (QUESTIONINDEXID NUMBER, responselist GETPHRHRA_ANS_TAB);



--
-- GETPHRHRA_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPHRHRA_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.GETPHRHRA_TAB AS TABLE OF GETPHRHRA_OBJ;



--
-- GETPMFDBK_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETPMFDBK_OBJ"
AS
   OBJECT (MARKERFDBDATE date,
           MARKERFDBSTATUS varchar2 (24),
           MARKERCOMMENTS varchar2 (4000),
           MARKERFDBSOURCE varchar2 (20)); 



--
-- GETPMFDBK_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPMFDBK_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."GETPMFDBK_TAB" AS TABLE OF getpmfdbk_obj; 



--
-- GETPMLST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPMSRC_TAB (Type)
--   GETPMFDBK_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.getpmlst_obj
AS
   OBJECT (markerid NUMBER,
           markertitle VARCHAR2 (2000),
           markerchronic VARCHAR2 (2 BYTE),
           MARKERTYPECODE VARCHAR2 (30),
           impactableflg VARCHAR2(1),
           MKSTATUS VARCHAR2 (30),
           MKSEVERITY VARCHAR2 (15),
           CLNCONDABBREV varchar2 (100),
           markersourcelist getpmsrc_tab,
           markerfdb getpmfdbk_tab)



--
-- GETPMLST_TAB  (Type) 
--
--  Dependencies: 
--   GETPMLST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.getpmlst_tab
as
table of getpmlst_obj



--
-- GETPMSRC_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETPMSRC_OBJ"
AS
   OBJECT (markertrackingid NUMBER,
           markersource varchar2 (30),
           markercreatedate date,
           markerdiagdate date); 



--
-- GETPMSRC_TAB  (Type) 
--
--  Dependencies: 
--   GETPMSRC_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."GETPMSRC_TAB" AS TABLE OF getpmsrc_obj; 



--
-- GETPRODUCTMARKER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPMLST_TAB (Type)
--
CREATE OR REPLACE type ODS.getproductmarker_obj
as
object(PRODUCTCD_IN varchar2(20),
               TOTALOPPORTUNITYSCORE  NUMBER,
               RunDate date,
               RECOMMENDATIONFLG  varchar2(12),
               PROGRAMINTENSITY  varchar2(12),
               PROGRAMTRACK VARCHAR2(12),
               MarkerList getpmlst_tab)



--
-- GETPRODUCTMARKER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPRODUCTMARKER_OBJ (Type)
--
CREATE OR REPLACE type ODS.getproductmarker_TAB
as
table of getproductmarker_obj



--
-- GET_HOMEWORKFORMEMBER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GET_HOMEWORKFORMEMBER_OBJ
AS
  OBJECT (
  SOURCETRACKINGID            NUMBER,
  MEMBERHOMEWORKID            NUMBER,
  COMMENTS                    VARCHAR2(4000),
  STATUS                      VARCHAR2(12),
  STATUSDT                    DATE,
  HOMEWORKSTDT                DATE, -- ADDED BY LIBINUS ON 07172014
  HOMEWORKENDDT               DATE, -- ADDED BY LIBINUS ON 07172014
  HOMEWORKVALUE               VARCHAR2(200),    
  HOMEWORKTEXTCD              VARCHAR2(12),
  HOMEWORKCATCD               VARCHAR2(12), -- ADDED BY LIBINUS ON 07172014
  MEDIATYPE                   VARCHAR2(24),
  MEDIAPATH                   VARCHAR2(600),
  MEDIATITLE                  VARCHAR2(255),
  LASTUPDATEDATE              DATE,
  DELETEDBYSOURCE             VARCHAR2(20),
  UPDATESOURCENAME            VARCHAR2(20)
) 



--
-- GET_HOMEWORKFORMEMBER_TAB  (Type) 
--
--  Dependencies: 
--   GET_HOMEWORKFORMEMBER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GET_HOMEWORKFORMEMBER_TAB IS TABLE OF GET_HOMEWORKFORMEMBER_OBJ 



--
-- GET_IMMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GET_IMMLIST_OBJ
AS
   OBJECT (IMMUINSTANCEID NUMBER,
           CODESYSTEMNAME VARCHAR2 (200),
           MEDICALCODE VARCHAR2 (100),
           IMMUNIZATIONNAME VARCHAR2 (100),
           STARTDATE DATE,
           ENDDATE DATE,
           RECORDUPDATEDATE DATE,
           MOODCD VARCHAR2 (10),
           FEEDSOURCENM VARCHAR2 (20),
           C32STATUSDESC VARCHAR2 (200),
           CAREPROVIDERID NUMBER,
           IMMUNIZATIONPROVIDERNAME VARCHAR2 (200),
           SERVICINGORGNAME VARCHAR2 (100));



--
-- GET_IMMLIST_TAB  (Type) 
--
--  Dependencies: 
--   GET_IMMLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GET_IMMLIST_TAB IS TABLE OF GET_IMMLIST_OBJ;



--
-- GET_LABRESULT_MAH_OBJ  (Type) 
--
--  Dependencies: 
--   GET_LABRESULT_SUBLIST_MAH_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GET_LABRESULT_MAH_OBJ FORCE as object
(
  UPDATESOURCENAME         VARCHAR2(20),
  SERVICEDATE              DATE,
  FEEDSOURCENM             VARCHAR2(20),
  LABCOMPONENTNAME         VARCHAR2(20),
  LABRESULTSUBLIST         GET_LABRESULT_SUBLIST_MAH_TAB
)



--
-- GET_LABRESULT_MAH_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GET_LABRESULT_MAH_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.GET_LABRESULT_MAH_TAB FORCE is table of GET_LABRESULT_MAH_OBJ



--
-- GET_LABRESULT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GET_LABRESULT_OBJ
AS
   OBJECT (SOURCETRACKINGID NUMBER,
           ODSTRACKINGID NUMBER,
           UPDATESOURCENAME VARCHAR2 (20),
           LABTESTNAME VARCHAR2 (500),
           MEDICALCODE VARCHAR2 (100),
           CODESYSTEMNAME VARCHAR2 (200),
           SERVICEDATE DATE,
           LABTESTNUMERICRESULT NUMBER,
           LABTESTMAXIMUMVALUE NUMBER,
           LABTESTMINIMUMVALUE NUMBER,
           DRUGUNITOFMEASURE VARCHAR2 (30),
           LABTESTNONNUMERICRESULT VARCHAR2 (200),
           LABTESTABNORMALINDICATOR VARCHAR2 (15),
           CAREPROVIDERID NUMBER,
           CHANNEL VARCHAR2 (5),
           COMMENTS VARCHAR2 (4000),
           LASTUPDATEDATE DATE,
           DELETEDBYSOURCE VARCHAR2 (20),
           FEEDSOURCENM VARCHAR2 (20),
           RECORDUPDATEDATE DATE,
           C32STATUSDESC VARCHAR2 (200),
           SERVICINGORGNAME VARCHAR2 (100));



--
-- GET_LABRESULT_SUBLIST_MAH_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GET_LABRESULT_SUBLIST_MAH_OBJ as object
(
  ODSTRACKINGID            NUMBER,
  SOURCETRACKINGID         NUMBER,
  LABTESTNAME              VARCHAR2(500),
  MEDICALCODE              VARCHAR2(10),
  CODESYSTEMNAME           VARCHAR2(20),
  LABTESTNUMERICRESULT     NUMBER,
  LABTESTMAXIMUMVALUE      NUMBER,
  LABTESTMINIMUMVALUE      NUMBER,
  DRUGUNITOFMEASURE        VARCHAR2(30),
  LABTESTNONNUMERICRESULT  VARCHAR2(20),
  COMMENTS                 VARCHAR2(4000)
)



--
-- GET_LABRESULT_SUBLIST_MAH_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GET_LABRESULT_SUBLIST_MAH_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.GET_LABRESULT_SUBLIST_MAH_TAB is table of GET_LABRESULT_SUBLIST_MAH_OBJ



--
-- GET_LABRESULT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GET_LABRESULT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.GET_LABRESULT_TAB IS TABLE OF GET_LABRESULT_OBJ;



--
-- GET_LABSUMRES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GET_LABSUMRES_OBJ
AS
   OBJECT (PATIENTLABRESULTSID NUMBER,
           CODESYSTEMNAME VARCHAR2 (200),
           MEDICALCODE VARCHAR2 (100),
           LABTESTNAME VARCHAR2 (500),
           SERVICEDATE DATE,
           LABTESTNUMERICRESULT NUMBER,
           DRUGUNITOFMEASURE VARCHAR2 (30),
           LABTESTNONNUMERICRESULT VARCHAR2 (200),
           LABTESTABNORMALINDICATOR VARCHAR2 (15),
           FEEDSOURCENM VARCHAR2 (20),
           C32STATUSDESC VARCHAR2 (200),
           CAREPROVIDERID NUMBER,
           SERVICINGORGNAME VARCHAR2 (100));



--
-- GET_LABSUMRES_TAB  (Type) 
--
--  Dependencies: 
--   GET_LABSUMRES_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.GET_LABSUMRES_TAB IS TABLE OF GET_LABSUMRES_OBJ;



--
-- HEALTHTRACKVALLST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."HEALTHTRACKVALLST_OBJ"
AS
   OBJECT (medicalcode VARCHAR2 (50),
           codetype VARCHAR2 (50),
           healthtrackername VARCHAR2 (35),
           healthtrackercomponentname VARCHAR2 (35),
           channelcode VARCHAR2 (20),
           labtestnumericresult NUMBER,
           labtestnonnumericresult VARCHAR2 (200),
           unitofmeasure VARCHAR2 (30),
           servicedt DATE,
           updtsourcenm VARCHAR2 (20),
           transactiondt DATE,
           odstrackingid NUMBER,
           sourcetrackingid NUMBER,
           comments VARCHAR2 (4000),
           deletedbydatasourcenm VARCHAR2 (20),
           measurementdt DATE);



--
-- HEALTHTRACKVALLST_TAB  (Type) 
--
--  Dependencies: 
--   HEALTHTRACKVALLST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."HEALTHTRACKVALLST_TAB"
AS
   TABLE OF healthtrackvallst_obj;



--
-- HIECCFEEDBACK_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CCUSER_OBJ (Type)
--
CREATE OR REPLACE type ODS.hieccfeedback_obj as object
(accountoid             varchar2(64),
cctrackingid             number,
ccfbstatusreasoncode     number,
feedbackdate             date,
submittedbyuser             ccuser_obj,
issuedbyuser             ccuser_obj,
returncode               number);



--
-- HIE_ACTRELATIONSHIP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_actrelationship_obj
IS OBJECT
(
   entryrelationshipid                     dt_ii_obj,
   typecode                                VARCHAR2 (100),
   inversionind                            VARCHAR2 (1),
   contextconductionind                    VARCHAR2 (1),
   sequencenumber                          NUMBER,
   actionnegationind                       VARCHAR2 (1),
   seperatableind                          VARCHAR2 (1),
   sourceactid                             hie_iiextn_obj,
   sourceactclasscode                      VARCHAR2 (100),
   targetactid                             hie_iiextn_obj,
   targetactclasscode                      VARCHAR2 (100),
   action                                  VARCHAR2 (20),
   effectivestartdate                      DATE,
   effectiveenddate                        DATE,
   replacementid                           hie_iiextn_obj,
   response                                hie_sectionresponse_obj   -- added for CM

);



--
-- HIE_ACTRELATIONSHIP_TAB  (Type) 
--
--  Dependencies: 
--   HIE_ACTRELATIONSHIP_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_actrelationship_tab IS TABLE OF hie_actrelationship_obj;



--
-- HIE_ADDRESS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_ADDRESS_OBJ
AS
   OBJECT (
      addressline1 varchar2 (50),
      addressline2 varchar2 (50),
      addressline3 varchar2 (50),
      city varchar2 (50),
      state varchar2 (50),
      zipcode varchar2 (50),
      country varchar2 (50)
   );





--
-- HIE_ADDRESS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_ADDRESS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.HIE_ADDRESS_TAB
AS
   TABLE OF hie_address_obj;





--
-- HIE_ALLDOMAIN_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_HIERARCHY_TAB (Type)
--   HIE_DOMAINLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_alldomain_obj AS OBJECT (
   accountoid            VARCHAR2 (64)
  ,accountid             NUMBER
  ,domainlist            hie_domainlist_tab
  ,HIERARCHY             hie_hierarchy_tab
  ,accounttype           VARCHAR2 (1)
);



--
-- HIE_ALLDOMAIN_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_ALLDOMAIN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_alldomain_tab IS TABLE OF hie_alldomain_obj;



--
-- HIE_ALLERGIES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_IIEXTN_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_RELTYPE_OBJ (Type)
--   HIE_PROBLEMS_TAB (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_CE_TAB (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.HIE_ALLERGIES_OBJ AS OBJECT (
   allergyid                               dt_ii_obj,
   allergycode                             dt_ce_obj,
   effectime                               dt_ivl_ts_obj,
   allergen                                dt_ce_obj,
   allergystatus                           dt_ce_obj,
   reaction                                dt_ce_tab,
   severity                                dt_ce_obj,
   treatingprov                            dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   servicinglocation                       dt_ii_obj,
   informant                               hie_informant_obj,
   sectiontype                             dt_ce_obj,
   recordtarget                            dt_ii_obj,
   negationind                             VARCHAR2 (5),
   docauthor                               hie_iiextn_obj,   -- added for CM
   replacedallergyid                       hie_reltype_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj,   -- added for CM
   patientreaction                         HIE_PROBLEMS_TAB, -- added for User story 14.01
   IntoleranceFlg                          VARCHAR2(1), -- added for User story 14.09
   odsinstanceid                           NUMBER, -- added for User story 14.09 , this patientallergyskey   
   allergyseverity                         dt_ce_obj 
) 



--
-- HIE_ALLERGIES_TAB  (Type) 
--
--  Dependencies: 
--   HIE_ALLERGIES_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_ALLERGIES_TAB IS TABLE OF HIE_ALLERGIES_OBJ 



--
-- HIE_CLINDOCSUMMARY_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   HIE_ENCOMPSERVICEEVENT_TAB (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   HIE_RECORDTARGET_OBJ (Type)
--   HIE_ENCOMPENC_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_clindocsummary_obj AS OBJECT (
   accountoid                              dt_ii_obj,
   docid                                   dt_ii_obj,
   doccode                                 dt_ce_obj,
   docformat                               dt_ce_obj,
   doctitle                                VARCHAR2 (100),
   docefftime                              TIMESTAMP,
   docsource                               hie_informant_obj,
   doccustodian                            dt_ii_obj,
   docrelparentid                          hie_reltype_obj,
   docsetid                                dt_ii_obj,
   docversionid                            NUMBER,
   encompenc                               hie_encompenc_obj,
   encserviceevnt                          hie_encompserviceevent_tab,
   recordtarget                            hie_recordtarget_obj,
   confidentialitycode                     dt_ce_obj,
   memberplanid                            NUMBER,   -- added for CM
   sourcesystem                            VARCHAR2 (50),   -- added for CM
   docauthor                               hie_iiextn_obj,   -- added for CM
   odsencounterid                          NUMBER,   -- added for CM,
   ahmflag                                 VARCHAR2 (20),
   claimamounttotal                        NUMBER,   -- added for 837
   patientamountpaid                       NUMBER,   -- added for 837
   custodiansourceid                       VARCHAR2(50), -- added for 837
   custodiansourcename                     VARCHAR2(100), -- added for 837
   healthplan                              VARCHAR2(50), -- added for 837
   groupnumber                             VARCHAR2(50),    -- added for 837
   taxonomy                                dt_ii_obj, -- added for 837
   claimfrequencytype                      number, -- Mantis 20192
   originalreferenceid                     varchar2(25) -- Mantis 20192
);



--
-- HIE_CLININB_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_ENCOUNTERS_TAB (Type)
--   HIE_CLINDOCSUMMARY_OBJ (Type)
--   HIE_ALLERGIES_TAB (Type)
--   HIE_ACTRELATIONSHIP_TAB (Type)
--   HIE_PROCEDURE_TAB (Type)
--   HIE_PROBLEMS_TAB (Type)
--   HIE_OBSERVATIONSECTION_OBJ (Type)
--   HIE_MEDICATION_TAB (Type)
--   STANDARD (Package)
--   HIE_RESULTS_TAB (Type)
--   HIE_VITALS_TAB (Type)
--   HIE_SOCIALHISTORY_OBJ (Type)
--   HIE_IMMUNIZATION_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."HIE_CLININB_OBJ" force
is object
(
CLINDOC                         	HIE_CLINDOCSUMMARY_OBJ,
ENC                          		HIE_ENCOUNTERS_TAB,
PROBS                                  	HIE_PROBLEMS_TAB,
MEDS                             		HIE_MEDICATION_TAB,
PROCS                                 	HIE_PROCEDURE_TAB,
RESULTS                              	HIE_RESULTS_TAB,
IMMUNIZATION                    	HIE_IMMUNIZATION_TAB,
VITALS                      		HIE_VITALS_TAB,
ALLERGIES                           	HIE_ALLERGIES_TAB,
RETURNCD                          	NUMBER,
SOCIALHISTORY                 	HIE_SOCIALHISTORY_OBJ,
ASSESSMENT         	HIE_OBSERVATIONSECTION_OBJ,
ACTRELATION                     	HIE_ACTRELATIONSHIP_TAB
)



--
-- HIE_CONSENTPOLICY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_consentpolicy_obj
IS OBJECT
(
 policyid             VARCHAR2(100)
,policynm             VARCHAR2(200)
,policydesc           VARCHAR2(2000)
,orgid                NUMBER
,orgoid               VARCHAR2(64)
,categorycd           VARCHAR2(3)
,consentpolicytypeid  VARCHAR2(64)
,defaultconsentstatus VARCHAR2(50)
);



--
-- HIE_CONSENTPOLICY_TAB  (Type) 
--
--  Dependencies: 
--   HIE_CONSENTPOLICY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_consentpolicy_tab IS TABLE OF hie_consentpolicy_obj;



--
-- HIE_DOMAINLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_DOMAINLIST_OBJ  as
   OBJECT (
      orgoid varchar2 (64),
      orgrole varchar2 (24),
      domaintype varchar2 (24),
      supplierid varchar2 (64),
      supplierusageflg varchar2 (12)
)





--
-- HIE_DOMAINLIST_TAB  (Type) 
--
--  Dependencies: 
--   HIE_DOMAINLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_DOMAINLIST_TAB
AS
   TABLE OF hie_domainlist_obj





--
-- HIE_ENCOMPENC_OBJ  (Type) 
--
--  Dependencies: 
--   DT_LOC_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_encompenc_obj AS OBJECT (
   encid                                   dt_ii_obj,
   enccode                                 dt_ce_obj,
   enctiming                               dt_ivl_ts_obj,
   --       encsource           hie_iiextn_obj ,-- changed from dt_ii_obj for CM
   encsource                               hie_informant_obj,
   enclocation                             dt_loc_obj
);



--
-- HIE_ENCOMPSERVICEEVENT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--   DT_II_TAB (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_encompserviceevent_obj AS OBJECT (
   serviceeventid                          dt_ii_obj,
   serviceeventclasscd                     VARCHAR2 (100),
   serviceeventcd                          dt_ce_obj,
   serviceeventtiming                      dt_ivl_ts_obj,
   relatedperformers                       dt_ii_tab
);



--
-- HIE_ENCOMPSERVICEEVENT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_ENCOMPSERVICEEVENT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_encompserviceevent_tab IS TABLE OF hie_encompserviceevent_obj;



--
-- HIE_ENCOUNTERS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_LOC_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_encounters_obj AS OBJECT (
   encid                                   dt_ii_obj,
   enctype                                 dt_ce_obj,
   encmoodcd                               VARCHAR2 (100),
   encdt                                   dt_ivl_ts_obj,
--encsource             hie_iiextn_obj ,      -- changed from dt_ii_obj
   encsource                               hie_informant_obj,
   treatingprov                            dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   encloc                                  dt_loc_obj,
   dischargedisposition                    dt_ce_obj,
   sectiontype                             dt_ce_obj,
   recordtarget                            dt_ii_obj,
   docauthor                               hie_iiextn_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   encstatus                               dt_ce_obj,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj   -- added for CM
);



--
-- HIE_ENCOUNTERS_TAB  (Type) 
--
--  Dependencies: 
--   HIE_ENCOUNTERS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_encounters_tab IS TABLE OF hie_encounters_obj;



--
-- HIE_HIERARCHY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_HIERARCHY_OBJ
AS
   OBJECT  (parentorgoid varchar2(64),
            childorgoid varchar2(64)
            );





--
-- HIE_HIERARCHY_TAB  (Type) 
--
--  Dependencies: 
--   HIE_HIERARCHY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_HIERARCHY_TAB
AS
   TABLE OF hie_hierarchy_obj;





--
-- HIE_IIEXTN_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_iiextn_obj AS OBJECT (
   ID                                      dt_ii_obj,
   TYPE                                    VARCHAR2 (20),
   ahmflag                                 VARCHAR2 (2),
   orgoid                                  VARCHAR2 (200)
);



--
-- HIE_IMMUNIZATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--   DT_DOSAGE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_CE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_MEDADMINTIMING_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_immunization_obj AS OBJECT (
   immunid                                 dt_ii_obj,
   classcode                               dt_ce_obj,
   moodcode                                VARCHAR2 (100),
   medservicedt                            dt_ivl_ts_obj,
   medadmintiming                          hie_medadmintiming_obj,
   routecode                               dt_ce_obj,
   dosage                                  dt_dosage_obj,
   productform                             dt_ce_obj,
   deliverymethod                          VARCHAR2 (100),
   medtypecode                             dt_ce_obj,
   meddrugname                             VARCHAR2 (100),
   meddrugcode                             dt_ce_obj,
   medstatus                               dt_ce_obj,
   assocperformer                          dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   servicinglocation                       dt_ii_obj,
--informant                         hie_iiextn_obj ,         -- changed from dt_ii_obj  for CM
   informant                               hie_informant_obj,
   negationind                             VARCHAR2 (20),
   medicationserienumber                   NUMBER,
   reasonforrefusa                         dt_ce_obj,
   sectiontype                             dt_ce_obj,
   recordtarget                            dt_ii_obj,
   docauthor                               hie_iiextn_obj,   -- added for CM
   replacedmedid                           hie_reltype_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj   -- added for CM
);



--
-- HIE_IMMUNIZATION_TAB  (Type) 
--
--  Dependencies: 
--   HIE_IMMUNIZATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_immunization_tab IS TABLE OF hie_immunization_obj;



--
-- HIE_INFORMANT_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   DT_PN_OBJ (Type)
--   DT_ADDR_OBJ (Type)
--   STANDARD (Package)
--   DT_TEL_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_informant_obj IS OBJECT (
   ID                                      dt_ii_obj,
   TYPE                                    VARCHAR2 (20),
   ahmflag                                 VARCHAR2 (2),
   orgoid                                  VARCHAR2 (64),
   relationcode                            VARCHAR2 (100),
   relationname                            dt_pn_obj,
   relationphone                           dt_tel_obj,
   relationaddress                         dt_addr_obj
);



--
-- HIE_LABPANEL_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_INFORMANT_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   STANDARD (Package)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_labpanel_obj AS OBJECT (
   labpanelid                              dt_ii_obj,
   moodcode                                VARCHAR2 (100),
   labpanelcode                            dt_ce_obj,
   labpanelstatus                          dt_ce_obj,
   efftime                                 dt_ivl_ts_obj,
   assocperformer                          dt_ii_obj,
   assocproviderorg                        dt_ii_obj,
   servicinglocation                       dt_ii_obj,
--   informant               hie_iiextn_obj ,      -- changed from dt_ii_obj  for CM
   informant                               hie_informant_obj,
   docauthor                               hie_iiextn_obj,   -- added for CM
   replacedresultid                        hie_reltype_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj   -- added for CM
);



--
-- HIE_LABRESULT_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_REFERENCERANGE_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_LABRESVALUE_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   STANDARD (Package)
--   HIE_RELTYPE_OBJ (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_labresult_obj AS OBJECT (
   labresultid                             dt_ii_obj,
   moodcode                                VARCHAR2 (100),
   labresultcode                           dt_ce_obj,
   efftime                                 dt_ivl_ts_obj,
   labresultstatus                         dt_ce_obj,
   labresultvalue                          hie_labresvalue_obj,
   interpretationcode                      dt_ce_obj,
   referencerange                          hie_referencerange_obj,
   assocperformer                          dt_ii_obj,
   assocproviderorg                        dt_ii_obj,
   servicinglocation                       dt_ii_obj,
--   informant                hie_iiextn_obj,     -- changed from dt_ii_obj  for CM
   informant                               hie_informant_obj,
   docauthor                               hie_iiextn_obj,   -- added for CM
   replacedresultid                        hie_reltype_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj   -- added for CM
);



--
-- HIE_LABRESULT_TAB  (Type) 
--
--  Dependencies: 
--   HIE_LABRESULT_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_labresult_tab IS TABLE OF hie_labresult_obj;



--
-- HIE_LABRESVALUE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_labresvalue_obj AS OBJECT (
   labrestype                              VARCHAR2 (200),
   labresvalue                             VARCHAR2 (200),
   labresuom                               VARCHAR2 (100),
   codesystem                              VARCHAR2 (100),
   codesysdesc                             VARCHAR2 (100)
);



--
-- HIE_LABRESVALUE_OBJ_V2  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_labresvalue_obj_v2 AS OBJECT (
   labrestype                              VARCHAR2 (200),
   labresvalue                             VARCHAR2 (200),
   labresuom                               VARCHAR2 (100),
   codesystem                              VARCHAR2 (100),
   codesysdesc                             VARCHAR2 (100)
);



--
-- HIE_MEDADMINTIMING_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_medadmintiming_obj AS OBJECT (
   adminfreqnbr                            NUMBER,
   adminfrequomcd                          VARCHAR2 (50),
   adminintervalnbr                        NUMBER,
   adminintervaluomcd                      VARCHAR2 (50),
   admindurationnbr                        NUMBER,
   admindurationuomcd                      VARCHAR2 (50),
   admineventtimingcd                      VARCHAR2 (50),
   admintimingtxt                          VARCHAR2 (2000),
   rateqtytxt                              VARCHAR2 (2000)
);



--
-- HIE_MEDICATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   HIE_MEDADMINTIMING_OBJ (Type)
--   DT_CE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_DOSAGE_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_medication_obj AS OBJECT (
   medicationid                            dt_ii_obj,
   classcode                               dt_ce_obj,
   moodcode                                VARCHAR2 (100),
   medservicedt                            dt_ivl_ts_obj,
   medadmintiming                          hie_medadmintiming_obj,
   routecode                               dt_ce_obj,
   dosage                                  dt_dosage_obj,
   productform                             dt_ce_obj,
   deliverymethod                          VARCHAR2 (100),
   medtypecode                             dt_ce_obj,
   meddrugname                             VARCHAR2 (100),
   meddrugcode                             dt_ce_obj,
   medstatus                               dt_ce_obj,
   assocperformer                          dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   servicinglocation                       dt_ii_obj,
   sectiontype                             dt_ce_obj,
--informant                         hie_iiextn_obj ,       -- changed from dt_ii_obj  for CM
   informant                               hie_informant_obj,
   recordtarget                            dt_ii_obj,
   negationind                             VARCHAR2 (5),
   docauthor                               hie_iiextn_obj,   -- added for CM
   replacedmedid                           hie_reltype_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj,   -- added for CM
   routexcd                                      varchar2(24),
   additionalinfo                           varchar2(255),
   medicationqty                           number,
   medicationquantityuomcd                  VARCHAR2(24),
   COMPLEXDOSAGEFLG                           VARCHAR2(1)    -- Added for User Story 2.04 Complex Dosing.   
); 



--
-- HIE_MEDICATION_TAB  (Type) 
--
--  Dependencies: 
--   HIE_MEDICATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_medication_tab AS TABLE OF hie_medication_obj; 



--
-- HIE_OBSERVATIONDETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   DT_CD_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_UNITVALUE_OBJ (Type)
--   DT_PHASE_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_CE_TAB (Type)
--   DT_EVENTCODE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_OBSERVATIONDETAIL_OBJ IS OBJECT (
   ID                                      dt_ii_obj,
   moodcode                                VARCHAR2 (100),
   code                                    dt_ce_obj,
   status                                  dt_ce_obj,
   assocperformer                          hie_iiextn_obj,
   assocproviderorg                        dt_ii_obj,
   servicinglocation                       dt_ii_obj,
   author                                  hie_iiextn_obj,
   informant                               hie_informant_obj,
   actionnegationind                       VARCHAR2 (1),
   valuenegationind                        VARCHAR2 (1),
   interpretationcode                      dt_ce_tab,
   methodcode                              dt_ce_tab,
   targetsitecode                          dt_ce_tab,
   effectivetime                           dt_ivl_ts_obj,
   valuetype                               VARCHAR2(20),
   valueuom                                dt_ce_obj,
   valuelow                                NUMBER,
   valuehigh                               NUMBER,
   valuetext                               VARCHAR2(255),
   valueevent                              dt_eventcode_obj,
   valueduration                           dt_unitvalue_obj,
   valuefrequency                          dt_unitvalue_obj,
   valueinterval                           dt_unitvalue_obj,
   instspecifier                           VARCHAR2(1) ,
   valuephase                              dt_phase_obj,
   valuecode                               dt_cd_obj,     -- This will be modified to include Translation qualifier.
   response                                hie_sectionresponse_obj,
   activeinactiveflag                      VARCHAR2(20) -- Mantis 23368 Lifestyle event
);



--
-- HIE_OBSERVATIONDETAIL_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_OBSERVATIONDETAIL_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_observationdetail_tab IS TABLE OF hie_observationdetail_obj;



--
-- HIE_OBSERVATIONHEADER_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_OBSERVATIONDETAIL_TAB (Type)
--   STANDARD (Package)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.HIE_OBSERVATIONHEADER_OBJ IS OBJECT (
   ID                                      dt_ii_obj,
   moodcode                                VARCHAR2 (100),
   code                                    dt_ce_obj,
   status                                  dt_ce_obj,
   assocperformer                          hie_iiextn_obj,
   assocproviderorg                        dt_ii_obj,
   servicinglocation                       dt_ii_obj,
   author                                  hie_iiextn_obj,
   informant                               hie_informant_obj,
   reporteddate                            DATE,
   effectivetime                           dt_ivl_ts_obj,
   observationdetail                       hie_observationdetail_tab,
   annotation                              dt_annotation_tab,
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj,
   classification						   VARCHAR2(12), -- Mantis 23368 Lifestyle event
   activeinactiveflag                      VARCHAR2(20), -- Mantis 23368 Lifestyle event
   replacedobservationid                   NUMBER
);



--
-- HIE_OBSERVATIONHEADER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_OBSERVATIONHEADER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_observationheader_tab IS TABLE OF hie_observationheader_obj;



--
-- HIE_OBSERVATIONSECTION_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_OBSERVATIONHEADER_TAB (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_observationsection_obj IS OBJECT (
   sectioncode                             dt_ce_obj,
   performer                               hie_iiextn_obj,
   author                                  hie_iiextn_obj,
   informant                               hie_informant_obj,
   observationheader                       hie_observationheader_tab
);



--
-- HIE_OB_ADDRESSLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_addresslist_obj
AS
   OBJECT (addresstrackingid number,
           addressline1 varchar2 (50),
           addressline2 varchar2 (50),
           addressline3 varchar2 (50),
           city varchar2 (50),
           state varchar2 (2),
           zipcode varchar2 (10),
           country varchar2 (50),
           addresstype varchar2 (20));



--
-- HIE_OB_ADDRESSLIST_TAB  (Type) 
--
--  Dependencies: 
--   HIE_OB_ADDRESSLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_addresslist_tab
IS
   TABLE OF hie_ob_addresslist_obj;



--
-- HIE_OB_ALLERGY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_allergy_obj
AS
   OBJECT (allergytrackingid number,
           allergytype varchar2 (30),
           effectivedt date,
           allergen varchar2 (500),
           reaction varchar2 (200),
           comments varchar2 (4000),
           feedsourcenm varchar2 (20));



--
-- HIE_OB_ALLERGY_TAB  (Type) 
--
--  Dependencies: 
--   HIE_OB_ALLERGY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_allergy_tab IS TABLE OF hie_ob_allergy_obj;



--
-- HIE_OB_EMERGENCYINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_emergencyinfo_obj
AS
   OBJECT (erinfotrackingid number,
           contacttype varchar2 (20),
           contactname varchar2 (200),
           contactrelation varchar2 (35),
           contactphone varchar2 (30));



--
-- HIE_OB_EMERGENCYINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_OB_EMERGENCYINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_ob_emergencyinfo_tab
IS
   TABLE OF hie_ob_emergencyinfo_obj;



--
-- HIE_OB_HEALTHTEAM_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_OB_ADDRESSLIST_TAB (Type)
--   STANDARD (Package)
--   HIE_OB_PHONELIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.hie_ob_healthteam_obj
AS
   OBJECT (healthteamid number,
           personneltype varchar2 (20),
           firstname varchar2 (50),
           lastname varchar2 (50),
           emailaddress varchar2 (50),
           speciality1 varchar2 (100),
           speciality2 varchar2 (100),
           speciality3 varchar2 (100),
           pcpflag varchar2 (1),
           healthaddresslist hie_ob_addresslist_tab,
           healthphonelist hie_ob_phonelist_tab);



--
-- HIE_OB_HEALTHTEAM_TAB  (Type) 
--
--  Dependencies: 
--   HIE_OB_HEALTHTEAM_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_healthteam_tab IS TABLE OF hie_ob_healthteam_obj;



--
-- HIE_OB_HOSPVISIT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_hospvisit_obj
AS
   OBJECT (hospvisittrackingid number,
           locationnm varchar2 (500),
           admissiondt date,
           dischargedt date,
           purpose varchar2 (200),
           providernm varchar2 (100),
           comments varchar2 (4000),
           feedsourcenm varchar2 (20));



--
-- HIE_OB_HOSPVISIT_TAB  (Type) 
--
--  Dependencies: 
--   HIE_OB_HOSPVISIT_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_hospvisit_tab IS TABLE OF hie_ob_hospvisit_obj;



--
-- HIE_OB_HRA_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_hra_obj
AS
   OBJECT (hratrackingid number,
           qid_aid varchar2 (100),
           qid number,
           qtext varchar2 (2000),
           aid number,
           atext varchar2 (2000),
           transactiondt timestamp (6));



--
-- HIE_OB_HRA_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_OB_HRA_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_ob_hra_tab IS TABLE OF hie_ob_hra_obj;



--
-- HIE_OB_IMMUNIZATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_immunization_obj
AS
   OBJECT (immutrackingid number,
           codesystemoid varchar2 (64),
           medicalcode varchar2 (100),
           immunizationname varchar2 (200),
           immunizationprovidername varchar2 (200),
           comments varchar2 (4000),
           startdate date,
           enddate date,
           feedsourcenm varchar2 (20),
           informantoid varchar2 (64));



--
-- HIE_OB_IMMUNIZATION_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_OB_IMMUNIZATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_ob_immunization_tab
IS
   TABLE OF hie_ob_immunization_obj;



--
-- HIE_OB_INSURANCE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_insurance_obj
AS
   OBJECT (insuranceplanid number,
           memberplanid number,
           nameofsubscriber varchar2 (200),
           planmembershipid varchar2 (30),
           plangroupid varchar2 (30));



--
-- HIE_OB_INSURANCE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_OB_INSURANCE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_ob_insurance_tab IS TABLE OF hie_ob_insurance_obj;



--
-- HIE_OB_LABS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_labs_obj
AS
   OBJECT (labtrackingid number,
           labtestname varchar2 (200),
           medicalcode varchar2 (100),
           codesystemoid varchar2 (64),
           servicedate date,
           labtestnumericresult number,
           drugunitofmeasure varchar2 (30),
           labtestnonnumericresult varchar2 (20),
           rangehighvalue number,
           rangelowvalue number,
           comments varchar2 (4000),
           feedsourcenm varchar2 (20),
           informantoid varchar2 (64));



--
-- HIE_OB_LABS_TAB  (Type) 
--
--  Dependencies: 
--   HIE_OB_LABS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_labs_tab IS TABLE OF hie_ob_labs_obj;



--
-- HIE_OB_MEDICATIONS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_medications_obj
AS
   OBJECT (codesystemoid varchar2 (64),
           medicalcode varchar2 (100),
           medtrackingid number,
           drugtradename varchar2 (50),
           drugdosage varchar2 (30),
           comments varchar2 (4000),
           statuscd varchar2 (50),
           statusdesc varchar2 (500),
           statusreasoncd varchar2 (50),
           statusreasondesc varchar2 (500),
           startdate date,
           enddate date,
           feedsourcenm varchar2 (20),
           informantoid varchar2 (64));



--
-- HIE_OB_MEDICATIONS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_OB_MEDICATIONS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_ob_medications_tab
IS
   TABLE OF hie_ob_medications_obj;



--
-- HIE_OB_MEMBERPLANID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_memberplanid_obj
AS
   OBJECT (memberplanid number);



--
-- HIE_OB_MEMBERPLANID_TAB  (Type) 
--
--  Dependencies: 
--   HIE_OB_MEMBERPLANID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_memberplanid_tab
IS
   TABLE OF hie_ob_memberplanid_obj;



--
-- HIE_OB_PATIENTINFO_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_OB_PHONELIST_TAB (Type)
--   HIE_OB_ADDRESSLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_patientinfo_obj
AS
   OBJECT (memberplanid number,
           clientpatid varchar2 (50),
           issuingorgoid varchar2 (64),
           supplierid number,
           firstname varchar2 (50),
           lastname varchar2 (50),
           middlename varchar2 (25),
           namesuffix varchar2 (20),
           nameprefix varchar2 (20),
           gender varchar2 (2),
           dateofbirth date,
           last4ssn varchar2 (4),
           race varchar2 (40),
           language varchar2 (10),
           citizenship varchar2 (30),
           email varchar2 (50),
           addresslist hie_ob_addresslist_tab,
           phonelist hie_ob_phonelist_tab);



--
-- HIE_OB_PATIENTINFO_TAB  (Type) 
--
--  Dependencies: 
--   HIE_OB_PATIENTINFO_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_patientinfo_tab
IS
   TABLE OF hie_ob_patientinfo_obj;



--
-- HIE_OB_PHONELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_phonelist_obj
AS
   OBJECT (phonetrackingid number,
           phonenumber varchar2 (30),
           phoneext number,
           phonetype varchar2 (20),
           phoneusagetype varchar2 (20),
           phonelocationcode varchar2 (15));



--
-- HIE_OB_PHONELIST_TAB  (Type) 
--
--  Dependencies: 
--   HIE_OB_PHONELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_phonelist_tab IS TABLE OF hie_ob_phonelist_obj;



--
-- HIE_OB_PROCEDURE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_procedure_obj
AS
   OBJECT (codesystemoid varchar2 (64),
           medicalcode varchar2 (100),
           procedurename varchar2 (500),
           proceduretrackingid number,
           comments varchar2 (4000),
           startdate date,
           enddate date,
           feedsourcenm varchar2 (20),
           informantoid varchar2 (64));



--
-- HIE_OB_PROCEDURE_TAB  (Type) 
--
--  Dependencies: 
--   HIE_OB_PROCEDURE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_ob_procedure_tab IS TABLE OF hie_ob_procedure_obj;



--
-- HIE_OB_UEPATIENTLIST_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_OB_HEALTHTEAM_TAB (Type)
--   HIE_OB_ALLERGY_TAB (Type)
--   HIE_OB_PROCEDURE_TAB (Type)
--   HIE_OB_EMERGENCYINFO_TAB (Type)
--   HIE_OB_LABS_TAB (Type)
--   HIE_OB_MEDICATIONS_TAB (Type)
--   HIE_OB_INSURANCE_TAB (Type)
--   HIE_OB_HOSPVISIT_TAB (Type)
--   HIE_OB_HRA_TAB (Type)
--   HIE_OB_PATIENTINFO_TAB (Type)
--   HIE_OB_IMMUNIZATION_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.hie_ob_uepatientlist_obj
AS
   OBJECT (patientinfo hie_ob_patientinfo_tab,
           emergencyinfo hie_ob_emergencyinfo_tab,
           healthteaminfo hie_ob_healthteam_tab,
           medicationinfo hie_ob_medications_tab,
           procedureinfo hie_ob_procedure_tab,
           immunizationinfo hie_ob_immunization_tab,
           labinfo hie_ob_labs_tab,
           allergyinfo hie_ob_allergy_tab,
           hospvisitinfo hie_ob_hospvisit_tab,
           hrainfo hie_ob_hra_tab,
           insuranceinfo hie_ob_insurance_tab);



--
-- HIE_PATIENTALTERNATEIDS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_patientalternateids_obj IS OBJECT (
                                                         patientid varchar2 (64),
                                                         patientidtype varchar2 (50),
                                                         patientissuingoid varchar2 (64)
                                                      );



--
-- HIE_PATIENTALTERNATEIDS_TAB  (Type) 
--
--  Dependencies: 
--   HIE_PATIENTALTERNATEIDS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_patientalternateids_tab
IS
   TABLE OF hie_patientalternateids_obj;



--
-- HIE_PHONE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_PHONE_OBJ
AS
   OBJECT (
      phonenumber varchar2 (30),
      phoneext varchar2 (30),
      phonetype varchar2 (20),
      phoneusagetype varchar2 (20),
      phonelocationcode varchar2 (12)
   );





--
-- HIE_PHONE_TAB  (Type) 
--
--  Dependencies: 
--   HIE_PHONE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_PHONE_TAB
AS
   TABLE OF hie_phone_obj;





--
-- HIE_PROBLEMS_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   DT_CE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.hie_problems_obj AS OBJECT (
   problemid                               dt_ii_obj,
   problemtype                             dt_ce_obj,
   problemlevel							   VARCHAR2(20),-- Newly added for 837
   problemcode                             dt_ce_obj,
   efftime                                 dt_ivl_ts_obj,
   problemstatus                           dt_ce_obj,
   treatingprovider                        dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   sectiontype                             dt_ce_obj,
   problemsource                           hie_informant_obj,
   recordtarget                            dt_ii_obj,
   negationind                             VARCHAR2 (5),
   docauthor                               hie_iiextn_obj,   -- added for CM
   replacedprobid                          hie_reltype_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj   -- added for CM
);



--
-- HIE_PROBLEMS_TAB  (Type) 
--
--  Dependencies: 
--   HIE_PROBLEMS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_problems_tab IS TABLE OF hie_problems_obj;



--
-- HIE_PROCEDURE_OBJ  (Type) 
--
--  Dependencies: 
--   DT_IVL_TS_OBJ (Type)
--   DT_CE_TAB (Type)
--   HIE_IIEXTN_OBJ (Type)
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   DT_II_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_procedure_obj AS OBJECT (
   procid                                  dt_ii_obj,
   moodcode                                VARCHAR2 (100),
   proccode                                dt_ce_obj,
   procstatus                              dt_ce_obj,
   targetsite                              dt_ce_tab,
   assocperformer                          dt_ii_obj,
   assocproviderorg                        dt_ii_obj,
   servicinglocation                       dt_ii_obj,
--informant                hie_iiextn_obj ,      -- changed from dt_ii_obj  for CM
   informant                               hie_informant_obj,
   efftime                                 dt_ivl_ts_obj,
   sectiontype                             dt_ce_obj,
   recordtarget                            dt_ii_obj,
   negationind                             VARCHAR2 (5),
   docauthor                               hie_iiextn_obj,   -- added for CM
   replacedprocid                          hie_reltype_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj,   -- added for CM
   procedureamount						   NUMBER,
   units								   VARCHAR2(20),
   quantity								   NUMBER,
   modifier1					 		   VARCHAR2(255),
   modifier2					 		   VARCHAR2(255),
   modifier3					 		   VARCHAR2(255),
   modifier4					 		   VARCHAR2(255),
   facilitytypecode						   VARCHAR2(2)
   );



--
-- HIE_PROCEDURE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_PROCEDURE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_procedure_tab IS TABLE OF hie_procedure_obj;



--
-- HIE_PROVIDER_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   PROVIDERORG_OBJ (Type)
--   DT_PN_OBJ (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--   DT_TEL_OBJ (Type)
--   DT_ADDR_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.HIE_PROVIDER_OBJ AS OBJECT (
   accountoid            dt_ii_obj
  ,prov_id               dt_ii_obj
  ,prov_role             dt_ce_obj
  ,prov_type             dt_ce_obj
  ,prov_name             dt_pn_obj
  ,prov_addr             dt_addr_obj
  ,prov_tel              dt_tel_obj
  ,prov_org              providerorg_obj
  ,prov_localmrn         dt_ii_obj
  ,npi                   VARCHAR2(50)
);



--
-- HIE_PROVIDER_TAB  (Type) 
--
--  Dependencies: 
--   HIE_PROVIDER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HIE_PROVIDER_TAB IS TABLE OF HIE_PROVIDER_OBJ;



--
-- HIE_RECORDTARGET_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_recordtarget_obj AS OBJECT (
   recordtargetid                          dt_ii_obj,
   facilitypatid                           dt_ii_obj,
   scopingorgid                            dt_ii_obj
);



--
-- HIE_REFERENCERANGE_OBJ  (Type) 
--
--  Dependencies: 
--   DT_UNITVALUE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_referencerange_obj AS OBJECT (
   low                                     dt_unitvalue_obj,
   high                                    dt_unitvalue_obj
);



--
-- HIE_RELTYPE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_reltype_obj AS OBJECT (
   ID                                      dt_ii_obj,
   TYPE                                    VARCHAR2 (4)
);



--
-- HIE_RESULTS_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   HIE_LABPANEL_OBJ (Type)
--   DT_CE_OBJ (Type)
--   HIE_PROCEDURE_TAB (Type)
--   HIE_LABRESULT_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.hie_results_obj AS OBJECT (
   resultprocedure                         hie_procedure_tab,
   labpanel                                hie_labpanel_obj,
   labresult                               hie_labresult_tab,
   sectiontype                             dt_ce_obj,
   recordtarget                            dt_ii_obj
);



--
-- HIE_RESULTS_TAB  (Type) 
--
--  Dependencies: 
--   HIE_RESULTS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_results_tab IS TABLE OF hie_results_obj;



--
-- HIE_SECTIONRESPONSE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_sectionresponse_obj AS OBJECT (
   sourcetrackingid                        NUMBER,
   odstrackingid                           NUMBER,
   returncode                              NUMBER
);



--
-- HIE_SOCIALHISTHEADER_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_IIEXTN_OBJ (Type)
--   DT_IVL_TS_STR_OBJ (Type)
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   HIE_OBSERVATIONDETAIL_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."HIE_SOCIALHISTHEADER_OBJ"

is object
(
ID                    DT_II_OBJ,
MOODCODE                VARCHAR2 (100),
CODE                                            DT_CE_OBJ,
STATUS                                      DT_CE_OBJ,
ASSOCPERFORMER                       HIE_IIEXTN_OBJ,
ASSOCPROVIDERORG                   DT_II_OBJ,
SERVICINGLOCATION                     DT_II_OBJ,
AUTHOR                                      HIE_IIEXTN_OBJ,
INFORMANT                                   HIE_INFORMANT_OBJ,
REPORTEDDATE                                DATE,
EFFECTIVETIME                               DT_IVL_TS_STR_OBJ,
OBSERVATIONDETAIL                    HIE_OBSERVATIONDETAIL_TAB,
ANNOTATION                                  DT_ANNOTATION_TAB,
RELATEDENCOUNTERID                DT_II_OBJ,
RESPONSE                                    HIE_SECTIONRESPONSE_OBJ,
CLASSIFICATION            VARCHAR2(12),
ACTIVEINACTIVEFLAG                    VARCHAR2(20),
REPLACEDOBSERVATIONID          NUMBER
)



--
-- HIE_SOCIALHISTHEADER_TAB  (Type) 
--
--  Dependencies: 
--   HIE_SOCIALHISTHEADER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."HIE_SOCIALHISTHEADER_TAB" is table of HIE_SOCIALHISTHEADER_obj



--
-- HIE_SOCIALHISTORY_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   DT_CE_OBJ (Type)
--   HIE_SOCIALHISTHEADER_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."HIE_SOCIALHISTORY_OBJ"
is object
(
SECTIONCODE                             	DT_CE_OBJ,
PERFORMER                               	HIE_IIEXTN_OBJ,
AUTHOR                                  	HIE_IIEXTN_OBJ,
INFORMANT                               	HIE_INFORMANT_OBJ,
OBSERVATIONHEADER     HIE_SOCIALHISTHEADER_TAB
)



--
-- HIE_USERMASTERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_usermasterlist_obj
IS
   OBJECT (odsuserid number, usertyPecd varchar2 (1), returncode varchar2 (50));



--
-- HIE_USERMASTERLIST_TAB  (Type) 
--
--  Dependencies: 
--   HIE_USERMASTERLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_usermasterlist_tab IS TABLE OF hie_usermasterlist_obj



--
-- HIE_VITALSIGNOBSERVATION_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_SECTIONRESPONSE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   HIE_REFERENCERANGE_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   HIE_LABRESVALUE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hie_vitalsignobservation_obj AS OBJECT (
   vitalsignobsid                          dt_ii_obj,
   moodcode                                VARCHAR2 (100),
   vitalsignobscode                        dt_ce_obj,
   efftime                                 dt_ivl_ts_obj,
   vitalsignobsstatus                      dt_ce_obj,
   vitalsignobsvalue                       hie_labresvalue_obj,
   interpretationcode                      dt_ce_obj,
   referencerange                          hie_referencerange_obj,
   assocperformer                          dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   servicinglocation                       dt_ii_obj,
--informant                    hie_iiextn_obj,           -- changed from dt_ii_obj  for CM
   informant                               hie_informant_obj,
   docauthor                               hie_iiextn_obj,   -- added for CM
   replacedresultid                        hie_reltype_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj   -- added for CM
);



--
-- HIE_VITALSIGNOBSERVATION_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_VITALSIGNOBSERVATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_vitalsignobservation_tab IS TABLE OF hie_vitalsignobservation_obj;



--
-- HIE_VITALSIGNORGANIZER_OBJ  (Type) 
--
--  Dependencies: 
--   DT_ANNOTATION_TAB (Type)
--   DT_CE_OBJ (Type)
--   HIE_RELTYPE_OBJ (Type)
--   HIE_IIEXTN_OBJ (Type)
--   HIE_INFORMANT_OBJ (Type)
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--   DT_IVL_TS_OBJ (Type)
--   HIE_SECTIONRESPONSE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_vitalsignorganizer_obj AS OBJECT (
   vitalsignorgid                          dt_ii_obj,
   moodcode                                VARCHAR2 (100),
   vitalsignorgcode                        dt_ce_obj,
   vitalsignorgstatus                      dt_ce_obj,
   effectime                               dt_ivl_ts_obj,
   assocperformer                          dt_ii_obj,
   assocprovorg                            dt_ii_obj,
   servicinglocation                       dt_ii_obj,
--informant                    hie_iiextn_obj,           -- changed from dt_ii_obj  for CM
   informant                               hie_informant_obj,
   docauthor                               hie_iiextn_obj,   -- added for CM
   replacedresultid                        hie_reltype_obj,   -- added for CM
   reporteddate                            DATE,   -- added for CM
   annotation                              dt_annotation_tab,   -- added for CM
   relatedencounterid                      dt_ii_obj,
   response                                hie_sectionresponse_obj   -- added for CM
);



--
-- HIE_VITALS_OBJ  (Type) 
--
--  Dependencies: 
--   HIE_VITALSIGNOBSERVATION_TAB (Type)
--   HIE_VITALSIGNORGANIZER_OBJ (Type)
--   DT_CE_OBJ (Type)
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_vitals_obj AS OBJECT (
   vitalsignorganizer                      hie_vitalsignorganizer_obj,
   vitalsignobservation                    hie_vitalsignobservation_tab,
   sectiontype                             dt_ce_obj,
   recordtarget                            dt_ii_obj,
   negationind                             VARCHAR2 (5)
);



--
-- HIE_VITALS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HIE_VITALS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.hie_vitals_tab IS TABLE OF hie_vitals_obj;



--
-- HIGHLIGHTINGLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."HIGHLIGHTINGLIST_OBJ" IS OBJECT (
                                                          MEMBERCASEID NUMBER,
                                                          MEMBERCLAIMSID NUMBER,
                                                          CLAIMTYPE VARCHAR2 (20 BYTE)
                                                       );



--
-- HIGHLIGHTINGLIST_TAB  (Type) 
--
--  Dependencies: 
--   HIGHLIGHTINGLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."HIGHLIGHTINGLIST_TAB"
IS
   TABLE OF highlightinglist_obj;



--
-- HLTHACTIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   MECOMMLISTMEM_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HLTHACTIONLIST_OBJ
AS
   OBJECT (METRACKINGID NUMBER,
           MEID NUMBER,
           METITLE VARCHAR2 (1000),
           HATITLE VARCHAR2 (200),
           MEDESC VARCHAR2 (2000),
           METYPECODE VARCHAR2 (24),
           MEIMPACTABLEFLAG VARCHAR2 (1),
           REASONFORIMPACTABLETXT VARCHAR2 (4000),
           MECHRONIC CHAR(1),
           MERANK NUMBER,
           MESEVERITY NUMBER,
           MECHANGEDATE DATE,
           CECOMPLETIONSTATUS CHAR(1),
           MEEXPIREDFLAG CHAR(1),
		   METYPEDESC VARCHAR2(255),
		   SNOOZEFLAG VARCHAR2(1),
		   SNOOZESTARTDT DATE,
		   SNOOZEENDDT DATE,
           MECOMMLIST MECOMMLISTMEM_TAB);



--
-- HLTHACTIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HLTHACTIONLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.HLTHACTIONLIST_TAB AS TABLE OF ODS.HlthActionList_OBJ;



--
-- HMTDRUG_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hmtdrug_object as object(
  memberid       NUMBER,
  patientid      VARCHAR2(20),
  dateofevent    DATE,
  description    VARCHAR2(500),
  code           VARCHAR2(20),
  classification number,
  dateofbirth    DATE,
  value          VARCHAR2(30),
  instanceid     NUMBER);



--
-- HMTDRUG_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HMTDRUG_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.hmtdrug_object_array as table of hmtdrug_object;



--
-- HMTUTIL_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.hmtutil_object as object(
  memberid       NUMBER,
  patientid      VARCHAR2(20),
  dateofevent    DATE,
  description    VARCHAR2(500),
  code           VARCHAR2(20),
  classification number,
  dateofbirth    DATE,
  value          VARCHAR2(30),
  instanceid     NUMBER);



--
-- HMTUTIL_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HMTUTIL_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.hmtutil_object_array as table of hmtutil_object;



--
-- HOA_HLTHCLDDATA_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPHRHRAQA_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.HOA_HLTHCLDDATA_OBJ
as
OBJECT
(
MEMBERPLANID                             NUMBER,
AETNACUMBID                 VARCHAR2(30),
HOADATALIST                   ODS.GETPHRHRAQA_TAB
)



--
-- HOA_HLTHCLDDATA_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HOA_HLTHCLDDATA_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.HOA_HLTHCLDDATA_TAB IS TABLE OF ODS.HOA_HLTHCLDDATA_OBJ



--
-- HOSPITALVISITLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HOSPITALVISITLIST_OBJ IS OBJECT (
                                                   ODSINSTANCEID NUMBER,
                                                   SOURCETRACKINGID NUMBER,
                                                   HOSPITALNAME VARCHAR2 (200),
                                                   ADMISSIONDATE DATE,
                                                   DISCHARGEDATE DATE,
                                                   HOSPITALVISITPURPOSE VARCHAR2 (50),
                                                   HOSPITALVISITPHYSICIAN VARCHAR2 (100),
                                                   HOSPITALVISITDIAGNOSIS VARCHAR2 (1000),
                                                   TRANSACTIONDT DATE,
                                                   SYSTEMSOURCE VARCHAR2 (20)
                                                ); 



--
-- HOSPITALVISITLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HOSPITALVISITLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.HOSPITALVISITLIST_TAB
IS
   TABLE OF HOSPITALVISITLIST_OBJ; 



--
-- HOSP_VISIT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."HOSP_VISIT_OBJ"
AS
   OBJECT (SOURCETRACKINGID NUMBER,
           HOSPITALVISITHOSPITAL VARCHAR2 (200),
           HOSPITALVISITADMISSIONDATE DATE,
           HOSPITALVISITDISCHARGE DATE,
           HOSPITALVISITPURPOSE VARCHAR2 (50),
           HOSPITALVISITPHYSICIAN VARCHAR2 (50),
           HOSPITALVISITDIAGNOSIS VARCHAR2 (1000),
           ACTION VARCHAR2 (10),
           ODSINSTANCEID NUMBER,
           RETURNCODE NUMBER);



--
-- HOSP_VISIT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HOSP_VISIT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."HOSP_VISIT_TAB" IS TABLE OF HOSP_VISIT_OBJ;



--
-- HRAANSWERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HRAANSWERLIST_OBJ IS OBJECT (
                                               ANSWERINDEXID NUMBER,
                                               RESPONSETEXT VARCHAR2 (4000),
                                               RESPONSESCORE NUMBER,
                                               TRANSACTIONDATE DATE
                                            ); 



--
-- HRAANSWERLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HRAANSWERLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.HRAANSWERLIST_TAB IS TABLE OF HRAANSWERLIST_OBJ; 



--
-- HRAQUESTIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HRAANSWERLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.HRAQUESTIONLIST_OBJ IS OBJECT (
                                                 QUESTIONINDEXID NUMBER,
                                                 TRANSACTIONDATE DATE,
                                                 HRAANSWERLIST HRAANSWERLIST_TAB
                                              ); 



--
-- HRAQUESTIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HRAQUESTIONLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.HRAQUESTIONLIST_TAB IS TABLE OF HRAQUESTIONLIST_OBJ; 



--
-- HRAQUESTION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HRAQUESTION_OBJ IS OBJECT
   (
   QUESTIONINDEXID NUMBER,
   TRANSACTIONDATE TIMESTAMP(6)
   );



--
-- HRAQUESTION_TAB  (Type) 
--
--  Dependencies: 
--   HRAQUESTION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.HRAQUESTION_TAB IS TABLE OF HRAQUESTION_OBJ;



--
-- HRA_PHR_ANS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."HRA_PHR_ANS_OBJ"
AS
   OBJECT (ANSWERINDEXID NUMBER,
           TRANSACTIONDATE DATE,
           RESPONSETEXT VARCHAR2 (4000 BYTE));



--
-- HRA_PHR_ANS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HRA_PHR_ANS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."HRA_PHR_ANS_TAB" AS TABLE OF HRA_PHR_ANS_OBJ;



--
-- HRA_PHR_OBJ  (Type) 
--
--  Dependencies: 
--   HRA_PHR_ANS_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."HRA_PHR_OBJ"
AS
   OBJECT (QUESTIONINDEXID NUMBER,
           ACTION VARCHAR2 (20 BYTE),
           HRA_ANS HRA_PHR_ANS_TAB);



--
-- HRA_PHR_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HRA_PHR_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."HRA_PHR_TAB" AS TABLE OF HRA_PHR_OBJ;



--
-- HRA_SS_ANS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."HRA_SS_ANS_OBJ" 
AS
   OBJECT (ANSWERINDEXID NUMBER,
           RESPONSETEXT VARCHAR2 (4000 BYTE),
           RESPONSESCORE NUMBER) 



--
-- HRA_SS_ANS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HRA_SS_ANS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."HRA_SS_ANS_TAB" AS TABLE OF HRA_SS_ANS_OBJ 



--
-- HRA_SS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HRA_SS_ANS_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."HRA_SS_OBJ" 
AS
   OBJECT (QUESTIONAIREID NUMBER,
           QUESTIONINDEXID NUMBER,
           ANSWER_LST HRA_SS_ANS_TAB) 



--
-- HRA_SS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   HRA_SS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."HRA_SS_TAB" AS TABLE OF ODS.HRA_SS_OBJ 



--
-- IDTIMESTAMP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.IDTIMESTAMP_OBJ
as
OBJECT
(
COL_ID                             NUMBER,
COL_DT                 TIMESTAMP(6)
)



--
-- IDTIMESTAMP_TAB  (Type) 
--
--  Dependencies: 
--   IDTIMESTAMP_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.IDTIMESTAMP_TAB IS TABLE OF ODS.IDTIMESTAMP_OBJ



--
-- IHR_MEMBERPLANID_REQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ihr_memberplanid_req_obj
AS OBJECT (old_memberplanid  NUMBER
          ,new_memberplanid NUMBER) 



--
-- IHR_MEMBERPLANID_REQ_TAB  (Type) 
--
--  Dependencies: 
--   IHR_MEMBERPLANID_REQ_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ihr_memberplanid_req_tab IS TABLE OF ihr_memberplanid_req_obj 



--
-- IHR_MEMBERPLANID_RES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ihr_memberplanid_res_obj
AS OBJECT (old_memberplanid  NUMBER
          ,new_memberplanid NUMBER
		  ,returncode       NUMBER) 



--
-- IHR_MEMBERPLANID_RES_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   IHR_MEMBERPLANID_RES_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ihr_memberplanid_res_tab IS TABLE OF ihr_memberplanid_res_obj 



--
-- IHR_MERGEDMEMBERS_RES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ihr_mergedmembers_res_obj
AS OBJECT ( old_memberid      NUMBER
           ,old_memberplanid  NUMBER
           ,new_memberid      NUMBER
		   ,new_memberplanid  NUMBER) 



--
-- IHR_MERGEDMEMBERS_RES_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   IHR_MERGEDMEMBERS_RES_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ihr_mergedmembers_res_tab IS TABLE OF ihr_mergedmembers_res_obj 



--
-- IMMUDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ImmuDetailList_OBJ
AS
   OBJECT (ImmunizationDate DATE,
           DoctorName VARCHAR2 (200),
           Comments VARCHAR2 (4000),
           SelfReported CHAR(1),
           ODSTrackingID NUMBER,
           PHRImmunizationID NUMBER);



--
-- IMMUDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   IMMUDETAILLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ImmuDetailList_TAB AS TABLE OF ODS.ImmuDetailList_OBJ;



--
-- IMMUSUMRYLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ImmuSumryList_OBJ
AS
   OBJECT (ImmunizationName VARCHAR2(100 BYTE),
           ImmunizationCode VARCHAR2(20 BYTE));



--
-- IMMUSUMRYLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   IMMUSUMRYLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ImmuSumryList_TAB AS TABLE OF ODS.ImmuSumryList_OBJ;



--
-- INSURANCEINFOLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."INSURANCEINFOLIST_OBJ"
AS
   OBJECT (InsurancePlanID NUMBER,
           InsuranceCompanyName VARCHAR2 (200),
           NameOfSubscriber VARCHAR2 (200),
           PlanMembershipID VARCHAR2 (30),
           PlanGroupID VARCHAR2 (30));



--
-- INSURANCEINFOLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   INSURANCEINFOLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."INSURANCEINFOLIST_TAB"
IS
   TABLE OF insuranceInfoList_obj;



--
-- JUSTIFICATIONS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.JUSTIFICATIONS_OBJ IS OBJECT (
               JUSTIFICATIONSEQ VARCHAR2(2),
               JUSTIFICATIONCODESYSTEMNM VARCHAR2(20),
               JUSTIFICATIONCODE VARCHAR2(20),
               JUSTIFICATIONDESCRIPTION VARCHAR2(300),
               JUSTIFICATIONOCCURS NUMBER,
               JUSTIFICATIONSTARTDATE VARCHAR2(30),
               JUSTIFICATIONENDDATE VARCHAR2(30)
   ); 



--
-- JUSTIFICATIONS_TAB  (Type) 
--
--  Dependencies: 
--   JUSTIFICATIONS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.JUSTIFICATIONS_TAB IS TABLE OF JUSTIFICATIONS_OBJ; 



--
-- LAB_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.LAB_OBJECT   as object
( memberid       NUMBER,
   dateofevent    DATE,
   code           VARCHAR2(10),
   result         NUMBER,
   reflow         NUMBER,
   refhigh        NUMBER,
   unit           varchar(30),
   instanceid     NUMBER,
   careproviderid NUMBER,
   sourceproviderid VARCHAR2(30)); 



--
-- LAB_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   LAB_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.LAB_OBJECT_ARRAY   as table of LAB_OBJECT; 



--
-- LOINC_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.loinc_OBJECT     as object(
  loinc           VARCHAR2(50),
  name    VARCHAR2(100),
  elementid         NUMBER)



--
-- LOINC_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   LOINC_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.loinc_OBJECT_ARRAY   as table of loinc_OBJECT



--
-- MANAGE_AGGREGATE_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MANAGE_AGGREGATE_OBJ
AS OBJECT (
PATIENTID            DT_II_OBJ,
MASTERPATIENTFLAG    VARCHAR2(1),
EFFECTIVE_START_DATE DATE,
EFFECTIVE_END_DATE   DATE,
UPDATE_ACTION_TYPE   VARCHAR2(1)
);




--
-- MANAGE_AGGREGATE_TAB  (Type) 
--
--  Dependencies: 
--   MANAGE_AGGREGATE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MANAGE_AGGREGATE_TAB" IS TABLE OF MANAGE_AGGREGATE_OBJ;




--
-- MARKERFDB_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MARKERFDB_OBJ" IS OBJECT (
                                                   MarkerFDBDate date,
                                                   MarkerFDBStatus varchar2 (24),
                                                   MarkerFDBComments varchar2 (4000),
                                                   MarkerFDBSource varchar2 (20)
                                                );



--
-- MARKERFDB_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MARKERFDB_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MARKERFDB_TAB" IS TABLE OF MarkerFDB_OBJ;



--
-- MARKERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   MARKERSOURCELIST_TAB (Type)
--   MARKERFDB_TAB (Type)
--   MEVIDENCELIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MARKERLIST_OBJ AS OBJECT
(
MarkerID                 NUMBER,
MarkerTitle              VARCHAR2(200),
MarkerChronic            VARCHAR2(5),
MarkerTypeCode           VARCHAR2(20),
MarkerSeverity           VARCHAR2(12),
MarkerStatus             VARCHAR2(12),
MarkerStatusChangeDt     DATE,
MarkerSourceList         MarkerSourceList_TAB,
MarkerFDB                MarkerFDB_TAB,
MarkerEvidenceList       MEvidenceList_TAB
);



--
-- MARKERLIST_TAB  (Type) 
--
--  Dependencies: 
--   MARKERLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MARKERLIST_TAB IS TABLE OF MARKERLIST_OBJ;



--
-- MARKERSOURCELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MARKERSOURCELIST_OBJ"
AS
   OBJECT (MarkerTrackingID number,
           MarkerSource varchar2 (20),
           MarkerCreateDate date,
           MarkerDiagDate date);



--
-- MARKERSOURCELIST_TAB  (Type) 
--
--  Dependencies: 
--   MARKERSOURCELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MARKERSOURCELIST_TAB"
IS
   TABLE OF MarkerSourceList_OBJ;



--
-- MBREMERGENCYDETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   EMERGENCYDETAIL_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."MBREMERGENCYDETAIL_OBJ" AS OBJECT
   (  MEMBERPLANID             NUMBER,
      EMERGENCTDETAIL      EMERGENCYDETAIL_TAB,
      RETURNCD                 NUMBER);




--
-- MBRREFRESHSTS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.mbrrefreshsts_obj
is object
(
memberid number,
processstatus varchar2(20)
) 



--
-- MBRREFRESHSTS_TAB  (Type) 
--
--  Dependencies: 
--   MBRREFRESHSTS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.mbrrefreshsts_tab is table of mbrrefreshsts_obj 



--
-- MBR_DIAGNOSIS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MBR_PROV_INFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MBR_DIAGNOSIS_OBJ"
AS
   OBJECT  ( Memberid              number,
             MedicalDiagnosisCode  varchar2 (20),
             DIAGNOSISNM           varchar2 (100),
             SERVICEDT             date,
             COMMENTS              varchar2(4000),
             CP_details            mbr_prov_info_obj,
             CPO_details           mbr_prov_info_obj
);




--
-- MBR_DIAGNOSIS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MBR_DIAGNOSIS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MBR_DIAGNOSIS_TAB" IS TABLE OF mbr_diagnosis_OBJ;




--
-- MBR_EMER_CONTACT_INFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MBR_EMER_CONTACT_INFO_OBJ"
AS
   OBJECT (EmergencyContactName          varchar2 (200),
           ContactPhoneNumber1           varchar2 (30),
           EmergencyContactRelationship  varchar2 (35));




--
-- MBR_EMER_CONTACT_INFO_TAB  (Type) 
--
--  Dependencies: 
--   MBR_EMER_CONTACT_INFO_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MBR_EMER_CONTACT_INFO_TAB"
IS
   TABLE OF mbr_emer_contact_info_obj;




--
-- MBR_INFO_OBJ  (Type) 
--
--  Dependencies: 
--   MBR_EMER_CONTACT_INFO_TAB (Type)
--   MBR_PROV_INFO_TAB (Type)
--   MBR_TEL_INFO_TAB (Type)
--   ADDR_INFO_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MBR_INFO_OBJ
AS
   OBJECT (PrimaryMemberPlanID       NUMBER,
           AHMSupplierIdentifier     NUMBER,
           FirstName                 varchar2 (50),
           MiddleInitial             varchar2 (25),
           LastName                  varchar2 (40),
           Salutation                varchar2 (5),
           Suffix                    varchar2 (10),
           DateOfBirth               DATE,
           Gender                    varchar2 (2),
           MaritalStatusCode         varchar2 (24),
           sourcepatientid           varchar2(30) ,
           SourceOrgOID              varchar2(100),
           Mbr_addr_info             addr_info_tab,
           Mbr_tel_info              Mbr_tel_info_tab,
           mbr_emer_contact_info     mbr_emer_contact_info_tab,
           mbr_prov_info             mbr_prov_info_tab);



--
-- MBR_LAB_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MBR_PROV_INFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MBR_LAB_OBJ"
AS
   OBJECT  (MemberId                 NUMBER,
            LOINC                    VARCHAR2 (10),
            LABTESTNM                VARCHAR2 (50 ),
            SERVICEDT                date,
            SERVICETIME              NUMBER,
            DrugUnitOfMeasure        VARCHAR2 (30 ),
            LabTestMinValue          NUMBER,
            LabTestMaxValue          NUMBER,
            LabTestAbnormalInd       VARCHAR2 (15 ),
            LabTestNumericResult     NUMBER,
            LabTestNonNumericResult  VARCHAR2 (200 ),
            CP_details               mbr_prov_info_obj,
            CPO_details              mbr_prov_info_obj
);




--
-- MBR_LAB_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MBR_LAB_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MBR_LAB_TAB" IS TABLE OF mbr_lab_OBJ;




--
-- MBR_MEDICATIONS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MBR_PROV_INFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MBR_MEDICATIONS_OBJ"
AS
   OBJECT  (Memberid                    number,
            NDCCode                     VARCHAR2 (20 Byte),
            ServiceDt                   DATE,
            DrugNm                      VARCHAR2 (50 Byte),
            NoofdaysSupplied            NUMBER,
            DrugQuantity                NUMBER,
            Prescribeddosgeamount       NUMBER,
            Dosageintervalnumber        NUMBER,
            Dosageintervaluom           VARCHAR2 (30 Byte),
            CP_details                  mbr_prov_info_obj,
            CPO_details                 mbr_prov_info_obj
);




--
-- MBR_MEDICATIONS_TAB  (Type) 
--
--  Dependencies: 
--   MBR_MEDICATIONS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MBR_MEDICATIONS_TAB" IS TABLE OF mbr_medications_OBJ;




--
-- MBR_PROCEDURE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MBR_PROV_INFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MBR_PROCEDURE_OBJ"
AS
   OBJECT  (MemberId                NUMBER,
           MEDICALPROCEDURECODE    VARCHAR2 (20),
           MEDICALPROCEDURENAME     varchar2(100),
           ServiceDt              DATE,
           CP_details              mbr_prov_info_obj,
           CPO_details             mbr_prov_info_obj
);




--
-- MBR_PROCEDURE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MBR_PROCEDURE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MBR_PROCEDURE_TAB" IS TABLE OF mbr_procedure_OBJ;




--
-- MBR_PROV_INFO_OBJ  (Type) 
--
--  Dependencies: 
--   ADDR_INFO_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MBR_PROV_INFO_OBJ"
AS
   OBJECT (CareProviderIdentifier    NUMBER,
           PrimaryProviderFlag       varchar2 (20),
           FirstName                 varchar2 (100),
           MiddleName                varchar2 (100),
           LastName                  varchar2 (100),
           NPI                       varchar2 (10),
           PROVIDERTYPE              VARCHAR2 (20),
           PROVIDERSPECIALTY         VARCHAR2 (60 ),
           mbr_prov_addr_info        addr_info_tab
           )




--
-- MBR_PROV_INFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MBR_PROV_INFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MBR_PROV_INFO_TAB" is
   TABLE OF mbr_prov_info_obj;




--
-- MBR_TEL_INFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MBR_TEL_INFO_OBJ"
AS
   OBJECT (PhoneFaxDisplayNumber     varchar2 (30),
           PhoneFaxTypeCode          varchar2 (30),
           PhoneFaxUsageTypeCode     varchar2 (20),
           PHONEPREFERENCESEQ        number );




--
-- MBR_TEL_INFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MBR_TEL_INFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."MBR_TEL_INFO_TAB" IS TABLE OF Mbr_tel_info_obj;




--
-- MECOMMLISTMEM_OBJ  (Type) 
--
--  Dependencies: 
--   MEFDBLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MECOMMLISTMEM_OBJ as
OBJECT(
MECommTrackingID    NUMBER,
MECommID            NUMBER,
MECommType          varchar2(24),
MECommTitle         varchar2(200),
MECommDesc          varchar2(2000),
MECommCreateDate    date,
appendtext			varchar2(4000),
MEFDBList           MEFDBList_tab
)
;




--
-- MECOMMLISTMEM_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MECOMMLISTMEM_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.MECOMMLISTMEM_TAB as table of MECommListmem_obj ;




--
-- MECOMMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MECOMMLIST_OBJ as
OBJECT(
MECommTrackingID    NUMBER,
MECommID            NUMBER,
MECommTitle         varchar2(1000),
MECommTxt           varchar2(4000),
MECommCreateDate    varchar2(20)
);




--
-- MECOMMLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MECOMMLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.MECOMMLIST_TAB IS TABLE OF MECommList_obj;




--
-- MEDDIAG_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEDdiag_OBJECT     as object(
  MEDICALDIAGNOSISCODE           VARCHAR2(50),
  diagnosisnm    VARCHAR2(100),
  elementid         NUMBER)



--
-- MEDDIAG_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEDDIAG_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.MEDdiag_OBJECT_ARRAY   as table of MEDdiag_OBJECT



--
-- MEDICATIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEDICATIONLIST_OBJ
AS
   OBJECT (       drugprescriptioninstanceid       NUMBER,
                  codesystemname            VARCHAR2(10),
                  medicalcode               VARCHAR2(20),
                  medcialclasscd            VARCHAR2(12),
                  drugtradename             VARCHAR2(50),
                  drugdosage                VARCHAR2(30),
                  drugrouteofadministration VARCHAR2(20),
                  dosageformdescription     VARCHAR2(200),
                  numberofdays              NUMBER,
                  genericname               VARCHAR2(35),
                  startdt                   DATE,
                  enddt                     DATE,
                  moodcd                    VARCHAR2(12),
                  feedsourcenm              VARCHAR2(20),
                  c32statusdesc             VARCHAR2(200),
                  careproviderid            NUMBER,
                  servicingorgid            VARCHAR2(100)
          );



--
-- MEDICATIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEDICATIONLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.MEDICATIONLIST_TAB AS TABLE OF medicationlist_obj;



--
-- MEDICATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEDICATION_OBJ AS OBJECT (
  CODESYSTEMNAME         VARCHAR2(200 BYTE),
  MEDICALCODE            VARCHAR2(100 BYTE),
  ODSINSTANCETRACKINGID  NUMBER,
  SOURCETRACKINGID       NUMBER,
  ODSSUMMARYTRACKINGID   NUMBER,
  DRUGTRADENAME          VARCHAR2(200 BYTE),
  DRUGDOSAGE             VARCHAR2(30 BYTE),
  VBFMESSAGE             VARCHAR2(4000 BYTE),
  GENERICNAME            VARCHAR2(35 BYTE),
  COMMENTS               VARCHAR2(4000 BYTE),
  STATUS                 VARCHAR2(50 BYTE),
  STATUSREASON           VARCHAR2(60 BYTE),
  LASTUPDATEDATE         DATE,
  UPDATESOURCENAME       VARCHAR2(20 BYTE),
  MEDCLASSCD             VARCHAR2(12 BYTE),
  STARTDATE              DATE,
  ENDDATE                DATE,
  CHANNEL                VARCHAR2(12 BYTE),
  MOODCD                 VARCHAR2(20 BYTE),
  FEEDSOURCENM           VARCHAR2(20 BYTE),
  C32STATUSDESC          VARCHAR2(200 BYTE),
  CAREPROVIDERID         NUMBER,
  servicingorgnm         Varchar2(200),
  DELETEDBYDATASOURCENM  VARCHAR2(20 BYTE)
);



--
-- MEDICATION_TAB  (Type) 
--
--  Dependencies: 
--   MEDICATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEDICATION_TAB AS TABLE OF MEDICATION_OBJ;



--
-- MEDPROC_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.Medproc_object     as object(
  medicalprocedurecode           VARCHAR2(50),
  procedurenm    VARCHAR2(100),
  elementid         NUMBER)



--
-- MEDPROC_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEDPROC_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.Medproc_object_ARRAY   as table of Medproc_object



--
-- MED_SUMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MED_SUMLIST_OBJ
AS
   OBJECT (CODESYSTEMNAME VARCHAR2 (200),
           MEDICALCODE VARCHAR2 (100),
           DRUGTRADENAME VARCHAR2 (100),
           DRUGDOSAGE VARCHAR2 (50),
           STARTDATE DATE,
           ENDDATE DATE,
           MOODCD VARCHAR2 (10),
           MEDCLASSCD VARCHAR2 (10),
           FEEDSOURCENM VARCHAR2 (20),
           C32STATUSDESC VARCHAR2 (200),
           CAREPROVIDERID NUMBER,
           SERVICINGORGNAME VARCHAR2 (100));



--
-- MED_SUMLIST_TAB  (Type) 
--
--  Dependencies: 
--   MED_SUMLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MED_SUMLIST_TAB IS TABLE OF MED_SUMLIST_OBJ;



--
-- MEEVIDENCELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.meevidencelist_obj
AS
   OBJECT (codetype varchar2 (20),
           code varchar2 (100),
           codesystem varchar2 (50),
           namedescription varchar2 (2000),
           clinicaldatavalue varchar2 (50),
           clinicaldataunits varchar2 (50),
           startdate varchar2 (20),
           enddates varchar2 (20),
           sensitiveflag varchar2 (50),
           datasource varchar2 (50),
           clientpatid varchar2 (100),
           patientissuingorgid varchar2 (64),
           servicingorgid varchar2 (64),
           servicingorgname varchar2 (50),
           cpproviderid number,
           providerissuingorgid varchar2 (64));



--
-- MEEVIDENCELIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEEVIDENCELIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.meevidencelist_tab IS TABLE OF meevidencelist_obj;



--
-- MEFDBLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEFDBLIST_OBJ AS
OBJECT(
MEFDBDATE                DATE,
MEFDBSTATUS              VARCHAR2(24),
MEFDBSTATUSREASON        NUMBER,
MEFDBCOMMENTS            VARCHAR2(4000),
MEFDBSOURCE              VARCHAR2(20)
);



--
-- MEFDBLIST_TAB  (Type) 
--
--  Dependencies: 
--   MEFDBLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEFDBLIST_TAB AS TABLE OF MEFDBLIST_OBJ;



--
-- MELISTMEM_OBJ  (Type) 
--
--  Dependencies: 
--   MECOMMLISTMEM_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MELISTMEM_OBJ
AS
   OBJECT (METRACKINGID NUMBER,
           MEID NUMBER,
           METITLE VARCHAR2 (1000),
           METYPECODE VARCHAR2 (24),
           MEIMPACTABLEFLAG VARCHAR2 (1),
           REASONFORIMPACTABLETXT VARCHAR2 (4000),
           MECHRONIC CHAR(1),
           MERANK NUMBER,
           MESEVERITY NUMBER,
           MECHANGEDATE DATE,
           CECOMPLETIONSTATUS CHAR(1),
           MEEXPIREDFLAG CHAR(1),
           MECOMMLIST MECOMMLISTMEM_TAB);



--
-- MELISTMEM_TAB  (Type) 
--
--  Dependencies: 
--   MELISTMEM_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MELISTMEM_TAB AS TABLE OF MELISTMEM_OBJ;



--
-- MELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEEVIDENCELIST_TAB (Type)
--   MECOMMLIST_TAB (Type)
--   MEMEDREFLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.melist_obj
AS
   OBJECT (metrackingid number,
           meid number,
           metitle varchar2 (1000),
           metypecode varchar2 (24),
           meproviderpriority number,
           meseverity number,
           mestatus varchar2 (30),
           mechangedate varchar2 (20),
           cecompletionstatus varchar2 (1),
           sensitiveflag varchar2 (1),
           cpproviderid number,
           providertype varchar2 (10),
           mecommlist mecommlist_tab,
           meevidencelist meevidencelist_tab,
           memedreflist memedreflist_tab);



--
-- MELIST_TAB  (Type) 
--
--  Dependencies: 
--   MELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.melist_tab IS TABLE OF melist_obj;



--
-- MEMBERCHATDETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.memberchatdetail_obj
IS OBJECT
(
 MemberChatDetailSkey NUMBER
,ChatTime TIMESTAMP
,ChatText VARCHAR2(4000)
,ChatSource VARCHAR2(50)
)



--
-- MEMBERCHATDETAIL_TAB  (Type) 
--
--  Dependencies: 
--   MEMBERCHATDETAIL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.memberchatdetail_tab IS TABLE OF memberchatdetail_obj



--
-- MEMBERCHATSUMMARY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.memberchatsummary_obj
IS OBJECT
(
 MemberChatSummarySkey NUMBER
,LiveChatEngagementID VARCHAR2(256)
,AgentID VARCHAR2(50)
,AgentFullName VARCHAR2(100)
,AgentLoginName VARCHAR2(255)
,ChatStartTime TIMESTAMP
,ChatEndTime TIMESTAMP
,StartReasonDesc VARCHAR2(255)
,EndReasonDesc VARCHAR2(255)
)



--
-- MEMBERCHATSUMMARY_TAB  (Type) 
--
--  Dependencies: 
--   MEMBERCHATSUMMARY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.memberchatsummary_tab IS TABLE OF memberchatsummary_obj



--
-- MEMBERDETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MEMBERDETAIL_OBJ" AS OBJECT (
Primarymemberplanid NUMBER,
careteampatientid NUMBER,
primaryflg VARCHAR2(1)
)



--
-- MEMBERDETAIL_TAB  (Type) 
--
--  Dependencies: 
--   MEMBERDETAIL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MEMBERDETAIL_TAB" As TABLE of MEMBERDETAIL_OBJ



--
-- MEMBERELIGIBILITY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MemberEligibility_OBJ AS OBJECT
(
MemberPlanID                 NUMBER,
SupplierID                   NUMBER,
RegisteredStatus             CHAR(1)
);



--
-- MEMBERELIGIBILITY_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEMBERELIGIBILITY_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.MemberEligibility_TAB IS TABLE OF MemberEligibility_OBJ;



--
-- MEMBERHEALTHSCOREPART_ARRAY  (Type) 
--
--  Dependencies: 
--   MEMBERHEALTHSCOREPART_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MEMBERHEALTHSCOREPART_ARRAY"
  as table of MEMBERHEALTHSCOREPART_OBJECT; 



--
-- MEMBERHEALTHSCOREPART_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEMBERHEALTHSCOREPART_OBJECT
as object(
    MEMBERHEALTHSTATESKEY number, 
    PRODUCTMNEMONICCD varchar2(50)
    ); 



--
-- MEMBERHEALTHSTATE_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEMBERHEALTHSTATE_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS."MEMBERHEALTHSTATE_ARRAY"
  as table of MEMBERHEALTHSTATE_OBJECT; 



--
-- MEMBERHEALTHSTATE_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEMBERHEALTHSTATE_OBJECT
as object(
    MEMBERHEALTHSTATESKEY number, 
    EPISODEID number,
    VERSIONNBR number,  
    STATETYPECD varchar2(4),
    STATECOMPONENTID number,
    MEMBERID number,
    HEALTHSTATESTATUSCD varchar2(12), 
    HEALTHSTATESTATUSCHANGERSNCD varchar2(12),
    HEALTHSTATESTATUSCHANGEDT date, 
    HEALTHSTATECHANGEDT date, SEVERITYLEVEL varchar2(12), COMPLETIONFLG char(1), 
    CLINICALREVIEWSTATUSCD varchar2(12), CLINICALREVIEWSTATUSDT date, LASTEVALUATIONDT date, 
    SEVERITYSCORE number,
    VOIDFLG varchar2(2)); 



--
-- MEMBERIDPLANID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEMBERIDPLANID_OBJ AS OBJECT (
MEMBERID NUMBER,
MEMBERPLANID NUMBER
);



--
-- MEMBERIDPLANID_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEMBERIDPLANID_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.MEMBERIDPLANID_TAB as TABLE OF ODS.MEMBERIDPLANID_OBJ;



--
-- MEMBERID_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MEMBERID_OBJECT"
  as object(
memberid     NUMBER);



--
-- MEMBERID_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   MEMBERID_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MEMBERID_OBJECT_ARRAY"
  as table of memberid_object;



--
-- MEMBERID_OBJECT_ROW  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MEMBERID_OBJECT_ROW"
  as object(
 memberid         NUMBER,
 ahmsupplierid    NUMBER,
 personid         NUMBER);



--
-- MEMBERINFO_ARRAY  (Type) 
--
--  Dependencies: 
--   MEMBERINFO_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEMBERINFO_ARRAY as table of memberinfo_object; 



--
-- MEMBERINFO_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEMBERINFO_OBJECT                                                                         
as object(
supplierid                  NUMBER,
memberid                    NUMBER,
patientid                   VARCHAR2(20),
dateofbirth                 DATE,
sex                         VARCHAR2(2),
firstname                   VARCHAR2(50),
lastname                    VARCHAR2(40),
primarysourceproviderid     VARCHAR2(200),
primarycareproviderid       NUMBER,
batchid                     NUMBER,
eligibility                 DATE
); 



--
-- MEMBERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.memberlist_obj AS OBJECT (
   memberplanid   NUMBER,
   memberid    NUMBER
)



--
-- MEMBERLIST_TAB  (Type) 
--
--  Dependencies: 
--   MEMBERLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.memberlist_tab AS TABLE OF memberlist_obj



--
-- MEMBERPLANIDCUMBID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.memberplanidcumbid_obj AS OBJECT (
   memberplanid   NUMBER,
   membercumbid    VARCHAR2(20)
)



--
-- MEMBERPLANIDCUMBID_TAB  (Type) 
--
--  Dependencies: 
--   MEMBERPLANIDCUMBID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.memberplanidcumbid_tab AS TABLE OF memberplanidcumbid_obj



--
-- MEMBERPROGRAMSESSION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.memberprogramsession_obj
is object (
programcd							varchar2(50),
enrollmentdt					date,
availablemembercount	number,
maxmembercount				number)



--
-- MEMBERPROGRAMSESSION_TAB  (Type) 
--
--  Dependencies: 
--   MEMBERPROGRAMSESSION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.memberprogramsession_tab is table of ods.memberprogramsession_obj



--
-- MEMBERREGDEVICE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MemberRegDevice_OBJ AS OBJECT
(
PushNotificationID     VARCHAR2(1000 BYTE),
DeviceType             VARCHAR2(100 BYTE),
DataSource             VARCHAR2(20 BYTE)
);



--
-- MEMBERREGDEVICE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEMBERREGDEVICE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.MemberRegDevice_TAB IS TABLE OF MemberRegDevice_OBJ;



--
-- MEMBER_OBJECTROW_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEMBERID_OBJECT_ROW (Type)
--
CREATE OR REPLACE TYPE ODS."MEMBER_OBJECTROW_ARRAY"
  as table of memberid_object_row;



--
-- MEMBER_PRODUCT_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEMBER_PRODUCT_OBJECT AS OBJECT (
   MEMBERID		NUMBER,
   PRODUCTCD     	VARCHAR2 (50 Byte)
)



--
-- MEMBER_PRODUCT_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   MEMBER_PRODUCT_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.MEMBER_PRODUCT_OBJECT_ARRAY AS TABLE OF MEMBER_PRODUCT_OBJECT



--
-- MEMEDREFLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEMEDREFLIST_OBJ as
  OBJECT (
MedRefAbbr    varchar2(200),
MedRefText    varchar2(500),
MedRefVolPg   varchar2(200)
);




--
-- MEMEDREFLIST_TAB  (Type) 
--
--  Dependencies: 
--   MEMEDREFLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MEMEDREFLIST_TAB IS TABLE OF MEMedRefList_obj;




--
-- MESSAGETOPIC_OBJ  (Type) 
--
--  Dependencies: 
--   PROGRAMTYP_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MESSAGETOPIC_OBJ
AS
  object
  (
    topiccd          VARCHAR2(4),
	topicdescription VARCHAR2(300),
    activeflag       CHAR(1),
    returncode       NUMBER,
	programtypcd     programtyp_tab
	);



--
-- MESSAGETOPIC_TAB  (Type) 
--
--  Dependencies: 
--   MESSAGETOPIC_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MESSAGETOPIC_TAB
AS
  TABLE OF MESSAGETOPIC_OBJ;



--
-- MEVIDENCELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MEVIDENCELIST_OBJ" IS OBJECT (
                                                       EvidenceType varchar2 (20),
                                                       EvidenceCode varchar2 (30),
                                                       EvidenceCodeSystemNm varchar2 (10),
                                                       ClaimDescription varchar2 (100),
                                                       startdate date,
                                                       enddate date,
                                                       SourceTrackingiD number,
                                                       ClinicalDataValue varchar2 (50),
                                                       ClinicalDataUnits varchar2 (50),
                                                       DataSource varchar2 (50),
                                                       UFName varchar2 (100),
                                                       UFDescription varchar2 (4000)
                                                    );



--
-- MEVIDENCELIST_TAB  (Type) 
--
--  Dependencies: 
--   MEVIDENCELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MEVIDENCELIST_TAB"
IS
   TABLE OF MEvidenceList_OBJ;



--
-- MHSFEEDBACK_ARRAY  (Type) 
--
--  Dependencies: 
--   MHSFEEDBACK_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."MHSFEEDBACK_ARRAY"
  as table of MHSFEEDBACK_OBJECT; 



--
-- MHSFEEDBACK_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MHSFEEDBACK_OBJECT AS OBJECT
(
  MHSFEEDBACKID NUMBER,
  MEMBERID NUMBER,
  REFERENCETYPE VARCHAR2(4 BYTE), 
  REFERENCEID NUMBER, 
  FDBKDATE DATE, 
  STATUSCODE VARCHAR2(12 BYTE),
  STATUSREASONCODE NUMBER, 
  FEEDBACKDATASOURCENM VARCHAR2(20 BYTE),
  COMMENTS VARCHAR2(4000 BYTE)
); 



--
-- MHSTRACKINGIDLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MHSTRACKINGIDLIST_OBJ IS OBJECT (
   MHSTRACKINGID NUMBER
   ); 



--
-- MHSTRACKINGIDLIST_TAB  (Type) 
--
--  Dependencies: 
--   MHSTRACKINGIDLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.MHSTRACKINGIDLIST_TAB IS TABLE OF MHSTRACKINGIDLIST_OBJ; 



--
-- NEW_DATA_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.NEW_DATA_OBJECT AS OBJECT
(
  MEMBERID NUMBER,
  BATCHID NUMBER
)



--
-- NEW_DATA_OBJECT_TABLE  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NEW_DATA_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.NEW_DATA_OBJECT_TABLE AS TABLE OF  NEW_DATA_OBJECT



--
-- NGX_AANURSE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_AANURSE_OBJ AS OBJECT (
           NurseUserID             VARCHAR2 (20),
           NurseName               VARCHAR2 (150),
           NURSEPHONE          VARCHAR2 (10),
           AAMAINPHONE             VARCHAR2 (10),
           AAMAINPHONEEXT          VARCHAR2 (10)
)



--
-- NGX_AANURSE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_AANURSE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ngx_AANURSE_TAB AS TABLE OF ngx_AANURSE_OBJ



--
-- NGX_ALLERGIESLIST_OBJ  (Type) 
--
--  Dependencies: 
--   NGX_ALLERGYREACTIONLIST_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_allergieslist_obj AS OBJECT (
   allergytype        VARCHAR2(30),
   allergyname		  VARCHAR2(256),
   reactionlist  	  NGX_ALLERGYREACTIONLIST_TAB,
   comments           VARCHAR2 (4000),
   odstrackingid	  NUMBER
)



--
-- NGX_ALLERGIESLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_ALLERGIESLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ngx_allergieslist_tab AS TABLE OF ngx_allergieslist_obj



--
-- NGX_ALLERGYREACTIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_allergyreactionlist_obj AS OBJECT (
   reactionname		  VARCHAR2(200)
)



--
-- NGX_ALLERGYREACTIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   NGX_ALLERGYREACTIONLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_allergyreactionlist_tab AS TABLE OF ngx_allergyreactionlist_obj



--
-- NGX_CONDDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.NGX_CONDDETAILLIST_OBJ
AS
   OBJECT (       conditiondate      DATE,
				  comments           VARCHAR2 (4000),
				  conditionstatuscode    VARCHAR2 (20),
                  selfreported       CHAR (1),
				  odstrackingid	  	 NUMBER
          )



--
-- NGX_CONDDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   NGX_CONDDETAILLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.NGX_CONDDETAILLIST_TAB as table of NGX_CONDDETAILLIST_OBJ



--
-- NGX_CONDSUMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.NGX_CONDSUMLIST_OBJ
AS
   OBJECT (       conditionname               VARCHAR2(200),
                  conditioncode               NUMBER
          )



--
-- NGX_CONDSUMLIST_TAB  (Type) 
--
--  Dependencies: 
--   NGX_CONDSUMLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.NGX_CONDSUMLIST_TAB as table of NGX_CONDSUMLIST_OBJ



--
-- NGX_HOSPVISITSLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_hospvisitslist_obj AS OBJECT (
   hospitalname        VARCHAR2(200),
   purpose		  	   VARCHAR2(1000),
   admissiondate	   DATE,
   dischargedate	   DATE,
   comments            VARCHAR2 (4000),
   physicianname	   VARCHAR2(200),
   odstrackingid	   NUMBER
)



--
-- NGX_HOSPVISITSLIST_TAB  (Type) 
--
--  Dependencies: 
--   NGX_HOSPVISITSLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_hospvisitslist_tab AS TABLE OF ngx_hospvisitslist_obj



--
-- NGX_LABDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_labdetaillist_obj AS OBJECT (
   servicedate        DATE,
   testresult		  VARCHAR2(200),
   drugunitofmeasure  VARCHAR2 (30),
   labtestmaxvalue	  NUMBER,
   labtestminvalue	  NUMBER,
   comments           VARCHAR2 (4000),
   selfreported       CHAR (1),
   odstrackingid	  NUMBER,
   providername		  VARCHAR2(200)
)



--
-- NGX_LABDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_LABDETAILLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ngx_labdetaillist_tab AS TABLE OF ngx_labdetaillist_obj



--
-- NGX_LABSUMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.NGX_LABSUMLIST_OBJ
AS
   OBJECT (       labname               VARCHAR2(500),
                  labcode               VARCHAR2(100)
          )



--
-- NGX_LABSUMLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_LABSUMLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.NGX_LABSUMLIST_TAB as table of NGX_LABSUMLIST_OBJ



--
-- NGX_MEDDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_MEDFILLDETAILS_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.ngx_meddetaillist_obj AS OBJECT (
   drugdosage         VARCHAR2 (30 BYTE),
   daysofsupply       NUMBER,
   selfreported       CHAR (1),
   medicationstatus   VARCHAR2 (255),
   medicationreason   VARCHAR2 (255),
   comments           VARCHAR2 (4000),
   phrmedicationid    NUMBER,
   drugfilldetails    ngx_medfilldetails_tab
)



--
-- NGX_MEDDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   NGX_MEDDETAILLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_meddetaillist_tab AS TABLE OF ngx_meddetaillist_obj



--
-- NGX_MEDFILLDETAILS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_medfilldetails_obj AS OBJECT (
   odstrackingid   NUMBER,
   drugfilldate    DATE
)



--
-- NGX_MEDFILLDETAILS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_MEDFILLDETAILS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ngx_medfilldetails_tab AS TABLE OF ngx_medfilldetails_obj



--
-- NGX_MEDSUMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_medsumlist_obj
AS
   OBJECT (       medicalname               VARCHAR2(200),
                  medicalcode               VARCHAR2(100),
          recentflag                CHAR(1)
          )



--
-- NGX_MEDSUMLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_MEDSUMLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ngx_medsumlist_tab as table of ngx_medsumlist_obj



--
-- NGX_MESSAGEDETAIL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ngx_messagedetail_obj as object
(
MessageID NUMBER,
MessageBody VARCHAR2 (4000),
isfrommember  VARCHAR2 (1),
IsTopicBased  VARCHAR2(1),
TopicCode VARCHAR2 (4),
TopicDescription VARCHAR2 (300),
MessageReadflag VARCHAR2 (1),
MessageCreateDate timestamp ,
NurseName   VARCHAR2 (150)
)



--
-- NGX_MESSAGEDETAIL_TAB  (Type) 
--
--  Dependencies: 
--   NGX_MESSAGEDETAIL_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_messagedetail_tab AS TABLE OF ngx_messagedetail_obj



--
-- NGX_MESSAGETHREAD_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ngx_messagethread_obj as object
(
ThreadID    NUMBER,
ThreadSubject VARCHAR2(100),
ThreadReadFlag VARCHAR2 (1),
TotalMessageCount  NUMBER,
Type varchar2(20),  --DOCUMENT, THREAD
MessageID NUMBER,
MessageBody VARCHAR2 (4000),
isfrommember  VARCHAR2 (1),
TopicCode VARCHAR2 (4),
TopicDescription VARCHAR2 (300),
MessageCreateDate timestamp ,
NurseName   VARCHAR2 (150),
IsTopicBased VARCHAR2 (1)
)



--
-- NGX_MESSAGETHREAD_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_MESSAGETHREAD_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ngx_messagethread_tab AS TABLE OF ngx_messagethread_obj



--
-- NGX_MESSAGETOPIC_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ngx_MESSAGETOPIC_OBJ AS OBJECT
  (
    topiccd          VARCHAR2(4),
    topicdescription VARCHAR2(300),
    activeflag       CHAR(1)
  )



--
-- NGX_MESSAGETOPIC_TAB  (Type) 
--
--  Dependencies: 
--   NGX_MESSAGETOPIC_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ngx_MESSAGETOPIC_tab as table of ngx_MESSAGETOPIC_OBJ



--
-- NGX_PROCDETAILLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_procdetaillist_obj AS OBJECT (
   servicedate     DATE,
   odstrackingid   NUMBER
)



--
-- NGX_PROCDETAILLIST_TAB  (Type) 
--
--  Dependencies: 
--   NGX_PROCDETAILLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ngx_procdetaillist_tab AS TABLE OF ngx_procdetaillist_obj



--
-- NGX_PROCSUMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_PROCDETAILLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.ngx_procsumlist_obj AS OBJECT (
   procedurename      VARCHAR2 (200),
   procedurecode      VARCHAR2 (100),
   comments           VARCHAR2 (4000),
   selfreported       CHAR (1),
   phrprocedureid     NUMBER,
   proceduredetails   ngx_procdetaillist_tab
)



--
-- NGX_PROCSUMLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NGX_PROCSUMLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ngx_procsumlist_tab AS TABLE OF ngx_procsumlist_obj



--
-- NOTEITEMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.NOTEITEMLIST_OBJ AS OBJECT
  (
    noteitemid     NUMBER ,
    notestatusdate DATE ,
    notetypecd     VARCHAR2 (5) ,
    notetext       nclob ,
    username       VARCHAR2 (100) );



--
-- NOTEITEMLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   NOTEITEMLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.NOTEITEMLIST_TAB IS TABLE OF ods.noteitemlist_obj;



--
-- NUM_ARR_T  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.num_arr_t is table of number 



--
-- ODSID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."ODSID_OBJ" IS OBJECT
(odsid NUMBER)



--
-- ODSID_TAB  (Type) 
--
--  Dependencies: 
--   ODSID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."ODSID_TAB" IS TABLE of odsid_OBJ



--
-- ODSVARCHAR_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ODSVARCHAR_OBJ
IS
   OBJECT (ODSVARCHAR VARCHAR2 (200));



--
-- ODSVARCHAR_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   ODSVARCHAR_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ODSVARCHAR_TAB IS TABLE OF ODSVARCHAR_OBJ



--
-- ODS_ALERTFEEDBACKLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ODS_ALERTFEEDBACKLIST_OBJ AS OBJECT(
STATECOMPONENTID      NUMBER,
STATETYPECD           VARCHAR2(4),
COMMTARGETMNEMONIC    VARCHAR2(12),
FDBKSTATUSCD          VARCHAR2(12),
FDBKSTATUSDESC        VARCHAR2(200),
FDBKSTATUSREASONCD    NUMBER,
STATUSREASONDESC      VARCHAR2(200),
DISPLAYORDERNBR       NUMBER);



--
-- ODS_ALERTFEEDBACKLIST_TAB  (Type) 
--
--  Dependencies: 
--   ODS_ALERTFEEDBACKLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ODS_ALERTFEEDBACKLIST_TAB IS TABLE OF ODS_ALERTFEEDBACKLIST_OBJ;



--
-- ODS_DELMITEDSTRING_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ods_delmitedstring_tab IS TABLE OF varchar2 (8192);



--
-- ODS_ETLDELMITEDSTRING_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ods_etldelmitedstring_tab IS TABLE OF varchar2 (8192);



--
-- ODS_NOTIFICATIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ods_notificationlist_tab IS TABLE OF dt_ii_obj;



--
-- ODS_OTHEREXTRLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   ODS_OTHERLIST_TAB (Type)
--
CREATE OR REPLACE type ODS.ods_otherextrlist_obj is object (memberplanid number,
                                      otherextrlist ods_otherlist_tab);



--
-- ODS_OTHEREXTRLIST_TAB  (Type) 
--
--  Dependencies: 
--   ODS_OTHEREXTRLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ods_otherextrlist_tab is table of ods_otherextrlist_obj;



--
-- ODS_OTHERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ods_otherlist_obj is object (
                                                    type  varchar2(20),
                                                    orgid dt_ii_obj
                                                   );



--
-- ODS_OTHERLIST_TAB  (Type) 
--
--  Dependencies: 
--   ODS_OTHERLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.ods_otherlist_tab is table of ods_otherlist_obj;



--
-- PARTY_ADDRESS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PARTY_ADDRESS_OBJ"
AS  OBJECT
  (addrtypecd    varchar2 (20),
   addrline1    varchar2 (255),
   addrline2    varchar2 (255),
   citynm    varchar2 (100),
   countynm    varchar2 (100),
   statecd    varchar2 (2),
   countrycd    varchar2 (3),
   zipcd    varchar2 (5),
   prioritycd    varchar2 (12),
   statuscd    varchar2 (12),
   effdt    date,
   expdt    date,
   skey      number,
   expflag    varchar2 (1));




--
-- PARTY_ADDRESS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PARTY_ADDRESS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."PARTY_ADDRESS_TAB" IS   TABLE OF ods.PARTY_ADDRESS_OBJ;


--------------------------------------------------




--
-- PARTY_ALTERNATE_ID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PARTY_ALTERNATE_ID_OBJ" AS
OBJECT (alternateid    varchar2 (50 ),
 typecd            varchar2 (12 ),
 issuingorgid    varchar2 (100 ),
 effdt            Date    ,
 expFlag    varchar2 (1));




--
-- PARTY_ALTERNATE_ID_TAB  (Type) 
--
--  Dependencies: 
--   PARTY_ALTERNATE_ID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PARTY_ALTERNATE_ID_TAB" IS TABLE OF ods.PARTY_ALTERNATE_ID_OBJ;




--
-- PARTY_ALT_ADDRESS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PARTY_ALT_ADDRESS_OBJ"
AS
   OBJECT (addrtypecd        varchar2 (20),
           addrfunctioncd   varchar2 (20 ),
           addrvalue        varchar2 (255 ),
           prioritycd        varchar2 (20 ),
           statuscd        varchar2 (20 ),
           effdt        date,
           expdt        date,
           skey          number,
           expflag        varchar2 (1)

           );




--
-- PARTY_ALT_ADDRESS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PARTY_ALT_ADDRESS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."PARTY_ALT_ADDRESS_TAB" IS   TABLE OF ods.PARTY_ALT_ADDRESS_OBJ;


----------------------------




--
-- PATIENTCACHE_OBJ  (Type) 
--
--  Dependencies: 
--   CT_PATIENTDECEASED_TAB (Type)
--   CT_PATIENT_ADDRESS_TAB (Type)
--   CT_PATIENT_EMAIL_TAB (Type)
--   CT_ALTID_TAB (Type)
--   CT_POPULATIONFOCUSTAG_TAB (Type)
--   STANDARD (Package)
--   CT_PATIENT_MEMBERSETTING_TAB (Type)
--   CT_PATIENT_PHONE_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.patientcache_obj
IS
  OBJECT
  (
    accountid              NUMBER,
    memberplanid           NUMBER,
    clientpatid            VARCHAR2 (50),
    patissuingorgoid       VARCHAR2 (64),
    gender                 VARCHAR2 (10),
    dateofbirth            DATE,
    firstname              VARCHAR2 (50),
    lastname               VARCHAR2 (50),
    ethnicity              VARCHAR2 (50),
    supplierid             NUMBER,
    suppliername           VARCHAR2 (200),
    effstartdate           DATE,
    effenddate             DATE,
    acteligibilityflag     VARCHAR2 (1),
    addresslist            ct_patient_address_tab,
    phonelist              ct_patient_phone_tab,
    emaillist              ct_patient_email_tab,
    patientdeathinfolist   ct_patientdeceased_tab,
    membersettinglist      ct_patient_membersetting_tab,
    altidlist              ct_altid_tab,
    datasourcenm           VARCHAR2 (20),
    winnercity             VARCHAR2 (50),
    winnerzip              VARCHAR2 (10),
    actsearchflag          VARCHAR2 (1),
    PopulationFocusTaglist ct_PopulationFocusTag_TAB, -- Added by Poorani on 09192014
    Aetnaemplflg           VARCHAR2 (1)  -- Added by Subbiah on 23062015 for US57873
  )



--
-- PATIENTCACHE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PATIENTCACHE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.patientcache_tab IS TABLE OF patientcache_obj;



--
-- PATIENTDEMO_OBJ  (Type) 
--
--  Dependencies: 
--   DT_II_OBJ (Type)
--   DT_PERSON_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."PATIENTDEMO_OBJ" AS
OBJECT (issuing_oid DT_II_OBJ,
        patient_Person dt_Person_obj)



--
-- PATIENTDEMO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PATIENTDEMO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."PATIENTDEMO_TAB" as TABLE OF patientdemo_obj



--
-- PATIENTIDTRACKER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   DT_II_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.PATIENTIDTRACKER_OBJ
AS  OBJECT
(
TYPECD    VARCHAR2(1),
EMPIID  dt_ii_obj,
ORPHANTYPECD   NUMBER,
MRNID  dt_ii_obj,
OLDLOCALMRN dt_ii_obj,
ACCOUNTOID VARCHAR2(64)
);



--
-- PATIENTIDTRACKER_TBL  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PATIENTIDTRACKER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.patientidtracker_tbl AS TABLE OF patientidtracker_obj;



--
-- PATIENT_AGGREGATE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PATIENT_AGGREGATE_OBJ"
AS
OBJECT
(
PATIENTID    VARCHAR2(30),
ISSUINGORGID    VARCHAR2(30),
MASTERPATIENTFLAG    VARCHAR2(1),
EFFECTIVE_START_DATE    DATE,
EFFECTIVE_END_DATE    DATE,
UPDATE_ACTION_TYPE    VARCHAR2(1)
);




--
-- PATIENT_AGGREGATE_TAB  (Type) 
--
--  Dependencies: 
--   PATIENT_AGGREGATE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PATIENT_AGGREGATE_TAB"
IS
   TABLE OF PATIENT_AGGREGATE_OBJ;




--
-- PATIENT_DEMOGRAPHICS_OBJ  (Type) 
--
--  Dependencies: 
--   PARTY_ADDRESS_TAB (Type)
--   STANDARD (Package)
--   PARTY_ALT_ADDRESS_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."PATIENT_DEMOGRAPHICS_OBJ"
AS  OBJECT(
Givennm                         varchar2 (100 ),
Familynm                 varchar2 (100 ),
Middlenm                 varchar2 (100 ),
Title                         varchar2 (5 ),
nicknm                         varchar2 (100 ),
birthdt                         Date,
deceaseddt                 Date,
legalnm                         varchar2 (100 ),
suffixcd                 varchar2 (10 ),
gendercd                  char (1 ),
gendercdsystemoid         varchar2 (30 ),
maritalstatuscdsystemoid     varchar2 (30 ),
maritalstatuscd                 char (1 ),
effdt                         date,
expdt                         date,
VIPFlag                         varchar(1)    ,
patientaddresslist         party_address_tab,
partyalternateaddress         PARTY_ALT_ADDRESS_TAB,
updateflag                   varchar2 (1)    );




--
-- PATIENT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PARTY_ALTERNATE_ID_TAB (Type)
--   SOURCE_DOC_OBJ (Type)
--   PATIENT_DEMOGRAPHICS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.PATIENT_OBJ AS
  OBJECT (SOURCEPATIENTID             varchar2 (50),
          HIEPATIENTID                varchar2(40),
          MASTERINDEXFLG              varchar2 (1),
          PATIENTIDENTITYSOURCEOID    varchar2 (100),
          PRIMARYHOSPITALOID          varchar2 (100),
          PRIMARYMEMBERPLANID         varchar2(50),
          MEMBERID                    number,
          SUPPLIERID                  number,
          MEMBERTYPECODE              varchar(2),
          DATASOURCENM                varchar2(20),
          DSN_PatientId               varchar2(20),
          SOURCE_DOC                  source_doc_obj,
          PATIENTDEMO                 patient_demographics_obj,
          ALTIDS                      party_alternate_id_tab
          );



--
-- PATIENT_TAB  (Type) 
--
--  Dependencies: 
--   PATIENT_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.patient_tab IS TABLE OF ods.patient_obj;



--
-- PERSONNELLISTREQ_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PERSONNELLISTREQ_OBJ
as object (
PersonnelID      NUMBER,
PersonnelType    VARCHAR2(20));




--
-- PERSONNELLISTREQ_TAB  (Type) 
--
--  Dependencies: 
--   PERSONNELLISTREQ_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PERSONNELLISTREQ_TAB IS TABLE OF PersonnelListReq_OBJ;




--
-- PERSONNELLISTRSP_OBJ  (Type) 
--
--  Dependencies: 
--   GETPERSONELDTLSADDRINFO_TAB (Type)
--   GETPERSONELDTLSPHONEINFO_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PERSONNELLISTRSP_OBJ
AS
   OBJECT (personnelid number,
           personneltype varchar2 (20),
           firstname varchar2 (50),
           lastname varchar2 (50),
           middlename varchar2 (50),
           title varchar2 (20),
           namesuffix varchar2 (20),
           nameprefix varchar2 (10),
           sourceuserid varchar2 (200),
           sourceissuingoid varchar2 (64),
           accountmasteruserid varchar2 (200),
           licensenumber varchar2 (50),
           licensestateoid varchar2 (64),
           deanumber varchar2 (20),
           upin varchar2 (64),
           npi varchar2 (20),
           effectiveenddate date,
           emailaddress varchar2 (50),
           role varchar2 (50),
           secondaryrole varchar2 (50),
           speciality1 varchar2 (100),
           speciality2 varchar2 (100),
           speciality3 varchar2 (100),
           facilityname varchar2 (100),
           facilityoid varchar2 (64),
           updateddate date,
           datasourcenm varchar2 (20),
           addresslist getpersoneldtlsaddrinfo_tab,
           phonelist getpersoneldtlsphoneinfo_tab,
           returncode varchar2 (10));



--
-- PERSONNELLISTRSP_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PERSONNELLISTRSP_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.PERSONNELLISTRSP_TAB IS TABLE OF personnellistrsp_obj;



--
-- PHONELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.phonelist_obj IS OBJECT (
   odstrackingid          NUMBER,
   phonefaxnumber         NUMBER,
   phonefaxtype           VARCHAR2 (15),
   phonefaxusagetype      VARCHAR2 (20),
   phonefaxlocationcode   VARCHAR2 (15),
   preferredflg           CHAR (1),
   updatedsourcename      VARCHAR2 (20),
   updateddate            DATE,
   channel                VARCHAR2 (10),
   deletedbysource        VARCHAR2 (20)
);



--
-- PHONELIST_TAB  (Type) 
--
--  Dependencies: 
--   PHONELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.phonelist_tab IS TABLE OF phonelist_obj;



--
-- PHRPARTICIPATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHRPARTICIPATION_OBJ IS OBJECT (
  EligibilityCode number,
  surveycomplete char(1),
  SurveyResponseDt date,
  SurveyCompleteDt date,
  PHRRegisteredDate date,
  PHRTerminationDate date,
  PHRCaseStatus VARCHAR2 (20),
  MobileLastLoginDt date
);



--
-- PHRPARTICIPATION_TAB  (Type) 
--
--  Dependencies: 
--   PHRPARTICIPATION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHRPARTICIPATION_TAB IS TABLE OF phrparticipation_obj



--
-- PHR_SETMBRHRA  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETMBRHRA AS OBJECT (
  memberplanidentifier    NUMBER,
  memberid                NUMBER,
  hraassmntid             NUMBER,
  hraanswerid             NUMBER,
  hraquestionid           NUMBER,
  hraquestiontype         VARCHAR2(15),
  datasourcenm            VARCHAR2(20),
  responsedt              DATE,
  responsetext            VARCHAR2(4000),
  responsevalue           NUMBER);



--
-- PHR_SETMBRHRA_ARRAY  (Type) 
--
--  Dependencies: 
--   PHR_SETMBRHRA (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETMBRHRA_ARRAY AS TABLE OF PHR_SETMBRHRA;



--
-- PHR_SETMBRSSHRA  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETMBRSSHRA
 AS OBJECT (
  memberplanidentifier    NUMBER,
  memberid                NUMBER,
  hraassmntid             NUMBER,
  hraanswerid             NUMBER,
  hraquestionaireid       NUMBER,
  hraquestionid           NUMBER,
  hraquestiontype         VARCHAR2(15),
  datasourcenm            VARCHAR2(20),
  responsedt              DATE,
  responsetext            VARCHAR2(4000),
  responsevalue           NUMBER,
  responsescore           NUMBER);



--
-- PHR_SETMBRSSHRA_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PHR_SETMBRSSHRA (Type)
--
CREATE OR REPLACE TYPE ODS.PHR_SETMBRSSHRA_ARRAY AS TABLE OF PHR_SETMBRSSHRA;



--
-- PHR_SETMEDS4MBR  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETMEDS4MBR AS OBJECT (
  memberplanidentifier    NUMBER,
  vndcout                 VARCHAR2(20),
  vtradenm                VARCHAR2(50),
  transactiondate         DATE,
  updatedby               VARCHAR2(30),
  status                  VARCHAR2(50),
  statusreason            VARCHAR2(60),
  vfilldt                 DATE,
  vcomment                VARCHAR2(4000)); 



--
-- PHR_SETMEDS4MBR_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PHR_SETMEDS4MBR (Type)
--
CREATE OR REPLACE TYPE ODS.PHR_SETMEDS4MBR_ARRAY AS TABLE OF PHR_SETMEDS4MBR; 



--
-- PHR_SETMEDS4MBR_ARRAY_M  (Type) 
--
--  Dependencies: 
--   PHR_SETMEDS4MBR_M (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETMEDS4MBR_ARRAY_M AS TABLE OF PHR_SETMEDS4MBR_M;



--
-- PHR_SETMEDS4MBR_M  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETMEDS4MBR_m AS OBJECT (
  vmemberid               NUMBER,
  vndcout                 VARCHAR2(20),
  vtradenm                VARCHAR2(50),
  transactiondate         DATE,
  updatedby               VARCHAR2(30),
  status                  VARCHAR2(50),
  statusreason            VARCHAR2(60),
  vfilldt                 DATE,
  vcomment                VARCHAR2(4000));



--
-- PHR_SETPROCS4MBR  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETPROCS4MBR AS OBJECT (
  memberplanidentifier    NUMBER,
  CPTCODE       VARCHAR2(20),
  transactiondate    DATE,
  updatedby         VARCHAR2(30),
  systemsource      VARCHAR2(20),
  vlatest_service_date   DATE,
  procedurecomment      VARCHAR2(4000)); 



--
-- PHR_SETPROCS4MBR_ARRAY  (Type) 
--
--  Dependencies: 
--   PHR_SETPROCS4MBR (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETPROCS4MBR_ARRAY AS TABLE OF PHR_SETPROCS4MBR; 



--
-- PHR_SETPROCS4MBR_ARRAY_M  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PHR_SETPROCS4MBR_M (Type)
--
CREATE OR REPLACE TYPE ODS.PHR_SETPROCS4MBR_ARRAY_m AS TABLE OF PHR_SETPROCS4MBR_m;



--
-- PHR_SETPROCS4MBR_M  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETPROCS4MBR_m AS OBJECT (
  vmemberid              NUMBER,
  CPTCODE                VARCHAR2(20),
  transactiondate        DATE,
  updatedby              VARCHAR2(30),
  systemsource           VARCHAR2(20),
  vlatest_service_date   DATE,
  procedurecomment       VARCHAR2(4000));




--
-- PHR_SETRECOMMEND  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETRECOMMEND AS OBJECT(
  caserecommendationid        NUMBER);



--
-- PHR_SETRECOMMEND_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PHR_SETRECOMMEND (Type)
--
CREATE OR REPLACE TYPE ODS.PHR_SETRECOMMEND_ARRAY AS
TABLE OF PHR_SETRECOMMEND;



--
-- PHR_SETWELLNESSREFERRAL  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PHR_SETWELLNESSREFERRAL AS OBJECT (
  personid               NUMBER,
  referraldate           DATE,
  phonefaxtype           VARCHAR2(15))



--
-- PHR_SETWELLNESSREFERRAL_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PHR_SETWELLNESSREFERRAL (Type)
--
CREATE OR REPLACE TYPE ODS.PHR_SETWELLNESSREFERRAL_ARRAY AS TABLE OF PHR_SETWELLNESSREFERRAL



--
-- PREAUTH_EVENTLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.preauth_eventlist_obj IS OBJECT (
   memberplanid                            NUMBER
  ,sourcecaseid                            VARCHAR2 (20)
  ,inoutpatientflg                         VARCHAR2 (1)
  ,admitdt                                 DATE
  ,dischargedt                             DATE
  ,approvedlengthofstay                    NUMBER
  ,diagcodesettype                         VARCHAR2 (10)
  ,primarydiagnosiscd                      VARCHAR2 (20)
  ,proccodesettype                         VARCHAR2 (10)
  ,primaryprocedurecd                      VARCHAR2 (20)
  ,admittingproviderlastnm                 VARCHAR2 (40)
  ,admittingproviderfirstnm                VARCHAR2 (32)
  ,admittingproviderphone                  VARCHAR2 (15)
  ,admittingproviderstate                  VARCHAR2 (2)
  ,facilitynm                              VARCHAR2 (60)
  ,facilityphone                           VARCHAR2 (15)
  ,facilitystate                           VARCHAR2 (2)
  ,sourcerecordsentdt                      DATE
  ,sourcefiletypecd                        VARCHAR2 (10)
  ,vendorsourcenm                          VARCHAR2 (20)
)



--
-- PREAUTH_EVENTLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PREAUTH_EVENTLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.preauth_eventlist_tab IS TABLE OF preauth_eventlist_obj



--
-- PREAUTH_EVENT_RESPONSE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.preauth_event_response_obj IS OBJECT (
	memberplanid                            NUMBER
   ,sourcecaseid                            VARCHAR2 (20)
   ,returncode								NUMBER
   ,cerunreturncode							NUMBER
)



--
-- PREAUTH_EVENT_RESPONSE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PREAUTH_EVENT_RESPONSE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.preauth_event_response_tab IS TABLE OF preauth_event_response_obj



--
-- PROBLEMCURSOR_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PROBLEMCURSOR_OBJ" IS OBJECT (
                                                       ProblemInstanceID number,
                                                       ProblemType varchar2 (255),
                                                       CodeSystemName varchar2 (20),
                                                       MedicalCode varchar2 (20),
                                                       MedicalCodeDescription varchar2 (500),
                                                       StartDate date,
                                                       EndDate date,
                                                       FeedSourceNm varchar2 (20),
                                                       C32StatusDesc varchar2 (200),
                                                       CareProviderID number,
                                                       ServicingOrgName varchar2 (200)
                                                    );



--
-- PROBLEMCURSOR_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROBLEMCURSOR_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."PROBLEMCURSOR_TAB"
IS
   TABLE OF problemcursor_obj;



--
-- PROCEDURECURSOR_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PROCEDURECURSOR_OBJ" IS OBJECT (
                                                         codesystemname VARCHAR2 (10),
                                                         medicalcode VARCHAR2 (20),
                                                         procedurename VARCHAR2 (100),
                                                         odsinstancetrackingid NUMBER,
                                                         odssummarytrackingid NUMBER,
                                                         ufprocedurename VARCHAR2 (100),
                                                         ufproceduredescription VARCHAR2 (4000),
                                                         startdate DATE,
                                                         enddate DATE,
                                                         moodcd VARCHAR2 (12),
                                                         feedsourcenm VARCHAR2 (20),
                                                         c32statusdesc VARCHAR2 (200),
                                                         careproviderid NUMBER,
                                                         servicingorgname VARCHAR2 (100)
                                                      );



--
-- PROCEDURECURSOR_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROCEDURECURSOR_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."PROCEDURECURSOR_TAB"
IS
   TABLE OF procedurecursor_obj;



--
-- PROCEDUREDTLCURSOR_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PROCEDUREDTLCURSOR_OBJ" IS OBJECT (
                                                            ODSInstanceTrackingID number,
                                                            StartDate date,
                                                            EndDate date,
                                                            MoodCD varchar2 (12),
                                                            FeedSourceNm varchar2 (20),
                                                            C32StatusDesc varchar2 (200),
                                                            CareProviderID number,
                                                            ServicingOrgName varchar2 (100)
                                                         );



--
-- PROCEDUREDTLCURSOR_TAB  (Type) 
--
--  Dependencies: 
--   PROCEDUREDTLCURSOR_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PROCEDUREDTLCURSOR_TAB"
IS
   TABLE OF proceduredtlcursor_obj;



--
-- PROCEDURELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PROCEDURELIST_OBJ IS OBJECT (
   ODSINSTANCETRACKINGID NUMBER,
   ODSSUMMARYTRACKINGID NUMBER,
   PROCEDURENAME VARCHAR2(100),
   CODESYSTEMNAME VARCHAR2(10),
   MEDICALCODE VARCHAR2(20),
   FEEDSOURCENM VARCHAR2(20),
   PROCEDURECOMMENT VARCHAR2(4000),
   RETURNCODE NUMBER
);



--
-- PROCEDURELIST_TAB  (Type) 
--
--  Dependencies: 
--   PROCEDURELIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PROCEDURELIST_TAB IS TABLE OF PROCEDURELIST_OBJ;



--
-- PROCEDURE_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PROCEDURE_OBJECT as object(
  memberid       NUMBER,
  dateofevent    DATE,
  code           VARCHAR2(20),
  instanceid     NUMBER,
  careproviderid NUMBER,
  sourceproviderid VARCHAR2(30)); 



--
-- PROCEDURE_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROCEDURE_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.PROCEDURE_OBJECT_ARRAY as table of PROCEDURE_OBJECT; 



--
-- PROCRIGENROLELIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ProcRigEnrolelist_obj
AS
  OBJECt
  (         productcode        VARCHAR2(20),
            registrationflg  VARCHAR2(1),
           registrationdt   DATE,
           enrollmentflg   VARCHAR2(1),
           enrollmentdt    DATE

);



--
-- PROCRIGENROLELIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROCRIGENROLELIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ProcRigEnrolelist_tab
AS
  TABLE OF ProcRigEnrolelist_obj;



--
-- PRODUCTELIGIBILITY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROGRAMLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.PRODUCTELIGIBILITY_OBJ IS OBJECT (
   ProductMnemonicCd VARCHAR2 (50 Byte),
   productowner VARCHAR2 (10 Byte),
   populationeligibilitycd  VARCHAR2 (10 Byte),
   onlinemode VARCHAR2 (10 Byte),
   TelephonicMode VARCHAR2 (10 Byte),
   ChatMode VARCHAR2 (10 Byte),
   EffectiveStartDate date,
   EffectiveEndDate date,
   ExecutionMode varchar2(4),
   ProgramList ProgramList_tab
);



--
-- PRODUCTELIGIBILITY_TAB  (Type) 
--
--  Dependencies: 
--   PRODUCTELIGIBILITY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PRODUCTELIGIBILITY_TAB
IS
   TABLE OF producteligibility_obj;



--
-- PRODUCTLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.productlist_obj
AS
  OBJECT
  (
    productcode        VARCHAR2(20)

);



--
-- PRODUCTLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PRODUCTLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.productlist_tab
AS
  TABLE OF productlist_obj;



--
-- PRODUCT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.product_obj IS OBJECT
                                                                                    (
                                                                                    productcd varchar2(50),
                                                                                    AssignedTaskid NUMBER,
                                                                                    ERRORCODE       NUMBER
                                                                                    );




--
-- PRODUCT_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.product_object AS OBJECT (
    MEMBERID NUMBER,
    CMSTYPE VARCHAR2(12),
    AACASEID NUMBER,
    AACASETRACKID NUMBER,
    TRACKTYPECD VARCHAR2(12),
    TRACKPHASECD VARCHAR2(12),
    TRACKSTATUSCD VARCHAR2(12),
    TRACKPHASEDT DATE
);



--
-- PRODUCT_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   PRODUCT_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PRODUCT_OBJECT_ARRAY AS TABLE OF product_object;



--
-- PRODUCT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PRODUCT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.product_tab IS TABLE OF product_obj;



--
-- PROGRAMLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.ProgramList_obj IS OBJECT (
  ProgramMnemonicCd VARCHAR2 (50 Byte),
  onlinemode VARCHAR2 (10 Byte),
  TelephonicMode VARCHAR2 (10 Byte),
  ChatMode VARCHAR2 (10 Byte),
  EffectiveStartDate date,
  EffectiveEndDate date
);




--
-- PROGRAMLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROGRAMLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.ProgramList_tab IS TABLE OF ProgramList_obj;



--
-- PROGRAMTYP_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.programtyp_obj
AS
  object
  (
    programtypcd      VARCHAR2(30),
	ProgramTrack     VARCHAR2(50),
	Markerid       NUMBER,
    MarkerTitle        VARCHAR2(2000)
	);



--
-- PROGRAMTYP_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROGRAMTYP_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.programtyp_tab
AS
  TABLE OF programtyp_obj;



--
-- PROVIDERCACHE_OBJ  (Type) 
--
--  Dependencies: 
--   PRVCACHE_PERSONNEL_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.PROVIDERCACHE_OBJ AS OBJECT (personnellist prvcache_personnel_OBJ); 



--
-- PROVIDERCACHE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROVIDERCACHE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.PROVIDERCACHE_TAB AS TABLE OF providercache_obj; 



--
-- PROVIDERID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PROVIDERID_OBJ AS OBJECT (
PROVIDERID NUMBER,
FIRSTNAME VARCHAR2(50),
LASTNAME VARCHAR2(40),
IDTYPE VARCHAR2(100),
SPECIALTY VARCHAR2(100)
);



--
-- PROVIDERID_TAB  (Type) 
--
--  Dependencies: 
--   PROVIDERID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PROVIDERID_TAB as TABLE OF ODS.PROVIDERID_OBJ;



--
-- PROVIDERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PROVIDERLIST_OBJ AS OBJECT (
	   providerid               NUMBER,
           providername             VARCHAR2(200),
           specialty1               VARCHAR2(100),
           specialty2               VARCHAR2(100),
           specialty3               VARCHAR2(100),
           providerpin              VARCHAR2(200),
           providertin              VARCHAR2(9),
           servicedt                DATE,
           effectiveenddt           DATE,
           datasource               VARCHAR2(20),
           addrline1                VARCHAR2(50),
           addrline2                VARCHAR2(50),
           city                     VARCHAR2(50),
           state                    VARCHAR2(2),
           zipcode                  VARCHAR2(5),
           phone1                   NUMBER,
           phone2                   NUMBER
           );




--
-- PROVIDERLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROVIDERLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.PROVIDERLIST_TAB AS TABLE OF providerlist_obj;



--
-- PROVIDERORGLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PERSONNELLISTRSP_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.PROVIDERORGLIST_OBJ
AS
   OBJECT (prvorgoid varchar2 (64), prvorgname varchar2 (200), personnellist personnellistrsp_tab);



--
-- PROVIDERORGLIST_TAB  (Type) 
--
--  Dependencies: 
--   PROVIDERORGLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PROVIDERORGLIST_TAB IS TABLE OF providerorglist_obj;



--
-- PROVIDERORG_OBJ  (Type) 
--
--  Dependencies: 
--   DT_SCORG_OBJ (Type)
--
CREATE OR REPLACE type ODS.providerorg_obj as object
(
    providerorg_id         dt_scorg_obj,
    parentorg              dt_scorg_obj

);



--
-- PROVIDER_OBJ  (Type) 
--
--  Dependencies: 
--   PROVIDERORG_OBJ (Type)
--   DT_TEL_TAB (Type)
--   DT_PN_OBJ (Type)
--   DT_II_OBJ (Type)
--   DT_ADDR_OBJ (Type)
--   DT_CE_OBJ (Type)
--
CREATE OR REPLACE type ODS.provider_obj as object
(
    accountoid      dt_ii_obj,
    prov_id         dt_ii_obj,
    prov_role       dt_ce_obj,
    prov_type       dt_ce_obj,
    prov_name       dt_pn_obj,
    prov_addr       dt_addr_obj,
    prov_tel        dt_tel_tab,
    prov_org        providerorg_obj,
    prov_localmrn   dt_ii_obj
)



--
-- PROVIDER_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.PROVIDER_OBJECT AS OBJECT
(
  ALTPROVIDERID VARCHAR2(50),
  PROVIDERID NUMBER
)



--
-- PROVIDER_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PROVIDER_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.PROVIDER_OBJECT_ARRAY   as table of PROVIDER_OBJECT



--
-- PROVIDER_SUMM_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PROVIDER_SUMM_OBJ"
AS
   OBJECT (providerid NUMBER,
           providername varchar2 (200),
           providerspecialty1 VARCHAR2 (100 BYTE),
           phone1 NUMBER,
           phone2 NUMBER);



--
-- PROVIDER_SUMM_TAB  (Type) 
--
--  Dependencies: 
--   PROVIDER_SUMM_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."PROVIDER_SUMM_TAB"
AS
   TABLE OF provider_summ_obj;



--
-- PROVIDER_TAB  (Type) 
--
--  Dependencies: 
--   PROVIDER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.provider_tab is table of provider_obj



--
-- PRVCACHE_PERSONNEL_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   GETPERSONELDTLSPHONEINFO_TAB (Type)
--   PRVCACHE_SPECIALITY_TAB (Type)
--   USERORGINFO_TAB (Type)
--   GETPERSONELDTLSADDRINFO_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.PRVCACHE_PERSONNEL_OBJ
AS
   OBJECT (AccountID number,
           AccountName varchar2 (250),
           --PrvOrgOID varchar2 (64),
           --PrvOrgName varchar2 (255),
           personnelid number,
           personneltype varchar2 (20),
           firstname varchar2 (50),
           lastname varchar2 (50),
           middlename varchar2 (50),
           title varchar2 (20),
           namesuffix varchar2 (20),
           nameprefix varchar2 (10),
           sourceuserid varchar2 (200),
           sourceissuingoid varchar2 (64),
           licensenumber varchar2 (50),
           licensestateoid varchar2 (64),
           deanumber varchar2 (20),
           upin varchar2 (64),
           npi varchar2 (20),
           effectiveenddate date,
           emailaddress varchar2 (50),
           role varchar2 (50),
           secondaryrole varchar2 (50),
           masterflag varchar2 (1),
           updateddate date,
           datasourcenm varchar2 (20),
           addresslist ods.getpersoneldtlsaddrinfo_tab,
           phonelist ods.getpersoneldtlsphoneinfo_tab,
           specialitylist ods.prvcache_speciality_tab,
           returncode number,
           FULLNM varchar2 (200),
           filterflag varchar2 (1),
           optoutflag varchar2 (1),
           orglist ods.userorginfo_tab)



--
-- PRVCACHE_SPECIALITY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.prvcache_speciality_obj
AS
   OBJECT (specialtyCode varchar2 (100), specialtyCodeSystem varchar2 (64), specialtyDescription varchar2 (255));



--
-- PRVCACHE_SPECIALITY_TAB  (Type) 
--
--  Dependencies: 
--   PRVCACHE_SPECIALITY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.prvcache_speciality_tab AS TABLE OF prvcache_speciality_obj;



--
-- PSA_ERRORREPORT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.PSA_ERRORREPORT_OBJ as OBJECT (PSUID varchar2(20), PSUNM varchar2(100),CONTROLID varchar2(8),ERRORSOURCE varchar2(50),ERRORDESC varchar2(2000));



--
-- PSA_ERRORREPORT_TAB  (Type) 
--
--  Dependencies: 
--   PSA_ERRORREPORT_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.PSA_ERRORREPORT_TAB is TABLE OF PSA_ERRORREPORT_OBJ;



--
-- QAATVLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.QAATVLIST_OBJ
AS
   OBJECT (
           questionidexid varchar2 (20),
           questionText VARCHAR2 (4000 BYTE),
           answerText VARCHAR2 (4000 BYTE),
           answerIdentifer varchar2 (20))



--
-- QAATVLIST_TAB  (Type) 
--
--  Dependencies: 
--   QAATVLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.QAATVLIST_TAB AS TABLE OF QAATVlist_obj



--
-- QANDALST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.QANDALST_OBJ AS OBJECT (
	Questioncode        NUMBER,
        Answer              VARCHAR2(4000)
);



--
-- QANDALST_TAB  (Type) 
--
--  Dependencies: 
--   QANDALST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.QANDALST_TAB AS TABLE OF qandalst_obj;



--
-- QUERY_BY_PATIENT_ID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.QUERY_BY_PATIENT_ID_OBJ AS
   OBJECT (
      account_oid varchar2 (64),
      query_patient_orgid varchar2 (64),
      query_patient_id varchar2 (50),
      primary_patient_org_id varchar2 (64),
      primary_patient_id varchar2 (50),
      master_org_id varchar2 (64),
      master_patient_id varchar2 (50),
      query_patient_exist_status varchar2 (1)
   );



--
-- QUERY_BY_PATIENT_ID_TAB  (Type) 
--
--  Dependencies: 
--   QUERY_BY_PATIENT_ID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.QUERY_BY_PATIENT_ID_TAB IS TABLE OF query_by_patient_id_obj;



--
-- QUERY_PATIENT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."QUERY_PATIENT_OBJ"
 AS
 OBJECT
 (
PATIENTID    VARCHAR(30) ,
ISSUINGORGID    VARCHAR(30 ),
Account_EMPI_IssuingOrgOID    VARCHAR2(30)
) ;




--
-- REFERENCES_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.REFERENCES_OBJ IS OBJECT (
   REFERENCE VARCHAR2 (1000)
   ); 



--
-- REFERENCES_TAB  (Type) 
--
--  Dependencies: 
--   REFERENCES_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.REFERENCES_TAB IS TABLE OF REFERENCES_OBJ; 



--
-- RELCONDITION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.relcondition_obj
as object
(
 conditiontext varchar2(2000),
 seqnbr        number

);



--
-- RELCONDITION_TAB  (Type) 
--
--  Dependencies: 
--   RELCONDITION_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.relcondition_tab as table of relcondition_obj;



--
-- REMEDYACCOUNTDTLS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.remedyaccountdtls_obj IS OBJECT (
                                                   accountnm varchar2 (200),
                                                   accountid varchar2 (64),
                                                   lvl2type varchar2 (30),
                                                   lvl2name varchar2 (200),
                                                   lvl2id varchar2 (64)
                                                );



--
-- REMEDYACCOUNTDTLS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   REMEDYACCOUNTDTLS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.remedyaccountdtls_tab
IS
   TABLE OF remedyaccountdtls_obj;



--
-- RUNCE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."RUNCE_OBJ"
IS
   OBJECT (
productcd varchar2(50),
runid NUMBER)



--
-- RUNCE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   RUNCE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."RUNCE_TAB" IS TABLE OF runce_obj



--
-- RUNMEMBEROBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.runmemberobject AS OBJECT
(
memberid NUMBER,
memberrecommendrunid number,
overallscorenbr NUMBER,
careenginerunmemberactionid NUMBER,
careenginerunscheduleid NUMBER,
outputdt TIMESTAMP
);



--
-- RUNMEMBERTBL  (Type) 
--
--  Dependencies: 
--   RUNMEMBEROBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.runmembertbl AS TABLE OF runmemberobject;



--
-- SETAA_HRA_OBJ  (Type) 
--
--  Dependencies: 
--   AA_HRA_ANS_TAB (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."SETAA_HRA_OBJ" is object
(QUESTIONINDEXID NUMBER,
TRANSACTIONDATE DATE,
aa_hra_ans aa_hra_ans_tab); 



--
-- SETAA_HRA_TAB  (Type) 
--
--  Dependencies: 
--   SETAA_HRA_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."SETAA_HRA_TAB" 
IS table of setaa_hra_obj; 



--
-- SETALLERGY_IN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETALLERGY_REACTION_IN_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.SETALLERGY_IN_OBJ
AS
   OBJECT (ALLERGYTYPE                            VARCHAR2(30),
           SOURCETRACKINGID                       NUMBER,
           CODEDALLERGYVALUE                      VARCHAR2(256),
           CODEDALLERGYOTHER                      VARCHAR2(200),
           CODEDALLERGYREACTIONLIST               SETALLERGY_REACTION_IN_TAB,
           COMMENTSS                              VARCHAR2(4000),
           TRANSACTIONDATE                        DATE,
           SYSTEMSOURCE                           VARCHAR2(20),
           ACTION                                 VARCHAR2(10)); 



--
-- SETALLERGY_IN_TAB  (Type) 
--
--  Dependencies: 
--   SETALLERGY_IN_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETALLERGY_IN_TAB AS TABLE OF ODS.SETALLERGY_IN_OBJ; 



--
-- SETALLERGY_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETALLERGY_REACTIONS_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."SETALLERGY_OBJ"
AS
   OBJECT (allergytype VARCHAR2 (256),
           phrallergyid NUMBER,
           codedallergyvalue VARCHAR2 (256),
           codedallergyother VARCHAR2 (256),
           vCOMMENT VARCHAR2 (4000),
           transactiondate date,
           systemsource varchar2 (20),
           action varchar2 (20),
           reaction_lst SETALLERGY_REACTIONS_TAB,
           ods_trackingid NUMBER,
           returncode VARCHAR2 (10));



--
-- SETALLERGY_OUT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETALLERGY_OUT_OBJ
AS
    OBJECT (SOURCETRACKINGID                       NUMBER, 
            ODSINSTANCEID                          NUMBER,
            RETURNCODE                             NUMBER
           ); 



--
-- SETALLERGY_OUT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETALLERGY_OUT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SETALLERGY_OUT_TAB AS TABLE OF ODS.SETALLERGY_OUT_OBJ; 



--
-- SETALLERGY_REACTIONS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."SETALLERGY_REACTIONS_OBJ"
AS
   OBJECT (reaction VARCHAR2 (2000));



--
-- SETALLERGY_REACTIONS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETALLERGY_REACTIONS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."SETALLERGY_REACTIONS_TAB"
AS
   TABLE OF SETALLERGY_REACTIONS_OBJ;



--
-- SETALLERGY_REACTION_IN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETALLERGY_REACTION_IN_OBJ
AS
   OBJECT (ALLERGYREACTIONLIST               VARCHAR2(200)); 



--
-- SETALLERGY_REACTION_IN_TAB  (Type) 
--
--  Dependencies: 
--   SETALLERGY_REACTION_IN_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETALLERGY_REACTION_IN_TAB AS TABLE OF ODS.SETALLERGY_REACTION_IN_OBJ; 



--
-- SETALLERGY_TAB  (Type) 
--
--  Dependencies: 
--   SETALLERGY_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."SETALLERGY_TAB" AS TABLE OF SETALLERGY_OBJ;



--
-- SETCONSENTDIRECTIVE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   CONSENTRULE_TAB (Type)
--
CREATE OR REPLACE type ODS.setconsentdirective_obj
as object
(
consentdirectiveid           varchar2(100),
consentdirectivestatus       varchar2(100),
provorgoid                   varchar2(64),
provorgnm                    varchar2(300),
careprovid                   number,
careprovnm                   varchar2(300),
relatedconsentrules          consentrule_tab,
rulecombalg                  varchar2(100),
starttime                    date,
exptime                      date,
requesttime                  date
);



--
-- SETCONSENTDIRECTIVE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETCONSENTDIRECTIVE_OBJ (Type)
--
CREATE OR REPLACE type ODS.setconsentdirective_tab is table of
setconsentdirective_obj;



--
-- SETCONSENT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETCONSENTDIRECTIVE_TAB (Type)
--
CREATE OR REPLACE type ODS.setconsent_obj as
object(accountoid                varchar2(64),
       memberplanid              number,
       patid                     varchar2(100),
       assngauthority            varchar2(64),
       consentpolicy             varchar2(100),
       healthcareproxy           varchar2(100),
       relationtype              varchar2(100),
       consentdirectiveslist     setconsentdirective_tab,
       consentdirectivesource    varchar2(4),
       requesttime               date,
       returncode                number
);



--
-- SETHEALTHFEEDBACK_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."SETHEALTHFEEDBACK_OBJ"
AS
   OBJECT (HEALTHSTATETRACKINGID NUMBER,
           HEALTHSTATESOURCE VARCHAR2 (10 BYTE));



--
-- SETHEALTHFEEDBACK_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETHEALTHFEEDBACK_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."SETHEALTHFEEDBACK_TAB"
AS
   TABLE OF SETHEALTHFEEDBACK_obj;



--
-- SETMED_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETMED_OBJ
   AS
   OBJECT
(
  ODSINSTANCETRACKINGID  NUMBER,
  SOURCETRACKINGID       NUMBER,
  ODSSUMMARYTRACKINGID   NUMBER,
  DRUGTRADENAME          VARCHAR2(50 BYTE),
  MEDICATIONCODE         VARCHAR2(20 BYTE),
  CODESYSTEMNAME         VARCHAR2(200 BYTE),
  DRUGSTRENGTH           VARCHAR2(30 BYTE),
  COMMENTS               VARCHAR2(4000 BYTE),
  STATUS                 VARCHAR2(50 BYTE),
  STATUSREASON           VARCHAR2(255 BYTE),
  LASTUPDATEDATE         DATE,
  FEEDSOURCENM           VARCHAR2(30 BYTE),
  MEDCLASSCD             VARCHAR2(30 BYTE),
  ACTION                 VARCHAR2(10 BYTE),
  RETURNCODE             VARCHAR2(10 BYTE)
);



--
-- SETMED_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETMED_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SETMED_TAB AS TABLE OF SETMED_OBJ;



--
-- SETPATIENTDEMOGRAPHICS_OBJ  (Type) 
--
--  Dependencies: 
--   DT_CE_OBJ (Type)
--   DT_CE_TAB (Type)
--   DT_II_OBJ (Type)
--   DT_PERSON_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETPATIENTDEMOGRAPHICS_OBJ AS
   OBJECT (messageid   varchar2(50),
           account_oid DT_II_OBJ,
           issuing_oid DT_II_OBJ,
           memberplanid_in  NUMBER,
           HIEPATIENTID NUMBER,
           patient_ConfidentialityCode DT_CE_TAB,
           patient_VIPCode DT_CE_OBJ,
           patient_Person dt_Person_obj);




--
-- SETUEMI_ADDRESS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."SETUEMI_ADDRESS_OBJ"
AS
   OBJECT (
  ODSTRACKINGID   NUMBER,
  ADDRESSLINE1    VARCHAR2(50 BYTE),
  ADDRESSLINE2    VARCHAR2(50 BYTE),
  CITY            VARCHAR2(50 BYTE),
  STATE           VARCHAR2(2 BYTE),
  ZIPCODE         VARCHAR2(9 BYTE),
  COUNTRY         VARCHAR2(50 BYTE),
  ADDRESSTYPE     VARCHAR2(20 BYTE),
  LASTUPDATEDATE  DATE,
  ACTION          VARCHAR2(10 BYTE),
  returnmessage    varchar2(300 BYTE),
  RETURNCODE      VARCHAR2(10 BYTE)
)



--
-- SETUEMI_ADDRESS_TAB  (Type) 
--
--  Dependencies: 
--   SETUEMI_ADDRESS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."SETUEMI_ADDRESS_TAB" as table of SETUEMI_ADDRESS_OBJ ;



--
-- SETUEMI_MAILINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUEMI_MAILINFO_OBJ
AS
   OBJECT
(
  ODSTRACKINGID    NUMBER,
  EMAILADDRESS     VARCHAR2(50 BYTE),
  EMAILTYPECODE    VARCHAR2(20 BYTE),
  LASTUPDATEDATE   DATE,
  ACTION           VARCHAR2(10 BYTE),
  EMAILPREFERENCE  VARCHAR2(1 BYTE),
  EMAILFORMAT      VARCHAR2(8 BYTE),
  returnmessage    varchar2(200 BYTE),
  RETURNCODE       VARCHAR2(10 BYTE)
) ;



--
-- SETUEMI_MAILINFO_TAB  (Type) 
--
--  Dependencies: 
--   SETUEMI_MAILINFO_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUEMI_MAILINFO_TAB as table of ODS.SETUEMI_MAILINFO_OBJ



--
-- SETUEMI_PHONEINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUEMI_PHONEINFO_OBJ FORCE 
AS
   OBJECT 
(
  ODSTRACKINGID         NUMBER,
  PHONEFAXNUMBER        VARCHAR2(30 BYTE),
  PHONEFAXTYPE          VARCHAR2(20 BYTE),
  PHONEFAXUSAGETYPE     VARCHAR2(20 BYTE),
  PHONEFAXLOCATIONCODE  VARCHAR2(15 BYTE),
  LASTUPDATEDATE        DATE,
  ACTION                VARCHAR2(10 BYTE),
  returnmessage    varchar2(200 BYTE),
  RETURNCODE            VARCHAR2(10 BYTE),
  PHONEPREFERENCEFLG    CHAR(1)
) 



--
-- SETUEMI_PHONEINFO_TAB  (Type) 
--
--  Dependencies: 
--   SETUEMI_PHONEINFO_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUEMI_PHONEINFO_TAB AS TABLE OF SETUEMI_PHONEINFO_OBJ 



--
-- SETUE_IMMUN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUE_IMMUN_OBJ
AS OBJECT (PHRIMMUNIZATIONID         NUMBER,
           IMMUNIZATIONNAME          VARCHAR2(100 BYTE),
           IMMUNIZATIONDESCRIPTION   VARCHAR2(200 BYTE),
           IMMUNIZATIONDATE          DATE,
           IMMUNIZATIONPROVIDERNAME  VARCHAR2(200),
           IMMUNIZATIONNEXTDATE      DATE,
           IMMUNIZATIONCOMMENT       VARCHAR2(4000),
           IMMUNIZATIONCD            VARCHAR2(20 BYTE),
           CODESETTYPE               VARCHAR2(10 BYTE),
           ACTION                    VARCHAR2(10),
           RETURNCODE                NUMBER
          );



--
-- SETUE_IMMUN_TAB  (Type) 
--
--  Dependencies: 
--   SETUE_IMMUN_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUE_IMMUN_TAB as table of SETUE_IMMUN_OBJ;



--
-- SETUE_LAB_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUE_LAB_OBJ
AS
   OBJECT
( SOURCETRACKINGID         NUMBER,
  ODSTRACKINGID            NUMBER,
  LOINC                    VARCHAR2(20 BYTE),
  CODESYSTEMNAME           VARCHAR2(10 BYTE),
  LABTESTNM                VARCHAR2(500 BYTE),
  SERVICEDT                DATE,
  LABTESTNUMERICRESULT     NUMBER,
  LABTESTNONNUMERICRESULT  VARCHAR2(20 BYTE),
  DRUGUNITOFMEASURE        VARCHAR2(30 BYTE),
  LABTESTNONNUMERICIND     VARCHAR2(20 BYTE),
  COMMENTS                 VARCHAR2(4000 BYTE),
  LASTUPDATEDATE           DATE,
  ACTION                   VARCHAR2(10 BYTE),
  RETURNCODE               VARCHAR2(10 BYTE)
);



--
-- SETUE_LAB_TAB  (Type) 
--
--  Dependencies: 
--   SETUE_LAB_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUE_LAB_TAB IS TABLE OF ODS.SETUE_LAB_OBJ;



--
-- SETUE_PRVDRADDRESS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUE_PRVDRADDRESS_OBJ AS OBJECT (
  ODSTRACKINGID   NUMBER,
  ADDRESSLINE1    VARCHAR2(50 BYTE),
  ADDRESSLINE2    VARCHAR2(50 BYTE),
  CITY            VARCHAR2(50 BYTE),
  STATE           VARCHAR2(2 BYTE),
  ZIPCODE         VARCHAR2(9 BYTE),
  COUNTRY         VARCHAR2(50 BYTE),
  ADDRESSTYPE     VARCHAR2(20 BYTE),
  LASTUPDATEDATE  DATE,
  ACTION          VARCHAR2(10 BYTE),
  RETURNCODE      NUMBER,
  RETURNMESSAGE   VARCHAR2(4000 BYTE)
);



--
-- SETUE_PRVDRADDRESS_TAB  (Type) 
--
--  Dependencies: 
--   SETUE_PRVDRADDRESS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUE_PRVDRADDRESS_TAB
IS
   TABLE OF ODS.SETUE_PRVDRADDRESS_obj;



--
-- SETUE_PRVDRMAILINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUE_PRVDRMAILINFO_OBJ
AS
   OBJECT
(
  ODSTRACKINGID    NUMBER,
  EMAILADDRESS     VARCHAR2(50 BYTE),
  EMAILTYPECODE    VARCHAR2(20 BYTE),
  LASTUPDATEDATE   DATE,
  ACTION           VARCHAR2(10 BYTE),
  RETURNCODE       NUMBER,
  RETURNMESSAGE    VARCHAR2(4000 BYTE)
);



--
-- SETUE_PRVDRMAILINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETUE_PRVDRMAILINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SETUE_PRVDRMAILINFO_TAB
IS
   TABLE OF ODS.SETUE_PRVDRMAILINFO_obj;



--
-- SETUE_PRVDRPHONEINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SETUE_PRVDRPHONEINFO_OBJ AS OBJECT (
  ODSTRACKINGID         NUMBER,
  PHONEFAXNUMBER        VARCHAR2(30 BYTE),
  PHONEFAXTYPE          VARCHAR2(20 BYTE),
  PHONEFAXUSAGETYPE     VARCHAR2(20 BYTE),
  PHONEFAXLOCATIONCODE  VARCHAR2(15 BYTE),
  LASTUPDATEDATE        DATE,
  ACTION                VARCHAR2(10 BYTE),
  RETURNCODE            NUMBER,
  RETURNMESSAGE   	VARCHAR2(4000 BYTE)
);



--
-- SETUE_PRVDRPHONEINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SETUE_PRVDRPHONEINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SETUE_PRVDRPHONEINFO_TAB
IS
   TABLE OF ODS.SETUE_PRVDRPHONEINFO_obj;



--
-- SET_HEALTH_TRKR_VALUE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SET_HEALTH_TRKR_VALUE_OBJ
AS
   OBJECT (SOURCETRACKINGID NUMBER,
           ODSTRACKINGID NUMBER,
           HEALTHTRACKERNAME VARCHAR2 (35 BYTE),
           HEALTHTRACKERCOMPONENTNAME VARCHAR2 (35 BYTE),
           HEALTHTRACKERVALUE NUMBER,
           UNITOFMEASURE VARCHAR2 (30 BYTE),
           LASTUPDATEDATE DATE,
           COMMENTS VARCHAR2 (4000 BYTE),
           ACTION VARCHAR2 (20 BYTE),
           MEASUREMENTDATE DATE,
           RETURNCODE VARCHAR2 (10 BYTE));



--
-- SET_HEALTH_TRKR_VALUE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SET_HEALTH_TRKR_VALUE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SET_HEALTH_TRKR_VALUE_TAB
IS
   TABLE OF SET_HEALTH_TRKR_VALUE_OBJ;



--
-- SET_HOMEWORKFORMEMBER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SET_HOMEWORKFORMEMBER_OBJ
AS
  OBJECT (
  SOURCETRACKINGID            NUMBER,
  ODSTRACKINGID               NUMBER,
  COMMENTS                    VARCHAR2(4000),
  STATUS                      VARCHAR2(12),
  STATUSDT                    DATE,
  HOMEWORKSTDT                DATE, -- ADDED BY LIBINUS ON 07172014
  HOMEWORKENDDT               DATE, -- ADDED BY LIBINUS ON 07172014
  HOMEWORKVALUE               VARCHAR2(200),   
  HOMEWORKTEXTCD              VARCHAR2(12),
  HOMEWORKCATCD               VARCHAR2(12), -- ADDED BY LIBINUS ON 07172014
  MEDIATYPE                   VARCHAR2(24),
  MEDIAPATH                   VARCHAR2(600),
  MEDIATITLE                  VARCHAR2(255),
  LASTUPDATEDATE              DATE,
  ACTION                      VARCHAR2(20),
  RETURNCODE                  NUMBER) 



--
-- SET_HOMEWORKFORMEMBER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SET_HOMEWORKFORMEMBER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SET_HOMEWORKFORMEMBER_TAB IS TABLE OF SET_HOMEWORKFORMEMBER_OBJ 



--
-- SET_IMMUN_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SET_IMMUN_OBJ
AS OBJECT (IMMUNIZATIONINSTANCEID    NUMBER,
           IMMUNIZATIONCOMMENT       VARCHAR2(4000 BYTE),
           FEEDSOURCENM              VARCHAR2(20),
           RETURNCODE                NUMBER
          ); 



--
-- SET_IMMUN_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SET_IMMUN_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SET_IMMUN_TAB as table of SET_IMMUN_OBJ; 



--
-- SET_LABRSULT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SET_LABRSULT_obj
AS
   OBJECT
(  ODSTRACKINGID   NUMBER,
   FEEDSOURCENM    VARCHAR2(30 BYTE),
   COMMENTS        VARCHAR2(4000 BYTE),
   LASTUPDATEDATE  DATE,
   RETURNCODE      VARCHAR2(10 BYTE)
);



--
-- SET_LABRSULT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SET_LABRSULT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SET_LABRSULT_TAB IS TABLE OF ODS.SET_LABRSULT_obj;



--
-- SET_RECOMMENDATION_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SET_RECOMMENDATION_OBJ
AS
  OBJECT (
  CASERECOMMENDATIONIDENTIFIER       NUMBER,
  STATUS                      VARCHAR2(20),
  STATUSREASON                VARCHAR2(35),
  TRANSACTIONDATE             DATE,
  RECOMMENDATIONTYPE          VARCHAR2(2),
  RETURNCODE                  NUMBER); 



--
-- SET_RECOMMENDATION_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SET_RECOMMENDATION_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SET_RECOMMENDATION_TAB IS TABLE OF SET_RECOMMENDATION_OBJ; 



--
-- SOURCE_DOC_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."SOURCE_DOC_OBJ"
AS
   OBJECT (
      source_doc_type varchar2 (25),
      source_doc_major_id varchar2 (100),
      source_doc_minor_id varchar2 (100)
   );




--
-- SRVCMPLDT_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SRVCMPLDT_obj
as object
(
COMPLETIONDATE DATE
)



--
-- SRVCMPLDT_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SRVCMPLDT_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.SRVCMPLDT_tab  as table of SRVCMPLDT_obj



--
-- SUPPLIERTASK_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   PRODUCT_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.suppliertask_obj IS OBJECT
                                                                                    (
                                                                                    AssignedTaskid NUMBER,
                                                                                    AHMsupplierid NUMBER,
                                                                                    Productlist product_tab,
                                                                                    ERRORCODE       NUMBER
                                                                                    );



--
-- SUPPLIERTASK_TAB  (Type) 
--
--  Dependencies: 
--   SUPPLIERTASK_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.suppliertask_tab IS TABLE OF suppliertask_obj;



--
-- SUPPLIER_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SUPPLIER_OBJECT AS OBJECT
(
  SUPPLIER_ID NUMBER,
  SUPPLIER_RUN_ID NUMBER
)



--
-- SUPPLIER_OBJECT_TABLE  (Type) 
--
--  Dependencies: 
--   SUPPLIER_OBJECT (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.SUPPLIER_OBJECT_TABLE AS TABLE OF  SUPPLIER_OBJECT



--
-- TABLE_CHAR20  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.table_char20 as table of varchar2(20)



--
-- TABLE_DATE  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.table_DATE  as table of DATE;



--
-- TABLE_MEMBERID  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."TABLE_MEMBERID" AS TABLE OF NUMBER;



--
-- TABLE_NUMBER  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.table_number  as table of number;



--
-- TABLE_PROVIDERID  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TABLE_PROVIDERID IS TABLE OF NUMBER;



--
-- TABLE_SRCPROVIDER  (Type) 
--
CREATE OR REPLACE TYPE ODS.table_srcprovider as table of varchar2(200);


ed



--
-- TABLE_SUPPLIER_IDS  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."TABLE_SUPPLIER_IDS"
  AS TABLE OF NUMBER



--
-- TABLE_VARCHAR  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.table_varchar as table of varchar2(200);



--
-- TKT_CUMBID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_CUMBID_OBJ as object
(
  MEMBERID              NUMBER,
  SOURCEMEMBERID        VARCHAR2(11 BYTE),
  AETNASUBCUMBID        VARCHAR2(9 BYTE),
  MEDICARECONTRACTID    VARCHAR2(5 BYTE),
  MEDICAREPLANBENPKGCD  VARCHAR2(3 BYTE),
  RHAFLG                CHAR(1 BYTE),
  AHCEFFECTIVEDT        DATE,
  ATVEFFECTIVEDT        DATE,
  PHRFLG                CHAR(1 BYTE),
  PHREFFDT              DATE,
  AETNACONTROLGROUPID   VARCHAR2(20 BYTE),
  CONTROLSUFFIXACCT     VARCHAR2(20 BYTE),
  PSUID                 VARCHAR2(20 BYTE),
  AETNACUMBID           VARCHAR2(9 BYTE)
)




--
-- TKT_CUMBID_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TKT_CUMBID_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.TKT_CUMBID_TAB is table of tkt_cumbid_obj




--
-- TKT_DEPENDENTS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_DEPENDENTS_OBJ 
as
   object (
      memberid_m number,
      primarymemberplanid_m number,
      dependentmemberid_mmr number,
      memberid_mmr number,
      ahmsupplierid_m number,
      sourcememberpatientid_m varchar2 (20 byte),
      membertypecode_m varchar2 (20 byte),
      effectivestartdt_m date,
      effectiveenddt_m date,
      dependenttype_mmr varchar2 (20 byte),
      dependentsubtypecd_mmr varchar2 (20 byte),
      effectivestartdt_mmr date,
      effectiveenddt_mmr date,
      personid_p number,
      firstnm_p varchar2 (50 byte),
      lastnm_p varchar2 (40 byte),
      fullnm_p varchar2 (200 byte),
      gender_p varchar2 (2 byte),
      ssn_p varchar2 (11 byte),
      dtofbirth_p date,
      addrline1_pa varchar2 (50 byte),
      city_pa varchar2 (50 byte),
      state_pa varchar2 (2 byte),
      zipcode_pa varchar2 (5 byte),
      dtregistered date,
      productid varchar2 (20 byte)
   ); 



--
-- TKT_DEPENDENTS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TKT_DEPENDENTS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.TKT_DEPENDENTS_TAB 
is
   table of tkt_dependents_obj; 



--
-- TKT_DISPUTEDPROVIDER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.tkt_disputedprovider_obj
AS
   OBJECT (claimid number,
           evidence varchar2 (20),
           servicedt date,
           claim varchar2 (250),
           careproviderid number,
           careproviderorgid number,
           careprovidertype varchar2 (20),
           firstnm varchar2 (50),
           lastnm varchar2 (50),
           fullnm varchar2 (250),
           hdmsproviderreferenceid varchar2 (30),
           providerspecialty1 varchar2 (100),
           addrline1 varchar2 (50),
           city varchar2 (50),
           state varchar2 (2),
           zipcode varchar2 (10));



--
-- TKT_DISPUTEDPROVIDER_TAB  (Type) 
--
--  Dependencies: 
--   TKT_DISPUTEDPROVIDER_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.tkt_disputedprovider_tab
IS
   TABLE OF tkt_disputedprovider_obj;



--
-- TKT_FIND_CC_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_find_CC_OBJ 
AS
   OBJECT (
      STATETYPECD VARCHAR2 (4 ),
      careenginerunmemberactionid number,
      commmethodcd VARCHAR2 (12 Byte),
      metrackingid NUMBER,
      meid number,
      metitle VARCHAR2 (1000 ),
      metypecode VARCHAR2 (24 Byte),
      mechronic CHAR (1 Byte),
      merank number,
      meseverity number,
      mechangedate date,
      cecompletionstatus CHAR (1 Byte)
   ); 



--
-- TKT_FIND_CC_TAB  (Type) 
--
--  Dependencies: 
--   TKT_FIND_CC_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_find_CC_TAB IS TABLE OF tkt_find_CC_obj; 



--
-- TKT_FIND_MEMBER_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_FIND_MEMBER_OBJ
AS
   OBJECT (
      recordinsertdt timestamp (6),
      recordupdtdt timestamp (6),
      aetnacumbid varchar2 (9 BYTE),
      aetnasubcumbid varchar2 (9 BYTE),
      psuid varchar2 (20 BYTE),
      sourcememberpatientid varchar2 (20 BYTE),
      memberid number,
      primarymemberplanid number,
      membertypecode varchar2 (20 BYTE),
      firstnm varchar2 (50 BYTE),
      lastnm varchar2 (40 BYTE),
      dtofbirth date,
      gender varchar2 (2 BYTE),
      effectivestartdt date,
      effectiveenddt date,
      supplier_so number,
      supplier_sm number,
      orgnm varchar2 (200 BYTE),
      dtregistered date,
      productid varchar2 (20 BYTE),
      addrline1 varchar2 (50 BYTE),
      addrline2 varchar2 (50 BYTE),
      city varchar2 (50 BYTE),
      state varchar2 (2 BYTE),
      zipcode varchar2 (5 BYTE)
   ); 



--
-- TKT_FIND_MEMBER_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TKT_FIND_MEMBER_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.TKT_FIND_MEMBER_TAB IS TABLE OF tkt_find_member_obj; 



--
-- TKT_FIND_PRODUCTCD_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_find_productcd_OBJ 
AS
   OBJECT (
      AHMSUPPLIERID NUMBER,
      PRODUCTIONSTATUS VARCHAR2 (20),
      EFFECTIVEENDDT  DATE,
      PRODUCTOWNER VARCHAR2 (100),
      PRODUCTCD  VARCHAR2(50),
      PRODUCTLIVEDT DATE,
      PRODUCTTERMINATIONDT DATE
   ); 



--
-- TKT_FIND_PRODUCTCD_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TKT_FIND_PRODUCTCD_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.TKT_find_productcd_TAB IS TABLE OF tkt_find_productcd_obj; 



--
-- TKT_HRARES_HRARESHIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_hrares_hrareshist_OBJ 
AS
   OBJECT (HRAMEMBERRESPONSEHISTSKEY  NUMBER ,
  HRASOURCEANSWERID          NUMBER,
  HRASOURCEQUESTIONID        NUMBER,
  HRAASSMNTID                NUMBER,
  DATASOURCENM               VARCHAR2(20 BYTE),
  HRASOURCEQUESTIONAIREID    NUMBER,
  HRAQUESTIONTYPE            VARCHAR2(15 BYTE),
  RESPONSETEXT               VARCHAR2(4000 BYTE),
  RESPONSEVALUE              NUMBER,
  RESPONSESCORE              NUMBER,
  RESPONSEDT                 TIMESTAMP(6),
  UTILIZATIONCODE            VARCHAR2(20 BYTE),
  HMTISDRUG                  NUMBER,
  CURRENTRESPONSEBYSYSTEM    CHAR(1 BYTE),
  CURRENTRESPONSEBYSOURCE    CHAR(1 BYTE),
  RECORDINSERTDT             TIMESTAMP(6),
  RECORDUPDTDT               TIMESTAMP(6),
  INSERTEDBY                 VARCHAR2(30 BYTE),
  UPDTDBY                    VARCHAR2(30 BYTE),
  MEMBERID                   NUMBER ,
  EFFECTIVESTARTDT           DATE,
  EFFECTIVEENDDT             DATE,
  HMTSORTORDER               NUMBER,
  NURSEID                    NUMBER,
  HRAHISTASSMNTID            NUMBER,
  CONDITIONDESC              VARCHAR2(30 BYTE),
  CONDITIONRISKCODE          VARCHAR2(3 BYTE)
 ); 



--
-- TKT_HRARES_HRARESHIST_TAB  (Type) 
--
--  Dependencies: 
--   TKT_HRARES_HRARESHIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_hrares_hrareshist_TAB IS TABLE OF tkt_hrares_hrareshist_obj; 



--
-- TKT_HRA_GENERAT_CONDITIONS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_HRA_GENERAT_CONDITIONS_OBJ
as
   object (
  hramemberresponsehistskey  number   ,
  hrasourceanswerid          number,
  hrasourcequestionid        number,
  hraassmntid                number,
  datasourcenm               varchar2(20 byte),
  hrasourcequestionaireid    number,
  hraquestiontype            varchar2(15 byte),
  responsetext               varchar2(4000 byte),
  responsevalue              number,
  responsescore              number,
  responsedt                 timestamp(6),
  utilizationcode            varchar2(20 byte),
  hmtisdrug                  number,
  currentresponsebysystem    char(1 byte),
  currentresponsebysource    char(1 byte),
  recordinsertdt             timestamp(6),
  recordupdtdt               timestamp(6),
  insertedby                 varchar2(30 byte),
  updtdby                    varchar2(30 byte),
  memberid                   number        ,
  effectivestartdt           date,
  effectiveenddt             date,
  hmtsortorder               number,
  nurseid                    number,
  hrahistassmntid            number,
  conditiondesc              varchar2(30 byte),
  conditionriskcode          varchar2(3 byte)
); 



--
-- TKT_HRA_GENERAT_CONDITIONS_TAB  (Type) 
--
--  Dependencies: 
--   TKT_HRA_GENERAT_CONDITIONS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_HRA_GENERAT_CONDITIONS_TAB
is
   table of tkt_hra_generat_conditions_obj; 



--
-- TKT_HRA_HRAHIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_hra_hrahist_OBJ 
AS
   OBJECT (
  HRAHISTASSMNTID     NUMBER,
  HRAASSMNTID         NUMBER,
  SURVEYTEMPLATESKEY  NUMBER,
  MEMBERID            NUMBER,
  SURVEYNM            VARCHAR2(200 BYTE),
  HRASOURCEASSMNTID   NUMBER,
  SURVEYDT            DATE,
  SURVEYSTATUS        VARCHAR2(15 BYTE),
  DATASOURCENM        VARCHAR2(20 BYTE),
  VENDORSOURCENM      VARCHAR2(20 BYTE),
  SURVEYCOMPLETIONDT  DATE,
  CONTENTCD           VARCHAR2(5 BYTE),
  DELTATYPECD         VARCHAR2(5 BYTE),
  DELTATRACKINGID     NUMBER,
  INSERTEDBY          VARCHAR2(30 BYTE),
  INSERTEDDT          TIMESTAMP(6),
  UPDATEDBY           VARCHAR2(30 BYTE),
  UPDATEDDT           TIMESTAMP(6),
  BATCHID             NUMBER,
  SURVEYRESPONSEDT    DATE
 ); 



--
-- TKT_HRA_HRAHIST_TAB  (Type) 
--
--  Dependencies: 
--   TKT_HRA_HRAHIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_hra_hrahist_TAB IS TABLE OF tkt_hra_hrahist_obj; 



--
-- TKT_INCORRECT_CLAIMS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_incorrect_claims_OBJ
AS
   OBJECT (
   CAREPROVIDERID number, ProviderName varchar2(200),
      claimid number,
      evidence VARCHAR2 (20 Byte),
      evidence_reference VARCHAR2 (20 Byte),
      claim_type_code CHAR (3 Byte),
      servicedt date,
      hdmsproviderreferenceid VARCHAR2 (30 Byte),
      claim_name VARCHAR2 (100 Byte),
      uft VARCHAR2 (500 Byte),
      exclusionflag VARCHAR2 (2 Byte),
      claim varchar2(15),
      labtestnumericresult number,
      labtestnonnumericresult   VARCHAR2 (200 Byte),
      NUMBEROFDAYSSUPPLIED number,
      DRUGQUANTITY number
   );



--
-- TKT_INCORRECT_CLAIMS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TKT_INCORRECT_CLAIMS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.tkt_incorrect_claims_tab IS TABLE OF tkt_incorrect_claims_OBJ;



--
-- TKT_PSUID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_PSUID_OBJ
AS
   OBJECT (
      ahmsupplierid number,
      usagemnemonic varchar2(20),
      defaultbusinesssupplierflg varchar2(20),
      psuid varchar2 (20),
      psuname varchar2 (100),
      clientsystemname varchar2 (100),
      spsr_plansponsorinstanceid number
   )




--
-- TKT_PSUID_TAB  (Type) 
--
--  Dependencies: 
--   TKT_PSUID_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_PSUID_TAB is table of ods.tkt_psuid_obj;




--
-- TKT_SUPPLIERDTLS_MV_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.tkt_supplierdtls_mv_obj
as
   object (
  supplierorgid          number,
  ahmsupplierid          number,
  operationalproductcd   varchar2(50),
  productowner           varchar2(100),
  effectivestartdt       date,
  effectiveenddt         date,
  executionmodecd        varchar2(4 ),
  settinglevelcd         varchar2(4 byte),
  operationalprogramcd   varchar2(12 byte),
  onlinemodeflg          char(1 byte),
  telphonicmodeflg       char(1 byte),
  chatmodeflg            char(1 byte),
  employeeeligibilitycd  varchar2(1 byte)
   );



--
-- TKT_SUPPLIERDTLS_MV_TAB  (Type) 
--
--  Dependencies: 
--   TKT_SUPPLIERDTLS_MV_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE type ODS.tkt_supplierdtls_mv_tab is table of tkt_supplierdtls_mv_obj;



--
-- TKT_TRACKERS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TKT_TRACKERS_OBJ as
object 
(
  MEMBERHEALTHTRACKERSKEY       NUMBER    ,
  HEALTHTRACKERELEMENTSKEY      NUMBER,
  PHRHEALTHTRACKERENTRYID       NUMBER,
  UPDTSOURCENM                  VARCHAR2(20 BYTE),
  HEALTHTRACKERVALUE            NUMBER,
  DRUGUNITOFMEASURE             VARCHAR2(30 BYTE),
  RECORDINSERTDT                TIMESTAMP(6),
  RECORDUPDTDT                  TIMESTAMP(6),
  INSERTEDBY                    VARCHAR2(30 BYTE),
  UPDTDBY                       VARCHAR2(30 BYTE),
  DELETEDBYDATASOURCENM         VARCHAR2(20 BYTE),
  COMMENTS                      VARCHAR2(4000 BYTE),
  MEMBERID                      NUMBER,
  TRANSACTIONDT                 DATE,
  MEASUREMENTDT                 DATE,
  COMPONENTSHORTNM              VARCHAR2(35 BYTE),
  DISPLAYLABEL                  VARCHAR2(200 BYTE),
  HTE_HEALTHTRACKERELEMENTSKEY  NUMBER         ,
  HEALTHTRACKERID               NUMBER         ,
  COMPONENTMNEMONICCD           VARCHAR2(12 BYTE),
  HTE_INSERTEDBY                VARCHAR2(30 BYTE),
  HTE_UPDTDBY                   VARCHAR2(30 BYTE),
  HTE_DISPLAYLABEL              VARCHAR2(200 BYTE),
  HT_HEALTHTRACKERID            NUMBER       ,
  HEALTHTRACKERMNEMONICCD       VARCHAR2(12 BYTE),
  SHORTDESC                     VARCHAR2(200 BYTE),
  HT_INSERTEDBY                 VARCHAR2(30 BYTE),
  HT_UPDTDBY                    VARCHAR2(30 BYTE),
  LOINC                         VARCHAR2(10 BYTE),
  MEDICALPROCEDURECODE          VARCHAR2(20 BYTE),
  HTX_HEALTHTRACKERELEMENTSKEY  NUMBER,
  HEALTHTRACKERXREFSKEY         NUMBER,
  HTXREF_DRUGUNITOFMEASURE      VARCHAR2(30 BYTE),
  HTXREF_INSERTEDBY             VARCHAR2(30 BYTE),
  HTXREF_UPDTDBY                VARCHAR2(30 BYTE)
); 



--
-- TKT_TRACKERS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TKT_TRACKERS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.TKT_TRACKERS_TAB as table of tkt_trackers_obj; 



--
-- TMP_PCPMIGRATE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.tmp_pcpmigrate_obj IS OBJECT (memberid number, supplierid number,enddt date) 



--
-- TMP_PCPMIGRATE_TAB  (Type) 
--
--  Dependencies: 
--   TMP_PCPMIGRATE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.tmp_pcpmigrate_TAB IS TABLE OF tmp_pcpmigrate_obj 



--
-- TOC_NOTIFICATIONLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.toc_notificationlist_obj AS OBJECT (
   accountid                               NUMBER
  ,ahmsupplierid                           NUMBER
  ,memberid                                NUMBER
  ,memberplanid                            NUMBER
  ,patientpreauthnotificationskey          NUMBER
  ,encounterid                             VARCHAR2 (20)
  ,eventtype                               VARCHAR2 (30)
  ,admitdate                               DATE
  ,dischargedate                           DATE
  ,primarydiagnosiscd                      VARCHAR2 (20)
  ,diagnosiscdsystemnm					   VARCHAR2 (50)
  ,facilityname                            VARCHAR2 (60)
  ,providerinfo                            VARCHAR2 (72)
  ,NOTIFICATIONCATEGORY					   VARCHAR2 (30)
)



--
-- TOC_NOTIFICATIONLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TOC_NOTIFICATIONLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.toc_notificationlist_tab AS TABLE OF toc_notificationlist_obj



--
-- TOC_ODSSTATUS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.toc_odsstatus_obj AS OBJECT (
   patientpreauthnotificationskey          NUMBER
  ,odsstatus                               VARCHAR2 (20)   ---
)



--
-- TOC_ODSSTATUS_TAB  (Type) 
--
--  Dependencies: 
--   TOC_ODSSTATUS_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.toc_odsstatus_tab AS TABLE OF toc_odsstatus_obj



--
-- TOC_TRANSACTIONSTATUS_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.toc_transactionstatus_obj AS OBJECT (
   patientpreauthnotificationskey          NUMBER
  ,actreturncode                           VARCHAR2 (10)
  ,actupdatestatus                         VARCHAR2 (20)
)



--
-- TOC_TRANSACTIONSTATUS_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TOC_TRANSACTIONSTATUS_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.toc_transactionstatus_tab AS TABLE OF toc_transactionstatus_obj



--
-- TOPICCMSTYPE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TOPICCMSTYPE_OBJ
IS OBJECT (
   cmstype VARCHAR2 (12 Byte)
)



--
-- TOPICCMSTYPE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TOPICCMSTYPE_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.TOPICCMSTYPE_TAB
IS TABLE OF ODS.TOPICCMSTYPE_OBJ



--
-- TOPICMARKERID_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TOPICMARKERID_OBJ
IS OBJECT
(
markerid NUMBER
)



--
-- TOPICMARKERID_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TOPICMARKERID_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.TOPICMARKERID_TAB
IS TABLE OF ODS.TOPICMARKERID_OBJ



--
-- TRACKERLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."TRACKERLIST_OBJ"
AS
   OBJECT (medicalcode varchar2 (50), codetype varchar2 (20));



--
-- TRACKERLIST_TAB  (Type) 
--
--  Dependencies: 
--   TRACKERLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."TRACKERLIST_TAB" AS TABLE OF trackerlist_obj;



--
-- TRACKERSUB_TYPE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.trackersub_type_obj
as object
     (MANUFACTURER_NAME                VARCHAR2(255),
      STATUS                           VARCHAR2(4) ,
      CREATED_AT                       TIMESTAMP(6),
      UPDATED_AT                       TIMESTAMP(6),
      USER_DEVICE_ID                   NUMBER,
      DEVICE_NAME                      VARCHAR2(255),
      DEVICE_ID                        NUMBER,
      VENDOR_ID                        VARCHAR2(255),
      RETURNCODE                       NUMBER)



--
-- TRACKERSUB_TYPE_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TRACKERSUB_TYPE_OBJ (Type)
--
CREATE OR REPLACE type ODS.trackersub_type_tab as table of trackersub_type_obj



--
-- TRACKER_SUBTYPE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TRACKER_SUBTYPE_OBJ
AS
   OBJECT (subtype varchar2 (60), subtype_value varchar2 (100))



--
-- TRACKER_SUBTYPE_TAB  (Type) 
--
--  Dependencies: 
--   TRACKER_SUBTYPE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TRACKER_SUBTYPE_TAB
AS
   TABLE OF tracker_subtype_obj



--
-- TRACKER_TYPE_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   TRACKER_SUBTYPE_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.TRACKER_TYPE_OBJ force
as object (tracker_id varchar2(60),
           tracker_type varchar2(40),
           tracker_value varchar2(20),
           tracker_ind   char,
           tracker_date timestamp,
	   returncode number,
           device_tracker_subtype_tab  tracker_subtype_tab)



--
-- TRACKER_TYPE_TAB  (Type) 
--
--  Dependencies: 
--   TRACKER_TYPE_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.TRACKER_TYPE_TAB AS TABLE OF tracker_type_obj



--
-- UEMEDS_SUBLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."UEMEDS_SUBLIST_OBJ"
AS
   OBJECT (SOURCETRACKINGID NUMBER,
           ODSTRACKINGID    NUMBER,
           SERVICEDATE      DATE,
           ACTION           VARCHAR2(10),
           RETURNCODE       VARCHAR2(10))




--
-- UEMEDS_SUBLIST_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   UEMEDS_SUBLIST_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."UEMEDS_SUBLIST_TAB" as table of UEMEDS_SUBLIST_OBJ




--
-- UEPROCMEM_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   UEPROCMEM_SUBLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS."UEPROCMEM_OBJ"
AS
   OBJECT
(  PHRPROCEDUREID         NUMBER,
   PROCEDURENAME          VARCHAR2(100),
   PROCEDURECODE          VARCHAR2(20),
   CODESYSTEMNAME         VARCHAR2(10),
   PROCEDURECOMMENT       VARCHAR2(4000),
   ACTION                 VARCHAR2(10),
   UEPROCMEMSUBLIST       UEPROCMEM_SUBLIST_TAB
);



--
-- UEPROCMEM_SUBLIST_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."UEPROCMEM_SUBLIST_OBJ"
AS
   OBJECT (SERVICEDATE      DATE,
           RETURNCODE       VARCHAR2(10));



--
-- UEPROCMEM_SUBLIST_TAB  (Type) 
--
--  Dependencies: 
--   UEPROCMEM_SUBLIST_OBJ (Type)
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."UEPROCMEM_SUBLIST_TAB" as table of UEPROCMEM_SUBLIST_OBJ;



--
-- UEPROCMEM_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   UEPROCMEM_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS."UEPROCMEM_TAB" AS TABLE OF ODS.UEPROCMEM_OBJ;



--
-- UE_MED_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   UEMEDS_SUBLIST_TAB (Type)
--
CREATE OR REPLACE TYPE ODS.UE_MED_OBJ
AS
   OBJECT (
  DRUGTRADENAME     VARCHAR2(50 BYTE),
  MEDICALCODE       VARCHAR2(20 BYTE),
  CODESYSTEMNAME    VARCHAR2(10 BYTE),
  NDCDOSAGEID       NUMBER,
  DRUGDOSAGE        VARCHAR2(30 BYTE),
  COMMENTS          VARCHAR2(4000 BYTE),
  STATUS            VARCHAR2(50 BYTE),
  STATUSREASON      VARCHAR2(255 BYTE),
  LASTUPDATEDATE    DATE,
  DAYSOFSUPPLY      NUMBER,
  UEMEDSSUBLIST     UEMEDS_SUBLIST_TAB
)



--
-- UE_MED_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   UE_MED_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.UE_MED_TAB as table of UE_MED_OBJ



--
-- USERORGINFO_OBJ  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.userOrginfo_obj
AS
   OBJECT (OrgId NUMBER,
           OrgName VARCHAR2 (200),
           OrgoId VARCHAR2 (64),
           CreatedDataSource VARCHAR2 (20),
           UpdatedDataSource VARCHAR2 (20),
           StartDate DATE,
           EndDate DATE,
           PrimaryFlag CHAR (1),
           OrgType VARCHAR2 (12),
           OrgTypeDesc VARCHAR2 (255));



--
-- USERORGINFO_TAB  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   USERORGINFO_OBJ (Type)
--
CREATE OR REPLACE TYPE ODS.userorginfo_tab AS TABLE OF userOrginfo_obj;



--
-- UTILDRUG_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.UTILDRUG_OBJECT AS OBJECT (
   memberid             NUMBER,
   dateofevent          DATE,
   code                 VARCHAR2 (20),
   status               VARCHAR2 (255),
   statusreason         VARCHAR2 (255),
   notcompliant         VARCHAR2 (30),
   notcompliantreason   VARCHAR2 (255),
   memberreporteddruginstid    number,
   drugdosage           VARCHAR2 (30),
   datasourcenm VARCHAR(20)
); 



--
-- UTILDRUG_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   UTILDRUG_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.UTILDRUG_OBJECT_ARRAY as table of UTILDRUG_OBJECT; 



--
-- UTIL_OBJECT  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS.UTIL_OBJECT as object(
  memberid       NUMBER,
  dateofevent    DATE,
  code          varchar2(50),
  value          VARCHAR2(4000),
  instanceid     NUMBER,
  datasourcenm VARCHAR(20)); 



--
-- UTIL_OBJECT_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--   UTIL_OBJECT (Type)
--
CREATE OR REPLACE TYPE ODS.UTIL_OBJECT_ARRAY as table of ODS.UTIL_OBJECT; 



--
-- VARCHAR2_ARRAY  (Type) 
--
--  Dependencies: 
--   STANDARD (Package)
--
CREATE OR REPLACE TYPE ODS."VARCHAR2_ARRAY" AS TABLE OF VARCHAR2 (32767);




-- EXIT;