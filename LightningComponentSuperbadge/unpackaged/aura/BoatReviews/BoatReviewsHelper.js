({
	onInit : function(component, event, helper) {
        var action= component.get('c.getAll');
        console.log('In init '+component.get('v.boat.Id'));
		 action.setParams({
            boatId : component.get('v.boat.Id')
        });
          action.setCallback(this,function(response)
         {
              var state = response.getState();
             if (state === "SUCCESS")
             {
                 debugger;
                 console.log('inside success boatReviews state');
                 component.set('v.boatReviews',response.getReturnValue());
                 console.log('hiiiiiiiii '+component.get('v.boatReviews')[0]);
             }
         });
         $A.enqueueAction(action); 
    }
})