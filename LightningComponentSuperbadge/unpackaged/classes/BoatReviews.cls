public with sharing class BoatReviews {
     @AuraEnabled
    public static List<BoatReview__c> getAll(Id boatId){
        List<BoatReview__c> reviews= new List<BoatReview__c>();
        reviews = [select Id,Name,Comment__c,Rating__c,LastModifiedDate,CreatedDate,CreatedBy.Name,CreatedBy.SmallPhotoUrl,
                   CreatedBy.CompanyName from BoatReview__c where Boat__c = :boatId];
        system.debug('reviews......'+reviews);
        return reviews;
    }

}