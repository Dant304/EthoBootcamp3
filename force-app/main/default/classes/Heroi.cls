public class Heroi extends Contato{
	
    public String habilidade;
    public String nomeDeGuerra;
    
    public Heroi(String nome, String email, String nomeDeGuerra, String habilidade){
        super(nome, email);
        this.nomeDeGuerra = nomeDeGuerra;
        this.habilidade = habilidade;
    }
}