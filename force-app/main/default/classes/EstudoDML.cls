public class EstudoDML {
	
    public static void mainDML(){
        
        List<Contact> contatos = new List<Contact>();
        
        Contact contato = new Contact(
        	firstName = 'Sinestro',
            lastName = 'Jesus cert',
            NomeGuerra__c = 'Void man aaaa'
        );
        Contact contato2 = new Contact(
        	firstName = 'Daniela',
            lastName = 'alves',
            NomeGuerra__c = 'player'
        );
        
        contatos.add(contato);
        contatos.add(contato2);

      //  insertContact(contatos, true);
		
		List<Contact> contactsToday = [SELECT Id, firstName, lastName, NomeGuerra__c FROM Contact
                                      WHERE createdDate = today];
        
       /* for(Integer i = 0; i < contactsToday.size(); i++){
            contactsToday[i].NomeGuerra__c = 'Cloner etapa update' +i;
		}*/
        
        //updateContact(contactsToday, true);
        
        // upsertContact(contatos, true);
        
        List<Contact> contactsToDelete = [SELECT Id, firstName, lastName, NomeGuerra__c FROM Contact
                                         WHERE createdDate = today ALL ROWS];
        System.debug(contactsToDelete);
        //deleteContact(contactsToDelete, true);
        
        //undeleteContact(contactsToDelete, true);
        
        mergeContacts(contactsToDelete[0], contactsToDelete[1], true);
        
    }
    
    public static void mergeContacts(Contact ct1, Contact ct2, boolean dbMethod){
        
        if(dbMethod){
            Database.mergeResult results = Database.merge(ct1,ct2, false);
            System.debug('merge>> '+ results);
        }else{
            merge ct1 ct1;
        }
    }
    
    public static void undeleteContact(List<Contact> contatos, boolean dbMethod){
        
        if(dbMethod){
            Database.UndeleteResult[] results = Database.undelete(contatos, false);
            //trataUpsertResult(results);
        }else{
            undelete contatos;
            System.debug('contatos>> '+ contatos);
        }
    }
    
    public static void deleteContact(List<Contact> contatos, boolean dbMethod){
        
        if(dbMethod){
            Database.DeleteResult[] results = Database.delete(contatos, false);
            //trataUpsertResult(results);
        }else{
            delete contatos;
            System.debug('contatos>> '+ contatos);
        }
    }
    
    public static void upsertContact(List<Contact> contatos, boolean dbMethod){
        
        if(dbMethod){
            Database.UpsertResult[] results = Database.upsert(contatos, false);
            trataUpsertResult(results);
        }else{
            upsert contatos;
        }
    }
    
    public static void updateContact(List<Contact> contatos, boolean dbMethod){
        
        if(dbMethod){
            Database.SaveResult[] results = Database.update(contatos, false);
            trataResult(results);
        }else{
            update contatos;
        }
    }
    
    public static void insertContact(List<Contact> contatos, boolean dbMethod){
        
        if(dbMethod){
            Database.SaveResult[] results = Database.insert(contatos, false);
            trataResult(results);
        }else{
            insert contatos;
        }
    }
    
    public static void trataResult(Database.SaveResult[] results){
        for(Database.SaveResult result :  results){
            if(result.isSuccess()){
                System.debug('SUCESSO id'+ result.getId());
            }
            else{
                for(Database.Error erro : result.getErrors()){
                    System.debug('ERRO STATUS>>' + erro.getStatusCode() + ' ERRO STATUS>>' + erro.getMessage());
                }
            }
        }
    }
        
    public static void trataUpsertResult(Database.UpsertResult[] results){
        for(Database.UpsertResult result :  results){
            if(result.isSuccess()){
                System.debug('SUCESSO id'+ result.getId());
            }
            else{
                for(Database.Error erro : result.getErrors()){
                    System.debug('ERRO STATUS>>' + erro.getStatusCode() + ' ERRO STATUS>>' + erro.getMessage());
                }
            }
        }
    }
    
}