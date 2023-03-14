USE master
SELECT 
	o.order_id,
	CONCAT(c.first_name, ' ', c.last_name) AS 'customer',
	c.city,
	c.state,
	o.order_date,
	SUM(oi.quantity) AS 'total_units',
	SUM(oi.quantity*oi.list_price) AS 'revenue',
	pp.product_name,
	pc.category_name,
	ss.store_name,
	CONCAT(sst.first_name, ' ', sst.last_name) AS 'sales_rep'
FROM sales.orders o

JOIN sales.customers c 
ON o.customer_id = c.customer_id

JOIN sales.order_items oi
ON o.order_id = oi.order_id

JOIN production.products pp
ON oi.product_id = pp.product_id

JOIN production.categories pc
ON pp.category_id =pc.category_id

JOIN sales.stores ss
ON o.store_id=ss.store_id

JOIN sales.staffs sst
ON o.staff_id = sst.staff_id

GROUP BY
	o.order_id,
	CONCAT(c.first_name, ' ', c.last_name),
	c.city,
	c.state,
	o.order_date,
	pp.product_name,
	pc.category_name,
	ss.store_name,
	CONCAT(sst.first_name, ' ', sst.last_name)