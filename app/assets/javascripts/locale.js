document.addEventListener('turbolinks:load', () => {
    I18n.locale = document.body.getAttribute("data-locale");

    document.dispatchEvent(new Event('localeLoaded'));
});
