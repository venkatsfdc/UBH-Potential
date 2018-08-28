public without sharing class AccountTriggerHandler {
    
    public void OnBeforeInsert(Account[] newAccounts) {
        // EXECUTE BEFORE INSERT LOGIC
        populateNumberOfContacts(newAccounts);
    }

    public void OnAfterInsert(Account[] newAccounts) {
        // AFTER INSERT LOGIC
    }

    public void OnBeforeUpdate(Account[] oldAccounts, Account[] updatedAccounts, Map<ID, Account> newMap, Map<ID, Account> oldMap) {
        // EXECUTE BEFORE UPDATE LOGIC
        populateNumberOfContacts(updatedAccounts);       
    }

    public void OnAfterUpdate(Account[] oldAccounts, Account[] updatedAccounts, Map<ID, Account> newMap, Map<ID, Account> oldMap) {
        // AFTER UPDATE LOGIC
    }

    public void OnBeforeDelete(Account[] accountsToDelete, Map<ID, Account> oldMap) {
        // BEFORE DELETE LOGIC
    }

    public void OnAfterDelete(Account[] deletedAccounts, Map<ID, Account> oldMap) {
        // AFTER DELETE LOGIC
    }

    public void OnUndelete(Account[] restoredAccounts) {
        // AFTER UNDELETE LOGIC
    }
    
    private void populateNumberOfContacts(Account[] newAccounts){
        set<Id> accountIds = new set<Id>();
        for(Account acc:newAccounts){
            accountIds.add(acc.Id);
        }
        List<Contact> ContactList = new List<Contact>([Select Id, accountId, LastName From Contact 
                                                      	Where accountId IN :accountIds]);
        
        for(Account acc:newAccounts){
            if(acc.Number_of_Contacts__c != ContactList.size()){
                acc.Number_of_Contacts__c = ContactList.size();
            }
        }
        
    }

}