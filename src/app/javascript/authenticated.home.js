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

document.querySelectorAll('.formulario_box').forEach(function(box) {
    box.addEventListener('click', function() {
        const id = this.getAttribute('data-form-id');
        const class_group_id = this.getAttribute('data-class-group-id');
        window.location.href = `/answer_form/?form_id=${id}&class_group_id=${class_group_id}`;
    });
});