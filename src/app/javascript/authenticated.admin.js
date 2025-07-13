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

function toggleSidebar() {
    const sidebar = document.getElementById('mySidebar');
    sidebar.classList.toggle('open');
}

function toggleLogoutDropdown() {
    const dropdown = document.getElementById('logoutDropdown');
    dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
}

window.onclick = function(event) {
    if (!event.target.matches('.user-icon') && !event.target.matches('.user-icon *') && !event.target.matches('.logout-dropdown') && !event.target.matches('.logout-dropdown *')) {
        const dropdowns = document.getElementsByClassName("logout-dropdown");
        for (let i = 0; i < dropdowns.length; i++) {
            const openDropdown = dropdowns[i];
            if (openDropdown.style.display === 'block') {
                openDropdown.style.display = 'none';
            }
        }
    }
}