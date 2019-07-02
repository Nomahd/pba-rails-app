document.addEventListener('turbolinks:load', () => {

    let messengerButton = document.querySelector('#btn-new-messenger');
    if (messengerButton != null)
        buttonAppear(messengerButton, '#div-new-messenger');

    let genreButton = document.querySelector('#btn-new-genre');
    if (genreButton != null)
        buttonAppear(genreButton, '#div-new-genre');
});

function buttonAppear(button, div) {
    button.addEventListener('click', () => {
        document.querySelector(div).style.display = 'inline';
        button.remove()
    })
}
