document.addEventListener('turbolinks:load', () => {

    let tabs = document.querySelectorAll('.tab');
    let tabContents = document.querySelectorAll('.tab-content');

    tabs.forEach((tab, index) => {
        tab.addEventListener('click', (event) => {
            tabContents.forEach((content) => {
                content.style.display = 'none';
            });
            tabs.forEach((tab) => {
                tab.className =  tab.className.replace(' active', '')
            });
            tabContents[index].style.display = 'block';
            event.target.className += ' active'
        })
    })
});
