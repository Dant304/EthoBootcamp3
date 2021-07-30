trigger HabilidadeContatoTrigger on HabilidadeContato__c (before insert, before update, after insert, after update, before delete, after delete) {
	
    new HabilidadeContatoTriggerHandler().run();
    
}