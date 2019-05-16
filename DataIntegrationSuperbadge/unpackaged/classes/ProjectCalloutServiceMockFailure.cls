global class ProjectCalloutServiceMockFailure implements HttpCalloutMock{
   //Implement http mock callout failure here 
   
      // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[]');
        response.setStatusCode(400);
        return response;
    }
}