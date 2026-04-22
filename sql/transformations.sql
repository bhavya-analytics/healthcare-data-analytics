-- Enriched claims view for reporting and analytics
SELECT
    c.claim_id,
    c.claim_date,
    c.claim_amount,
    p.patient_id,
    p.patient_name,
    p.age,
    p.gender,
    p.region,
    pr.provider_id,
    pr.provider_name,
    pr.specialty
FROM claims c
JOIN patients p
    ON c.patient_id = p.patient_id
JOIN providers pr
    ON c.provider_id = pr.provider_id;
