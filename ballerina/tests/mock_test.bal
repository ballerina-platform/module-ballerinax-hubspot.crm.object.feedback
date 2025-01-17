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

import ballerina/http;
import ballerina/test;

final string mockTestFeedbackSubmissionId = "512";

@test:Config {
    enable: !isLiveServer,
    groups: ["mock_service_test"]
    }
isolated function createFeedbackSubmission() returns error? {
    SimplePublicObject response = check baseClient->/.post(
        payload = {
            associations: [],
            properties: {
                "hs_content": "What a great product!",
                "hs_ingestion_id": "fd61286d-102b-4fcc-b486-3486b4ceafc2",
                "hs_response_group": "PROMOTER",
                "hs_submission_name": "Customer Satisfaction Survey - bcooper@biglytics.net",
                "hs_survey_channel": "EMAIL",
                "hs_survey_id": "5",
                "hs_survey_name": "Customer Satisfaction Survey",
                "hs_survey_type": "CSAT",
                "hs_value": "2"
            }
        }
    );

    test:assertEquals(response, {
                                    "id": "512",
                                    "properties": {
                                        "hs_content": "What a great product!",
                                        "hs_ingestion_id": "fd61286d-102b-4fcc-b486-3486b4ceafc2",
                                        "hs_response_group": "PROMOTER",
                                        "hs_submission_name": "Customer Satisfaction Survey - bcooper@biglytics.net",
                                        "hs_survey_channel": "EMAIL",
                                        "hs_survey_id": "5",
                                        "hs_survey_name": "Customer Satisfaction Survey",
                                        "hs_survey_type": "CSAT",
                                        "hs_value": "2"
                                    },
                                    "createdAt": "2019-10-30T03:30:17.883Z",
                                    "updatedAt": "2019-12-07T16:50:06.678Z",
                                    "archived": false
                                });
}

@test:Config {
    enable: !isLiveServer,
    groups: ["mock_service_test"]
    }
isolated function updateFeedbackSubmission() returns error? {
    SimplePublicObject response = check baseClient->/[mockTestFeedbackSubmissionId].patch(
        payload = {
            properties: {
                "hs_content": "Wow! This is awesome!"
            }
        }
    );

    test:assertEquals(response, {
                                    "id": "512",
                                    "properties": {
                                        "hs_content": "Wow! This is awesome!",
                                        "hs_ingestion_id": "fd61286d-102b-4fcc-b486-3486b4ceafc2",
                                        "hs_response_group": "PROMOTER",
                                        "hs_submission_name": "Customer Satisfaction Survey - bcooper@biglytics.net",
                                        "hs_survey_channel": "EMAIL",
                                        "hs_survey_id": "5",
                                        "hs_survey_name": "Customer Satisfaction Survey",
                                        "hs_survey_type": "CSAT",
                                        "hs_value": "2"
                                    },
                                    "createdAt": "2019-10-30T03:30:17.883Z",
                                    "updatedAt": "2019-12-07T16:50:06.678Z",
                                    "archived": false
                                });
}

@test:Config {
    enable: !isLiveServer,
    groups: ["mock_service_test"]
}
isolated function deleteFeedbackSubmission() returns error? {
    http:Response response = check baseClient->/[mockTestFeedbackSubmissionId].delete();

    test:assertEquals(response.getTextPayload(), "Successfully deleted");
    test:assertEquals(response.statusCode, 204);
}
