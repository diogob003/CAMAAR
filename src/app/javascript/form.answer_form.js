function toggleSidebar() {
    console.log("Toggle sidebar clicked! (No sidebar visible on this page)");
}

function toggleLogoutDropdown() {
    const dropdown = document.getElementById('logoutDropdown');
    dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
    if (!event.target.closest('.user-icon-container') && !event.target.closest('#logoutDropdown')) {
        const dropdown = document.getElementById("logoutDropdown");
        if (dropdown && dropdown.style.display === 'block') {
            dropdown.style.display = 'none';
        }
    }
}