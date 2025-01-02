import ballerina/http;
import ballerina/io;


service / on new http:Listener(9090) {
   resource function get .(http:Caller caller, http:Request req) returns error? {
       // Extract the "code" query parameter from the URL
       string? code = req.getQueryParamValue("code");


       if code is string {
           // Log the received code
           io:println("Authorization code received: " + code);
           // Respond to the client with the received code
           check caller->respond("Received code: " + code);
       } else {
           // Respond with an error message if no code is found
           check caller->respond("Authorization code not found.");
       }
   }
}

