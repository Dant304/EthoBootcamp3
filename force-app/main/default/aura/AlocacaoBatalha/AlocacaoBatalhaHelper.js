({
    setColumns : function(component) {
        component.set('v.columns', [
            {label: 'Batalha', fieldName: 'batalha', type: 'text'},
            {label: 'Contato', fieldName: 'contato', type: 'text'},
            {label: 'Tipo de contato', fieldName: 'tipo', type: 'text'},
            {label: 'Nível de Heroi', fieldName: 'nivel', type: 'text'},
            {label: 'Status da Batalha', fieldName: 'status', type: 'text'},
            {type: "button", typeAttributes: {
                label: 'Abrir',
                name: 'View',
                title: 'Clique',
                disabled: false,
                value: 'view',
                iconPosition: 'left'
            }},
            {type: "button", typeAttributes: {
                label: 'Abrir',
                name: 'View',
                title: 'Clique',
                disabled: false,
                value: 'view',
                iconPosition: 'left'
            }}
        ] );

       
    },

    fetchData : function(component) {
        console.log('Recuperando dados apex');

        var action = component.get("c.getBatalhas");

        action.setCallback( this, function(response) {
            let error = response.getError();
            let state = response.getState(); 
            console.log('Callback');

            if(state == 'SUCCESS'){
                var rows = response.getReturnValue();
                console.log('SUCESSO');

                for(var i = 0; i < rows.lenght; i++){
                    var row = rows[i];
                    if(row.Contato__r && row.Batalha__r){
                        row.batalha     = rows.Batalha__r.Name;
                        row.contato     = rows[i].Contato__r.NomeGuerra__c;
                        row.tipo        = rows[i].Contato__r.RecordType.Name;
                        row.status      = rows[i].Batalha__r.Status;

                    }
                }
                console.log('rows', rows);
                if(rows != null ){
                    component.set('v.data', rows);
                }
            }
            else{
                alert('Erro ' + error);
            }
        });

        $A.enqueueAction(action);

        
    }
})
