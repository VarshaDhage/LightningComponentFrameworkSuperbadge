({
	 doInit: function(component, event, helper) 
    {
       console.log('inside do init '); 
        debugger;
       var action=component.get('c.getSearchOptions');
        action.setCallback(this,function(response)
         {
             debugger;
             var state = response.getState();
             if (state === "SUCCESS")
             {
                 debugger;
                 console.log('inside success state');
                 component.set('v.searchOptionToIdMap',response.getReturnValue());
                 var custs = [];
                 var conts = response.getReturnValue();
                 for(var key in conts)
                 {
                    console.log('populated list');
                    // custs.push({value:conts[key], key:key});
                    custs.push(key);
                     
                 }
                  console.log("options............"+custs[1]);
                 component.set("v.searchOptions", custs);
             }
             
         }); 
           $A.enqueueAction(action);
    }, 
    onFormSubmit : function (component, event, helper) {
      
         var typeName = component.find('typeSelect').get('v.value');
                    var typeMap = component.get('v.searchOptionToIdMap');
                    var typeId = null;
                    if (typeName && typeMap && typeMap[typeName]) 
                    {
                            typeId = typeMap[typeName];
                    }else{
                        typeId='';
                    }
        var compEvents = component.getEvent("formsubmit");// getting the Instance of event
        compEvents.setParams({"formData":
                              {"boatTypeId" : typeId}});// setting the attribute of event
        compEvents.fire();// firing the event.
        
    },
	  createBoat: function (component, event, helper) 
     {
            console.log('inside controller');
            var createRecordEvent = $A.get('e.force:createRecord');
            if (createRecordEvent) 
            {
                    var typeName = component.find('typeSelect').get('v.value');
                    var typeMap = component.get('v.searchOptionToIdMap');
                    var typeId = null;
                    if (typeName && typeMap && typeMap[typeName]) 
                    {
                            typeId = typeMap[typeName];
                    }
                    createRecordEvent.setParams({
                        'entityApiName': 'Boat__c',
                        'defaultFieldValues': {
                            'BoatType__c': typeId
                        }
                    });
                    createRecordEvent.fire();
            }
          var createRecordEvent = $A.get('e.force:createRecord');
           if (createRecordEvent) {
              component.set('v.showNewButton', false);
    }
       }
})