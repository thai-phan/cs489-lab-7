PRAGMA foreign_keys = ON;

-- DELETE FROM bills;
-- DELETE FROM appointments;
-- DELETE FROM surgeries;
-- DELETE FROM patients;
-- DELETE FROM dentists;
-- DELETE FROM sqlite_sequence;

INSERT INTO dentists (first_name, last_name, contact_phone, email, specialization)
VALUES ('Amelia', 'Hart', '555-1001', 'amelia.hart@ads.example', 'Orthodontics'),
       ('Noah', 'Price', '555-1002', 'noah.price@ads.example', 'Endodontics');

INSERT INTO patients (first_name, last_name, contact_phone, email, mailing_address, date_of_birth)
VALUES ('Olivia', 'Stone', '555-2001', 'olivia.stone@example.com', '12 Willow Lane, Bristol', '1992-03-14'),
       ('Ethan', 'Cole', '555-2002', 'ethan.cole@example.com', '88 Harbour Road, Exeter', '1988-11-02'),
       ('Maya', 'Patel', '555-2003', 'maya.patel@example.com', '44 Queens Avenue, Bath', '1996-07-25'),
       ('Lucas', 'Green', '555-2004', 'lucas.green@example.com', '19 Orchard Close, Truro', '1979-01-09');

INSERT INTO surgeries (name, location_address, telephone)
VALUES ('Bristol Central Surgery', '100 Queen Square, Bristol', '0117 555 0101'),
       ('Exeter Riverside Surgery', '200 Riverbank, Exeter', '01392 555 0202');

INSERT INTO appointments (patient_id, dentist_id, surgery_id, scheduled_at, status, request_channel, notes)
VALUES (1, 1, 1, '2026-04-13 09:00:00', 'BOOKED', 'OFFICE_MANAGER', 'Routine examination'),
       (2, 1, 1, '2026-04-14 10:30:00', 'CONFIRMED', 'CALL_IN', 'Follow-up cleaning'),
       (3, 1, 1, '2026-04-15 13:00:00', 'COMPLETED', 'ONLINE_FORM', 'Filling review'),
       (4, 1, 2, '2026-04-16 15:15:00', 'BOOKED', 'OFFICE_MANAGER', 'Consultation for crown'),
       (1, 1, 1, '2026-04-17 11:00:00', 'CONFIRMED', 'CALL_IN', 'Post-treatment checkup'),
       (2, 2, 2, '2026-04-18 09:30:00', 'REQUESTED', 'ONLINE_FORM', 'Initial appointment request');

INSERT INTO bills (patient_id, appointment_id, amount_cents, issued_at, due_at, paid_at, status, notes)
VALUES (3, 3, 42500, '2026-04-15 14:00:00', '2026-04-29 23:59:59', '2026-04-16 09:10:00', 'PAID',
        'Paid after completed filling review'),
       (4, NULL, 18000, '2026-04-16 16:00:00', '2026-05-01 23:59:59', NULL, 'UNPAID',
        'Outstanding balance from prior treatment');

