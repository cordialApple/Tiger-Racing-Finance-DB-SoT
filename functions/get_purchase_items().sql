CREATE OR REPLACE FUNCTION get_purchase_items()
RETURNS SETOF purchase_item AS $$
    SELECT *
    FROM purchase_item;
$$ LANGUAGE sql;