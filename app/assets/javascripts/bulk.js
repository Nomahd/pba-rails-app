document.addEventListener('turbolinks:load', () => {
    document.addEventListener('dragover', (ev) => {
        ev.preventDefault();
    });

    document.addEventListener('drop', (ev) => {
        ev.preventDefault();
    });

    let dragDrop = document.querySelector('.drag-drop');
    let fileField = document.querySelector('.file-field');

    dragDrop.addEventListener('drop', (e) => {
        if (e.dataTransfer.files[0].name.split('.').pop() === 'csv') {
            let img = dragDrop.querySelector('.drag-drop img');
            img.style.display = 'none';
            fileField.files = e.dataTransfer.files;
            let p = dragDrop.querySelector('.drag-drop p');
            p.innerText = fileField.files[0].name;
            let submitButton = document.querySelector('#submit-button');
            submitButton.disabled = false;
        }
    });
    fileField.addEventListener('input', () => {
        let img = dragDrop.querySelector('.drag-drop img');
        img.style.display = 'none';
        let p = dragDrop.querySelector('.drag-drop p');
        p.innerText = fileField.files[0].name;
        let submitButton = document.querySelector('#submit-button');
        submitButton.disabled = false;
    });

});