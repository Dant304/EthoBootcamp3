({
    handleClick : function(component, event, helper) {
        alert('entrou');
    },

    init : function(component, event, helper){
        helper.setColumns( component );
        helper.fetchData( component );
    },

    viewRecord : function(component, event, helper){
        helper.viewRecord( component, event);
    }
})
