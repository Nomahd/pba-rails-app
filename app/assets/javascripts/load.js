document.addEventListener('submit', () => {

    let main = document.querySelector('#main-content');
    main.insertAdjacentHTML('afterbegin', '<div class="lds-overlay"></div>');
    main.insertAdjacentHTML('afterbegin', '<div class="lds-dual-ring"></div>');
});