/**
 * Created by nsanvell on 12/1/2021.
 */

@IsTest
public class UserTriggerHandlerTest {
    @IsTest
    static void testStreetAddressChanged() {

        Map<Id, User> updateUserList = new Map<Id, User>();

        //retrieving the user record of the current user
        User runningUser = [Select Id From User Where Id =:UserInfo.getUserId()];

        //To prevent the mixed DML error running the code in the current user's context
        System.runAs(runningUser){

            //create test data
            testUtilities.testSetup();


            //retrieving the users created in the test class and iterating over the list to update street address
            for(User userRec : [SELECT Id, ContactId From User where Lastname LIke '%TestUser%' LIMIT 100]){
                User updateUser = new User(Id = userRec.Id, Street = '400 South Jefferson Street');
                updateUserList.put(userRec.contactId, updateUser);
            }

            //updating the street address on the user records
            update updateUserList.values();

            ///retrieving the contacts to check if the street address is updated
            List<Contact> updatedContsctsList = [SELECT Id, MailingStreet From Contact Where Id IN :updateUserList.keySet()];

            //iterating over the contacts list to check if the street address on Contact is same as the User
            for(Contact c : updatedContsctsList){
                System.AssertEquals(updateUserList.get(c.Id).Street, c.MailingStreet, 'Street address on Contact is same as the street address on User');
            }
        }

    }
}