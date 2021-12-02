/**
 * Created by nikitha sanvelli on 11/30/2021.
 */

public with sharing class UserTriggerHandler {


    public static void afterUpdate(Map<Id, User> oldMap, Map<Id, User> newMap){
        List<Contact> updateContactList = new List<Contact>();
        //Iterate over new values
        for(User userRec :newMap.values()){
            //checking if contact lookup is not empty and the street address on the User record is different than the current value
            if(userRec.ContactId != null && userRec.Street != oldMap.get(userRec.Id).Street){
                Contact contactRec = new Contact(Id = userRec.ContactId, MailingStreet = userRec.Street);
                updateContactList.add(contactRec);
            }
        }
        
        // Update the contacts only if the list is non-empty
        // Checking the list to be non-empty can be skipped as Salesforce now handles DML operations on empty lists automatically,
        // and doesn't count the DML Operation against Governor limits
        if(!updateContactList.isEmpty()){ 
            update updateContactList;
        }

    }
}
