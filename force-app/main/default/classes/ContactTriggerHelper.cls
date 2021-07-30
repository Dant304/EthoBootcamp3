public class ContactTriggerHelper {

    public static void criaTarefaParaEncontrarFraquezas(List<Contact> newRecords){
        List<Task> taskToInsert = new List<Task>();
        
        for(Contact contato : newRecords){
            id vilaoId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Vilao').getRecordTypeId();
            if(contato.RecordTypeId == vilaoId){
                Task tarefa = new Task();
                tarefa.Subject = 'Descobrir fraquezas do vilão';
                tarefa.ownerId = contato.OwnerId;
                tarefa.WhoId = contato.Id;
                tarefa.Status = 'Open';
                
                taskToInsert.add(tarefa);
            }
        }
        if(!taskToInsert.isEmpty()){
            insert taskToInsert;
        }
    }
    
    public static void naoPermiteApagarEnquantoHouverTaskAberta(List<Contact> oldRecords, Map<Id, Contact> oldMap){
        
        List<Task> tasks = [SELECT Id, status, Who.Name FROM Task
                            WHERE whoId IN :oldRecords AND status != 'Completed'];
        
        for(Task tarefa : tasks){
            oldMap.get(tarefa.WhoId).addError('Não é possivel deletar contatos com tarefas em aberto!');            
        }
      
    }
}