// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerinax/hubspot.crm.obj.feedback as hsfeedback;
import ballerina/oauth2;
import ballerina/io;

configurable string & readonly clientId = ?;
configurable string & readonly clientSecret = ?;
configurable string & readonly refreshToken = ?;

// Create a new client using the provided configuration
hsfeedback:ConnectionConfig config = {
    auth: {
        clientId,
        clientSecret,
        refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    }
};

final hsfeedback:Client feedbackClient = check new (config);

public function main() returns error?{
    // Search for feedback submissions
    // In this scenario, we are searching for feedback submissions with a creation date of 2024-12-22T07:26:59.374Z
    hsfeedback:PublicObjectSearchRequest searchRequest = {
        filterGroups: [
            {
                "filters": [
                    {
                    "propertyName": "hs_createdate",
                    "value": "2024-12-22T07:26:59.374Z",
                    "operator": "EQ"
                    }
                ]
            }
        ]
    };

    hsfeedback:CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check feedbackClient->/feedback_submissions/search.post(searchRequest);
    io:println("Feedback submissions found: ");
    io:println(response);

    // Get a page of feedback submissions
    // Here, we have set the maximum number of feedback submissions to be retrieved per page to 2.
    // Also, the paging cursor token of the last successfully read resource will be returned as the paging.next.after JSON property of a paged response containing more results.
    hsfeedback:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging allFeedbackSubmissions = check feedbackClient->/feedback_submissions('limit = 2);
    io:println("All feedback submissions: ");
    io:println(allFeedbackSubmissions);

    // Get a feedback submission by ID
    // {feedbackSubmissionId} refers to the internal object ID by default, or optionally any unique property value as specified by the idProperty query param. 
    // Control what is returned via the properties query param.
    hsfeedback:SimplePublicObjectWithAssociations feedbackSubmissionId = check feedbackClient->/feedback_submissions/["392813793683"];
    io:println("Feedback submission by ID: ");
    io:println(feedbackSubmissionId);

    // Read batch of feedback submissions
    // This operation is used to read multiple feedback submissions in a single call.
    // You can give a list of feedback submission IDs to read and specify the properties and propertiesWithHistory to be returned.
    hsfeedback:BatchReadInputSimplePublicObjectId batchReadInput = {
        propertiesWithHistory: [
            "testFeedbackProperty"
        ],
        inputs: [
            {
                "id": "392813793683"
            },
            {
                "id": "392814365797"
            }
        ],
        properties: [
            "this_is_for_testing_purpose_"
        ]
    };

    hsfeedback:BatchResponseSimplePublicObject batchFeedbackSubmissions = check feedbackClient->/feedback_submissions/batch/read.post(batchReadInput);
    io:println("Batch of feedback submissions: ");
    io:println(batchFeedbackSubmissions);
};
