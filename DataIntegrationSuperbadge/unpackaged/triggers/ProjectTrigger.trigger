trigger ProjectTrigger on Project__c (after update, after insert) {
    //Call the Billing Service callout logic here
    
      if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            List<Project__c> filtered = ProjectTrigger_Helper.filterStatusChanged(Trigger.oldMap, Trigger.new, 'Billable');
            if (!filtered.isEmpty())
               // BillingCalloutService.callBillingService(filtered);
               BillingCalloutService.callBillingService(JSON.serialize(filtered));
              
        }
    }
    
}