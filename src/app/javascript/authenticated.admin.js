function handleButtonClick(action) {
    console.log(`Button "${action}" clicked!`);
    switch (action) {
        case 'importarDados':
            alert('Função para Importar dados será implementada aqui.');
            // Example: window.location.href = '/import_data_page';
            break;
        case 'editarTemplates':
            alert('Função para Editar Templates será implementada aqui.');
            // Example: window.location.href = '/edit_templates_page';
            break;
        case 'enviarFormularios':
            alert('Função para Enviar Formularios será implementada aqui.');
            // Example: window.location.href = '/send_forms_page';
            break;
        case 'resultados':
            alert('Função para Resultados será implementada aqui.');
            // Example: window.location.href = '/results_page';
            break;
        default:
            console.log('Unknown button clicked.');
    }
}

function setButtonDisabled(buttonId, isDisabled) {
    const button = document.getElementById(buttonId);
    if (button) {
        button.disabled = isDisabled;
    } else {
        console.warn(`Button with ID '${buttonId}' not found.`);
    }
}