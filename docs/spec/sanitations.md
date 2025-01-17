_Author_:  @Irash-Perera 
_Created_: 2024/12/18 
_Updated_: 2025/01/09 
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from HubSpot CRM Feedback.
The OpenAPI specification is obtained from [Hubspot Github Public API Spec Collection](https://github.com/HubSpot/HubSpot-public-api-spec-collection/blob/main/PublicApiSpecs/CRM/Feedback%20Submissions/Rollouts/424/v3/feedbackSubmissions.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change the `url` property of the servers object

- **Original**:
  ``https://api.hubspot.com``
- **Updated**:
  ``https://api.hubapi.com/crm/v3/objects/feedback_submissions``
- **Reason**:  This change of adding the common prefix `/crm/v3/objects/feedback_submissions` to the base url makes it easier to access endpoints using the client.

2. Update the API Paths

- **Original**: Paths included common prefix above in each endpoint. (eg: ``/crm/v3/objects/feedback_submissions/batch/read``)
- **Updated**: Common prefix is now removed from the endpoints as it is included in the base URL.

  - **Original**: ``/crm/v3/objects/feedback_submissions/batch/read``
  - **Updated**: ``/batch/read``
- **Reason**:  This change simplifies the API paths, making them shorter and more readable.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/feedbackSubmissions.json -o ballerina --mode client --license docs/license.txt
```

Note: The license year is hardcoded to 2025, change if necessary.
