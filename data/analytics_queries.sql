-- 1. Total claims and total claim amount by provider specialty
SELECT
    pr.specialty,
    COUNT(c.claim_id) AS total_claims,
    SUM(c.claim_amount) AS total_claim_amount
FROM claims c
JOIN providers pr
    ON c.provider_id = pr.provider_id
GROUP BY pr.specialty
ORDER BY total_claim_amount DESC;

-- 2. Average claim amount by region
SELECT
    p.region,
    AVG(c.claim_amount) AS avg_claim_amount
FROM claims c
JOIN patients p
    ON c.patient_id = p.patient_id
GROUP BY p.region
ORDER BY avg_claim_amount DESC;

-- 3. Top patients by total spending
SELECT
    p.patient_name,
    SUM(c.claim_amount) AS total_spending
FROM claims c
JOIN patients p
    ON c.patient_id = p.patient_id
GROUP BY p.patient_name
ORDER BY total_spending DESC;

-- 4. Monthly claims trend
SELECT
    DATE_FORMAT(claim_date, '%Y-%m') AS claim_month,
    COUNT(*) AS claim_count,
    SUM(claim_amount) AS total_amount
FROM claims
GROUP BY DATE_FORMAT(claim_date, '%Y-%m')
ORDER BY claim_month;

-- 5. Claims by provider
SELECT
    pr.provider_name,
    pr.specialty,
    COUNT(c.claim_id) AS claim_count,
    SUM(c.claim_amount) AS total_claim_amount
FROM claims c
JOIN providers pr
    ON c.provider_id = pr.provider_id
GROUP BY pr.provider_name, pr.specialty
ORDER BY total_claim_amount DESC;

-- Rank patients by total spending
SELECT
    p.patient_name,
    SUM(c.claim_amount) AS total_spending,
    RANK() OVER (ORDER BY SUM(c.claim_amount) DESC) AS spending_rank
FROM claims c
JOIN patients p ON c.patient_id = p.patient_id
GROUP BY p.patient_name;

-- Running total of claims over time
SELECT
    claim_date,
    SUM(claim_amount) AS daily_total,
    SUM(SUM(claim_amount)) OVER (ORDER BY claim_date) AS running_total
FROM claims
GROUP BY claim_date
ORDER BY claim_date;

-- Patient first claim date (cohort)
WITH first_claim AS (
    SELECT
        patient_id,
        MIN(claim_date) AS first_claim_date
    FROM claims
    GROUP BY patient_id
)

SELECT
    fc.first_claim_date,
    COUNT(DISTINCT c.patient_id) AS patient_count,
    SUM(c.claim_amount) AS total_revenue
FROM claims c
JOIN first_claim fc
    ON c.patient_id = fc.patient_id
GROUP BY fc.first_claim_date
ORDER BY fc.first_claim_date;
