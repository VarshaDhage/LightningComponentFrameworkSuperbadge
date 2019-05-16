@RestResource(urlMapping='/project/*')
global class ProjectRESTService {
    //Implement service logic here
    @HttpPost
    global static string postProjectData(String ProjectRef, String ProjectName, String OpportunityId, Date StartDate, Date EndDate, Double Amount, String Status){
        
        Project__c project = new Project__c();
        Savepoint sp = Database.setSavepoint();

      try{

          project.Billable_Amount__c = Amount;
          project.End_Date__c = EndDate;
          project.Name = ProjectName;
          project.Opportunity__c = OpportunityId;
          project.ProjectRef__c = ProjectRef;
          project.Start_Date__c = StartDate;
          project.Status__c = Status;

          upsert project;

    
          Opportunity opportunity = [SELECT Id, DeliveryInstallationStatus__c FROM Opportunity WHERE Id = :OpportunityId];
          opportunity.DeliveryInstallationStatus__c = 'In progress';

          update opportunity;

          return 'OK';

      }

      catch(exception ex){

          Database.rollback(sp);
          return ex.getMessage();

      }

    }
}