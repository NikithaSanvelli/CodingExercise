/**
 * Created by nsanvell on 11/30/2021.
 */

public with sharing class UserTriggerHandler {


    public static void afterUpdate(Map<Id, User> oldMap, Map<Id, User> newMap){
        List<Contact> updateContactList = new List<Contact>();
        //Iterate over new values
        for(User userRec :newMap.values()){
            //checking if contact lookup is not empty and the street address on the User record is changed
            if(userRec.ContactId != null && userRec.Street != oldMap.get(userRec.Id).Street){
                Contact contactRec = new Contact(Id = userRec.ContactId, MailingStreet = userRec.Street);
                updateContactList.add(contactRec);
            }
        }
        //checking if the list is empty
        if(!updateContactList.isEmpty()){
            update updateContactList;
        }

    }
}