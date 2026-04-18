-- ADS required queries

-- 1) Display all dentists registered in the system,
--    sorted in ascending order of last names.
SELECT
    d.dentist_id,
    d.first_name,
    d.last_name,
    d.phone,
    d.email,
    d.specialization
FROM schema1.dentists d
ORDER BY d.last_name ASC;

-- 2) Display all appointments for a given dentist by dentist_id,
--    including patient information.
-- Parameter: :dentist_id
SELECT
    app.appointment_id,
    app.appointment_date_time,
    app.status,
    dent.dentist_id,
    pat.patient_id,
    dent.first_name AS dentist_first_name,
    dent.last_name AS dentist_last_name,
    pat.first_name AS patient_first_name,
    pat.last_name AS patient_last_name,
    pat.contact_phone AS patient_contact_phone,
    pat.email AS patient_email,
    pat.date_of_birth AS patient_date_of_birth
FROM schema1.appointments app
JOIN schema1.dentists dent ON dent.dentist_id = app.dentist_id
JOIN schema1.patients pat ON pat.patient_id = app.patient_id
WHERE app.dentist_id = :dentist_id;

-- 3) Display all appointments scheduled at a surgery location.
-- Parameter: :location_address
SELECT
    a.appointment_id,
    a.appointment_date_time,
    a.status,
    s.surgery_id,
    s.name AS surgery_name,
    s.location_address
FROM schema1.appointments a
LEFT JOIN schema1.surgeries s ON s.surgery_id = a.surgery_id
WHERE s.surgery_id = :sid
ORDER BY a.appointment_date_time ASC, a.appointment_id ASC;

-- 4) Display appointments booked for a given patient on a given date.
-- Parameters: :patient_id, :appointment_date (YYYY-MM-DD)
SELECT
    a.appointment_id,
    a.appointment_date_time,
    a.status,
    p.patient_id,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.dentist_id,
    d.first_name AS dentist_first_name,
    d.last_name AS dentist_last_name
FROM schema1.appointments a
JOIN schema1.patients p ON p.patient_id = a.patient_id
JOIN schema1.dentists d ON d.dentist_id = a.dentist_id
WHERE a.patient_id = :patient_id
  AND CAST(a.appointment_date_time AS DATE) = :appointment_date
ORDER BY a.appointment_date_time ASC, a.appointment_id ASC;

