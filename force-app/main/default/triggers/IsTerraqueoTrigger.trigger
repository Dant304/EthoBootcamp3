trigger IsTerraqueoTrigger on Contact (before update, before insert) {

    if(Trigger.isUpdate || Trigger.isInsert){
        
        for(Contact c : trigger.new){
            if(c.IsTerraqueo__c == true){
				c.PlanetaOrigem__c = 'Terra';
                System.debug('Insert contato teste');
            }
        }

    }
    
    
}