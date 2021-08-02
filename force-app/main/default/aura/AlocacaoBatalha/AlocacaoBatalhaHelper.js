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
                label: 'Editar',
                name: 'Edit',
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

                for(var i = 0; i < rows.length; i++){
                    var row = rows[i];
                    if(row.Contato__r && row.Batalha__r){
                        row.contato     = row.Contato__r.NomeGuerra__c;
                        row.batalha     = row.Batalha__r.Name;
                        row.tipo        = row.Contato__r.RecordType.Name;
                        row.status      = row.Batalha__r.StatusBatalha__c;

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

        
    },

    viewRecord : function(component, event){
        var recId = event.getParam('row').Id;
        var actionName = event.getParam('action').name;
        if(actionName === 'Edit'){

            var editRecordEvent = $A.get("e.force:editRecord");
            editRecordEvent.setParams({
                "recordId": recId
            });
            editRecordEvent.fire();

        }else if (action === 'View'){

            var viewRecordEvent = $A.get('e.force:navigateToURL');
            viewRecordEvent.setParams({
                "url": "/" + recId
            });
            viewRecordEvent.fire();
        }
    }
})
