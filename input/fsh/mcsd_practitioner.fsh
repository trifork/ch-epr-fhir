Profile: CHmCSDPractitioner
Parent: http://fhir.ch/ig/ch-core/StructureDefinition/ch-core-practitioner-epr
Id: CH.mCSD.Practitioner
Title: "CH mCSD Practitioner"
Description: "CH mCSD profile on Practitioner"
* obeys ch-mcsd-practitioner-ihe-conformance
* obeys ch-mcsd-practitioner-only-one-legal-address 
* identifier contains HpdUid 1..1
* identifier[HpdUid] only HpdUidIdentifier
* identifier[HpdUid] ^short = "UID (unique identifier) of the provider stored in an HPD"
* identifier.extension contains HcIdentifierStatusExtension named status 0..1   // if not present, assume "active"
* active.extension contains HcProfessionalInactivityReasonExtension named inactivityReason 0..1   // to be ignored on "active", optional for "inactive"
* name.extension contains HcProfessionalInitialsExtension named initials 0..*
* address.extension contains HpdProviderPostalAddressStatusExtension named status 0..1  // if not present, assume "primary"
* extension contains HpdProviderCreationTimeExtension named creationTime 1..1 and 
        HcProfessionalPhysicalDeliveryOfficeNameExtension named physicalDeliveryOfficeName 0..* and
        HcProfessionalAssistantToExtension named assistantTo 0..* and
        HcProfessionalMedicalRecordsDeliveryEmailAddressExtension named medicalRecordsDeliveryEmailAddress 0..1 


Invariant: ch-mcsd-practitioner-ihe-conformance
Description: "The Practitioner needs to conform to IHE.mCSD.Practitioner"
Expression: "conformsTo('https://profiles.ihe.net/ITI/mCSD/StructureDefinition/IHE.mCSD.Practitioner')"
Severity: #error

Invariant: ch-mcsd-practitioner-only-one-legal-address
Description: "The Practitioner can have at most one legal address"
Expression: "address.where(use = 'work' and type = 'both').count() <= 1"
Severity: #error


Mapping:  CHmCSDPractitionerToHCProfessional
Source:   CHmCSDPractitioner
Target:   "https://www.bag.admin.ch/epra"
Title:    "HPD schema (DSMLv2/LDAP)"
* -> "HCProfessional"
* identifier -> "HCProfessional.uid"
* identifier -> "HCProfessional.hcIdentifier"
* identifier.extension[status] -> "HCProfessional.hcIdentifier status"
* active -> "HCProfessional.hpdProviderStatus (active, inactive)" 
* active.extension[inactivityReason] -> "HCProfessional.hpdProviderStatus (retired, deceased)"
* name.text -> "HCProfessional.displayName"
* name.prefix -> "HCProfessional.title"
* name.given -> "HCProfessional.givenName"
* name.extension[initials] -> "HCProfessional.initials"
* name.family -> "HCProfessional.sn"
* communication.coding.code -> "HCProfessional.hpdProviderLanguageSupported"
* gender -> "HCProfessional.gender"
* extension[medicalRecordsDeliveryEmailAddress] -> "HCProfessional.hpdMedicalRecordsDeliveryEmailAddress"
* telecom -> "HCProfessional.mail"
* extension[creationTime] -> "HCProfessional.createTimestamp" 
* meta.lastUpdated -> "HCProfessional.modifyTimestamp"
* address -> "HCProfessional.physicalDeliveryOfficeName"
* address -> "HCProfessional.hpdProviderMailingAddress"
* address -> "HCProfessional.hpdProviderBillingAddress"
* address -> "HCProfessional.hpdProviderPracticeAddress"
* telecom -> "HCProfessional.telephoneNumber" // [system='phone']
* telecom -> "HCProfessional.mobile"
* telecom -> "HCProfessional.pager"
* telecom -> "HCProfessional.facsimileTelephoneNumber" // [system='fax']
* address -> "HCProfessional.hpdProviderLegalAddress"


Instance: CHmCSDPractitionerDrPeterPan
InstanceOf: CHmCSDPractitioner
Title: "CH mCSD Practitioner Dr. Peter Pan"
Description: "An example of CHmCSDPractitioner that contains the same information as Dr. Peter Pan in the Swiss examples
(uid=CommunityA:00000003002,OU=HCProfessional,DC=HPD,O=BAG,C=ch)"
* id = "DrPeterPan"
* identifier[GLN].system = "urn:oid:2.51.1.3"
* identifier[GLN].value = "7601000102737"
* identifier[HpdUid].system = "urn:ietf:rfc:4514"
* identifier[HpdUid].value = "CommunityA:00000003002"
* identifier[+].system = "urn:SpitalX:SpitalX-ID"
* identifier[=].value = "abc123"
* identifier[=].extension[status].valueCode = #revoked
* identifier[+].system = "urn:SpitalY:SpitalY-ID"
* identifier[=].value = "def456"
* identifier[=].extension[status].valueCode = #active
* active = false
* active.extension[inactivityReason].valueCode = #retired
* name.text = "Dr. Peter A. Pan"
* name.family = "Pan"
* name.given = "Peter" // Wrong (Pan) in the example
* name.extension[initials].valueString = "A. B."
* name.prefix = "Dr."
* name.prefix.extension[ENQualifier].valueCode = #AC
* telecom[+].system = #email
* telecom[=].value = "peter.pan@email.com"
* telecom[+].system = #fax
* telecom[=].value = "+41 32 001 00 05"
* telecom[+].system = #phone
* telecom[=].value = "+41 79 001 00 06"
* telecom[=].use = #mobile
* telecom[+].system = #phone
* telecom[=].value = "+41 32 001 00 04"
* telecom[+].system = #pager
* telecom[=].value = "+41 79 001 00 07"
* gender = #male
* qualification[+].code = $sct#309343006 "Physician"
* qualification[+].code = $medreg#1051 "General internal medicine"
* communication[+].coding = $bcp47#de
* communication[+].coding = $bcp47#fr
* communication[+].coding = $bcp47#en
* communication[+].coding = $bcp47#it
* extension[creationTime].valueDateTime = "2025-03-17T16:37:20+01:00"
* meta.lastUpdated = "2025-03-18T07:12:32+01:00"
* extension[medicalRecordsDeliveryEmailAddress].valueString = "delivery-inbox@peter.pan"
