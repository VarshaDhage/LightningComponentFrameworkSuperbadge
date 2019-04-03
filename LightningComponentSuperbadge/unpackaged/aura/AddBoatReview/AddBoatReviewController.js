({
    doInit: function(component, event, helper) {
        helper.onInit(component,event);
    },
    onSave : function(component, event, helper) {
        
        
        component.set("v.boatReview.boat__c",component.get("v.boat.Id"));
        component.find("service").saveRecord($A.getCallback(function(saveResult) {
            
            if (saveResult.state == "SUCCESS" || saveResult.state == "DRAFT") {
                var resultsToast = $A.get("e.force:showToast");
                if(resultsToast){
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "Boat Review Created"});
                    resultsToast.fire(); 
                }else{
                    alert('Boat Review Created');	
                }
            } else if (saveResult.state == "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state == "ERROR") {
                console.log('Problem saving record, error: ' + 
                            JSON.stringify(saveResult.error));
                
                var errMsg='';
                
                
                for(var i = 0; i < saveResult.error.length; i++) {
                    errMsg += saveResult.error[i].message + "\n";
                }
                component.set("v.recordError", errMsg);
                
            }
            
            
        }));
        var boatReviewAddedEvnt=component.getEvent("BoatReviewAdded");
        
        boatReviewAddedEvnt.fire();
        
        helper.onInit(component,event,helper);   
        
    },
    onRecordUpdated :  function(component, event, helper) {
        var eventParams = event.getParams();
        
        if(eventParams.changeType === "CHANGED") {
            var changedFields = eventParams.changedFields;
            var saveResultsToast = $A.get("e.force:showToast");
            
            if(saveResultsToast!='undefined'){
                saveResultsToast.setParams({
                    "title": "Saved",
                    "message": "Boat Review Saved"});
                saveResultsToast.fire(); 
            }else{
                alert('Boat Review Saved');	
            }
            
        }
    }
})