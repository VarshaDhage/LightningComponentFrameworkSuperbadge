({
    afterScriptsLoaded : function(component, event, helper) {
        // var domEl = [get dom element of rating area]
        // var currentRating = [get value attribute of component]
        // var readOnly = [get readonly attribute of component]
        var domEl = component.find("ratingarea").getElement();
        var currentRating = component.get('v.value');
        var readOnly = component.get('v.readonly');
        var maxRating = 5;
        component.ratingObj = rating(domEl,currentRating,maxRating,callback,readOnly); 
        
        var callback = function(rating) {
            component.set('v.value',rating);
        }
        
        },
    onValueChange: function(component,event,helper) {
        if (component.ratingObj) {
            var value = component.get('v.value');
            component.ratingObj.setRating(value,false);
        }
        
    }
    
})