
  CREATE TABLE "STANCIULESCUA_64"."ABONATI" 
   (	"NR_ABONAT" NUMBER, 
	"CNP" CHAR(13 BYTE) NOT NULL ENABLE, 
	"NUME" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"PRENUME" VARCHAR2(20 BYTE), 
	"LOCALITATE" VARCHAR2(20 BYTE), 
	 CHECK (LOCALITATE IN ('bucurest','brasov')) ENABLE, 
	 CONSTRAINT "PK_ABONATI" PRIMARY KEY ("NR_ABONAT")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE, 
	 UNIQUE ("CNP")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;