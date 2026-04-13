package org.example.web;

public class PatientNotFoundException extends RuntimeException {
    public PatientNotFoundException(long patientId) {
        super("Patient with id " + patientId + " not found");
    }
}

