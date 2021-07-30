public with sharing class EditarContatoHabilidadeExtension {
    private Contact contato;

    public List<HabilidadeContato__c> habilidades {get; private set;}

    public EditarContatoHabilidadeExtension(ApexPages.StandardController controller ) {
        this.contato = (Contact) controller.getRecord();
        this.habilidades = [select id, habilidade__r.Name, NivelHabilidade__c from HabilidadeContato__c where Contato__c = :this.contato.id];
    }

    public PageReference voltar(){

        PageReference pg = new PageReference('/'+this.contato.id);
        pg.setRedirect(true);
        return pg;
    }

    public void salvar(){
        try {
            
            update this.contato;
            update this.habilidades;

            ApexPages.addMessage( new ApexPages.Message(ApexPages.severity.CONFIRM, 'Registros atualizados com sucesso!'));

        } catch (Exception e) {
            System.debug('Error>> ' + e.getMessage());
            ApexPages.addMessage( new ApexPages.Message(ApexPages.severity.ERROR, 'Registros Não foram atualizados! Erro: ' + e.getMessage()));

        }
    }
}
