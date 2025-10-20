CREATE OR REPLACE FUNCTION get_purchase_item_by_status(p_status purchase_status)
RETURNS SETOF purchase_item AS $$
    SELECT *
    FROM purchase_item
    WHERE purchase_item.status = p_status;
$$ LANGUAGE sql;