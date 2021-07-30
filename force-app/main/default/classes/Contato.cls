public virtual class Contato {

    private String nome;
    private String email;
    
    public Contato(String nome, String email){
        this.nome = nome;
		this.email = email;        
    }
    
    public static void mostrarTodosContatos(List<Contato> contatos){
        for(Contato personagem : contatos){
            System.debug('>>> contatos:: ' + personagem);
        }
        
    }
    
}