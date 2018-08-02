public class Test_PSR_TestingUtil {
    
    public static Idea createIdea(String Title, Id CommunityId){
        // create instance of idea object
        Idea idea             =  new Idea(Title=Title);
        idea.Status = 'New';
        idea.Categories = ('360 Online;360 Connect');
        idea.CommunityId = CommunityId;
        return idea;
    }
    
    public static string getListIdeas() {
        String soql = 'select Id, Status, Categories, CommunityId from Idea';
        return soql;
    }
    
    public static IdeaComment createIdeaComment(String Comment, Idea idea){
        // create instance of idea object
        IdeaComment ideaComment             =  new IdeaComment(CommentBody = Comment);
        ideaComment.IdeaId = idea.id;
        // ideaComment.CommentBody = Comment;
        return ideaComment;
        //SELECT Id, IdeaId, IsHtml, UpVotes, CreatorName, CommentBody, CommunityId FROM IdeaComment
    }
    
    public static User createUser(Integer index){
        // System Administrator (5)
        // Company Communities User (10)
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'last' + index,
            Email = 'p.user000@example.com',
            Username = 'p.user000@dummy.example.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
            // , UserRoleId = r.Id
        );
        return u;
    }
    
    public static List<Id> getCommunityIds() {
        List<Id> ListIds = new List<Id>();
        
        List<Community> ListCommunities = [SELECT Id, Name, Description, NetworkId FROM Community where Name = 'Tracker Ideas' ];
        
        for (Community CommunityRecord : ListCommunities) {
            ListIds.add(CommunityRecord.Id);
        }
        return ListIds;   
    }

    public static Id getPermissionSet() {
        Id id ;
        
        List<PermissionSet> ListPermissionSets = [SELECT Id, Name, Label FROM PermissionSet where Name = 'Idea_Tracker' ];
        if (ListPermissionSets.size() > 0) {
            id = ListPermissionSets[0].Id;
        }
        return id;   
    }
    /*
private static Id getRecordTypeId() {
Id id ='';

List<Community> ListCommunities = [SELECT Id, Name FROM RecordType where Name = 'Tracker Ideas' ];
if (ListCommunities.size() > 0) {
id = ListCommunities[0].Id;
}
return id;   
}
*/
    
}