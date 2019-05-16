public class BillingCalloutService {
    //Implement business and callout logic methods here
    public static final String BIlLING_SERVICE_CREDENTIALS = 'BillingServiceCredential';
    private static final ServiceCredentials__c CREDENTIALS = ServiceCredentials__c.getinstance(BIlLING_SERVICE_CREDENTIALS);
    
    
    @future(callout=true)
    public static void callBillingService(String serializeProjects) {
        List<Project__c> projects = ( List<Project__c> )JSON.deserialize( serializeProjects, List<Project__c>.class );
         // Holds project Ids with callout responses
        Map<String, String> mapCalloutResponses = new Map<String, String>();
        
        
        if (projects.isEmpty() || projects[0].ProjectRef__c == null || projects[0].Billable_Amount__c == null) {
            // log error
            return;
        }
        
        // prepare proxy
        List<BillingServiceProxy.project> soapRequests = prepareProjectProxy(projects);
        
         // Iterating over the soap payloads, making the callout, and storing the values in the map with project reference.
        for ( BillingServiceProxy.project soapPayloads : soapRequests ) {
        BillingServiceProxy.InvoicesPortSoap11 invoiceCall  = new BillingServiceProxy.InvoicesPortSoap11();
        mapCalloutResponses.put( soapPayloads.projectid, invoiceCall.billProject( soapPayloads ) );
        }
        
          // Holds projects that will be updated if the callout was successfull made
        List<Project__c> projectsToUpdate = new List<Project__c>();
        
        // Iterating over the result to confirm if the project can be updated
        for ( String projectReference: mapCalloutResponses.keySet() ) {
            if ( mapCalloutResponses.get( projectReference ) != null &&  mapCalloutResponses.get( projectReference ).equalsIgnoreCase('OK') ) {
                Project__c projectToUpdate = new Project__c( ProjectRef__c = projectReference );
                projectToUpdate.Status__c = 'Billed';
                projectsToUpdate.add( projectToUpdate );	
            }
        }
        
        if ( projectsToUpdate.size() > 0 ) {
            upsert projectsToUpdate ProjectRef__c;
        }
    }
    
    private static List<BillingServiceProxy.project> prepareProjectProxy(List<Project__c> recordsToBeProcessed) {
        // List of Soap Requests to Process
        List<BillingServiceProxy.project> soapRequests = new List<BillingServiceProxy.project>();
        
        for ( Project__c project: recordsToBeProcessed ) {
            BillingServiceProxy.project soapProject = new BillingServiceProxy.project();
            soapProject.projectid = project.ProjectRef__c;
            soapProject.billAmount = project.Billable_Amount__c;
            soapProject.username = CREDENTIALS.Username__c;
            soapProject.password = CREDENTIALS.Password__c;
            soapRequests.add(soapProject);
        }
        return soapRequests;
    }
}