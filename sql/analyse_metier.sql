-- 1. Top 10 produits les plus vendus
SELECT
    p.product_name,
    COUNT(*) AS nb_ventes
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY nb_ventes DESC
LIMIT 10;

-- 2. Top 10 produits générant le plus de chiffre d'affaires
SELECT
    p.product_name,
    ROUND(SUM(p.retail_price), 2) AS chiffre_affaires
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY chiffre_affaires DESC
LIMIT 10;

-- 3. Catégories les plus populaires
SELECT
    p.category,
    COUNT(*) AS nb_ventes
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY nb_ventes DESC;

-- 4. Départements avec le plus de ventes
SELECT
    p.department,
    COUNT(*) AS nb_ventes
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.department
ORDER BY nb_ventes DESC;

-- 5. Clients les plus actifs
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(DISTINCT o.order_id) AS nb_commandes
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY nb_commandes DESC
LIMIT 10;

-- 6. Clients générant le plus de revenus
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    ROUND(SUM(p.retail_price), 2) AS revenu_total
FROM order_items oi
JOIN users u ON oi.user_id = u.user_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY revenu_total DESC
LIMIT 10;

-- 7. Répartition des commandes selon leur statut
SELECT
    status,
    COUNT(*) AS total
FROM orders
GROUP BY status
ORDER BY total DESC;

-- 8. Catégorie générant le plus de chiffre d'affaires
SELECT
    p.category,
    ROUND(SUM(p.retail_price), 2) AS chiffre_affaires
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY chiffre_affaires DESC
LIMIT 1;

-- 9. Département générant le plus de chiffre d'affaires
SELECT
    p.department,
    ROUND(SUM(p.retail_price), 2) AS chiffre_affaires
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.department
ORDER BY chiffre_affaires DESC
LIMIT 1;

-- 10. Produits avec la meilleure marge bénéficiaire
SELECT
    p.product_name,
    ROUND(((SUM(p.retail_price) - SUM(p.cost)) / SUM(p.retail_price)) * 100, 2) AS marge_beneficiaire
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY marge_beneficiaire DESC
LIMIT 10;

-- 11. Produits avec la marge bénéficiaire la plus faible
SELECT
    p.product_name,
    ROUND(((SUM(p.retail_price) - SUM(p.cost)) / SUM(p.retail_price)) * 100, 2) AS marge_beneficiaire
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY marge_beneficiaire ASC
LIMIT 10;


-- 12. Valeur moyenne d'une commande
SELECT
    ROUND(AVG(total_commande), 2) AS panier_moyen
FROM (
    SELECT
        oi.order_id,
        SUM(p.retail_price) AS total_commande
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY oi.order_id
) AS commandes;


-- 13. Nombre de produits différents vendus
SELECT
    COUNT(DISTINCT product_id) AS nb_produits_differents_vendus
FROM order_items
WHERE status = 'Complete';


-- 14. Fréquence d'achat moyenne des clients
SELECT
    ROUND(COUNT(DISTINCT order_id) / COUNT(DISTINCT user_id), 2) AS frequence_achat
FROM orders;


-- 15. Concentration des ventes sur les produits
SELECT
    p.product_name,
    COUNT(*) AS nb_ventes
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY nb_ventes DESC
LIMIT 20;


-- 16. Produits les moins performants
SELECT
    p.product_name,
    COUNT(*) AS nb_ventes
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY nb_ventes ASC
LIMIT 20;


-- 17. Revenu total généré par les ventes
SELECT
    ROUND(SUM(p.retail_price), 2) AS chiffre_affaires_total
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;


-- 18. Profit total estimé
SELECT
    ROUND(SUM(p.retail_price - p.cost), 2) AS profit_total
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;


-- 19. Proportion des commandes annulées
SELECT
    ROUND(
        100 * SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS taux_annulation
FROM orders;


-- 20. Segments de produits à privilégier en marketing
SELECT
    p.category,
    COUNT(*) AS nb_ventes,
    ROUND(SUM(p.retail_price), 2) AS chiffre_affaires,
    ROUND(SUM(p.retail_price - p.cost), 2) AS profit_estime
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY chiffre_affaires DESC;
