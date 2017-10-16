### Q1.1 - All customers who have not purchased bikes or tires ###
select customers.customerid, customers.custfirstname, customers.custlastname
from customers
where customers.customerid not in (
select distinct o.customerid
from order_details od
inner join products p on od.productnumber = p.productnumber
inner join orders o on od.ordernumber = o.ordernumber
inner join customers c on o.customerid = c.customerid
inner join categories cat on p.categoryid = cat.categoryid
where cat.categoryid in (2, 6)
order by o.customerid);

### Q1.2 - All customers who have purchased a bike, but not a helmet ###
#https://dev.mysql.com/doc/refman/5.7/en/exists-and-not-exists-subqueries.html
select distinct c.CustomerID, c.CustFirstName, c.CustLastName
from order_details od
inner join products p on od.ProductNumber = p.ProductNumber
inner join orders o on od.OrderNumber = o.OrderNumber
inner join customers c on o.CustomerID = c.CustomerID
where p.CategoryID in (2)
and not exists
(select distinct c2.CustomerID, c2.CustFirstName, c2.CustLastName
from order_details
inner join products on order_details.ProductNumber = products.ProductNumber
inner join orders on order_details.OrderNumber = orders.OrderNumber
inner join customers c2 on orders.CustomerID = c2.CustomerID
where products.CategoryID = 1 and products.ProductName like '%Helmet'
and c.CustomerID = c2.CustomerID)
order by c.CustomerID;

### Q1.3 Customer Orders that have a bike but do not have a helmet ###
### Different method from 1.2 to experiment
select distinct OrderNumber
from order_details, products, categories
where order_details.ProductNumber = products.ProductNumber
and products.CategoryID = categories.CategoryID
and categories.CategoryID = 2
and OrderNumber not in
(select distinct OrderNumber
from order_details, products, categories
where order_details.ProductNumber = products.ProductNumber
and products.CategoryID = categories.CategoryID
and categories.CategoryID = 1
and ProductName like '%Helmet')
order by OrderNumber;

### Q1.4 Customer Orders with a bike and a helmet ###
select distinct c.CustomerID, c.CustFirstName, c.CustLastName, od.OrderNumber
from order_details od
inner join products p on od.ProductNumber = p.ProductNumber
inner join orders o on od.OrderNumber = o.OrderNumber
right join customers c on o.CustomerID = c.CustomerID
where p.CategoryID = 2
and od.OrderNumber in
(select distinct od.OrderNumber
from order_details od
inner join products p on od.ProductNumber = p.ProductNumber
inner join orders o on od.OrderNumber = o.OrderNumber
right join customers c on o.CustomerID = c.CustomerID
where p.CategoryID = 1
and p.productname like '%Helmet')
order by c.CustomerID, od.OrderNumber;

### Q1.5 Vendors who sell accessories, car racks and clothing
select distinct pv.VendorID, v.VendName
from product_vendors pv
inner join products p on pv.ProductNumber = p.ProductNumber
inner join categories cat on p.CategoryID = cat.CategoryID
inner join vendors v on pv.VendorID = v.VendorID
where cat.CategoryID in (1, 5, 3)
order by pv.VendorID;