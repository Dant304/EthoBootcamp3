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
    },

    showModal : function(component, event, helper){
        component.set("v.showModal", true);
    },

    closeModal : function(component, event, helper){
        component.set("v.showModal", false);
    },

    batalhaCriada : function(component, event, helper){
        helper.fetchData(component);
        component.set("v.showModal", false);
    }
})
