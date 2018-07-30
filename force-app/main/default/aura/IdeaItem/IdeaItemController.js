({
    doInit : function(component, event, helper) {
		console.log('IdeaItemController - doInit');
        console.log(component.get("v.IdeaRecord"));
        
    },
    viewIdea : function(component, event, helper){
        console.log('IdeaItemController - viewIdea - about to trigger event.');
        var idea = component.get("v.IdeaRecord");
        var viewIdeaEvent = component.getEvent("ViewIdeaEvent");
        viewIdeaEvent.setParams({ "IdeaRecord" : idea });
        viewIdeaEvent.fire();
        console.log('IdeaItemController - viewIdea - event triggered.');
    }
})