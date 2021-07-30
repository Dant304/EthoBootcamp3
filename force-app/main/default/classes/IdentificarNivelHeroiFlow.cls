global class IdentificarNivelHeroiFlow {

    @InvocableMethod(label='Identifica Nivel do Heroi')
    public static void identificaNivelHeroi(List<ContactRequest> requests){
        
        List<Contact> contatos = new List<Contact>();
        
        for(ContactRequest request : requests){
            Decimal media = 0;
            Decimal somaLevel = 0;
            String nivel = '';
            
            for(HabilidadeContato__c habilidadeContato : request.habilidadesContato){
                
                if(habilidadeContato.NivelHabilidade__c == null){
                    habilidadeContato.NivelHabilidade__c = 10;
     
                }
                if(habilidadeContato != null)
                	somaLevel += HabilidadeContato.NivelHabilidade__c;
            }
            
            media = somaLevel/request.habilidadesContato.size();
            
            if(media >= 80){
                nivel = 'Senior';
            }
            else if(media >= 40){
                nivel = 'Pleno';
            }
            else{
                nivel = 'Junior';
            }
            
            //contatos.add(new Contact(Id = request.contactId, NivelHeroi__c = nivel));
            request.contact.NivelHeroi__c = nivel;
            contatos.add(request.contact);
        }
        
        update contatos;
    }
    
    global class ContactRequest{
        @InvocableVariable(required=true)
        global Contact contact;
        @InvocableVariable(required=true) 
        global List<HabilidadeContato__c> habilidadesContato;
    }
}