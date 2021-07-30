global class ContactCreateTask {

    @InvocableMethod(label = 'Cria tarefa para o Contato')
    public static void ContactCreateTask(List<CreateTaskRequest> requests){
        System.debug('>>> requests:: ' + requests);
        
        
        List<Id> listContactId = new List<Id>();
        for(CreateTaskRequest request : requests){
            listContactId.add(request.contactId);
        }
        
	
		        
        List<HabilidadeContato__c> listaHabilidades = [SELECT Id, Contato__c, Habilidade__r.Name FROM HabilidadeContato__c];
        
       	Map<Id, List<String>> mapContatoHabilidades = new Map<Id, List<String>>();
        
        for(HabilidadeContato__c habilidade : listaHabilidades){
            if(mapContatoHabilidades.containsKey(habilidade.Contato__c)){
                mapContatoHabilidades.get(habilidade.Contato__c).add(habilidade.Habilidade__r.Name);
            }else{
                mapContatoHabilidades.put(habilidade.Contato__c, new List<String>{ habilidade.Habilidade__r.Name});
                
            }
        }

       createtask(requests, mapContatoHabilidades);
    }
    
    public static void createTask(List<CreateTaskRequest> requests, Map<Id, List<String>> mapContatoHabilidades){
        List<Task> taskToInsert = new List<Task>();
        
        for(CreateTaskRequest request : requests){
            Task tarefa = new Task();
            tarefa.Subject = request.subject;
            tarefa.WhoId = request.contactId;
            tarefa.OwnerId = request.ownerId;
            tarefa.Description = 'Por favor, avalie este herói. Suas habilidades sãoa as seguintes: '+ String.valueOf(mapContatoHabilidades.get(request.contactId));
            tarefa.Status = 'Open';
			
            taskToInsert.add(tarefa);
        }
        
        if(!taskToInsert.isEmpty()){ 
        	insert taskToInsert;
        }
    }
    global Class CreateTaskRequest{
        @InvocableVariable(required=true)
        global String contactId;
        @InvocableVariable()
        global String subject;
        @InvocableVariable(required=true)
        global String ownerId;
    }
}