Given below, is the same Problem Statement/Description from Lab3, of a Software system
required by a company named, Advantis Dental Surgeries (ADS), which is an enterprise web
application for managing their Dental Surgery operations. Assume you have been hired by
the company to design and develop this software solution.
Your tasks for this Lab Assignment is to:
- Create an E-R model for the database needed for the system. You may draw the ER
  diagram using a graphical drawing tool on computer or draw by hand.
- Implement the model on a physical Relational database. Use any RDBMS of your choice
  e.g. MySQL.
- Populate the Database tables with dummy data
- Write SQL Queries for the following:
  o Display the list of ALL Dentists registered in the system, sorted in ascending
  order of their lastNames
  o Display the list of ALL Appointments for a given Dentist by their dentist_Id
  number. Include in the result, the Patient information.
  o Display the list of ALL Appointments that have been scheduled at a Surgery
  Location
  o Display the list of the Appointments booked for a given Patient on a given Date.
-----------------------------------------------------------------

dentistName,patNo,patName,appointment date,time,surgeryNo
Tony Smith,P100,Gillian White,12-Sep-13,10.00,S15
Tony Smith,P105,Jill Bell,12-Sep-13,12.00,S15
Helen Pearson,P108,Ian MacKay,12-Sep-13,10.00,S10
Helen Pearson,P108,Ian MacKay,14-Sep-13,14.00,S10
Robin Plevin,P105,Jill Bell,14-Sep-13,16.30,S15
Robin Plevin,P110,John Walker,15-Sep-13,18.00,S13

Problem Statement/Description:
Advantis Dental Surgeries, LLC (ADS) are a company that are in the business of managing a
growing network of dental surgeries which are located across cities in the South West
region. Assume you have been hired by the company, as a Lead Software Engineer and
tasked to lead the effort in designing and developing a web-based software solution (i.e. a
website) which the company will be using to manage their business. 

The system will be used by an Office Manager to register Dentists who apply to join their
network of dental surgeries. Each Dentist is given a unique ID number and their First Name,
Last Name, Contact Phone Number, Email and Specialization are recorded into the system.
The Office Manager also uses the system to enroll new Patients who require dental services,
including the Patient’s First Name, Last Name, Contact Phone Number, Email, Mailing
Address and Date of Birth. A Patient can call-in to request appointments to see a dentist. A
Patient can also request appointment by submitting an online form on the ADS website.
Upon receiving a request for an appointment, the Office Manager can then book the
appointment and the system will send a confirmation email notifying the Patient and the
appointment gets recorded accordingly.
Dentists should be able to sign-in to the system and view a listing of all their Appointments,
including details of the Patients who they have been scheduled to see. Each appointment is
normally made for a specific date and time and the dentist is expected to see/treat the
patient at one of ADS’s surgery locations. The system should provide information about
each Surgery, including its name, location address and telephone number. Patients should
be able to sign-in to the system and view their appointments, including the information of
the dentist who they have been booked to see. Patients should also be able to request to
cancel or change their appointments.
A dentist cannot be given more than 5 appointments in any given week. The system should
prevent a Patient from requesting a new appointment if they have an outstanding, unpaid
bill for dental service they have received. 