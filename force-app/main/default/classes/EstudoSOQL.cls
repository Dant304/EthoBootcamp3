public class EstudoSOQL {

    public static List<Contact> getAllContacts(){
        List<Contact> contatos = [SELECT id, NomeGuerra__c, Name FROM Contact];
        
        return contatos;
    }
    
    public static Contact getContactById(Id contatoId){
        Contact contato = [SELECT Id, Name, NomeGuerra__c FROM Contact where Id = :contatoId];
        
        return contato;
    }
    
    public static Map<String, Decimal> getAvgByContact(){
        AggregateResult[] result = [SELECT Contato__r.NomeGuerra__c NomeDeGuerra, AVG(NivelHabilidade__c) mediaLevel
                                    FROM HabilidadeContato__c 
									GROUP BY Contato__r.NomeGuerra__c
									HAVING AVG(NivelHabilidade__c) > 0 Order BY AVG(NivelHabilidade__c) DESC];
        Map<String, Decimal> mapa = new Map<String, Decimal>();
        
        for(AggregateResult resultado : result){
            String nomeDeGuerra = (String) resultado.get('NomeDeGuerra');
            Decimal mediaLevel = (Decimal) resultado.get('mediaLevel');
            
            mapa.put(nomeDeGuerra, mediaLevel);
        }
        
        return mapa;
    }
    
    public static List<HabilidadeContato__c> getHabilidadesByContatoOrHabilidade(String nomeDeGuerra, String nomeHabilidade){
    	String query = 'SELECT Habilidade__r.Name, NivelHabilidade__c, Contato__r.NomeGuerra__c FROM HabilidadeContato__c WHERE ';
        
        
        if(!String.isEmpty(nomeDeGuerra)){
            query += 'Contato__r.NomeGuerra__c = :nomeDeGuerra';
        }else{
            query += 'Habilidade__r.Name = :nomeHabilidade';
        }
        List<HabilidadeContato__c> habilidadesDoContato = DataBase.query(query);

        return habilidadesDoContato;
        
    }
    
    
    
    
    
    
    
    
}