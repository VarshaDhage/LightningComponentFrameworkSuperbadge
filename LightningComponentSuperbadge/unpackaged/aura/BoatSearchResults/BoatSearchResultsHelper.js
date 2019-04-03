({
 onSearch : function(component,event,helper){
   
         component.set('v.boats',null);
        var action = component.get("c.getBoats");
        action.setParams({
            boatTypeId : component.get('v.boatTypeId')
        });
          action.setCallback(this,function(response)
         {
              var state = response.getState();
             if (state === "SUCCESS")
             {
                 debugger;
                 console.log('inside success state');
                 component.set('v.boats',response.getReturnValue());
                
             }
         });
         $A.enqueueAction(action);
    }
})