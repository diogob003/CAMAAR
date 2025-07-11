updateFormularioBoxes();

function updateFormularioBoxes() {
    console.log('Document loaded, rendering boxes ...');
    const container = document.getElementById('formularioBoxesContainer');
    if(container) {
        renderFormularioBoxes();
    } else {
        console.log("No container found for rendering boxes.");
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

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
    if (!event.target.matches('.user-icon') && !event.target.matches('.user-icon *')) {
        const dropdowns = document.getElementsByClassName("logout-dropdown");
        for (let i = 0; i < dropdowns.length; i++) {
            const openDropdown = dropdowns[i];
            if (openDropdown.style.display === 'block') {
                openDropdown.style.display = 'none';
            }
        }
    }
}

async function handleLogout(event) {
    console.log('Logging out...');

    const token = document.querySelector('meta[name="csrf-token"]')
        ? document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        : '';

    try {
        const response = await fetch('/logout', {
            method: 'DELETE',
            credentials: 'same-origin',
            headers: {
                'X-CSRF-Token': token,
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            console.log('Logout successful');
            window.location.href = '/'; // Redirect to home or login page
        } else {
            console.error('Logout failed:', response.statusText);
            alert('Logout failed. Please try again.');
        }
    } catch (error) {
        console.error('Error during logout:', error);
        alert('An error occurred during logout.');
    }
}

async function renderFormularioBoxes() {
    const container = document.getElementById('formularioBoxesContainer');
    container.innerHTML = '';

    console.log('Fetching data from /user_forms...');

    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    const response = await fetch("/user_forms", {
        method: 'GET',
        credentials: 'same-origin',
        headers: { 'X-CSRF-Token': token }
    });

    // remove existent boxes before rendering new ones
    const boxes = container.querySelectorAll('.formulario_box');
    boxes.forEach(box => box.remove());

    const data = await response.json();

    data.forEach(item => {
        const box = document.createElement('div');
        box.classList.add('formulario_box');
        box.setAttribute('data-id', item.id);

        if (item.answered) {
            box.classList.add('respondido');
            box.innerHTML = `
                  <h3>${item.subject}</h3>
                  <p>${item.semester}</p>
                  <p class="professor-name">${item.professor}</p>
                  <p>Respondido</p>
                `;
        } else {
            box.innerHTML = `
                  <h3>${item.subject}</h3>
                  <p>${item.semester}</p>
                  <p class="professor-name">${item.professor}</p>
                  <p>Não respondido</p>
                `;
            box.addEventListener('click', () => handleBoxClick(item.id, item.subject));
        }

        container.appendChild(box);
    });
}

function handleBoxClick(id, subject) {
    alert(`Box for "${subject}" (ID: ${id}) clicked!`);
    // Here you can navigate to a detailed page, open a modal, etc.
    // In Rails, you might redirect:
    // window.location.href = `/evaluations/${id}`;
}
