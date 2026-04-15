
1. HTTP GET request: http://localhost:8080/adsweb/api/v1/patients - Displays the list of all Patients, including their primaryAddresses, sorted in ascending order by their lastName, in JSON format.
2. HTTP GET request: http://localhost:8080/adsweb/api/v1/patients/1 - Displays the data for Patient whose PatientId is 1 including the primaryAddress, in JSON format. Also, make sure to implement appropriate exception handling, for where patientId is invalid and not found.
3. HTTP POST request: http://localhost:8080/adsweb/api/v1/patients - Register a new Patient into the system. Note: You supply the correct/appropriate Patient data in JSON format
4. HTTP PUT request: http://localhost:8080/adsweb/api/v1/patient/1 - Retrieves and updates Patient data for the patient whose patientId is 1 (or any other valid patientId). Also, make sure to implement appropriate exception handling, for where patientId is invalid and not found.
5. HTTP DELETE request: http://localhost:8080/adsweb/api/v1/patient/1 - Deletes the Patient data for the patient whose patientId is 1 (or any other valid patientId).

6. http://localhost:8080/adsweb/api/v1/patient/search/{searchString} - Queries all the Patient data for the patient(s) whose data matches the input searchString.

7. HTTP GET request: http://localhost:8080/adsweb/api/v1/addresses - Displays the list of all Addresses, including the Patient data, sorted in ascending order by their city, in JSON format.

