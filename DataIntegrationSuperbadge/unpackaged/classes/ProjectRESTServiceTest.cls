@isTest
private class ProjectRESTServiceTest {
    //Implement Apex REST service tests here
    
     @testSetup
    static void setup() {
        Opportunity opp = new Opportunity(
                Name = 'OpportunityName',
                StageName = 'Prospecting',
                CloseDate = Date.today().addYears(1)
        );
        insert opp;

        Project__c project = new Project__c();
        project.ProjectRef__c = '5678';
        project.Opportunity__c = opp.Id;
        insert project;
    }
    
    @isTest
    static void testPostCreate() {
        Id oppId = [select id from opportunity][0].Id;

        Test.startTest();

        String result = ProjectRESTService.postProjectData('3456', 'TestProjectName' , oppId, Date.today(), Date.today().addYears(1), 100, 'Running');

        Test.stopTest();

        Opportunity opp = [select id, DeliveryInstallationStatus__c from opportunity][0];
        List<Project__c> projects = [select id,Name, Status__c, ProjectRef__c from Project__c];

        System.assertEquals('OK', result);
        System.assertEquals(2, projects.size());

        Project__c project = projects[0].ProjectRef__c == '3456' ? projects[0] : projects[1];

        System.assertEquals('In progress', opp.DeliveryInstallationStatus__c);
        System.assertEquals('TestProjectName', project.Name);
        System.assertEquals('Running', project.Status__c);
    }
    
    @isTest
    static void testPostUpdate() {
        Id oppId = [select id from opportunity][0].Id;

        Test.startTest();

        String result = ProjectRESTService.postProjectData('5678', 'TestProject2', oppId, Date.today(), Date.today().addYears(1), 100, 'Billable');

        Test.stopTest();

        Opportunity opp = [select id, DeliveryInstallationStatus__c from opportunity][0];
        List<Project__c> projects = [select id, Status__c  from Project__c];

       
        System.assertEquals(1, projects.size());
     
    }
    
   

}