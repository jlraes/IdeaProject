public class TestDataFactory {
    //SELECT Id, IsDeleted, ParentId, Type, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp FROM Vote where ParentId='087560000008TVWAA2'
    // Type = Down or Type = Up
    // 
    // PROJECT 1 : CommunitIdeaApp => Preview (? Origin ?)
    // PROJECT 2 : Tab Idea (permissionset to be added => can tab visibility be set here ?)
    //TestDataFactory.createListUsers(3);
    //TestDataFactory.createListIdeas(100);
    //TestDataFactory.createListIdeaComments(1000); // 10 per idea
    
    public static void createTestData(){
        //Test_PSR_TestingUtil.createIdea('Some Title');
        createListIdeas(50);
    }
    
    public static void createTestUsers() {
        createListUsers(99999999);
    }
    
    // Step 1
    public static void createListUsers(Integer NumberOfUsers){
        List<User> ListUsers = new List<User>();
        for(integer i=0;i<NumberOfUsers;i++) {
            ListUsers.add(Test_PSR_TestingUtil.createUser(i));
        }
        
        Database.insert(ListUsers);
        assignPermissionSet(ListUsers);
        
    }
    
    private static void assignPermissionSet(List<User> ListUsers){
        Id PermissionSetId = Test_PSR_TestingUtil.getPermissionSet();
        List<PermissionSetAssignment> ListPermissionSetAssignment = new List<PermissionSetAssignment>();        
        for (User user : ListUsers) {
            PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = PermissionSetId, AssigneeId = user.Id);
            ListPermissionSetAssignment.add(psa);
        }
        Database.insert(ListPermissionSetAssignment); 
    }
    
    public static void createListIdeas(Integer NumberOfIdeas){
        List<Idea> ListIdeas = new List<Idea>();
        List<Id> ListCommunityIdeas = Test_PSR_TestingUtil.getCommunityIds();
        
        for (ID CommunityId : ListCommunityIdeas) {
            for(integer i=0;i<NumberOfIdeas/ListCommunityIdeas.Size();i++) {
                ListIdeas.add(Test_PSR_TestingUtil.createIdea('Some Title ' + i, CommunityId));
            }
            
        }
        Database.insert(ListIdeas);
        
        // add comments
        //createListIdeaComments(10, ListIdeas);
        
    }
    
    public static void createListIdeaComments(Integer NumberOfIdeaComments){
        List<Idea> ListIdeas = Database.query(Test_PSR_TestingUtil.getListIdeas());
        createListIdeaComments(NumberOfIdeaComments, ListIdeas);
    }
    
    private static void createListIdeaComments(Integer NumberOfIdeaComments, List<Idea> ListIdeas){
        System.Debug('TestDataFactory.createListIdeaComments -  NumberOfIdeaComments: ' + NumberOfIdeaComments);
        System.Debug('TestDataFactory.createListIdeaComments -  ListIdeas.size: ' + ListIdeas.size());
        Integer NumberOfIdeaCommentsPerIdea = NumberOfIdeaComments / ListIdeas.Size() ;
        System.Debug('TestDataFactory.createListIdeaComments -  NumberOfIdeaCommentsPerIdea: ' + NumberOfIdeaCommentsPerIdea);
        List<IdeaComment> ListIdeaComments = new List<IdeaComment>();
        for (Idea IdeaObject : ListIdeas) {
            for (integer i=0;i<NumberOfIdeaCommentsPerIdea;i++) {
                ListIdeaComments.add(Test_PSR_TestingUtil.createIdeaComment('Comment number: ' + i, IdeaObject));
            }
            
        }
        System.debug('TestDataFactory.createListIdeaComments - about to insert IdeaComments: ' + ListIdeaComments.size());
        Database.insert(ListIdeaComments);
    }
    
    
}