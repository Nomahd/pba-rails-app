document.addEventListener('turbolinks:load', () => {

    document.addEventListener('dragover', (ev) => {
        ev.preventDefault();
    });

    document.addEventListener('drop', (ev) => {
        ev.preventDefault();
    });

    let dragDropField = document.querySelector('#drag-drop');
    let fileField = document.querySelector('#file-field');

    if (dragDropField != null)
        dragDropField.addEventListener('drop', (ev) => dragDropEvent(ev, dragDropField, fileField));

    if (fileField != null) {
        fileField.value = '';
        fileField.addEventListener('input', (ev) => fileFieldEvent(ev, dragDropField, fileField));
    }
});


function fileFieldEvent(ev, dragDropField, fileField) {

    let img = document.querySelector('#drag-drop-img');
    if (img != null) {
        dragDropField.removeChild(document.querySelector('#drag-drop-img'));
    }

    let p = document.querySelector('#drag-drop p');
    p.style.color = 'black';
    p.style.paddingTop = '100px';
    p.innerText = fileField.files[0].name;

    let submitButton = document.querySelector('#submit-button');
    submitButton.disabled = false;
}

function dragDropEvent(ev, dragDropField, fileField) {

    fileField.value = '';

    if (ev.dataTransfer.files[0].name.split('.').pop().localeCompare('csv')) {
        let img = document.querySelector('#drag-drop-img');
        if (img != null) {
            dragDropField.removeChild(document.querySelector('#drag-drop-img'));
        }

        let p = document.querySelector('#drag-drop p');
        p.style.paddingTop = '100px';
        p.style.color = 'red';
        let language = window.navigator.language;
        if (language === "ja") {
            p.innerText = 'CSVファイルではありません';
        }
        else {
            p.innerText = 'Not a CSV File';
        }

        let submitButton = document.querySelector('#submit-button');
        submitButton.disabled = true;
    }
    else {
        fileField.files = ev.dataTransfer.files;
        fileFieldEvent(ev, dragDropField, fileField);
    }

}
