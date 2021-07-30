public class ContactTriggerHandler {

    public void onBeforeInsert(List<Contact> newRecords){
        System.debug('<<< ');
    }
    public void onBeforeUpdate(List<Contact> newRecords, Map<Id, Contact> mapOld){
        System.debug('<<< Before Update');
        for(Contact contato : newRecords){
            System.debug('<<<Before Contato new LastmodifiedDate' + contato.LastModifiedDate);
            System.debug('<<< Contato new' + contato);
            System.debug('<<< Contato old' + mapOld.get(contato.id));
        }
    }
    public void onAfterInsert(List<Contact> newRecords){
        System.debug('>>> After Insert <<');
        
        ContactTriggerHelper.criaTarefaParaEncontrarFraquezas(newRecords);
    }
    public void onAfterUpdate(List<Contact> newRecords, Map<Id, Contact> mapOld){
        
    }
    
    public void onBeforeDelete(List<Contact> oldRecords, Map<Id, Contact> oldMap){
        ContactTriggerHelper.naoPermiteApagarEnquantoHouverTaskAberta(oldRecords, oldMap);
    }
}