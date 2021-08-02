public with sharing class AlocacaoBatalhaController {
    
    @AuraEnabled
    public static List<BatalhaContato__c> getBatalhas(){
        return [select id, Contato__r.NomeGuerra__c, Contato__r.RecordType.Name, Batalha__r.Name, Batalha__r.StatusBatalha__c from BatalhaContato__c limit 100 ];
    }
}
