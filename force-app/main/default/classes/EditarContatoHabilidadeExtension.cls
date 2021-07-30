public with sharing class EditarContatoHabilidadeExtension {
    private Contact contato;

    public List<HabilidadeContato__c> habilidades {get; private set;}

    public EditarContatoHabilidadeExtension(ApexPages.StandardController controller ) {
        this.contato = (Contact) controller.getRecord();
        this.habilidade = [select id, habilidade__r.Name, NivelHabilidade__c from HabilidadeContato__c where Contato__c = :this.contato.id];
    }
}
