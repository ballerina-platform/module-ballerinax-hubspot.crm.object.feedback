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

    final feedback:Client baseClient = check new feedback:Client(config, serviceUrl = "https://api.hubapi.com/crm/v3/objects"); 
    io:println(baseClient);
    io:println("Client created successfully");

    // Search for feedback submissions
    feedback:PublicObjectSearchRequest searchRequest = {
        filterGroups: [
            {"filters": [
                    {
                    "propertyName": "hs_createdate",
                    "value": "2024-12-22T07:26:59.374Z",
                    "operator": "EQ"
                    }
            ]}
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