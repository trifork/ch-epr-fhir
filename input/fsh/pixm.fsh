Profile: CHPIXmPatientFeed
Parent: CHPDQmPatient
Id: ch-pixm-patient-feed
Title: "CH PIXm Patient Feed"
Description: "The patient demographics and identifier information which can be provided in the PIXm Feed according to the EPR. The EPR-SPID as an identifier SHALL be added. The birthname can be added with the ISO 21090 qualifier extension."
* identifier 2..
* identifier[LocalPid] ^sliceName = "LocalPid"

Profile: PIXm_IN_Parameters_CH
Parent: $IHE.PIXm.Query.Parameters.In
Id: ch-pixm-in-parameters
Title: "CH PIXm IN Parameters"
Description: "The StructureDefinition defines the Input Parameters for the $ihe-pix operation: - Input: sourceIdentifier, targetSystem"
* parameter[sourceIdentifier] 1..1
* parameter[sourceIdentifier] ^short = "sourceIdentifier"
* parameter[sourceIdentifier].name = "sourceIdentifier" (exactly)
* parameter[sourceIdentifier].valueIdentifier 1..
* parameter[sourceIdentifier].valueIdentifier only Identifier
* parameter[sourceIdentifier].valueIdentifier.system 1..
* parameter[sourceIdentifier].valueIdentifier.value 1..
* parameter[targetSystem] 1..2
* parameter[targetSystem] ^short = "targetSystem"
* parameter[targetSystem].name = "targetSystem" (exactly)
* parameter[targetSystem].valueUri 1..
* parameter[targetSystem].valueUri only uri

Profile: IHE_PIXm_OUT_Parameters_CH
Parent: $IHE.PIXm.Query.Parameters.Out
Id: ch-pixm-out-parameters
Title: "CH PIXm OUT Parameters"
Description: "The StructureDefinition defines the Output Parameters for the $ihe-pix operation: "
* parameter ..3
* parameter[targetId] 0..1
* parameter[targetId] ^short = "targetId"
* parameter[targetId].name = "targetId" (exactly)
* parameter[targetId].valueReference only Reference(CHPDQmPatient)
* parameter[targetId].valueReference ^type.aggregation = #referenced
* parameter[targetId].valueReference.reference ^short = "Absolute URL"
* parameter[targetIdentifier] 0..2
* parameter[targetIdentifier] ^short = "targetIdentifier"
* parameter[targetIdentifier].name = "targetIdentifier" (exactly)


// ---------------------------------------------------------------------------------------------------------------------
// Audit events [ITI-83]
Profile:     ChAuditEventIti83Consumer
Parent:      AuditPixmQueryConsumer
Title:       "CH Audit Event for [ITI-83] Patient Identifier Cross-reference Consumer"
Description: "This profile is used to define the CH Audit Event for the [ITI-83] transaction and the actor 'Patient
Identifier Cross-reference Consumer'."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Patient Identifier Cross-reference Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Patient Identifier Cross-reference Manager' actor (EPR API)"
* entity[patient].what.identifier 1..1
  * value 1..1
  * system 1..1


Profile:     ChAuditEventIti83Manager
Parent:      AuditPixmQueryManager
Title:       "CH Audit Event for [ITI-83] Patient Identifier Cross-reference Manager"
Description: "This profile is used to define the CH Audit Event for the [ITI-83] transaction and the actor 'Patient
Identifier Cross-reference Manager'."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Patient Identifier Cross-reference Consumer' actor (EPR application)"
* agent[server] ^short = "The 'Patient Identifier Cross-reference Manager' actor (EPR API)"
* entity[patient].what.identifier 1..1
  * value 1..1
  * system 1..1


Instance:   ChAuditEventIti83ConsumerExample
InstanceOf: ChAuditEventIti83Consumer
Usage:      #example
* insert ChAuditEventIti83ExampleRules
* insert ChExampleAuditEventClientRules


Instance:   ChAuditEventIti83ManagerExample
InstanceOf: ChAuditEventIti83Manager
Usage:      #example
* insert ChAuditEventIti83ExampleRules
* insert ChExampleAuditEventServerRules


RuleSet: ChAuditEventIti83ExampleRules
* insert ChExampleAuditEventBaseRules(client, server)
* insert ChExampleAuditEventHcpRules
* insert ChExampleAuditEventEntityPatientRules
* type = $auditEventType#rest
* subtype[anySearch] = $restfulInteraction#search "search"
* subtype[iti83] = $eventTypeCode#ITI-83 "Mobile Patient Identifier Cross-reference Query"
* agent[server].network.address = "https://example.org/fhir/"
* entity[query]
  * type = $auditEntityType#2
  * role = $objectRole#24
  * query = "aHR0cDovL2V4YW1wbGUuY29tL2ZoaXIvUGF0aWVudC8kaWhlLXBpeD9zb3VyY2VJZGVudGlmaWVyPXVybjpvaWQ6Mi45OTkuMS4yLjN8MTIzJnRhcmdldFN5c3RlbT11cm46b2lkOjIuOTk5LjUuNi43JnRhcmdldFN5c3RlbT11cm46b2lkOjIuMTYuNzU2LjUuMzAuMS4xMjcuMy4xMC4z"


// ---------------------------------------------------------------------------------------------------------------------
// Audit events [ITI-104]
Profile:     ChAuditEventIti104Source
Parent:      AuditPixmFeedSourceUpdate
Title:       "CH Audit Event for [ITI-104] Patient Identity Source"
Description: "This profile is used to define the CH Audit Event for the [ITI-104] transaction and the actor 'Patient
Identity Source'."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Patient Identifier Source' actor (EPR application)"
* agent[server] ^short = "The 'Patient Identifier Cross-reference Manager' actor (EPR API)"


Profile:     ChAuditEventIti104ManagerCreate
Parent:      AuditPixmFeedManagerCreate
Title:       "CH Audit Event for [ITI-104] Patient Identifier Cross-reference Manager / Create patient"
Description: "This profile is used to define the CH Audit Event for the [ITI-104] transaction and the actor 'Patient
Identifier Cross-reference Manager' when creating a patient."
* insert ChAuditEventBasicRules
* agent[client] ^short = "The 'Patient Identifier Source' actor (EPR application)"
* agent[server] ^short = "The 'Patient Identifier Cross-reference Manager' actor (EPR API)"
* entity[patient].what.identifier 1..1
  * value 1..1
  * system 1..1


Profile:     ChAuditEventIti104ManagerUpdate
Parent:      AuditPixmFeedManagerUpdate
Title:       "CH Audit Event for [ITI-104] Patient Identifier Cross-reference Manager / Update patient"
Description: "This profile is used to define the CH Audit Event for the [ITI-104] transaction and the actor 'Patient
Identifier Cross-reference Manager' when updating a patient."
* insert ChAuditEventExtendedRules
* agent[client] ^short = "The 'Patient Identifier Source' actor (EPR application)"
* agent[server] ^short = "The 'Patient Identifier Cross-reference Manager' actor (EPR API)"
* entity[patient].what.identifier 1..1
  * value 1..1
  * system 1..1


Instance:   ChAuditEventIti104SourceExample
InstanceOf: ChAuditEventIti104Source
Usage:      #example
* insert ChAuditEventIti104ExampleRules
* insert ChExampleAuditEventClientRules
* subtype[anyUpdate] = $restfulInteraction#update "update"


Instance:   ChAuditEventIti104ManagerCreateExample
InstanceOf: ChAuditEventIti104ManagerCreate
Usage:      #example
* insert ChAuditEventIti104ExampleRules
* insert ChExampleAuditEventServerRules
* subtype[anyCreate] = $restfulInteraction#create "create"


Instance:   ChAuditEventIti104ManagerUpdateExample
InstanceOf: ChAuditEventIti104ManagerUpdate
Usage:      #example
* insert ChAuditEventIti104ExampleRules
* insert ChExampleAuditEventServerRules
* subtype[anyUpdate] = $restfulInteraction#update "update"


RuleSet: ChAuditEventIti104ExampleRules
* insert ChExampleAuditEventBaseRules(client, server)
* insert ChExampleAuditEventHcpRules
* insert ChExampleAuditEventEntityPatientRules
* type = $auditEventType#rest
* subtype[iti104] = $eventTypeCode#ITI-104 "Patient Identity Feed FHIR"
* agent[server].network.address = "https://example.org/fhir/"
* entity[data]
  * what.identifier
    * value = "761337610411353650"
    * system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
  * type = $auditEntityType#2
  * role = $objectRole#4
