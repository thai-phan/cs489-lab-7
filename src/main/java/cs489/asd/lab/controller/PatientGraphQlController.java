package cs489.asd.lab.controller;

import cs489.asd.lab.model.Address;
import cs489.asd.lab.model.Patient;
import cs489.asd.lab.repository.PatientRepository;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import java.util.Comparator;
import java.util.List;

@Controller
public class PatientGraphQlController {

    private final PatientRepository patientRepository;

    public PatientGraphQlController(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    @QueryMapping
    public List<PatientView> patients() {
        return patientRepository.findAllByOrderByLastNameAscFirstNameAscPatientIdAsc()
                .stream()
                .map(this::toPatientView)
                .toList();
    }

    @QueryMapping
    public PatientView patient(@Argument long patientId) {
        return patientRepository.findById(patientId)
                .map(this::toPatientView)
                .orElse(null);
    }

    @QueryMapping
    public List<PatientView> searchPatients(@Argument String searchString) {
        String term = searchString == null ? "" : searchString.trim();
        if (term.isEmpty()) {
            return patients();
        }

        return patientRepository
                .findByFirstNameContainingIgnoreCaseOrLastNameContainingIgnoreCaseOrEmailContainingIgnoreCaseOrContactPhoneContainingIgnoreCaseOrMailingAddressContainingIgnoreCaseOrderByLastNameAscFirstNameAscPatientIdAsc(
                        term, term, term, term, term)
                .stream()
                .map(this::toPatientView)
                .toList();
    }

    @QueryMapping
    public List<AddressView> addresses() {
        return patientRepository.findAllByOrderByLastNameAscFirstNameAscPatientIdAsc()
                .stream()
                .map(this::toAddressView)
                .sorted(Comparator.comparing(AddressView::city, String.CASE_INSENSITIVE_ORDER)
                        .thenComparing(AddressView::lastName, String.CASE_INSENSITIVE_ORDER)
                        .thenComparing(AddressView::firstName, String.CASE_INSENSITIVE_ORDER)
                        .thenComparingLong(AddressView::patientId))
                .toList();
    }

    private PatientView toPatientView(Patient patient) {
        return new PatientView(
                patient.getPatientId(),
                patient.getFirstName(),
                patient.getLastName(),
                patient.getContactPhone(),
                patient.getEmail(),
                patient.getMailingAddress(),
                patient.getDateOfBirth() == null ? null : patient.getDateOfBirth().toString()
        );
    }

    private AddressView toAddressView(Patient patient) {
        return new AddressView(
                patient.getPatientId(),
                patient.getFirstName(),
                patient.getLastName(),
                patient.getEmail(),
                patient.getContactPhone(),
                patient.getMailingAddress(),
                Address.extractCity(patient.getMailingAddress()),
                patient.getDateOfBirth() == null ? null : patient.getDateOfBirth().toString()
        );
    }


    public record PatientView(
            long patientId,
            String firstName,
            String lastName,
            String contactPhone,
            String email,
            String mailingAddress,
            String dateOfBirth
    ) {
    }

    public record AddressView(
            long patientId,
            String firstName,
            String lastName,
            String email,
            String contactPhone,
            String mailingAddress,
            String city,
            String dateOfBirth
    ) {
    }
}

