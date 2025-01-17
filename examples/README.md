# Examples

The `HubSpot CRM Feedback` connector provides practical examples illustrating usage in various scenarios.

[Feedback Reviewing](https://github.com/module-ballerinax-hubspot.crm.object.feedback/tree/main/examples/) - This example demonstrates the usage of the HubSpot CRM Feedback connector to read a page of feedback submissions, read an object identified by `{feedbackSubmissionId}`, read a batch of feedback submissions by internal ID, or unique property values, and search feedback submissions.

> **Note**: The feedback submissions endpoints are currently read only. Feedback submissions cannot be submitted or edited through the API. You can only create properties in the [feedback surveys tool within HubSpot](https://knowledge.hubspot.com/customer-feedback/create-a-custom-survey), and the properties cannot be edited after creation.

## Prerequisites

- **Ballerina:** Download and install Ballerina from [here](https://ballerina.io/downloads/).
- **HubSpot developer account:** Create a HubSpot developer account and create an app to obtain the necessary credentials. Refer to the [Setup Guide](../ballerina/Package.md) for instructions.
- **`hubspot.crm.obj.feedback` module:** Import the `ballerinax/hubspot.crm.obj.feedback` module into your Ballerina project and configure it with the obtained credentials. Refer to the [Config.toml.template](./feedback_review/Config.toml.template) file for creating the `Config.toml` file.

```ballerina
import ballerinax/hubspot.crm.obj.feedback as hsfeedback;

configurable string & readonly clientId = ?;
configurable string & readonly clientSecret = ?;
configurable string & readonly refreshToken = ?;

hsfeedback:ConnectionConfig config = {
    auth: {
        clientId,
        clientSecret,
        refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    }
};

final hsfeedback:Client baseClient = check new (config);
```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

  ```bash
  bal build
  ```
* To run an example:

  ```bash
  bal run
  ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

  ```bash
  ./build.sh build
  ```
* To run all the examples:

  ```bash
  ./build.sh run
  ```
