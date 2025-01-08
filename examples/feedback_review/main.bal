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

import ballerinax/hubspot.crm.obj.feedback as feedback;
import ballerina/oauth2;
import ballerina/io;

configurable string & readonly clientId = ?;
configurable string & readonly clientSecret = ?;
configurable string & readonly refreshToken = ?;

public function main() returns error?{
    // Create a new client using the provided configuration
    feedback:ConnectionConfig config = {
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        }
    };

    final feedback:Client baseClient = check new feedback:Client(config); 

    // Search for feedback submissions
    feedback:PublicObjectSearchRequest searchRequest = {
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

    feedback:CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check baseClient->/feedback_submissions/search.post(searchRequest);
    io:println("Feedback submissions found: ");
    io:println(response);

    // Get all feedback submissions
    feedback:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging allFeedbackSubmissions = check baseClient->/feedback_submissions;
    io:println("All feedback submissions: ");
    io:println(allFeedbackSubmissions);

    // Get a feedback submission by ID
    feedback:SimplePublicObjectWithAssociations feedbackSubmissionById = check baseClient->/feedback_submissions/["392813793683"];
    io:println("Feedback submission by ID: ");
    io:println(feedbackSubmissionById);

    // Read batch of feedback submissions
    feedback:BatchReadInputSimplePublicObjectId batchReadInput = {
        propertiesWithHistory: [
            "testFeedbackProperty"
        ],
        inputs: [
            {
            "id": "testFeedbackSubmissionId"
            }
        ],
        properties: [
            "testFeedbackProperty"
        ]
    };

    feedback:BatchResponseSimplePublicObject batchFeedbackSubmissions = check baseClient->/feedback_submissions/batch/read.post(batchReadInput);
    io:println("Batch of feedback submissions: ");
    io:println(batchFeedbackSubmissions);
};