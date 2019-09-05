-- SET ECHO ON

--
-- FAGE  (Function) 
--
--  Dependencies: 
--   DUAL (Synonym)
--   STANDARD (Package)
--   SYS_STUB_FOR_PURITY_ANALYSIS (Package)
--
CREATE OR REPLACE FUNCTION ODS.FAGE
  (DTOFBIRTH   IN DATE,
   ASOFDT      IN DATE)
   RETURN NUMBER
 IS
   AGE         NUMBER;
--
BEGIN
 IF DTOFBIRTH < ASOFDT THEN
 SELECT FLOOR (MONTHS_BETWEEN(ASOFDT, DTOFBIRTH) / 12)
 INTO AGE
 FROM DUAL;
 ELSE AGE := 0;
 END IF;
--
RETURN AGE;
END;
/


--
-- FDEBUG  (Function) 
--
--  Dependencies: 
--   STANDARD (Package)
--   SYS_STUB_FOR_PURITY_ANALYSIS (Package)
--   DEBUGPROC (Table)
--
CREATE OR REPLACE FUNCTION ODS.FDEBUG
  (PTABLE    IN VARCHAR2)
   RETURN    CHAR
 IS
   DEBUGIND   CHAR(1);
--
 BEGIN
   SELECT debugsw
     INTO debugind
     FROM debugproc
    WHERE procname = ptable;
RETURN debugind;
 EXCEPTION WHEN NO_DATA_FOUND
  THEN
  RETURN 'N';
END;
/


--
-- FERRORCODES  (Function) 
--
--  Dependencies: 
--   SYS_STUB_FOR_PURITY_ANALYSIS (Package)
--   STANDARD (Package)
--   REFDATASERVICEERROR (Table)
--   LOG_ERROR (Procedure)
--
CREATE OR REPLACE FUNCTION ODS.ferrorcodes (errorgroup_in   IN VARCHAR2,
                                                errordesc_in    IN VARCHAR2)
   RETURN VARCHAR2
AS
   verrorcode   VARCHAR2 (5);
BEGIN
   SELECT   ERRORCD
     INTO   verrorcode
     FROM   REFDATASERVICEERROR
    WHERE   UPPER (TARGETSYSTEMNM) = UPPER (errorgroup_in)
            AND UPPER (ERRORMSG) = UPPER (errordesc_in);

   RETURN verrorcode;
EXCEPTION
   WHEN OTHERS
   THEN
      log_error ('ferrorcodes',
                 errorgroup_in || ' ' || errordesc_in,
                 SQLCODE,
                 SQLERRM,
                 SYSDATE,
                 NULL);
      RETURN NULL;
END ferrorcodes;
/


--
-- FGETMEMBERID  (Function) 
--
--  Dependencies: 
--   SUPPLIERORGANIZATION (Table)
--   STANDARD (Package)
--   SYS_STUB_FOR_PURITY_ANALYSIS (Package)
--   AHMMRNBUSINESSSUPPLIER (Table)
--   MEMBER (Table)
--
CREATE OR REPLACE FUNCTION ODS.fgetmemberid (
   memberid_in       IN   MEMBER.sourcememberpatientid%TYPE,
   clientid_in       IN   MEMBER.ahmsupplierid%TYPE,
   memberplanid_in   IN   MEMBER.primarymemberplanid%TYPE
)
   RETURN NUMBER
AS
   vmemberid        MEMBER.memberid%TYPE;
   vusagemnemonic   supplierorganization.usagemnemonic%TYPE;
BEGIN
   IF memberid_in IS NOT NULL AND clientid_in IS NOT NULL
   THEN
      SELECT usagemnemonic
        INTO vusagemnemonic
        FROM ods.supplierorganization
       WHERE ahmsupplierid = clientid_in;

      IF vusagemnemonic = 'B'
      THEN
         SELECT memberid
           INTO vmemberid
           FROM MEMBER m, ahmmrnbusinesssupplier ahmbs
          WHERE m.memberid = ahmbs.ahmmrnmemberid
            AND sourcememberpatientid = memberid_in
            AND ahmbs.lastbusinessahmsupplierid = clientid_in;
      ELSE
         SELECT memberid
           INTO vmemberid
           FROM MEMBER
          WHERE sourcememberpatientid = memberid_in
            AND ahmsupplierid = clientid_in;
      END IF;
   ELSIF memberplanid_in IS NOT NULL
   THEN
      SELECT memberid
        INTO vmemberid
        FROM MEMBER
       WHERE primarymemberplanid = memberplanid_in AND ahmsupplierid <> 0;
   ELSE
      vmemberid := 0;
   END IF;

   RETURN vmemberid;
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN 0;
END;
/

-- EXIT;