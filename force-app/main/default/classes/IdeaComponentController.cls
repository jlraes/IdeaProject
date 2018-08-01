public with sharing class IdeaComponentController {
    @AuraEnabled
    public static List<Idea> AllIdeas(String CommunityId){
        List<Idea> ideasList = new List<Idea>();
        
        IF(CommunityId=='None' || CommunityId=='undefined' || CommunityId==null){
            List<Community> idealst = new List<Community>();
            if(Schema.sObjectType.Community.fields.ID.isAccessible()&&
               Schema.sObjectType.Community.fields.IsActive.isAccessible()&&
               Schema.sObjectType.Community.fields.Name.isAccessible())
                idealst =[Select Id, Name From Community WHERE IsActive=true Order By CreatedDate ASC LIMIT 1];
            if(idealst!=null && idealst.size()>0) CommunityId = idealst[0].id;
            
        }
        System.debug('CommunityId '+CommunityId);
        if(hasAccess()){
            //ideasList = [Select Id, Title,IsHtml,Body,CommunityId,CreatorName, NumComments, CreatedDate From Idea Where CommunityId=:CommunityId LIMIT 50000];
            ideasList = IdeaSelector.AllIdeasByCommunityId(CommunityId);
        }
        return ideasList;
    }
    
    @AuraEnabled
    public static List<Idea> AllIdeasByCommunityId(String CommunityId){
        List<Idea> ideasList = new List<Idea>();
        if(hasAccess()){
            //ideasList = [Select Id, Title,IsHtml,Body,CommunityId,CreatorName, NumComments, CreatedDate From Idea Where CommunityId=:CommunityId LIMIT 50000];
            ideasList = IdeaSelector.AllIdeasByCommunityId(CommunityId);
        }
        return ideasList;
    }
    
    @AuraEnabled
    public static List<Idea> AllTopIdeas(String CommunityId){
        List<Idea> ideasList = new List<Idea>();
        IF(CommunityId=='None' || CommunityId=='undefined' || CommunityId==null){
            List<Community> idealst = new List<Community>();
            IF(Schema.sObjectType.Community.fields.ID.isAccessible()&&
               Schema.sObjectType.Community.fields.IsActive.isAccessible()&&
               Schema.sObjectType.Community.fields.Name.isAccessible())
                idealst =[Select Id, Name From Community WHERE IsActive=true Order By CreatedDate ASC LIMIT 1];
            if(idealst!=null && idealst.size()>0) CommunityId = idealst[0].id;
        }
        
        if(hasAccess()){
            //   ideasList = [Select Id, Title,IsHtml,Body,CommunityId,CreatorName, NumComments, CreatedDate From Idea Where VoteTotal>=150 AND CommunityId=:CommunityId LIMIT 50000];
            ideasList = IdeaSelector.AllTopIdeas(CommunityId);
        }
        
        return ideasList;
    }
    
    @AuraEnabled
    public static List<String> CommunityForIdea(){
        List<String> allComminuties = new List<String>();
        List<Community> idealst = new List<Community>();
        IF(Schema.sObjectType.Community.fields.ID.isAccessible()&&
           Schema.sObjectType.Community.fields.IsActive.isAccessible()&&
           Schema.sObjectType.Community.fields.Name.isAccessible())
            idealst =[Select Id, Name,IsActive From Community WHERE IsActive=true ];  
        For(Community s : idealst){
            allComminuties.add(s.Id+'####'+s.Name);
        }
        return allComminuties;
    }
    
    @AuraEnabled
    public static List<Idea> AllRecentIdeas(String CommunityId){
        List<Idea> ideasList = new List<Idea>();
        system.debug('CommunityId '+CommunityId);
        IF(CommunityId=='None' || CommunityId=='undefined' || CommunityId==null){
            List<Community> idealst = new List<Community>();
            IF(Schema.sObjectType.Community.fields.ID.isAccessible()&&
               Schema.sObjectType.Community.fields.IsActive.isAccessible()&&
               Schema.sObjectType.Community.fields.Name.isAccessible())
                idealst = [Select Id, Name From Community WHERE IsActive=true Order By CreatedDate ASC LIMIT 1];
            if(idealst!=null && idealst.size()>0) CommunityId = idealst[0].id;
        }
        
        if(hasAccess()){
            // ideasList = [Select Id, Title,IsHtml,Body,CommunityId,CreatorName, LastViewedDate, NumComments, CreatedDate From Idea Where LastViewedDate=THIS_WEEK AND CommunityId=:CommunityId LIMIT 50000];
            ideasList = IdeaSelector.AllRecentIdeas(CommunityId);
        } 
        
        return ideasList;
    }
    
    @AuraEnabled
    public static List<IdeaComment> AllIdeaComments(String CommunityId){
        List<IdeaComment> ideaCommentList = new List<IdeaComment>();
        Set<Id> ideasIdsSet = new Set<Id>();
        System.debug('CommunityId '+CommunityId);
        IF(CommunityId!='None' && CommunityId!='undefined' && CommunityId!=null){
            if(Schema.SObjectType.IdeaComment.isQueryable()&& 
               Schema.sObjectType.IdeaComment.fields.Id.isAccessible() &&
               Schema.sObjectType.IdeaComment.fields.CommentBody.isAccessible() &&
               Schema.sObjectType.IdeaComment.fields.UpVotes.isAccessible() &&
               Schema.sObjectType.IdeaComment.fields.CreatorName.isAccessible() &&
               Schema.sObjectType.IdeaComment.fields.IdeaId.isAccessible()){
                   ideaCommentList = [Select Id, CommentBody,CreatorName,CreatedDate, IdeaId,Idea.NumComments, Idea.Title From IdeaComment Where CommunityId=:CommunityId LIMIT 50000];
               }
        }else{
            List<Community> idealst = new List<Community>();
            IF(Schema.sObjectType.Community.fields.ID.isAccessible()&&
               Schema.sObjectType.Community.fields.IsActive.isAccessible()&&
               Schema.sObjectType.Community.fields.Name.isAccessible())
                idealst =[Select Id, Name,IsActive From Community WHERE IsActive=true ];  
            For(Community s : idealst ){
                ideasIdsSet.add(s.Id);
            }
            if(Schema.SObjectType.IdeaComment.isQueryable()&& 
               Schema.sObjectType.IdeaComment.fields.Id.isAccessible() &&
               Schema.sObjectType.IdeaComment.fields.CommentBody.isAccessible() &&
               Schema.sObjectType.IdeaComment.fields.UpVotes.isAccessible() &&
               Schema.sObjectType.IdeaComment.fields.CreatorName.isAccessible() &&
               Schema.sObjectType.IdeaComment.fields.IdeaId.isAccessible()){
                   ideaCommentList = [Select Id, CommentBody,CreatorName,CreatedDate, IdeaId,Idea.NumComments, Idea.Title From IdeaComment Where CommunityId=:ideasIdsSet LIMIT 50000];
               }
        }
        return ideaCommentList;
    }
    private static boolean hasAccess(){
        return Schema.SObjectType.Idea.isQueryable() && 
            Schema.sObjectType.Idea.fields.ID.isAccessible() &&
            Schema.sObjectType.Idea.fields.Title.isAccessible() &&
            Schema.sObjectType.Idea.fields.Body.isAccessible()&&
            Schema.sObjectType.Idea.fields.Categories.isAccessible() &&
            Schema.sObjectType.Idea.fields.CreatorName.isAccessible() &&
            Schema.sObjectType.Idea.fields.NumComments.isAccessible() &&
            Schema.sObjectType.Idea.fields.CommunityId.isAccessible() &&
            Schema.sObjectType.Idea.fields.CreatedDate.isAccessible();
    }
    
    /*Promote an Idea*/
    @AuraEnabled
    public static String promoteIdea(String IdeaId) {
        List<Idea> recentIdeas = new List<Idea>();
        try {
            Vote newVote = new Vote();
            newVote.Type = 'Up';
            newVote.ParentId = IdeaId;
            insert newVote;
            
        } catch (Exception e) {
            System.debug(e);
        }
        return 'Idea Promoted';
    }
    
    /*Promote an Idea from IdeaDetails page*/
    @AuraEnabled
    public static Idea promoteFromIdeaDetails(String IdeaId) {
        try {
            Vote newVote = new Vote();
            newVote.Type = 'Up';
            newVote.ParentId = IdeaId;
            insert newVote;
            
        } catch (Exception e) {
            System.debug(e);
        }
        return getIdea(IdeaId);
    }
    
    /*Demote an Idea*/
    @AuraEnabled
    public static String demoteIdea(String IdeaId) {
        List<Idea> recentIdeas = new List<Idea>();
        try {
            Vote newVote = new Vote();
            newVote.Type = 'Down';
            newVote.ParentId = IdeaId;
            insert newVote;
            
        } catch (Exception e) {
            System.debug(e);
        }
        return 'Idea Demoted';
    }
    
    /*Demote an Idea from IdeaDetails page*/
    @AuraEnabled
    public static Idea demoteFromIdeaDetails(String IdeaId) {
        try {
            Vote newVote = new Vote();
            newVote.Type = 'Down';
            newVote.ParentId = IdeaId;
            insert newVote;
            
        } catch (Exception e) {
            System.debug(e);
        }
        return getIdea(IdeaId);
    }
    
    /*Get an Idea*/
    @AuraEnabled
    public static Idea getIdea(String IdeaId) {
        Idea thisidea = null;
        try {
            thisIdea = [
                SELECT 
                Id,
                Title,
                Status,
                RecordTypeId,
                CreatedById,
                CreatedDate,
                CreatorName,
                CreatorSmallPhotoUrl,
                Body,
                Categories,
                NumComments,
                VoteScore,
                VoteTotal,
                (Select Id, ParentId, Type, CreatedDate, CreatedById From Votes where CreatedById =: userinfo.getuserid()),
                (Select Id, CommentBody, CreatedBy.Name, CreatedDate, UpVotes From Comments where IsDeleted = false order by CreatedDate)
                FROM 
                Idea 
                WHERE 
                Id = :IdeaId
                LIMIT 1
            ];
        } catch (Exception e) {
            System.debug(e);
        }
        system.debug('****** thisIdea: '+thisIdea);
        return thisIdea;
    }
    
    
}