CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    region VARCHAR(50)
);

CREATE TABLE providers (
    provider_id INT PRIMARY KEY,
    provider_name VARCHAR(100),
    specialty VARCHAR(50)
);

CREATE TABLE claims (
    claim_id INT PRIMARY KEY,
    patient_id INT,
    provider_id INT,
    claim_amount DECIMAL(10,2),
    claim_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id)
);
