public class CallOutMarvel {
	public static final String apiKey =  '37bf19fe30bf2e85d67fac6f9bef5404';
    public static final String hash =  '1eac52a113440af713aae39e8e21b658';
    
    @future(callOut=true)
    public static void getPersonagens(){
        final String endpoint = 'https://gateway.marvel.com:443/v1/public/characters?apikey='+apiKey+'&hash='+hash+'&ts=1';
        
        try{
            
            Http http = new Http();
			HttpRequest request = new HttpRequest();
            
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            
            System.debug('>>::' + request);
            
            HttpResponse response = http.send(request);
			
            if(response.getStatusCode() == 200){
                Map<String, Object> dataResults = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> data = (Map<String, Object>) dataResults.get('data');
                List<Object> results = (List<Object>) data.get('results');
				
                if(!results.isEmpty())
               	 	upsertPersonagens(results);
                    
                }else{
                    System.debug('Status >> ' + response.getStatusCode());
                }
               
            
        }catch( Exception e){
            System.debug(e.getMessage());
        }
        
    }
    
    private static void upsertPersonagens(List<Object> lstPersonagens){
        List<Lead> leadsToUpsert = new List<Lead>();
        
        for(Object personagem : lstPersonagens){
			Map<String, Object> mapPersonagem = (Map<String, Object>) personagem;
            System.debug('nome ' + mapPersonagem.get('name'));
            
            Lead lead = new Lead();
            lead.Company = 'Marvel API';
            lead.NomeGuerra__c = (String) mapPersonagem.get('name');
            lead.Description = (String) mapPersonagem.get('Description') != null ? (string) mapPersonagem.get('Description') : 'Sem descrição';
            lead.LastName    =  (String) mapPersonagem.get('name');
            lead.Email       = String.valueOf(mapPersonagem.get('id')) + '@marvel.com';
            lead.LeadSource  = 'Importado pela Marvel API';
            lead.NivelHeroi__c = 'Aspirante';
            
            
            leadsToUpsert.add(lead);
            
        }
        
        if(!leadsToUpsert.isEmpty()){
            upsert leadsToUpsert Email;
        }
    }
    
}