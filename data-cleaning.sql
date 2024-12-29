SELECT 
    ood.order_id,
    ood.customer_id,
    ood.order_purchase_timestamp,
    ood.order_status,
    ocd.customer_city,
    ocd.customer_state,
    ooid.product_id,
    ooid.seller_id,
    ooid.price,
    ooid.freight_value,
    oord.review_score,
    osd.seller_city AS seller_city,
    osd.seller_state AS seller_state,
    opd.product_weight_g,
    pcnt.product_category_name_english
FROM 
    olist_orders_dataset ood
LEFT JOIN 
    olist_customers_dataset ocd 
    ON ood.customer_id = ocd.customer_id
LEFT JOIN 
    olist_order_items_dataset ooid
    ON ood.order_id = ooid.order_id
LEFT JOIN 
    olist_order_reviews_dataset oord 
    ON ooid.order_id = oord.order_id
LEFT JOIN 
    olist_sellers_dataset osd 
    ON ooid.seller_id = osd.seller_id
INNER JOIN 
    olist_products_dataset opd 
    ON ooid.product_id = opd.product_id
INNER JOIN 
    (SELECT DISTINCT product_category_name, product_category_name_english 
     FROM product_category_name_translation) pcnt
    ON opd.product_category_name = pcnt.product_category_name
WHERE 
    TO_TIMESTAMP(ood.order_purchase_timestamp, 'YYYY-MM-DD HH24:MI:SS') 
    BETWEEN '2018-04-17'::timestamp 
    AND '2018-10-17'::timestamp;