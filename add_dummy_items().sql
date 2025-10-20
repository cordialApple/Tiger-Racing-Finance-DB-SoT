CREATE OR REPLACE FUNCTION add_dummy_items(n INT)
RETURNS INT AS $$    --Returns # Of Dummy Rows Generated
DECLARE
  rows INT;
BEGIN
  INSERT INTO public.purchase_item (
    id, requester, part_url, part_name, manufacturer_pt_no,
    unit_price, quantity, supplier, status, notes,
    created_at, needed_by, po_no, order_date, request_id, approvals
  )
  SELECT
    gen_random_uuid() AS id,                                                         
    (SELECT id FROM "users" ORDER BY random() LIMIT 1) AS requester,                                                  
    format('https://example.com/item_%s', i) AS part_url,                            
    format('Item_%s', i) AS part_name,                                                      
    100000 + i AS manufacturer_pt_no,                                                  
    round((random() * 150 + 10)::numeric, 2) AS unit_price,                                  
    (1 + floor(random() * 10))::int AS quantity,                                           
    format('Supplier%s', 1+ (floor(random() * 6))::int) AS supplier,                                 
    (enum_range(NULL::public.purchase_status))[
    1 + floor(random() * array_length(enum_range(NULL::public.purchase_status), 1))::int
    ]::public.purchase_status AS status,                                                 
    format('Dummy_Item_%s', i) AS notes,                                                
    now() - make_interval(days => i) AS created_at,                                          
    current_date + make_interval(days => (2 * (3*i % 11))) AS needed_by,                    
    'TR26-' || LPAD(i::text, 3, '0') AS po_no,                                          
    current_date - make_interval(days => i*5) AS order_date,                                 
    gen_random_uuid() AS request_id,                                                         
    ARRAY[(random()>0.5), (random()>0.5), (random()>0.5)] AS approvals                     
  FROM generate_series(1, n) AS s(i);

  GET DIAGNOSTICS rows = ROW_COUNT;
  RETURN rows;
END;
$$ LANGUAGE plpgsql;
