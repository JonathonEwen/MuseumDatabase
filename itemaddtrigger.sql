CREATE FUNCTION itemAddedToExhibition() RETURNS trigger AS $$
	DECLARE
		ItemInStorage integer;
		exhibitionStart ns_itemtimestamp;
		exhibitionEnd ns_itemtimestamp;
		exhibitionLocation ns_locationname;
		travelling boolean;
		insurance integer;
		
	BEGIN



	SELECT
		el_location 
	INTO exhibitionLocation
	FROM ns_exhibitions_locations 
	WHERE el_exhibitionname = new.ei_exhibitionname;

	SELECT
		loc_atmuseum
	INTO travelling
	FROM ns_locations 
	WHERE loc_locationname = exhibitionLocation;

	SELECT
		el_starttime 
	INTO exhibitionStart
	FROM ns_exhibitions_locations 
	WHERE el_exhibitionname = new.ei_exhibitionname;
	

	SELECT
		el_endtime 
	INTO exhibitionEnd
	FROM ns_exhibitions_locations 
	WHERE el_exhibitionname = new.ei_exhibitionname;
	
	SELECT 
		COUNT(*) FROM (SELECT * FROM ns_items_locations where il_location = 'Storage' and il_museum = NEW.ei_museum 
		and il_alpha = new.ei_alpha and il_num=new.ei_num and exhibitionStart > il_starttime and (il_endtime is null OR (il_endtime > exhibitionStart and il_endtime > exhibitionEnd)))as numitems
	INTO
		ItemInStorage;
	IF ItemInStorage = 0
	THEN RAISE EXCEPTION 'item is not available to be added to the exhibition';RETURN NULL;
	END IF;
	
	UPDATE ns_items_locations set il_endtime = exhibitionStart - interval '12 hours' where il_location = 'Storage' and il_museum = NEW.ei_museum 
		and il_alpha = new.ei_alpha and il_num=new.ei_num and exhibitionStart > il_starttime and (il_endtime is null OR (il_endtime > exhibitionStart and il_endtime > exhibitionEnd));

	--then update the item location table with the added items to the exhibit, the location of the exhibit, 
	--and the times of the exhibit. 

	INSERT into ns_items_locations (il_museum, il_alpha, il_num, il_location, il_starttime, il_endtime)
	VALUES (new.ei_museum, new.ei_alpha, new.ei_num, exhibitionLocation, exhibitionStart, exhibitionEnd);

	--Also schedule the item to be in storage starting the night the exhibition ends. 
 	INSERT into ns_items_locations (il_museum, il_alpha, il_num, il_location, il_starttime)
	VALUES (new.ei_museum, new.ei_alpha, new.ei_num, 'Storage', exhibitionStart + interval '12 hours'); 

	 --if the exhibit is travelling,  recalculate the total insurance value of all locations the item will be in.   

	 IF NOT travelling
	 THEN 	


	select sum( itm_insurancevalue) into insurance from ns_items where (itm_alpha, itm_num) in (select ei_alpha, ei_num 
from ns_exhibitions_items where ei_exhibitionname = new.ei_exhibitionname);
	insurance = 1.1 * insurance;
	update ns_locations set loc_travelinsurance = insurance where loc_locationname = exhibitionLocation;
	 END IF;

	RETURN NEW;
	END;
	
$$ LANGUAGE plpgsql;

CREATE TRIGGER itemAddedToExhibitionTrigger AFTER INSERT ON ns_exhibitions_items
	FOR EACH ROW EXECUTE PROCEDURE itemAddedToExhibition();