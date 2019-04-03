public  with sharing class BoatSearchResults {
    @AuraEnabled
    public static List<Boat__c> getBoats(string boatTypeId ){
        
        List<Boat__c> boats = new List<Boat__c>();
        system.debug('boatTypeId'+boatTypeId);
        if(boatTypeId==''){
              boats = [select id, BoatType__c, picture__c, name,contact__r.Name,Geolocation__Latitude__s, Geolocation__Longitude__s from Boat__c LIMIT 400];
        }else{
               Id id= Id.valueOf(boatTypeId);
               boats = [select id, BoatType__c, picture__c, name,contact__r.Name, Geolocation__Latitude__s, Geolocation__Longitude__s from Boat__c where BoatType__c= :id LIMIT 400];
               system.debug('boats...'+boats[1].BoatType__c);
        }
    
        return boats;
    }
    

}