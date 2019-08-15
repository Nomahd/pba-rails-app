document.addEventListener('turbolinks:load', () => {

    let addButtons = document.querySelectorAll('[id^="btn-dropdown-"]');

    if (addButtons.length !== 0) {
        addButtons.forEach((button) => {
            button.addEventListener('click', () => {
                button.parentElement.querySelector('[id$="-dropdown-new"]').style.display = 'inline';
                button.parentElement.querySelector('[id$="-dropdown-status"]').style.visibility = 'visible';
                button.remove()
            })
        })
    }
});