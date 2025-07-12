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

document.querySelectorAll('.formulario_box').forEach(function(box) {
    box.addEventListener('click', function() {
        const id = this.getAttribute('data-id');
        console.log(`Box clicked with ID: ${id}`);
    });
});