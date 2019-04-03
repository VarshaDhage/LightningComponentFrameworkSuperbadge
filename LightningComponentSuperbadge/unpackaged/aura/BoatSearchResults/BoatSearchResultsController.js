({
    doInit: function(component, event, helper) {
        helper.onSearch(component,event,helper);
    },
    search:  function(component, event, helper) {
        var params = event.getParam("arguments");
     
        console.log('params.boatTypeId....'+params.boatTypeId);
            component.set('v.boatTypeId ', params.boatTypeId);
          helper.onSearch(component,event,helper);
           doSearch(params.boatTypeId);
    },
    doSearch: function(boatTypeId){
         component.set('v.boatTypeId ', boatTypeId);
          helper.onSearch(component,event,helper);
    },
    onBoatSelect: function(component, event, helper){
         var boatId = event.getParam("boatId"); 
         component.set("v.selectedBoatId",boatId);
    }
})