-----------------
--Drop if exists-
-----------------


--Drop existing constraints if they exist
ALTER DOMAIN ns_locationlength DROP CONSTRAINT IF EXISTS ns_locationlength_check;
ALTER DOMAIN ns_locationwidth DROP CONSTRAINT IF EXISTS ns_locationwidth_check;
ALTER DOMAIN ns_locationitemnum DROP CONSTRAINT IF EXISTS ns_locationwidth_check;
ALTER DOMAIN ns_exhibitionnumberofitems DROP CONSTRAINT IF EXISTS ns_exhibitionnumberofitems_check;
ALTER DOMAIN ns_minitems DROP CONSTRAINT IF EXISTS ns_minitems_check;
ALTER DOMAIN ns_maxitems DROP CONSTRAINT IF EXISTS ns_maxitemsitems_check;

--Drop existing tables if they exist

DROP TABLE IF EXISTS  ns_Items CASCADE;
DROP TABLE IF EXISTS  ns_Exhibitions CASCADE;
DROP TABLE IF EXISTS  ns_Exhibitions_Items CASCADE;
DROP TABLE IF EXISTS  ns_Exhibitions_Locations CASCADE;
DROP TABLE IF EXISTS  ns_Items_materials CASCADE;
DROP TABLE IF EXISTS  ns_Items_locations CASCADE;
DROP TABLE IF EXISTS  ns_Locations_Doors CASCADE;
DROP TABLE IF EXISTS  ns_Locations CASCADE;
DROP TABLE IF EXISTS  ns_Doors CASCADE;
DROP TABLE IF EXISTS  ns_Loaned_Items CASCADE;
DROP TABLE IF EXISTS  ns_Transactions CASCADE;
DROP TABLE IF EXISTS  ns_Temp_Item_Locations CASCADE;
DROP TABLE IF EXISTS  ns_Temp_Ex_Locations CASCADE;
DROP TABLE IF EXISTS  ns_Temp_Owner CASCADE;
DROP TABLE IF EXISTS  ns_affiliations CASCADE;

--Drop existing domains if they exist

--Drop Items Domains
DROP DOMAIN IF EXISTS ns_alphakey CASCADE;
DROP DOMAIN IF EXISTS ns_numkey CASCADE;
DROP DOMAIN IF EXISTS ns_itemname CASCADE;
DROP DOMAIN IF EXISTS ns_completiondate CASCADE;
DROP DOMAIN IF EXISTS ns_acquisitiondate CASCADE;
DROP DOMAIN IF EXISTS ns_insurancevalue CASCADE;
DROP DOMAIN IF EXISTS ns_ceramictype CASCADE;
DROP DOMAIN IF EXISTS ns_itemware CASCADE;
DROP DOMAIN IF EXISTS ns_itemorigin CASCADE;
DROP DOMAIN IF EXISTS ns_itemdepartment CASCADE;
DROP DOMAIN IF EXISTS ns_itemdescription CASCADE;
DROP DOMAIN IF EXISTS ns_genre CASCADE;
DROP DOMAIN IF EXISTS ns_technique CASCADE;
DROP DOMAIN IF EXISTS ns_itemperiod CASCADE;
DROP DOMAIN IF EXISTS ns_itemcountry CASCADE;
DROP DOMAIN IF EXISTS ns_itemprovince CASCADE;
DROP DOMAIN IF EXISTS ns_acquisitionname CASCADE;
DROP DOMAIN IF EXISTS ns_biologicalclass CASCADE;
DROP DOMAIN IF EXISTS ns_scientistname CASCADE;
DROP DOMAIN IF EXISTS ns_geologicage CASCADE;
DROP DOMAIN IF EXISTS ns_itemcomplete CASCADE;
DROP DOMAIN IF EXISTS ns_itempending CASCADE;

--Drop Item Materials Domains
DROP DOMAIN IF EXISTS ns_itemmaterial CASCADE;

--Drop Exhibitions Domains
DROP DOMAIN IF EXISTS ns_exhibitionid CASCADE;
DROP DOMAIN IF EXISTS ns_exhibitionname CASCADE;
DROP DOMAIN IF EXISTS ns_exhibitiondescription CASCADE;
DROP DOMAIN IF EXISTS ns_exhibitionstart CASCADE;
DROP DOMAIN IF EXISTS ns_exhibitionend CASCADE;
DROP DOMAIN IF EXISTS ns_exhibitionnumberofitems CASCADE;
DROP DOMAIN IF EXISTS ns_exhibitionguard CASCADE;
DROP DOMAIN IF EXISTS ns_exhibitionsponsor CASCADE;
DROP DOMAIN IF EXISTS ns_exhibitiontravel CASCADE;

--Drop Exhibition Locations Domains
DROP DOMAIN IF EXISTS ns_locationtown CASCADE;

--Drop Locations Domains
DROP DOMAIN IF EXISTS ns_locationid CASCADE;
DROP DOMAIN IF EXISTS ns_locationname CASCADE;
DROP DOMAIN IF EXISTS ns_minitems CASCADE;
DROP DOMAIN IF EXISTS ns_maxitems CASCADE;
DROP DOMAIN IF EXISTS ns_locationlength CASCADE;
DROP DOMAIN IF EXISTS ns_locationwidth CASCADE;
DROP DOMAIN IF EXISTS ns_locationitemnum CASCADE;
DROP DOMAIN IF EXISTS ns_locationreadyon CASCADE;

--Drop Doors Domains
DROP DOMAIN IF EXISTS ns_doorid CASCADE;
DROP DOMAIN IF EXISTS ns_doorname CASCADE;

--Drop Loaned Items Domains
DROP DOMAIN IF EXISTS ns_loanstart CASCADE;
DROP DOMAIN IF EXISTS ns_loanendexp CASCADE;
DROP DOMAIN IF EXISTS ns_loanendact CASCADE;

--Drop Affiliations Domains
DROP DOMAIN IF EXISTS ns_affiliationid CASCADE;
DROP DOMAIN IF EXISTS ns_affiliationname CASCADE;
DROP DOMAIN IF EXISTS ns_affiliationaddress CASCADE;
DROP DOMAIN IF EXISTS ns_affiliationphone CASCADE;
DROP DOMAIN IF EXISTS ns_affiliationemail CASCADE;

--Drop Transactions Domains
DROP DOMAIN IF EXISTS ns_transactionsid CASCADE;
DROP DOMAIN IF EXISTS ns_transdate CASCADE;
DROP DOMAIN IF EXISTS ns_transcost CASCADE;
DROP DOMAIN IF EXISTS ns_transtype CASCADE;

--Drop Temp Domains
DROP DOMAIN IF EXISTS ns_tempstart CASCADE;
DROP DOMAIN IF EXISTS ns_tempend CASCADE;


-----------------
--Create Domains-
-----------------


--Create Items Domains
CREATE DOMAIN ns_alphakey AS VARCHAR(10);
CREATE DOMAIN ns_numkey AS SMALLINT
CHECK (VALUE >= 0);
CREATE DOMAIN ns_itemname AS VARCHAR(100);
CREATE DOMAIN ns_completiondate AS TEXT;
CREATE DOMAIN ns_datecollected as DATE;
CREATE DOMAIN ns_acquisitiondate AS TIMESTAMP;
CREATE DOMAIN ns_insurancevalue AS DECIMAL(10,2)
CHECK (VALUE >= 0);
CREATE DOMAIN ns_ceramictype AS VARCHAR(20);
CREATE DOMAIN ns_itemware AS VARCHAR(40);
CREATE DOMAIN ns_itemorigin AS VARCHAR(100);
CREATE DOMAIN ns_itemdepartment AS VARCHAR(35);
CREATE DOMAIN ns_itemdescription AS TEXT;
CREATE DOMAIN ns_genre AS VARCHAR(20);
CREATE DOMAIN ns_technique AS VARCHAR(20);
CREATE DOMAIN ns_itemperiod AS VARCHAR(50);
CREATE DOMAIN ns_itemcountry AS VARCHAR(50);
CREATE DOMAIN ns_itemprovince AS VARCHAR(50);
CREATE DOMAIN ns_acquisitionname AS VARCHAR(50);
CREATE DOMAIN ns_kingdom AS VARCHAR(50);
CREATE DOMAIN ns_phylum AS VARCHAR(50);
CREATE DOMAIN ns_class AS VARCHAR(50);
CREATE DOMAIN ns_scientistname AS TEXT;
CREATE DOMAIN ns_geologicage AS TEXT;
CREATE DOMAIN ns_itemcomplete AS BOOLEAN;

--Create Item Materials Domains
CREATE DOMAIN ns_itemmaterial AS VARCHAR(50);

--Create Exhibitions Domains
CREATE DOMAIN ns_exhibitionname AS TEXT;
CREATE DOMAIN ns_exhibitiondescription AS TEXT;
CREATE DOMAIN ns_exhibitionstart AS TIMESTAMP;
CREATE DOMAIN ns_exhibitionend AS TIMESTAMP;
CREATE DOMAIN ns_exhibitionguard AS TEXT;
CREATE DOMAIN ns_exhibitionsponsor AS TEXT;
CREATE DOMAIN ns_travelinsurance AS DECIMAL(10,2);

--Create Exhibition Locations Domains
CREATE DOMAIN ns_locationtown AS TEXT;

--Create Locations Domains
CREATE DOMAIN ns_locationname AS VARCHAR(50);
CREATE DOMAIN ns_minitems AS SMALLINT
CHECK (VALUE >= 0);
CREATE DOMAIN ns_maxitems AS SMALLINT
CHECK (VALUE >= 0);
CREATE DOMAIN ns_locationlength AS INTEGER
CHECK (VALUE >= 0);
CREATE DOMAIN ns_locationwidth AS INTEGER
CHECK (VALUE >= 0);

--Create Doors Domains
CREATE DOMAIN ns_doorname AS VARCHAR(50);

--Create Museums Domains
CREATE DOMAIN ns_museumname AS TEXT;

--Create Transactions Domains
CREATE DOMAIN ns_transdate AS TIMESTAMP;
CREATE DOMAIN ns_transcost AS DECIMAL(10,2)
CHECK (VALUE >= 0);
CREATE DOMAIN ns_transtype AS VARCHAR(4)
CHECK (VALUE IN('BUY' , 'SELL' , 'BORROW' , 'LOAN'));
CREATE DOMAIN ns_contactname AS TEXT;
CREATE DOMAIN ns_transaddress AS TEXT;
CREATE DOMAIN ns_transphone as VARCHAR(25);
CREATE DOMAIN ns_transemail as VARCHAR(50);
CREATE DOMAIN ns_loanstart AS TIMESTAMP;
CREATE DOMAIN ns_loanend AS TIMESTAMP;

-----------------
--Create Tables--
-----------------

--Create Museums Table
CREATE TABLE ns_Museums (
        mus_museumname ns_museumname PRIMARY KEY NOT NULL
);

--Create Locations Table
CREATE TABLE ns_Locations (
loc_museum ns_museumname NOT NULL,
loc_locationname ns_locationname NOT NULL,
loc_min ns_minitems,
loc_max ns_maxitems,
loc_length ns_locationlength,
loc_width ns_locationwidth,
loc_guard ns_exhibitionguard,
loc_sponsor ns_exhibitionsponsor,
loc_travelinsurance ns_travelinsurance,
loc_atmuseum BOOLEAN,
FOREIGN KEY (loc_museum) REFERENCES ns_Museums(mus_museumname) 
ON DELETE RESTRICT 
ON UPDATE CASCADE,
CONSTRAINT min_lessthan_max CHECK (loc_min <= loc_max),
PRIMARY KEY(loc_museum, loc_locationname)
);

--Create Doors Table
CREATE TABLE ns_Doors (
        dor_museum ns_museumname NOT NULL,
        dor_name ns_doorname NOT NULL,
        FOREIGN KEY (dor_museumname) REFERENCES ns_Museums (mus_museumname)
                ON DELETE RESTRICT
                ON UPDATE CASCADE,
        PRIMARY KEY (dor_museum,dor_name)
);

--Create Locations Doors Table
CREATE TABLE ns_Locations_Doors (
        ld_museum ns_museumname NOT NULL REFERENCES ns_Museums (mus_museumname),
        ld_doorname ns_doorname NOT NULL,
        ld_location ns_locationname NOT NULL,
        FOREIGN KEY (ld_doorname) REFERENCES ns_Doors (dor_name)
		FOREIGN KEY (ld_location) REFERENCES ns_Locations (loc_locationname)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
		PRIMARY KEY(ld_museum, ld_doorname, ld_location)
);

--Create Items Table
CREATE TABLE ns_Items (
        itm_museum ns_museumname NOT NULL REFERENCES ns_Museums(mus_museumname),
        itm_alpha ns_alphakey NOT NULL,
        itm_num ns_numkey NOT NULL,
        itm_name ns_itemname,
        itm_cdate ns_completiondate,
		itm_datecollected ns_datecollected,	
        itm_acqdate ns_acquisitiondate,
        itm_ins ns_insurancevalue,
        itm_certype ns_ceramictype,
        itm_ware ns_itemware,
        itm_origin ns_itemorigin,
        itm_dept ns_itemdepartment,
        itm_description ns_itemdescription,
        itm_genre ns_genre,
        itm_technique ns_technique,
        itm_period ns_itemperiod,
        itm_country ns_itemcountry,
        itm_province ns_itemprovince,
        itm_acqname ns_acquisitionname,
        itm_kingdom ns_kingdom,
        itm_phylum ns_phylum,
        itm_class ns_class,
        itm_identifiedby ns_scientistname,
        itm_geologicage ns_geologicage,
        itm_iscomplete ns_itemcomplete,
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
		PRIMARY KEY (itm_alpha, itm_num, itm_museum)
);

--Create Exhibitions Table
CREATE TABLE ns_Exhibitions (
        exh_museum ns_museumname NOT NULL,
        exh_name ns_exhibitionname NOT NULL,
        exh_desc ns_exhibitiondescription,
        exh_start ns_exhibitionstart NOT NULL,
        exh_end ns_exhibitionend,
FOREIGN KEY (exh_museum) REFERENCES ns_Museums(mus_museumname)
ON UPDATE CASCADE
ON DELETE RESTRICT,
PRIMARY KEY (exh_name, exh_museum),
CONSTRAINT start_before_end CHECK (exh_start <= exh_end)
);

--Create Exhibitions_Items Table
CREATE TABLE ns_Exhibitions_Items (
        ei_museum ns_museumname NOT NULL,
        ei_exhibitionname ns_exhibitionname NOT NULL,
        ei_alpha ns_alphakey NOT NULL,
        ei_num ns_numkey NOT NULL,
        FOREIGN KEY (ei_exhibitionname) REFERENCES ns_Exhibitions (exh_name) 
        FOREIGN KEY (ei_alpha, ei_num,) REFERENCES ns_Items(itm_alpha, itm_num) 
ON DELETE RESTRICT 
ON UPDATE CASCADE,
PRIMARY KEY (ei_museum, ei_exhibitionname, ei_alpha, ei_num)
);

--Create Exhibitions_Locations Table
CREATE TABLE ns_Exhibitions_Locations (
        el_museum ns_museumname NOT NULL REFERENCES ns_Museums(mus_museumname),
        el_exhibitionname ns_exhibitionname NOT NULL,
        el_location ns_locationid NOT NULL,
	el_starttime TIMESTAMP,
	el_endtime TIMESTAMP,
        FOREIGN KEY (el_exhibitionname) REFERENCES ns_Exhibitions(exh_name) 
        FOREIGN KEY (el_location) REFERENCES ns_Locations (loc_locationname) 
ON DELETE RESTRICT 
ON UPDATE CASCADE,
PRIMARY KEY (el_exhibitionname, el_location, el_museum)
);

--Create Materials Table
CREATE TABLE ns_Materials (
		mat_materialname ns_itemmaterial NOT NULL PRIMARY KEY
);

--Create Items_Materials Table
CREATE TABLE ns_Items_materials (
        im_museum ns_museumname NOT NULL REFERENCES ns_Museums (mus_museumname),
        im_alpha ns_alphakey NOT NULL REFERENCES ns_Items (itm_alpha),
        im_num ns_numkey NOT NULL REFERENCES ns_Items (itm_num),
        im_material ns_itemmaterial NOT NULL REFERENCES ns_Materials (mat_materialname),
        ON DELETE RESTRICT 
		ON UPDATE CASCADE,
		PRIMARY KEY(im_alpha, im_num, im_material, im_museum)
);

--Create Items_Locations Table
CREATE TABLE ns_Items_Locations (
        il_museum ns_museumname NOT NULL REFERENCES ns_Museums (mus_museumname),
        il_alpha ns_alphakey NOT NULL,
        il_num ns_numkey NOT NULL,
        il_location ns_locationname NOT NULL,
	il_starttime TIMESTAMP,
	il_endtime TIMESTAMP,
        FOREIGN KEY (il_alpha, il_num) REFERENCES ns_Items (itm_alpha, itm_num) 
        FOREIGN KEY (il_location) REFERENCES ns_Locations (loc_locationname) 
ON DELETE RESTRICT 
ON UPDATE CASCADE,
PRIMARY KEY (il_museumname,il_alpha, il_num)
);

--Create Transactions Table
CREATE TABLE ns_Transactions (
        tr_alpha ns_alphakey NOT NULL,
        tr_num ns_numkey NOT NULL,
        tr_contactname ns_contactname,
        tr_date ns_transdate NOT NULL,
        tr_cost ns_transcost,
        tr_type ns_transtype NOT NULL,
		tr_address ns_transaddress,
		tr_phonenumber ns_transphone,
		tr_email ns_transemail,
		tr_loanstart ns_loanstart,
		tr_loanend ns_loanend,
        FOREIGN KEY (tr_alpha, tr_num) REFERENCES ns_Items (itm_alpha, itm_num)
                ON DELETE RESTRICT
                ON UPDATE CASCADE
		PRIMARY KEY (tr_alpha, tr_num, tr_date, tr_type)
);











