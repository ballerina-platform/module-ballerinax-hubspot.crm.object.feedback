import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new(9090);

http:Service mockService = service object {
    // Create feedback submission
    resource function post crm/v3/objects/feedback_submissions(@http:Payload SimplePublicObjectInputForCreate payload) returns SimplePublicObject|error{
        return {
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
        };
    }

    // Update feedback submission
    resource function patch crm/v3/objects/feedback_submissions/[string feedbackSubmissionId](@http:Payload SimplePublicObjectInput payload) returns SimplePublicObject|error {
        return{
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
            };
    }

    // Delete a feedback submission
    resource function delete crm/v3/objects/feedback_submissions/[string feedbackSubmissionId]() returns http:Response|error {
        http:Response response = new;
        response.statusCode = 204;
        response.setPayload("Successfully deleted");
        return response;
    }
};

function init() returns error?{
    log:printInfo("Initializing mock service");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}

