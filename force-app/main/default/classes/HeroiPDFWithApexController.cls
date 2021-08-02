public with sharing class HeroiPDFWithApexController {

    public Contact contato {get; set;}

    public HeroiPDFWithApexController() {
        Id contactId = ApexPages.currentPage().getParameters().get('id');

        this.contato = [select id, Name, NomeGuerra__c, NivelHeroi__c, StatusCandidato__c, FeedbackTreinamento__c,
                        (select Habilidade__r.Name, NivelHabilidade__c from HabilidadesContato__r order by NivelHabilidade__c),
                        (select Id, Batalha__r.Name, Batalha__r.Descricao__c, Batalha__r.DataInicio__c, Batalha__r.DataTermino__c from Batalhas_do_Contato__r)
                        from Contact where Id = :contactId];


    }
 

}
