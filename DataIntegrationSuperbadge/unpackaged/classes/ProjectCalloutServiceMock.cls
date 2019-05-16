global class ProjectCalloutServiceMock implements HttpCalloutMock{
   //Implement http mock callout here
   
     // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[]');
        response.setStatusCode(201);
        
        return response;
    }
}