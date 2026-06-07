-- Nbre total de commandes
select count(*) as total_commande
from orders;

-- Nbre total de clients
select count(distinct user_id) as total_clients
from users;

-- Nbre total de produits vendus
select count(*) as produits_vendus
from order_items 
where status= 'Complete';

-- chiffre d'affaire total
select round(sum(p.retail_price),2) AS CA_total
from order_items oi
join products p on oi.product_id=p.product_id
where oi.status= 'Complete';

-- profit de l'entreprise
select round(sum(p.retail_price) - sum(p.cost),2) as profit_total
from order_items oi
join products p
on oi.product_id=p.product_id
where oi.status= 'Complete';

-- panier moyen
select ROUND(SUM(p.retail_price) / COUNT(DISTINCT oi.order_id), 2) as panier_moyen
from order_items oi
join products p
on oi.product_id = p.product_id
where oi.status = 'Complete';

-- frequence d'achat moyenne
select count(distinct order_id) / count(distinct user_id) as freq_achat
from orders
where status= 'Complete';

-- nbre de produits differents vendus
select count(distinct product_id) as produit_diff_vendus
from order_items
where status= 'Complete';

/* Taux d'annulation */
SELECT
ROUND(
100*
SUM(CASE WHEN status='Cancelled'
THEN 1 ELSE 0 END)
/ COUNT(*)
,2) AS taux_annulation
FROM orders;


/* KPI 10 : Taux de retour */

SELECT

ROUND(

100*

SUM(CASE WHEN status='Returned'

THEN 1 ELSE 0 END)

/ COUNT(*)

,2) AS taux_retour

FROM order_items;
