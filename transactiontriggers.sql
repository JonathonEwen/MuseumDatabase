CREATE FUNCTION transactionItems() RETURNS trigger AS $$
	DECLARE
		ItemInStorage integer;
		transtime ns_itemtimestamp;

		itemLocation ns_locationname;
		travelling boolean;
		insurance integer;
		
		
	BEGIN

--item must be in storage to be loaned or sold. if it is not in storage, see if it is at the museum. if not, then exception


	SELECT
		il_location 
	INTO itemLocation
	FROM ns_items_locations 
	WHERE il_exhibitionname = new.ei_exhibitionname;

	SELECT
		loc_atmuseum
	INTO travelling
	FROM ns_locations 
	WHERE loc_locationname = exhibitionLocation;


	

	




      If new.tr_type = 'BUY'
      THEN
      
      update ns_items set itm_ownername = new.tr_museum where itm_alpha = new.tr_alpha and itm_num = new.tr_num;    
      INSERT INTO ns_items_locations (il_museum, il_alpha, il_num, il_location, il_starttime) VALUES
      (new.tr_museum, new.tr_alpha, new.tr_num, 'Storage', new.tr_date);
      END IF;
--item must be in storage to be loaned or sold. if it is not in storage, then exception


      If new.tr_type = 'SELL'
      THEN
	SELECT 
		COUNT(*) FROM (SELECT * FROM ns_items_locations where il_location = 'Storage' and il_museum = NEW.tr_museum 
		and il_alpha = new.tr_alpha and il_num=new.tr_num and new.tr_date > il_starttime and (il_endtime is null OR il_endtime > new.tr_date ))as numitems
	INTO
		ItemInStorage;
	IF ItemInStorage = 0
      	THEN RAISE EXCEPTION 'item is not available to be sold. make sure it is due to be in storage at the time of the transaction';RETURN NULL;
	

	END IF;
      update ns_items set itm_ownername = new.tr_contactname where itm_alpha = new.tr_alpha and itm_num = new.tr_num;      
      INSERT INTO ns_items_locations (il_museum, il_alpha, il_num, il_location, il_starttime) VALUES
      (new.tr_museum, new.tr_alpha, new.tr_num, 'SOLD', new.tr_date);
    END IF;


      If new.tr_type = 'LOAN'
      THEN

 	SELECT 
		COUNT(*) FROM (SELECT * FROM ns_items_locations where il_location = 'Storage' and il_museum = NEW.tr_museum 
		and il_alpha = new.tr_alpha and il_num=new.tr_num and new.tr_loanstart > il_starttime and (il_endtime is null OR (il_endtime > new.tr_loanstart and il_endtime > new.tr_loanend) ))as numitems
	INTO
		ItemInStorage;
	IF ItemInStorage = 0
      	THEN RAISE EXCEPTION 'item is not available to be loaned. make sure it is due to be in storage at the time of the transaction';RETURN NULL;
	


	END IF;
      update ns_items set itm_ownername = new.tr_contactname where itm_alpha = new.tr_alpha and itm_num = new.tr_num;      
      INSERT INTO ns_items_locations (il_museum, il_alpha, il_num, il_location, il_starttime, il_endtime) VALUES
      (new.tr_museum, new.tr_alpha, new.tr_num, 'ON LOAN', new.tr_loanstart, new.tr_loanend);
      INSERT INTO ns_items_locations (il_museum, il_alpha, il_num, il_location, il_starttime) VALUES
      (new.tr_museum, new.tr_alpha, new.tr_num, 'Storage', new.tr_loanend);
END IF;

      If new.tr_type = 'BORROW'
      THEN
      
      update ns_items set itm_ownername = new.tr_contactname where itm_alpha = new.tr_alpha and itm_num = new.tr_num;      
      INSERT INTO ns_items_locations (il_museum, il_alpha, il_num, il_location, il_starttime) VALUES
      (new.tr_museum, new.tr_alpha, new.tr_num, 'Storage', new.tr_date);
      END IF;



      If new.tr_type = 'POTENTIAL BORROW'
      THEN
      
      update ns_items set itm_ownername = 'POTENTIAL BORROW' where itm_alpha = new.tr_alpha and itm_num = new.tr_num;      
      END IF;



	RETURN NEW;
	END;
	
$$ LANGUAGE plpgsql;

CREATE TRIGGER transactionItemsTrigger AFTER INSERT ON ns_transactions
	FOR EACH ROW EXECUTE PROCEDURE transactionItems();