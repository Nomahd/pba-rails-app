document.addEventListener('turbolinks:load', () => {

    let messengerButton = document.querySelector('#btn-new-messenger');
    if (messengerButton != null) {
        messengerButton.addEventListener('click', () => {
            document.querySelector('#new-messenger').style.display = 'inline';
            document.querySelector('#messenger-status').style.visibility = 'visible';
            messengerButton.remove()
        })
    }
});