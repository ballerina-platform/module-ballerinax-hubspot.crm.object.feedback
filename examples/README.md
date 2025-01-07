# Examples

The `ballerinax/hubspot.crm.object.feedback` connector provides practical examples illustrating usage in various scenarios.

## Prerequisites

- **Ballerina**Download and install Ballerina from [here](https://ballerina.io/downloads/).
- **HubSpot developer account**Create a HubSpot developer account and create an app to obtain the necessary credentials. Refer to the [Setup Guide](../ballerina/Package.md) for instructions.
- **`hubspot.crm.object.feedback` module**
  Import the `ballerinax/hubspot.crm.object.feedback` module into your Ballerina project and configure it with the obtained credentials. Refer to the [Config.toml.template](./feedback_review/Config.toml.template) file for creating the `Config.toml` file.

```
import ballerinax/hubspot.crm.obj.feedback as feedback;

configurable string & readonly clientId = ?;
configurable string & readonly clientSecret = ?;
configurable string & readonly refreshToken = ?;

public function main() returns error?{
    feedback:ConnectionConfig config = {
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        }
    };

    final feedback:Client baseClient = check new feedback:Client(config, serviceUrl);
}
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
