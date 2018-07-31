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
    },
    promoteAnIdea : function(component, event, helper){
        console.log('IdeaItemController - promoteAnIdea - about to trigger event.');
        var idea = component.get("v.IdeaRecord");
        var viewIdeaEvent = component.getEvent("PromoteIdeaEvent");
        viewIdeaEvent.setParams({ "IdeaRecord" : idea });
        viewIdeaEvent.fire();
        console.log('IdeaItemController - promoteAnIdea - event triggered.');
    },
    demoteAnIdea : function(component, event, helper){
        console.log('IdeaItemController - demoteAnIdea - about to trigger event.');
        var idea = component.get("v.IdeaRecord");
        var viewIdeaEvent = component.getEvent("DemoteIdeaEvent");
        viewIdeaEvent.setParams({ "IdeaRecord" : idea });
        viewIdeaEvent.fire();
        console.log('IdeaItemController - demoteAnIdea - event triggered.');
    }
})