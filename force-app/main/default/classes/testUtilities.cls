/**
 * Created by nsanvell on 11/30/2021.
 */

@IsTest
global class testUtilities {

    @TestSetup
    public static void testSetup(){
        List<Account> accList = new List<Account>();
        for(Integer i = 0 ; i < 100 ; i++){
            Account temp = new Account(Name = 'Test Acc ' + i);
            accList.add(temp);
        }
        insert accList;

        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0 ; i < accList.size() ; i++){
            Contact temp = new Contact(LastName = 'Test Contact ' + i, AccountId = accList[i].Id);
            contactList.add(temp);
        }
        insert contactList;

        List<User> usersList = new List<User>();
        Profile p = [SELECT Id FROM Profile Where Name = 'Customer Community Plus User' LIMIT 1];
        for(Integer i = 0 ; i < contactList.size() ; i++){
            User usr = new User();
            usr.emailencodingkey = 'UTF-8';
            usr.languagelocalekey = 'en_US';
            usr.localesidkey = 'en_US';
            usr.timezonesidkey = 'America/Los_Angeles';
            usr.ProfileId = p.Id;
            usr.alias = 'Test' + i;
            usr.email = 'TestUser' + i + '@gmail.com';
            usr.lastname = 'TestUser' + i;
            usr.username = 'TestUser' + i + '@gmail.com';
            usr.Street = '200 North Jefferson Street';
            usr.City = 'Milwaukee';
            usr.State = 'WI';
            usr.PostalCode = '53202';
            usr.Country = 'USA';
            usr.contactId = contactList[i].Id;

            usersList.add(usr);
        }
        insert usersList;
    }

}