public class HabilidadeContatoTriggerHandler extends TriggerHandler {

    private List<HabilidadeContato__c> newList;
    private List<HabilidadeContato__c> oldList;
    private Map<Id, HabilidadeContato__c> newMap;
    private Map<Id, HabilidadeContato__c> oldMap;

    public HabilidadeContatoTriggerHandler() {
       this.newList = (List<HabilidadeContato__c>) Trigger.new;
       this.oldList = (List<HabilidadeContato__c>) Trigger.old;
       this.newMap = (Map<Id, HabilidadeContato__c>) Trigger.newMap;
       this.oldMap = (Map<Id, HabilidadeContato__c>) Trigger.oldMap;

       if(this.oldList == null) this.oldList = new List<HabilidadeContato__c>();
       if(this.oldMap == null) this.oldMap = new Map<Id, HabilidadeContato__c>();
   }
      
   protected override void beforeInsert() {   
   }
    
   protected override void beforeUpdate() {   
   }
    
   protected override void beforeDelete() {   
   }
    
   protected override void afterInsert() {
       //System.debug('>>>>> AFTER INSERT: ENTROU NA TRIGGER ');
       new AtualizaRankingHabilidadeTrigger(newList, oldMap).run();
   }
     
   protected override void afterUpdate() {
       //System.debug('>>>>> AFTER UPDATE: ENTROU NA TRIGGER ');
       new AtualizaRankingHabilidadeTrigger(newList, oldMap).run();
   }
    
   protected override void afterDelete() {
       //System.debug('>>>>> AFTER DELETE: ENTROU NA TRIGGER');
       new AtualizaRankingHabilidadeTrigger(newList, oldMap).run();
   }
    
}