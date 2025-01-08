# Ballerina HubSpot CRM Feedback connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.feedback/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.feedback/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.feedback/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.feedback/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.feedback/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.feedback/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-hubspot.crm.object.feedback.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.object.feedback/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/hubspot.crm.object.feedback.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%hubspot.crm.object.feedback)

## Overview

[HubSpot](https://developers.hubspot.com/docs/reference/api) is an AI-powered customer relationship management (CRM) platform.

The `ballerinax/hubspot.crm.object.feedback` offers APIs to connect and interact with the [HubSpot Feedback Submission API](https://developers.hubspot.com/docs/reference/api/crm/objects/feedback-submissions) endpoints, specifically based on the [HubSpot API v3](https://developers.hubspot.com/docs/reference/api).

> **Note:** This package may be changed in the future based on the HubSpot API changes, since it is currently under development and is subject to change based on testing and feedback. By using this package, you are agreeing to accept any future changes that might occur and understand the risk associated with testing an unstable API. Refer to the [HubSpot Developer Terms](https://legal.hubspot.com/developer-terms) & [Developer Beta Terms](https://legal.hubspot.com/developerbetaterms) for more information.
>
> The feedback submissions endpoints are currently read only. Feedback submissions cannot be submitted or edited through the API.
>
> ```
> GET https://api.hubapi.com/crm/v3/objects/feedback_submissions
> GET https://api.hubapi.com/crm/v3/objects/feedback_submissions/{feedbackSubmissionId}
> POST https://api.hubapi.com/crm/v3/objects/feedback_submissions/batch/read
> POST https://api.hubapi.com/crm/v3/objects/feedback_submissions/search
> ```

## Setup guide

To use the HubSpot Feedback connector, you must have access to the HubSpot API through a HubSpot developer account and a HubSpot App under it. Therefore you need to register for a developer account at HubSpot if you don't have one already.

### Step 1: Create/Login to a HubSpot Developer Account

If you have an account already, go to the [HubSpot developer portal](https://app.hubspot.com/)

If you don't have a HubSpot Developer Account you can sign up to a free account [here](https://developers.hubspot.com/get-started)

### Step 2 (Optional): Create a [Developer Test Account](https://developers.hubspot.com/beta-docs/getting-started/account-types#developer-test-accounts) under your account

Within app developer accounts, you can create developer test accounts to test apps and integrations without affecting any real HubSpot data.

**_These accounts are only for development and testing purposes. In production you should not use Developer Test Accounts._**

1. Go to Test accounts section from the left sidebar.
   <img src="./docs/resources/test-account.png" style="width: 70%;">
2. Click on the `Create developer test account` button on the top right corner.

   <img src="./docs/resources/create-test-account.png" style="width: 70%;">
3. In the pop-up window, provide a name for the test account and click on the `Create` button.

   <img src="./docs/resources/create-account.png" style="width: 70%;">
4. You will see the newly created test account in the list of test accounts.

   <img src="./docs/resources/test-account-portal.png" style="width: 70%">

### Step 3: Create a HubSpot App

1. Now navigate to the `Apps` section from the left sidebar and click on the `Create app` button on the top right corner.

   <img src="./docs/resources/create-app.png" width="70%">
2. Provide a public app name and description for your app.

   <img src="./docs/resources/app-name-desc.png" width="70%">

### Step 4: Setup Authentication

1. Move to the `Auth` tab.

   <img src="./docs/resources/config-auth.png" width="70%">
2. In the `Scopes` section, add the following scopes for your app using the `Add new scopes` button.

   <img src="./docs/resources/add-scopes.png" width="70%">

   - `e-commerce`
   - `tickets`
   - `crm.objects.goals.read`
   - `media_bridge.read`
   - `crm.objects.custom.read`
   - `crm.objects.custom.write`
   - `crm.objects.feedback_submissions.read`

   <img src="./docs/resources/add-scopes.png" width="70%">

3. In the `Redirect URL` section, add the redirect URL for your app. This is the URL where the user will be redirected after the authentication process. You can use localhost for testing purposes. Then hit the `Create App` button.

   <img src="./docs/resources/redirect-url.png" width="70%">

### Step 5: Get the Client ID and Client Secret

Navigate to the `Auth` tab and you will see the `Client ID` and `Client Secret` for your app. Make sure to save these values.

   <img src="./docs/resources/client-id-secret.png" width="70%">

### Step 6: Setup Authentication Flow

Before proceeding with the Quickstart, ensure you have obtained the Access Token using the following steps:

1. Create an authorization URL using the following format:

   ```
   https://app.hubspot.com/oauth/authorize?client_id=<YOUR_CLIENT_ID>&scope=<YOUR_SCOPES>&redirect_uri=<YOUR_REDIRECT_URI>
   ```

   Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>` and `<YOUR_SCOPES>` with your specific value.
2. Paste it in the browser and select your developer test account to intall the app when prompted.

   <img src="./docs/resources/account-select.png" style="width: 70%;">
3. A code will be displayed in the browser. Copy the code.

   ```
   Received code: na1-129d-860c-xxxx-xxxx-xxxxxxxxxxxx
   ```
4. Run the following curl command. Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI`> and `<YOUR_CLIENT_SECRET>` with your specific value. Use the code you received in the above step 3 as the `<CODE>`.

   - Linux/macOS

     ```bash
     curl --request POST \
     --url https://api.hubapi.com/oauth/v1/token \
     --header 'content-type: application/x-www-form-urlencoded' \
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```
   - Windows

     ```bash
     curl --request POST ^
     --url https://api.hubapi.com/oauth/v1/token ^
     --header 'content-type: application/x-www-form-urlencoded' ^
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   This command will return the access token necessary for API calls.

   ```json
   {
     "token_type": "bearer",
     "refresh_token": "<Refresh Token>",
     "access_token": "<Access Token>",
     "expires_in": 1800
   }
   ```
5. Store the access token securely for use in your application.

## Quickstart

To use the `Hubspot CRM Feedback Submission` connector in your Ballerina project, follow the steps below and update the `.bal` file as follows.:

### Step 1: Import the Hubspot CRM Feedback Submission module

Import the `ballerinax/hubspot.crm.obj.feedback` module into your Ballerina project.

```
import ballerinax/hubspot.crm.obj.feedback;
```

### Step 2: Provide the required configurations

Create a `Config.toml` file where your `.bal` file is located and provide the following configurations:

```
clientId = "<CLIENT_ID>"
clientSecret = "<CLIENT_SECRET>"
refreshToken = "<REFRESH_TOKEN>"
```

### Step 3: Initialize the Hubspot CRM Feedback Submission Client

Initialize the Hubspot CRM Feedback Submission client by passing the configurations to the `main` function.

```
public function main() returns error?{
    feedback:ConnectionConfig config = {
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        }
    };

    final feedback:Client baseClient = check new feedback:Client(config, serviceUrl = "https://api.hubapi.com/crm/v3/objects"); 
}
```

### Step 4 (Optional): Invoke the Hubspot CRM Feedback Submission API (View Feedback Submissions)

You can view all feedback submissions by calling the `feedback_submissions` endpoint.

```
    feedback:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging allFeedbackSubmissions = check baseClient->/feedback_submissions;
    io:println("All feedback submissions: ");
    io:println(allFeedbackSubmissions);
```

Refer more examples [here](./../examples/feedback_review/main.bal)

### Step 5: Run the Ballerina file

Use the following command to run the Ballerina file.

```
bal run
```

## Examples

The `HubSpot CRM Feedback` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/module-ballerinax-hubspot.crm.object.feedback/tree/main/examples/), covering the following use cases:

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

   * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
   * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.
   >
2. Download and install [Ballerina Swan Lake](https://ballerina.io/).
3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.
   >
4. Export Github Personal access token with read package permissions as follows,

   ```bash
   export packageUser=<Username>
   export packagePAT=<Personal access token>
   ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```
2. To run the tests:

   ```bash
   ./gradlew clean test
   ```
3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```
4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```
5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```
6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```
7. Publish the generated artifacts to the local Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToLocalCentral=true
   ```
8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`hubspot.crm.object.feedback` package](https://central.ballerina.io/ballerinax/hubspot.crm.object.feedback/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.

[//]: #
[//]: #
