/*
Created: 6/5/2016
Modified: 6/17/2016
Project: IT 700 Capstone
Model: OAR Data Model
Author: Chris Ehmett
Database: PostgreSQL 9.4
*/


-- Create roles section (for roles used in schemas) ------------------------------------------

CREATE ROLE OAR_RO_ROLE NOINHERIT;

CREATE ROLE OAR_RW_ROLE NOINHERIT;

CREATE ROLE OAR_WS_USR INHERIT LOGIN PASSWORD 'Monkey05';

GRANT OAR_RO_ROLE to OAR_WS_USR;

CREATE ROLE OAR_DATA_ADMIN_USR INHERIT LOGIN PASSWORD 'Monkey09'; 

GRANT OAR_RW_ROLE to OAR_DATA_ADMIN_USR;

-- Create schemas section -------------------------------------------------

CREATE SCHEMA IF NOT EXISTS "OAR_OSP_DB" AUTHORIZATION "Admin_OAR"
;

--Grants to Schema
GRANT SELECT ON ALL TABLES IN SCHEMA "OAR_OSP_DB" TO OAR_RO_ROLE;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA "OAR_OSP_DB" TO OAR_RO_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA "OAR_OSP_DB"  TO OAR_RW_ROLE;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA "OAR_OSP_DB" TO OAR_RW_ROLE;
-- Create tables section -------------------------------------------------

-- Table OAR_OSP_DB.prvdr_t

-- Table OAR_OSP_DB.prvdr_t

CREATE TABLE "OAR_OSP_DB"."prvdr_t"(
 "prvdr_id" Integer NOT NULL,
 "prvdr_typ_cde" Character(4) NOT NULL,
 "locn_lati_qty" Numeric(9,6) NOT NULL,
 "locn_long_qty" Numeric(9,6) NOT NULL,
 "row_eff_dte" Date NOT NULL,
 "row_exp_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

--Add gemoetry type
SET search_path TO "OAR_OSP_DB", public;

SELECT AddGeometryColumn('prvdr_t', 'locn_geo_point', 4326,'POINT',2);

-- Create indexes for table OAR_OSP_DB.prvdr_t

CREATE INDEX "ix_prdr_typ_rel" ON "OAR_OSP_DB"."prvdr_t" ("prvdr_typ_cde")
;
CREATE INDEX ix_prvdr_locn_geo_point ON "OAR_OSP_DB".prvdr_t USING GIST ( locn_geo_point )
;
-- Add keys for table OAR_OSP_DB.prvdr_t

ALTER TABLE "OAR_OSP_DB"."prvdr_t" ADD CONSTRAINT "prvdr_pk" PRIMARY KEY ("prvdr_id")
;

-- Table OAR_OSP_DB.prvdr_typ_t

CREATE TABLE "OAR_OSP_DB"."prvdr_typ_t"(
 "prvdr_typ_cde" Character(4) NOT NULL,
 "prvdr_typ_nme" Character varying(75) NOT NULL,
 "prvdr_type_desc" Character varying(255),
 "row_eff_dte" Date NOT NULL,
 "row_exp_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

-- Add keys for table OAR_OSP_DB.prvdr_typ_t

ALTER TABLE "OAR_OSP_DB"."prvdr_typ_t" ADD CONSTRAINT "prvdr_typ_pk" PRIMARY KEY ("prvdr_typ_cde")
;

-- Table OAR_OSP_DB.prvdr_addr_t

CREATE TABLE "OAR_OSP_DB"."prvdr_addr_t"(
 "prvdr_addr_id" Integer NOT NULL,
 "prvdr_id" Integer NOT NULL,
 "addr_typ_cde" Character(4) NOT NULL,
 "addr_line_1_txt" Character varying(255) NOT NULL,
 "addr_line_2_txt" Character varying(255),
 "addr_line_3_txt" Character varying(255),
 "city_nme" Character varying(75) NOT NULL,
 "stt_cde" Character(2) NOT NULL,
 "postl_cde" Character(10) NOT NULL,
 "row_exp_dte" Date NOT NULL,
 "row_eff_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

-- Create indexes for table OAR_OSP_DB.prvdr_addr_t

CREATE INDEX "ix_prvdr_addr_rel" ON "OAR_OSP_DB"."prvdr_addr_t" ("prvdr_id")
;

CREATE INDEX "ix_addr_typ_rel" ON "OAR_OSP_DB"."prvdr_addr_t" ("addr_typ_cde")
;

-- Add keys for table OAR_OSP_DB.prvdr_addr_t

ALTER TABLE "OAR_OSP_DB"."prvdr_addr_t" ADD CONSTRAINT "prvdr_addr_pk" PRIMARY KEY ("prvdr_addr_id")
;

-- Table OAR_OSP_DB.prvdr_orgnn_nme

CREATE TABLE "OAR_OSP_DB"."prvdr_orgnn_nme"(
 "prvdr_nme_id" Integer NOT NULL,
 "prvdr_id" Integer NOT NULL,
 "orgnn_name" Character varying(255) NOT NULL,
 "orgnn_alias_nme" Character varying(75),
 "row_exp_date" Date NOT NULL,
 "row_eff_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

-- Create indexes for table OAR_OSP_DB.prvdr_orgnn_nme

CREATE INDEX "ix_prvdr_nme_rel" ON "OAR_OSP_DB"."prvdr_orgnn_nme" ("prvdr_id")
;

-- Add keys for table OAR_OSP_DB.prvdr_orgnn_nme

ALTER TABLE "OAR_OSP_DB"."prvdr_orgnn_nme" ADD CONSTRAINT "prvdr_nme_pk" PRIMARY KEY ("prvdr_nme_id")
;

-- Table OAR_OSP_DB.prdvr_cntc_t

CREATE TABLE "OAR_OSP_DB"."prvdr_cntc_t"(
 "prvdr_cntc_id" Integer NOT NULL,
 "prvdr_id" Integer NOT NULL,
 "cnct_typ_cde" Character(4) NOT NULL,
 "cntc_title_nme" Character varying(30),
 "cntc_frst_nme" Character varying(75) NOT NULL,
 "cnct_mid_init_nme" Character(1),
 "cntc_lst_nme" Character varying(75) NOT NULL,
 "row_eff_dte" Date NOT NULL,
 "row_exp_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

-- Create indexes for table OAR_OSP_DB.prdvr_cntc_t

CREATE INDEX "ix_prvdr_cntc_rel" ON "OAR_OSP_DB"."prvdr_cntc_t" ("prvdr_id")
;

CREATE INDEX "ix_cntc_typ_rel" ON "OAR_OSP_DB"."prvdr_cntc_t" ("cnct_typ_cde")
;

-- Add keys for table OAR_OSP_DB.prdvr_cntc_t

ALTER TABLE "OAR_OSP_DB"."prvdr_cntc_t" ADD CONSTRAINT "prvdr_cnct_pk" PRIMARY KEY ("prvdr_cntc_id")
;

-- Table OAR_OSP_DB.prvdr_phon_t

CREATE TABLE "OAR_OSP_DB"."prvdr_phon_t"(
 "prvdr_phon_id" Integer NOT NULL,
 "prvdr_id" Integer NOT NULL,
 "phon_typ_cde" Character(4) NOT NULL,
 "phon_num" Character(12) NOT NULL,
 "row_eff_dte" Date NOT NULL,
 "row_exp_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;
COMMENT ON COLUMN "OAR_OSP_DB"."prvdr_phon_t"."phon_num" IS 'Format 999-999-9999'
;

-- Create indexes for table OAR_OSP_DB.prvdr_phon_t

CREATE INDEX "ix_prvdr_phone_rel" ON "OAR_OSP_DB"."prvdr_phon_t" ("prvdr_id")
;

CREATE INDEX "ix_phon_typ_rel" ON "OAR_OSP_DB"."prvdr_phon_t" ("phon_typ_cde")
;

-- Add keys for table OAR_OSP_DB.prvdr_phon_t

ALTER TABLE "OAR_OSP_DB"."prvdr_phon_t" ADD CONSTRAINT "prvdr_phon_pk" PRIMARY KEY ("prvdr_phon_id")
;

-- Table OAR_OSP_DB.cntc_typ_t

CREATE TABLE "OAR_OSP_DB"."cntc_typ_t"(
 "cntc_typ_cde" Character(4) NOT NULL,
 "cntc_typ_name" Character varying(75) NOT NULL,
 "cntc_typ_desc" Character varying(255),
 "row_eff_dte" Date NOT NULL,
 "row_exp_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

-- Add keys for table OAR_OSP_DB.cntc_typ_t

ALTER TABLE "OAR_OSP_DB"."cntc_typ_t" ADD CONSTRAINT "cntc_typ_pk" PRIMARY KEY ("cntc_typ_cde")
;

-- Table OAR_OSP_DB.mtng_typ_t

CREATE TABLE "OAR_OSP_DB"."mtng_typ_t"(
 "mtng_typ_cde" Character(4) NOT NULL,
 "mtng_typ_nme" Character varying(75) NOT NULL,
 "mtng_typ_desc" Character varying(255),
 "row_eff_dte" Date NOT NULL,
 "row_exp_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

-- Add keys for table OAR_OSP_DB.mtng_typ_t

ALTER TABLE "OAR_OSP_DB"."mtng_typ_t" ADD CONSTRAINT "mtng_typ_pk" PRIMARY KEY ("mtng_typ_cde")
;

-- Table OAR_OSP_DB.phone_typ_t

CREATE TABLE "OAR_OSP_DB"."phone_typ_t"(
 "phon_typ_cde" Character(4) NOT NULL,
 "phon_typ_nme" Character varying(75) NOT NULL,
 "phon_typ_desc" Character varying(255),
 "row_eff_dte" Date NOT NULL,
 "row_exp_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

-- Add keys for table OAR_OSP_DB.phone_typ_t

ALTER TABLE "OAR_OSP_DB"."phone_typ_t" ADD CONSTRAINT "phon_typ_pk" PRIMARY KEY ("phon_typ_cde")
;

-- Table OAR_OSP_DB.addr_type_t

CREATE TABLE "OAR_OSP_DB"."addr_type_t"(
 "addr_typ_cde" Character(4) NOT NULL,
 "addr_typ_nme" Character varying(75) NOT NULL,
 "phone_typ_desc" Character varying(255),
 "row_eff_dte" Date NOT NULL,
 "row_exp_dte" Date NOT NULL,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

-- Add keys for table OAR_OSP_DB.addr_type_t

ALTER TABLE "OAR_OSP_DB"."addr_type_t" ADD CONSTRAINT "addr_typ_pk" PRIMARY KEY ("addr_typ_cde")
;

-- Table OAR_OSP_DB.prvdr_mtng_schdl_t

CREATE TABLE "OAR_OSP_DB"."prvdr_mtng_schdl_t"(
 "prvdr_mtng_id" Integer NOT NULL,
 "mtng_typ_cde" Character(4) NOT NULL,
 "prvdr_id" Integer NOT NULL,
 "mtng_day_nme" Varchar NOT NULL,
 "mtng_tm" Time,
 "mtng_frq_desc" Character varying(75),
 "row_eff_dte" Date,
 "row_exp_dte" Date,
 "lst_updte_usr_nme" character varying(30) NOT NULL
)
;

-- Create indexes for table OAR_OSP_DB.prvdr_mtng_schdl_t

CREATE INDEX "IX_prvdr_mtng_rel" ON "OAR_OSP_DB"."prvdr_mtng_schdl_t" ("prvdr_id")
;

CREATE INDEX "IX_mtng_typ_rel" ON "OAR_OSP_DB"."prvdr_mtng_schdl_t" ("mtng_typ_cde")
;

-- Add keys for table OAR_OSP_DB.prvdr_mtng_schdl_t

ALTER TABLE "OAR_OSP_DB"."prvdr_mtng_schdl_t" ADD CONSTRAINT "Key1" PRIMARY KEY ("prvdr_mtng_id")
;

-- Create relationships section ------------------------------------------------- 

ALTER TABLE "OAR_OSP_DB"."prvdr_t" ADD CONSTRAINT "provider type rel" FOREIGN KEY ("prvdr_typ_cde") REFERENCES "OAR_OSP_DB"."prvdr_typ_t" ("prvdr_typ_cde") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "OAR_OSP_DB"."prvdr_addr_t" ADD CONSTRAINT "provider to address rel" FOREIGN KEY ("prvdr_id") REFERENCES "OAR_OSP_DB"."prvdr_t" ("prvdr_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "OAR_OSP_DB"."prvdr_orgnn_nme" ADD CONSTRAINT "provider to name rel" FOREIGN KEY ("prvdr_id") REFERENCES "OAR_OSP_DB"."prvdr_t" ("prvdr_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "OAR_OSP_DB"."prdvr_cntc_t" ADD CONSTRAINT "provider to contact" FOREIGN KEY ("prvdr_id") REFERENCES "OAR_OSP_DB"."prvdr_t" ("prvdr_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "OAR_OSP_DB"."prvdr_phon_t" ADD CONSTRAINT "provider to telephone rel" FOREIGN KEY ("prvdr_id") REFERENCES "OAR_OSP_DB"."prvdr_t" ("prvdr_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "OAR_OSP_DB"."prdvr_cntc_t" ADD CONSTRAINT "contact type rel" FOREIGN KEY ("cnct_typ_cde") REFERENCES "OAR_OSP_DB"."cntc_typ_t" ("cntc_typ_cde") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "OAR_OSP_DB"."prvdr_phon_t" ADD CONSTRAINT "telephone type rel" FOREIGN KEY ("phon_typ_cde") REFERENCES "OAR_OSP_DB"."phone_typ_t" ("phon_typ_cde") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "OAR_OSP_DB"."prvdr_addr_t" ADD CONSTRAINT "address type rel" FOREIGN KEY ("addr_typ_cde") REFERENCES "OAR_OSP_DB"."addr_type_t" ("addr_typ_cde") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "OAR_OSP_DB"."prvdr_mtng_schdl_t" ADD CONSTRAINT "prvdr mtng rel" FOREIGN KEY ("prvdr_id") REFERENCES "OAR_OSP_DB"."prvdr_t" ("prvdr_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "OAR_OSP_DB"."prvdr_mtng_schdl_t" ADD CONSTRAINT "mtng typ rel" FOREIGN KEY ("mtng_typ_cde") REFERENCES "OAR_OSP_DB"."mtng_typ_t" ("mtng_typ_cde") ON DELETE NO ACTION ON UPDATE NO ACTION
;


