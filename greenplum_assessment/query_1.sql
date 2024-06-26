
-- Выбираем усеченную дату покупки до уровня месяца, количество транзакций и сумму продаж
SELECT
    DATE_TRUNC('month', purchase_date) AS each_month,
    COUNT(transaction_id) AS total_transactions,
    SUM(total_amount) AS sales_amount
FROM
    sales_transactions
GROUP BY
    each_month
ORDER BY
    each_month;



-- Определяем временную таблицу monthly_sales для вычисления ежемесячных продаж
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', purchase_date) AS month,
        SUM(total_amount) AS total_sales_amount
    FROM
        sales_transactions
    GROUP BY
        month
)
-- Основной запрос
SELECT
    month,
    total_sales_amount,
    -- Вычисление скользящего среднего для общей суммы продаж за текущий и два предыдущих месяца
    AVG(total_sales_amount) OVER (
        ORDER BY month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_sales_amount
FROM
    monthly_sales
ORDER BY
    month;
