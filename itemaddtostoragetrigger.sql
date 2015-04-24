CREATE FUNCTION itemaddtostorage() RETURNS trigger AS $$
	DECLARE
	
		itemowner ns_ownername;
		
	BEGIN



	SELECT
		itm_ownername
	INTO itemowner
	FROM ns_items
	WHERE itm_alpha = new.il_alpha and itm_num = new.il_num;

	IF itemowner = 'POTENTIAL BORROW'
	THEN RAISE EXCEPTION 'item is not available to be added to storage as it is only a potentially borrowable item';RETURN NULL;
	END IF;
	


	RETURN NEW;
	END;
	
$$ LANGUAGE plpgsql;

CREATE TRIGGER itemaddtostorageTrigger AFTER INSERT ON ns_items_locations
	FOR EACH ROW EXECUTE PROCEDURE itemaddtostorage();