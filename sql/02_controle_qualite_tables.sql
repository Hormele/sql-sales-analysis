-- Vérification du contenu de chaque table
select count(*) as nb_itms from order_items;
select count(*) as nb_users from users;
select count(*) as nb_commandes from orders;
select count(*) as nb_prodicts from products;

-- Vérification du nombre de colonnes correspondantes dans les tables
select count(*) as lignes_join
from order_items oi
join orders o on oi.order_id=o.order_id
join products p on oi.product_id=p.product_id
join users u on oi.user_id=u.user_id;


-- Vérification des commandes absentes
SELECT COUNT(*) AS commandes_sans_order
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Vérification des utilisateurs absents
SELECT COUNT(*) AS users_absents
FROM order_items oi
LEFT JOIN users u
ON oi.user_id = u.user_id
WHERE u.user_id IS NULL;

-- Vérification des produits absents
SELECT COUNT(*) AS produits_absents
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
