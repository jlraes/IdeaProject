({
    recentIdeas : function(component) {
        var action = component.get('c.AllRecentIdeas');
        var pageSize = component.get("v.pageSize");
        component.set('v.isSending',true);
        action.setParams({
            "CommunityId" :  component.find('zone').get('v.value')
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                component.set('v.ideaListToShow',result);
                component.set('v.isSending',false);
                
                component.set("v.totalIdeas", component.get("v.ideaListToShow").length);
                component.set("v.startPage",0);
                component.set("v.endPage",pageSize-1);
                
                var ideaPaginationList = [];
                for(var i=0; i< pageSize; i++)
                {
                    if(component.get("v.ideaListToShow").length> i)
                        ideaPaginationList.push(result[i]);    
                }
                component.set('v.ideaPaginationList', ideaPaginationList);
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    IdeasComment : function(component){
        var action = component.get('c.AllIdeaComments');
        component.set('v.isSending',true);
        action.setParams({
            "CommunityId" :  component.find('zone').get('v.value')
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                component.set('v.ideaCommentToShow',result);
                component.set('v.isSending',false);
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    TopIdeas : function(component){
        var action = component.get('c.AllTopIdeas');
        var pageSize = component.get("v.pageSize");
        component.set('v.isSending',true);
        action.setParams({
            "CommunityId" :  component.find('zone').get('v.value')
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                component.set('v.ideaListToShow',result);
                component.set('v.isSending',false);
                
                component.set("v.totalIdeas", component.get("v.ideaListToShow").length);
                component.set("v.startPage",0);
                component.set("v.endPage",pageSize-1);
                
                var ideaPaginationList = [];
                for(var i=0; i< pageSize; i++)
                {
                    if(component.get("v.ideaListToShow").length> i)
                        ideaPaginationList.push(result[i]);    
                }
                component.set('v.ideaPaginationList', ideaPaginationList);
                
                console.log(result.length);
                if(result.length==0){
                    component.set('v.noIdeas',true);
                }else{
                    component.set('v.noIdeas',false); 
                }
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    closeModal: function(component, event){    
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.removeClass(cmpBack, 'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open'); 
        //$A.get('e.force:refreshView').fire();
    },
    openModal: function(component, event) {
        var eventTarget = event.getSource().getLocalId();
        component.set('v.tabValue',eventTarget);
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open'); 
    },
    updateIdeaList : function(component, communityId){
        if(communityId== undefined || communityId =='' || communityId =='None'){
            var zoneComponent = component.find('zone');
            zoneComponent.set('v.errors',[{message:'Please Select a Valid Community/Zone'}]);
        }else {
            var zoneComponent = component.find('zone');
            zoneComponent.set('v.errors',null);
            var action = component.get('c.AllIdeasByCommunityId');
            var pageSize = component.get("v.pageSize");
            component.set('v.isSending',true);
            action.setParams({
                "CommunityId" : communityId
            });
            action.setCallback(this,function(response){
                var state = response.getState();
                if(state === 'SUCCESS' && component.isValid()){
                    component.set('v.isSending',false);
                    var result = response.getReturnValue();
                    component.set('v.ideaListToShow',result);
                    
                    component.set("v.totalIdeas", component.get("v.ideaListToShow").length);
                    component.set("v.startPage",0);
                    component.set("v.endPage",pageSize-1);
                    
                    var ideaPaginationList = [];
                    for(var i=0; i< pageSize; i++)
                    {
                        if(component.get("v.ideaListToShow").length> i)
                            ideaPaginationList.push(result[i]);    
                    }
                    component.set('v.ideaPaginationList', ideaPaginationList);
                }else if(state === 'ERROR'){
                    console.log(response.error);
                }else{
                    console.log('UNKNOWN ERROR');
                }
            });
            $A.enqueueAction(action);
        }
        
    },
    next : function(component, event){
        var idealist = component.get("v.ideaListToShow");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var PaginationIdealist = [];
        
        var counter = 0;
        for(var i=end+1; i<end+pageSize+1; i++)
        {
            if(idealist.length > i)
            {
                
                PaginationIdealist.push(idealist[i]);
                
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        
        component.set('v.ideaPaginationList', PaginationIdealist);
    },
    previous : function(component, event) 
    {
        var idealist = component.get("v.ideaListToShow");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var PaginationIdealist = [];
        
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++)
        {
            if(i > -1)
            {
                PaginationIdealist.push(idealist[i]);
                counter ++;
            }
            else
            {
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        
        component.set('v.ideaPaginationList', PaginationIdealist);
    },
    displayIdeaOld : function(component, event){
        var idx = event.target.id;
        this.displayIdea(component, idx);
    },
    displayIdea : function(component, IdeaRecordId){
        //var idx = event.target.id;
        var idx = IdeaRecordId;
        console.log('Clicked Idea Id =>'+idx+'  '+component.get('v.CommunitySite'));
        component.set("v.ideaId",idx);
        component.set("v.navigate",true);
        
        var navService = component.find("navService");
        
        var pageReference = {    
            "type": "standard__component",
            "attributes": {
                "componentName": "c__ViewIdea"    
            },    
            "state": {
                ideaId : idx,  
                Community : component.get('v.CommunitySite')
            }
        }
        //navService.navigate(pageReference);
        
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:ViewIdea",
            componentAttributes: {
                ideaId : idx,
                Community : component.get('v.CommunitySite')
            }
        });
        if( component.get('v.CommunitySite') === 'No'){ 
            //navService.navigate(pageReference); 
            evt.fire();
        }
    },
    promoteIdea : function(component, IdeaRecordId){
        var IdeaId = IdeaRecordId;
        var action = component.get("c.promoteIdea");
        action.setParams({"IdeaId" : IdeaId});
        action.setCallback(this, function(response) {
            console.log('Promote: '+response.getReturnValue());
        });
        $A.enqueueAction(action);
        
        //$A.get('e.force:refreshView').fire();
    },  
    // not yet used
    getIdea : function(component, IdeaRecordId){
        var IdeaId = IdeaRecordId;
        var action = component.get("c.getIdea");
        action.setParams({"IdeaId" : IdeaId});
        action.setCallback(this, function(response) {
            console.log('Promote: '+response.getReturnValue());
        });
        $A.enqueueAction(action);
        
        //$A.get('e.force:refreshView').fire();
    },
    displayIdeaTest : function(component, IdeaRecordId){
        //var idx = event.target.id;
        var idx = IdeaRecordId;
        console.log('displayIdeaTest - Clicked Idea Id =>'+idx+'  '+component.get('v.CommunitySite'));
        component.set("v.ideaId",idx);
        component.set("v.navigate",true);

        console.log('displayIdeaTest - about to getIdea');
        var action = component.get("c.getIdea");
        action.setParams({"IdeaId" : idx});
        action.setCallback(this, function(response) {
            var thisIdea = response.getReturnValue();
            console.log('Navigate: '+thisIdea);
            //c:CommunityIdeaDetail
            var evt = $A.get("e.force:navigateToComponent");
            evt.setParams({
                componentDef : "c:IdeaDetail",
                componentAttributes: {
                    ideaId : idx,
                    Community : component.get('v.CommunitySite'),
                    thisIdea : thisIdea,
                    comments : thisIdea.comments
                }
            });
            if( component.get('v.CommunitySite') === 'No'){ 
                //navService.navigate(pageReference); 
                evt.fire();
            }
            
        });
        $A.enqueueAction(action);
        
        
    },
    displayIdeaNavigate : function(component, IdeaRecordId){
        //var idx = event.target.id;
        var idx = IdeaRecordId;
        console.log('Clicked Idea Id =>'+idx+'  '+component.get('v.CommunitySite'));
        component.set("v.ideaId",idx);
        component.set("v.navigate",true);
        
        var navService = component.find("navService");
        
        var pageReference = {    
            "type": "standard__component",
            "attributes": {
                "componentName": "c__ViewIdea"    
            },    
            "state": {
                ideaId : idx,  
                Community : component.get('v.CommunitySite')
            }
        }
        navService.navigate(pageReference);
        /*
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:ViewIdea",
            componentAttributes: {
                ideaId : idx,
                Community : component.get('v.CommunitySite')
            }
        });*/
        if( component.get('v.CommunitySite') === 'No'){ 
            navService.navigate(pageReference); 
            //evt.fire();
        }
    }
    
    
})