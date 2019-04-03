public with sharing class BoatSearchForm {
    
     @AuraEnabled
        public static Map<String, String> getSearchOptions() 
        {
                List<BoatType__c> boatTypes = [SELECT Id, Name FROM BoatType__c LIMIT 400];
                Map<String, String> returnMap = new Map<String, String>();
                if(!boatTypes.isEmpty())
                {
                        for(BoatType__c bt: boatTypes)
                        {
                            returnMap.put(bt.Name, bt.Id);
                        }
                }
                system.debug(returnMap);
                return returnMap;
        }

}