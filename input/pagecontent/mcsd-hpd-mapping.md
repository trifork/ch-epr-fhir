# Mapping between mCSD and HPD data models

<style>
table, th, td {
  border: 1px solid black;
}
</style>

## Mapping of telecommunication channels

Same as with postal addresses, an HPD provider can have multiple communication channels. On the FHIR site, they
map to `ContactPoint` structures as shown in the table below:

| HPD communication channel  | FHIR `ContactPoint.system` | FHIR `ContactPoint.use` |
|----------------------------|----------------------------|-------------------------|
| `mail`                     | `#email`                   | `#work`                 |
| `telephoneNumber`          | `#phone`                   | `#work`                 |
| `mobile`                   | `#phone`                   | `#mobile`               |
| `pager`                    | `#pager`                   | `#work`                 |
| `facsimileTelephoneNumber` | `#fax`                     | `#work`                 |

HPD `HCProfessional.hpdMedicalRecordsDeliveryEmailAddress` constitutes a special case. The cardinality of this
attribute is 0..1, as opposed to 0..n for all other telecommunication channels, and it does not map conveniently
to FHIR `ContactPoint`. Therefore, it is mapped to FHIR
`Practitioner.extension[hpdMedicalRecordsDeliveryEmailAddress].valueString`.
