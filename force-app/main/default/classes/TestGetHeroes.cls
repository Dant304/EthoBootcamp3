@RestResource(urlMapping='/marvel/herois/*')
global class TestGetHeroes {

    @HttpGet
    global static List<Contact> doGet(){

        List<Contact> contatos = new List<Contact>();
		
        String query = 'select Name from Contact where RecordType.DeveloperName = \'Heroi\'';
        
        contatos = Database.query(query);
        
        for(Contact contato : contatos){
            System.debug('>>' + contatos);
        }
        
        return contatos;
    }
}