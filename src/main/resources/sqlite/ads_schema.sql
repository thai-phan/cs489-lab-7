PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS dentists (
    dentist_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    contact_phone TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE COLLATE NOCASE,
    specialization TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS patients (
    patient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    contact_phone TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE COLLATE NOCASE,
    mailing_address TEXT NOT NULL,
    date_of_birth TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    CHECK (date(date_of_birth) IS NOT NULL)
);

CREATE TABLE IF NOT EXISTS surgeries (
    surgery_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    location_address TEXT NOT NULL,
    telephone TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS appointments (
    appointment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    dentist_id INTEGER NOT NULL,
    surgery_id INTEGER NOT NULL,
    scheduled_at TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'REQUESTED' CHECK (status IN ('REQUESTED', 'BOOKED', 'CONFIRMED', 'CANCELLED', 'COMPLETED')),
    request_channel TEXT NOT NULL CHECK (request_channel IN ('CALL_IN', 'ONLINE_FORM', 'OFFICE_MANAGER')),
    notes TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (dentist_id) REFERENCES dentists (dentist_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (surgery_id) REFERENCES surgeries (surgery_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CHECK (datetime(scheduled_at) IS NOT NULL)
);

CREATE INDEX IF NOT EXISTS idx_appointments_patient_id ON appointments (patient_id);
CREATE INDEX IF NOT EXISTS idx_appointments_dentist_id ON appointments (dentist_id);
CREATE INDEX IF NOT EXISTS idx_appointments_surgery_id ON appointments (surgery_id);
CREATE INDEX IF NOT EXISTS idx_appointments_scheduled_at ON appointments (scheduled_at);

CREATE TABLE IF NOT EXISTS bills (
    bill_id INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    appointment_id INTEGER UNIQUE,
    amount_cents INTEGER NOT NULL CHECK (amount_cents >= 0),
    issued_at TEXT NOT NULL DEFAULT (datetime('now')),
    due_at TEXT NOT NULL,
    paid_at TEXT,
    status TEXT NOT NULL DEFAULT 'UNPAID' CHECK (status IN ('UNPAID', 'PAID', 'WAIVED', 'VOID')),
    notes TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (appointment_id) REFERENCES appointments (appointment_id) ON UPDATE CASCADE ON DELETE SET NULL,
    CHECK (datetime(due_at) IS NOT NULL),
    CHECK (paid_at IS NULL OR datetime(paid_at) IS NOT NULL)
);

CREATE INDEX IF NOT EXISTS idx_bills_patient_id ON bills (patient_id);
CREATE INDEX IF NOT EXISTS idx_bills_appointment_id ON bills (appointment_id);
CREATE INDEX IF NOT EXISTS idx_bills_status ON bills (status);

CREATE TRIGGER IF NOT EXISTS trg_appointments_block_unpaid_bills_insert
BEFORE INSERT ON appointments
WHEN NEW.status IN ('REQUESTED', 'BOOKED', 'CONFIRMED', 'COMPLETED')
BEGIN
    SELECT RAISE(ABORT, 'Patient has an outstanding unpaid bill')
    WHERE EXISTS (
        SELECT 1
        FROM bills b
        WHERE b.patient_id = NEW.patient_id
          AND b.status = 'UNPAID'
    );
END;

CREATE TRIGGER IF NOT EXISTS trg_appointments_block_unpaid_bills_update
BEFORE UPDATE OF patient_id, status ON appointments
WHEN NEW.status IN ('REQUESTED', 'BOOKED', 'CONFIRMED', 'COMPLETED')
BEGIN
    SELECT RAISE(ABORT, 'Patient has an outstanding unpaid bill')
    WHERE EXISTS (
        SELECT 1
        FROM bills b
        WHERE b.patient_id = NEW.patient_id
          AND b.status = 'UNPAID'
    );
END;

CREATE TRIGGER IF NOT EXISTS trg_appointments_limit_week_insert
BEFORE INSERT ON appointments
WHEN NEW.status IN ('BOOKED', 'CONFIRMED', 'COMPLETED')
BEGIN
    SELECT RAISE(ABORT, 'Dentist exceeds the weekly appointment limit')
    WHERE (
        SELECT COUNT(*)
        FROM appointments a
        WHERE a.dentist_id = NEW.dentist_id
          AND a.status IN ('BOOKED', 'CONFIRMED', 'COMPLETED')
          AND strftime('%Y-%W', a.scheduled_at) = strftime('%Y-%W', NEW.scheduled_at)
    ) >= 5;
END;

CREATE TRIGGER IF NOT EXISTS trg_appointments_limit_week_update
BEFORE UPDATE OF dentist_id, scheduled_at, status ON appointments
WHEN NEW.status IN ('BOOKED', 'CONFIRMED', 'COMPLETED')
BEGIN
    SELECT RAISE(ABORT, 'Dentist exceeds the weekly appointment limit')
    WHERE (
        SELECT COUNT(*)
        FROM appointments a
        WHERE a.dentist_id = NEW.dentist_id
          AND a.appointment_id <> OLD.appointment_id
          AND a.status IN ('BOOKED', 'CONFIRMED', 'COMPLETED')
          AND strftime('%Y-%W', a.scheduled_at) = strftime('%Y-%W', NEW.scheduled_at)
    ) >= 5;
END;

