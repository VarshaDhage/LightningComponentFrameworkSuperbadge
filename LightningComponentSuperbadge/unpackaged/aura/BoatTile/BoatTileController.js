({
	onBoatClick : function(component, event, helper) {
        var boat = component.get("v.boat");
		 var compEvents = component.getEvent("BoatSelect");// getting the Instance of event
        compEvents.setParams(
                              {"boatId" : boat.BoatType__c});// setting the attribute of event
        compEvents.fire();// firing the event.
        
        //Fire event to display BoatDetails
    
		 //var compEvents1 = component.getEvent("BoatSelected");
		  var compEvents1 = $A.get('e.c:BoatSelected');
        compEvents1.setParams(
                              {"boat" : boat});
        compEvents1.fire();
           console.log("In onBoatClick"+compEvents1);
        
        
        
        //send geolocation to map.cmp through the PlotMapMarker Application event
          var lat = boat.Geolocation__Latitude__s;
          var long = boat.Geolocation__Longitude__s;
          var label = boat.Name;
         var sObjectId;
        console.log('In BoatTileComponent.....', lat);
        
         var plotMapMarkerAppEvent = $A.get("e.c:PlotMapMarker");
        
        
        plotMapMarkerAppEvent.setParams({
            "lat"   : lat,
            "long"  : long,
            "label" : label,
            "SObjectId" : boat.Id
        });
         plotMapMarkerAppEvent.fire();
        
	}
})