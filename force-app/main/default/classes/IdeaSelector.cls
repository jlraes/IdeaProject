public class IdeaSelector {
    private static void getSample() {
        String myTestString = 'TestName';
		List<sObject> sobjList = Database.query('SELECT Id FROM MyCustomObject__c WHERE Name = :myTestString');
    }
    
    
    public static List<Idea> AllIdeasByCommunityId(String CommunityId){
        List<Idea> ideasList = new List<Idea>();
        ideasList = Database.query(getBaseSelect() + ' Where CommunityId=:CommunityId LIMIT 50000');
        
        return ideasList;
    }
    public static List<Idea> AllTopIdeas(String CommunityId){
        List<Idea> ideasList = new List<Idea>();
        ideasList = Database.query(getBaseSelect() + ' Where CommunityId=:CommunityId AND VoteTotal>=150 LIMIT 50000');
        return ideasList;
    }

    public static List<Idea> AllRecentIdeas(String CommunityId){
        List<Idea> ideasList = new List<Idea>();
        ideasList = Database.query(getBaseSelect() + ' Where CommunityId=:CommunityId AND LastViewedDate=THIS_WEEK LIMIT 50000');
        //ideasList = [Select Id, Title,IsHtml,Body,CommunityId,CreatorName, LastViewedDate, NumComments, CreatedDate From Idea Where LastViewedDate=THIS_WEEK AND CommunityId=:CommunityId LIMIT 50000];
        return ideasList;
    }
    
    private static String getBaseSelect(){
        //String SelectClause = 'Select Id, Title,IsHtml,Body,CommunityId,CreatorName, NumComments, CreatedDate From Idea';
        //String SelectClause = 'Select Id, Title,IsHtml,Body,CommunityId,CreatorName, LastViewedDate, NumComments, CreatedDate, VoteTotal From Idea';
        String SelectClause = 'Select Id, Title,IsHtml,Body,CommunityId,CreatorName, LastViewedDate, NumComments, '; 
        SelectClause += 'CreatedDate, VoteScore, VoteTotal, ';
        SelectClause += '(Select Id, ParentId, Type, CreatedDate, CreatedById ';
        //SelectClause += 'From Votes where CreatedById =: userinfo.getuserid()) From Idea';
        SelectClause += 'From Votes where CreatedById = \'' + userinfo.getuserid() + '\') From Idea';
        return SelectClause;
    }
    
    /*SELECT Id, Title, Status, RecordTypeId, CreatedById, CreatedDate, CreatorName,
                        CreatorSmallPhotoUrl, Body, Categories, NumComments, VoteScore, VoteTotal,
                        (Select Id, ParentId, Type, CreatedDate, CreatedById From Votes where CreatedById =: userinfo.getuserid()) 
                        FROM Idea 
                        WHERE IsDeleted = false AND CommunityId = :selectedZone
    
    */
}