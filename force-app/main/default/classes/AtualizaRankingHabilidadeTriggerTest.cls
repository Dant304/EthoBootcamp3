@isTest
public class AtualizaRankingHabilidadeTriggerTest {
 
    @testSetup
    public static void setup(){
        
        Contact contato = new Contact(
        	firstName = 'Matt',
            lastName = 'Murdock',
            NomeGuerra__c = 'Daredevil',
            StatusCandidato__c = 'Aprovado Direto'
        );
        Contact contato2 = new Contact(
        	firstName = 'Frank',
            lastName = 'Castle',
            NomeGuerra__c = 'Punisher',
            StatusCandidato__c = 'Em Treinamento'
        );
        
        List<Contact> contatos = new List<Contact> {contato, contato2};
        insert contatos;
        
        Habilidade__c visaoSensorial = new Habilidade__c(Name = 'Visão Sensorial');
        Habilidade__c resistencia = new Habilidade__c(Name = 'Resistência');
        
        List<Habilidade__c> habilidades = new List<Habilidade__c> {visaoSensorial, resistencia};
            
        insert habilidades;
        
        HabilidadeContato__c habilidadeContato1 = new HabilidadeContato__c();
        habilidadeContato1.Contato__c = contato.id;
        habilidadeContato1.Habilidade__c = visaoSensorial.id;
        habilidadeContato1.NivelHabilidade__c = 90;
        
        HabilidadeContato__c habilidadeContato2= new HabilidadeContato__c();
        habilidadeContato2.Contato__c = contato.id;
        habilidadeContato2.Habilidade__c = resistencia.id;
        habilidadeContato2.NivelHabilidade__c = 66;
        
        HabilidadeContato__c habilidadeContato3 = new HabilidadeContato__c();
        habilidadeContato3.Contato__c = contato2.id;
        habilidadeContato3.Habilidade__c = visaoSensorial.id;
        habilidadeContato3.NivelHabilidade__c = 10;
        
        HabilidadeContato__c habilidadeContato4= new HabilidadeContato__c();
        habilidadeContato4.Contato__c = contato2.id;
        habilidadeContato4.Habilidade__c = resistencia.id;
        habilidadeContato4.NivelHabilidade__c = 45;
        
        List<HabilidadeContato__c> habilidadesContato = new List<HabilidadeContato__c> {habilidadeContato1, habilidadeContato2, habilidadeContato3, habilidadeContato4};
        insert habilidadesContato;

    }
    
    @isTest
    public static void validaNovoRankingAfterInsert(){
        
        List<HabilidadeContato__c> habilidadesContato = [SELECT HABILIDADE__R.NAME, NAME
                                                        FROM HABILIDADECONTATO__C
                                                        WHERE CONTATO__R.NOMEGUERRA__C = 'Daredevil'];
        
        System.assertEquals(2, habilidadesContato.size());
        
        for(HabilidadeContato__c habilidadeContato : habilidadesContato){
            switch on habilidadeContato.Name{
                when 'Visão Sensorial'{
                    System.assertEquals(1, habilidadeContato.Ranking__c);
                }
                when 'Resistência'{ 
					System.assertEquals(2, habilidadeContato.Ranking__c);
                }
            }
        }
    }
}