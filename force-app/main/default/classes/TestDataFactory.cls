public class TestDataFactory {
//SELECT Id, IsDeleted, ParentId, Type, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp FROM Vote where ParentId='087560000008TVWAA2'
// Type = Down or Type = Up
// 
// PROJECT 1 : CommunitIdeaApp => Preview (also in RDJLR sandbox ?)
// PROJECT 2 : Tab Idea (permissionset to be added => can tab visibility be set here ?)
    
    
    public static void createTestData(){
        //Test_PSR_TestingUtil.createIdea('Some Title');
        createListIdeas(50);
    }
    
    public static void createTestUsers() {
        createListUsers(99999999);
    }
    
    public static void createListUsers(Integer NumberOfUsers){
        List<User> ListUsers = new List<User>();
        ListUsers.add(Test_PSR_TestingUtil.createUser());
        Database.insert(ListUsers);
    }
    
    public static void createListIdeas(Integer NumberOfIdeas){
        List<Idea> ListIdeas = new List<Idea>();
        for(integer i=0;i<NumberOfIdeas;i++) {
            ListIdeas.add(Test_PSR_TestingUtil.createIdea('Some Title ' + i));
        }
        Database.insert(ListIdeas);
        
        // add comments
        createListIdeaComments(10, ListIdeas);
        
    }

    
    private static void createListIdeaComments(Integer NumberOfIdeaComments, List<Idea> ListIdeas){
        List<IdeaComment> ListIdeaComments = new List<IdeaComment>();
        for (Idea IdeaObject : ListIdeas) {
            for (integer i=0;i<NumberOfIdeaComments;i++) {
                ListIdeaComments.add(Test_PSR_TestingUtil.createIdeaComment('Comment number: ' + i, IdeaObject));
            }
            
        }
        Database.insert(ListIdeaComments);
    }
    
    
}