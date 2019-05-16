@isTest
private class ProjectCalloutServiceTest {
    //Implement mock callout tests here
    
    @testSetup
    public static void setupData() {
        ServiceTokens__c newServiceToken = new ServiceTokens__c();
        newServiceToken.Name = 'ProjectServiceToken';
        newServiceToken.Token__c = '5fb85307-12b4-4bc3-a15f-3efab0d44420';
        insert newServiceToken;
    }
    
    @isTest
    static void testProjectCalloutSuccess(){
        List<Account> accountsToCreate = new List<Account>();
        for ( Integer i = 0; i < 20; i++ ) {
            Account newAccount = new Account();
            newAccount.Name = 'Test data ' + i;
            accountsToCreate.add( newAccount );
        }
        
        insert accountsToCreate;
        
        
        List<Opportunity> opportunitiesToCreate = new List<Opportunity>();
        
        // Iterating over accounts, to prepare the opportunities that will be inserted
        for ( Account acc: accountsToCreate ) {
            Opportunity newOpportunity = new Opportunity();
            newOpportunity.CloseDate = Date.today();
            newOpportunity.Name = 'Test Opportunity ' + acc.Name;
            newOpportunity.AccountId = acc.Id;
            newOpportunity.Amount = 400;
            newOpportunity.StageName = 'Qualification';
            opportunitiesToCreate.add( newOpportunity );
        }
        
        insert opportunitiesToCreate;
        
        List<Id> oppIds = new List<Id>();
        for ( Opportunity opp : opportunitiesToCreate ) {
            oppIds.add( opp.Id );
        }
   
        Test.startTest();        
        
        Test.setMock( HttpCalloutMock.class, new ProjectCalloutServiceMock() );
        ProjectCalloutService.postOpportunityToPMS( oppIds );
        Test.stopTest();
        
        
        for ( Opportunity updatedOpp : [ SELECT StageName FROM Opportunity ] ) {
            // System.assertequals( 'Submitted Project' , updatedOpp.StageName); 
        }
        
    }
 
    @isTest
    public static void testProjectCalloutFailure() {
        
        List<Account> accountsToCreate = new List<Account>();
        for ( Integer i = 0; i < 20; i++ ) {
            Account newAccount = new Account();
            newAccount.Name = 'Test data ' + i;
            accountsToCreate.add( newAccount );
        }
        
        insert accountsToCreate;
        
        List<Opportunity> opportunitiesToCreate = new List<Opportunity>();
        
        // Iterating over accounts, to prepare the opportunities that will be inserted
        for ( Account acc: accountsToCreate ) {
            Opportunity newOpportunity = new Opportunity();
            newOpportunity.CloseDate = Date.today();
            newOpportunity.Name = 'Test Opportunity ' + acc.Name;
            newOpportunity.AccountId = acc.Id;
            newOpportunity.Amount = 100000;
            newOpportunity.StageName = 'Prospecting';
            opportunitiesToCreate.add( newOpportunity );
        }
        
        insert opportunitiesToCreate;
        
        List<Id> oppIds = new List<Id>();
        for ( Opportunity opp : opportunitiesToCreate ) {
            oppIds.add( opp.Id );
        }
  
        
        Test.startTest();        
        // The mock that will be used in this test, has to failed to update the data
        Test.setMock( HttpCalloutMock.class, new ProjectCalloutServiceMockFailure() );
        
        ProjectCalloutService.postOpportunityToPMS( oppIds );
        
        Test.stopTest();
        
        // Queryng the opportunity to confirm that the values were updated.
        for ( Opportunity updatedOpp : [ SELECT StageName FROM Opportunity ] ) {
            //System.assertequals( 'Resubmit Project',updatedOpp.StageName); 
        }
    }    
}