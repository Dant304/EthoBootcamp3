@RestResource(urlMapping='/marvel/availableheroes/*')
global class GetAvailableHeroesIS {

    @HttpGet
    global static AvailableHeroes doGet(){
        Map<String, Hero> mapHerois = new Map<String, Hero>();
        List<HabilidadeContato__c> listHbContato = new List<HabilidadeContato__c>();
        
        String habilidadeParam = RestContext.request.params.get('habilidade');
        String nivelParam = RestContext.request.params.get('nivel');
        
        String dynamicQuery = 'SELECT id, Contato__r.NomeGuerra__c, Contato__r.NivelHeroi__c, Habilidade__r.Name, NivelHabilidade__c FROM HabilidadeContato__c where Contato__r.RecordType.DeveloperName = \'Heroi\' AND Contato__c NOT IN (Select Contato__c from BatalhaContato__c)';
        
        if(!String.isBlank(habilidadeParam)){
            List<String> habilidadesParam = habilidadeParam.split(',');
            dynamicQuery += ' AND Habilidade__r.Name IN :habilidadesParam';
        }if(!String.isBlank(nivelParam)){
            List<String> niveisParam = nivelParam.split(',');
            dynamicQuery += ' AND Contato__r.NivelHeroi__c IN :niveisParam';
        }
        
        listHbContato = Database.query(dynamicQuery);
        
        for(HabilidadeContato__c habilidadeContato : listHbContato){
            Skill habilidade = new Skill(habilidadeContato.Habilidade__r.Name, String.valueOf(habilidadeContato.NivelHabilidade__c));
         	Hero heroi;
            
            if( !mapHerois.containsKey(habilidadeContato.Contato__r.NomeGuerra__c)){
                heroi = new Hero();
                heroi.nome = HabilidadeContato.Contato__r.NomeGuerra__c;
                heroi.nivel = HabilidadeContato.Contato__r.NivelHeroi__c;
                heroi.habilidades = new List<Skill>{ habilidade};
            }else{
                heroi = mapHerois.get(habilidadeContato.Contato__r.NomeGuerra__c);
                heroi.habilidades.add(habilidade);
            }
            
            mapHerois.put(habilidadeContato.Contato__r.NomeGuerra__c, heroi);

         }
        
       return new AvailableHeroes(mapHerois.values());
    }
    
    global class AvailableHeroes{
        public List<Hero> herois;
        public Integer total;
        
        AvailableHeroes(List<Hero> herois){
            this.herois = herois;
            this.total = herois.size();
        }
        
    }
    global class Hero{
        public String nome;
        public String nivel;
        public List<Skill> habilidades;
    }
    global class Skill{
        public String nome;
        public String nivel;
        
        Skill(String nome, String nivel){
            this.nome = nome;
            this.nivel = nivel != null ? nivel : 'Nao avaliado';
        }
            
    }
}