CREATE OR REPLACE FUNCTION add_purchase_item(
    p_requester uuid DEFAULT NULL,              --implicit value-casting if attribute not used in constructur
    p_part_url varchar DEFAULT NULL,
    p_part_name text DEFAULT NULL,
    p_manufacturer_pt_no bigint DEFAULT NULL,
    p_unit_price float8 DEFAULT NULL,
    p_quantity int8 DEFAULT NULL,
    p_supplier text DEFAULT NULL,
    p_status purchase_status DEFAULT NULL,
    p_notes text DEFAULT NULL,
    p_needed_by date DEFAULT NULL,
    p_order_date date DEFAULT NULL,
    p_order_received_date date DEFAULT NULL,
    p_order_active_status date DEFAULT NULL,
    p_request_id uuid DEFAULT NULL,
    p_po_number numeric DEFAULT NULL
)
RETURNS SETOF purchase_item AS $$
    INSERT INTO purchase_item (
        requester,
        part_url,
        part_name,
        manufacturer_pt_no,
        unit_price,
        quantity,
        supplier,
        status,
        notes,
        created_at,
        needed_by,
        po_no,
        order_date,
        order_received_date,
        order_active_status,
        request_id
    )
    VALUES (
        COALESCE(p_requester, auth.uid()),        -- default requester
        p_part_url,
        p_part_name,
        p_manufacturer_pt_no,
        p_unit_price,
        p_quantity,
        p_supplier,
        COALESCE(p_status, 'pending'),            -- default status
        p_notes,
        NOW(),                                     -- created_at
        p_needed_by,
        'TR26-' || p_po_number,                    -- NULL if p_po_number not provided
        p_order_date,
        p_order_received_date,
        p_order_active_status,
        p_request_id
    )
    RETURNING *;
$$ LANGUAGE sql;
