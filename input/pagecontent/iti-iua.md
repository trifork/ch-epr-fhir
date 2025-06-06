This section specifies Swiss national extensions to Internet User Authorization (IUA) Profile, which
is [published](https://profiles.ihe.net/ITI/IUA/index.html) as an IHE ITI Trial Implementation profile.

### Scope

This profile provides means to retrieve EPR compliant access token and to incorporate the access token to transactions
to authorize client applications when accessing protected resources.

This profile is based on the IUA Trial Implementation and adds certain restrictions to be compliant to the ordinances of
the Swiss EPR.

This national extension is scoped for client authorization for FHIR based interfaces for primary systems, portals and
SMART on FHIR Apps launched from the portals or primary systems and to convey the information required to enforce the
privacy policy settings when accessing protected resources from the EPR.

This national extension covers:

- SMART on FHIR Apps launched from a portal or primary system, which require a launch context identifying the portal or
  primary system the app is launched from. This requires the portal or primary system to be registered with "client_id"
  and "client-secret" during onboarding. This may require an user consent which authorizes the SMART on FHIR to act on
  behalf for given scopes and the authentication of the user compliant to EPRO Annex 8.

- Portals and primary systems which shall be registered during onboarding, authenticate the user compliant to EPRO Annex
  8 and provide the identity token in the access token request send to the IUA Authorization Server.

### Use Cases

#### Patient Access from a Portal

A patient uses a portal which is integrated to the Swiss EPR using the profiles to access and share data and documents
with healthcare professionals. To access documents from the EPR, the patient authenticates at a certified Identity
Provider. The portal sends the identity token and the required claims to the IUA Authorization Server
to retrieve an authorization token to access the EPR.

The Authorization Server validates the claims together with the data from the identity token and resolves additional
information required to access the EPR (e.g., resolve the digital identity to the EPR-SPID). The IUA Authorization
Server
responds an IUA Authorization Token the portal shall incorporate to any transaction to retrieve the data and documents
from the patients EPR.

#### User Access from an integrated Primary System

A healthcare professional uses a primary system which is integrated to the Swiss EPR using the profiles to access and
share data and documents with her patients or other healthcare professionals. To access documents from the EPR the
healthcare professional authenticates at a certified identity provider from her primary system, selects the patient
and switches to the user interface to display the patients documents. The primary system connects to the IUA
Authorization
Server and sends the identity token and the required claims to access the patients EPR.

The IUA Authorization Server verifies if the primary system is authorized to access the EPR on behalf of the user by
checking that the primary system has been registered during the onboarding process.

The Authorization Server validates the claims together with the data from the identity token and resolves additional
information required to access the EPR (e.g., resolve the digital identity to GLN). The IUA Authorization Server
responds an IUA Authorization Token the portal shall incorporate to any transaction to retrieve the data and documents
from the patients EPR.

#### User Access from a SMART on FHIR component

A patient or healthcare professional uses a portal or primary system which uses SMART on FHIR Apps to connect to the
Swiss EPR.

The patient or healthcare professional authenticates in the portal or primary system and launches the SMART on FHIR App
from the portal or primary system. The portal or primary system first builds a SMART on FHIR launch context with the
patient context and identifiers of the portal or primary system application and launches the SMART on FHIR App with the
launch context.

The IUA Authorization Server verifies that the portal or primary system is authorized to launch SMART on FHIR Apps which
connect to the EPR on behalf of the user by checking that the portal or primary system has been registered beforehand
during the onboarding process of the portal or primary system application.

The IUA Authorization Server reflects the community policy which requires the user's consent for SMART on FHIR Apps to
access their protected data with a given scope. The IUA Authorization Server verifies that the user has a valid session
at the Identity Provider and retrieves the Identity Assertion from the Identity Provider to identity the user.
The Authorization Server validates the Authorization Client claims and resolves additional information the SMART on
FHIR App requires to access the EPR (e.g., resolve the digital identity to the EPR-SPID).

The IUA Authorization Server responds an IUA Authorization Token which the SMART on FHIR App shall incorporate to any
transaction to retrieve the data and documents from the patients EPR.

#### Writing documents from clinical archives

A healthcare professional uses a primary system which stores documents in a clinical archive system. The clinical
archive system uses specific algorithms to decide which documents shall be stored in the Swiss EPR of the patient.

The healthcare professional reports medical information of a treatment in her primary system. The primary system creates
a structured or unstructured document from the data and stores them in the clinical archive system. The clinical archive
system decides whether the document shall be stored in the patients EHR using the policies defined in the clinic.

To access the patient EHR the clinical archive system first request a basic authorization token using the client
credential flow and uses the basic authorization token in the PIXm or PDQm transactions used to retrieve the EHR-SPID
and the XAD PID of the patient.

The Authorization server returns the basic access token if the clinical archive systems is registered beforehand and is
authorized to access the Swiss EHR.

The clinical archive system then requests an extended authorization token to be used with the MHD transaction to store
the document in the patients EHR.

### Actors and Transactions

This national extension enhance the requirements on transactions and the expected actions of the Actors of the IUA Trial
Implementation to comply to the legal requirements of the Swiss EPR.

<div>
{%include IUA_actor_diagram.svg %}
</div>
This figure shows the actors directly involved in the _Internet User Authorization_ Profile and the relevant 
transactions between them.

### Actor Options

This national extension restricts the Actor options of the IUA Trial Implementation to comply to the legal requirements
of the Swiss EPR.

The IUA Trial Implementation supports three options for the Authorization Token format; the JWT Token, the SAML Token
and the Token Introspection option. Since this national extension will apply to cross community communication, the Token
Introspection Option SHALL NOT be used.

This national extension intends to simplify and modernize the technologies used to connect to the Swiss EPR. The legacy
SAML Token option SHALL NOT be used. To support automated client configuration the Authorization Server actor SHALL
support the Authorization Metadata option.

### Grouping

The Swiss national extension does not define requirements on the grouping of actors in this profile, which extend or
restrict the grouping required from the IUA profile.

### Process Flow

For the process flow of this profile and its interplay with the other profiles
see [sequence diagrams](sequencediagrams.html).

### Security Consideration

Portals and primary systems SHALL be identified by the client_id and client_secret registered during onboarding. All
requests to the IUA Authorization Server SHALL be authenticated by the digital signatures.

Implementers SHALL register the combination of the OAuth client ID, the URLs and the certificate used for message
signatures during the onboarding process and keep the data up to date.

Implementers shall verify the combination of the OAuth client ID, the URLs and the certificate of all requests
against the registered values and shall reject requests in case of mismatch.
