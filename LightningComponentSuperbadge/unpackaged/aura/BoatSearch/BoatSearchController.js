({
    onFormSubmit : function (component, event, helper) {
        
         var formData = event.getParam("formData"); 
         console.log('formData.boatTypeId..........'+formData.boatTypeId)
         var BoatSearchResults = component.find("BoatSearchResults");
        console.log('BoatSearchResults'+BoatSearchResults)
        BoatSearchResults.search(formData.boatTypeId);
    }

})