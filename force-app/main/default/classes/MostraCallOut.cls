public class MostraCallOut {

    public static void doCallOut(){
        
        Lead lead = new Lead();
        lead.FirstName = 'Bruce';
        lead.LastName = 'Wayne';
        lead.NomeGuerra__c = 'Batman';
        lead.Email  = 'batman' + '@marvel.com';
        lead.LeadSource  = 'Importado pela Marvel API';
        lead.NivelHeroi__c = 'Aspirante';
        
        insert lead;
        
        CallOutMarvel.getPersonagens();
    }
}