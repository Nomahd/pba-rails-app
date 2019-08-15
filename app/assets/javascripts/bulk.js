document.addEventListener('turbolinks:load', () => {

    document.addEventListener('dragover', (ev) => {
        ev.preventDefault();
    });

    document.addEventListener('drop', (ev) => {
        ev.preventDefault();
    });

    let dragDropFields = document.querySelectorAll('.drag-drop');
    let fileFields = document.querySelectorAll('.file-field');
    if (dragDropFields.length > 0 && fileFields.length > 0) {

        let submitButtonArray = new Array(dragDropFields.length).fill(0);
        for(let i = 0; i < dragDropFields.length; i++) {

            fileFields[i].value = '';
            dragDropFields[i].addEventListener('drop', (ev) => dragDropEvent(i, ev, dragDropFields[i], fileFields[i], submitButtonArray));
            fileFields[i].addEventListener('input', (ev) => fileFieldEvent(i, ev, dragDropFields[i], fileFields[i], submitButtonArray));
        }
    }
});


function fileFieldEvent(index, ev, dragDropField, fileField, submitButtonArray) {

    let img = dragDropField.querySelector('.drag-drop img');
    if (img != null) {
        dragDropField.removeChild(dragDropField.querySelector('.drag-drop img'));
    }

    let p = dragDropField.querySelector('.drag-drop p');
    p.style.color = 'black';
    p.style.paddingTop = '100px';
    p.innerText = fileField.files[0].name;

    submitButtonArray[index] = 1;
    let submitBool = false;
    submitButtonArray.forEach((e) => {
        if (e === 0) {
            submitBool = true;
        }
    });

    let submitButton = document.querySelector('#submit-button');
    submitButton.disabled = submitBool;

}

function dragDropEvent(index, ev, dragDropField, fileField, submitButtonArray) {

    fileField.value = '';
    let p = dragDropField.querySelector('.drag-drop p');

    if (ev.dataTransfer.files[0].name.split('.').pop().localeCompare(fileField.accept.slice(1))) {

        let img = dragDropField.querySelector('.drag-drop img');
        if (img != null) {
            dragDropField.removeChild(img);
        }


        p.style.paddingTop = '100px';
        p.style.color = 'red';
        if (fileField.accept === ".csv") {
            p.innerText = I18n.t('bulk_csv_error');
        }
        else if (fileField.accept === ".zip") {
            p.innerText = I18n.t('bulk_zip_error');
        }


        let submitButton = document.querySelector('#submit-button');
        submitButton.disabled = true;
    }
    else {
        fileField.files = ev.dataTransfer.files;
        fileFieldEvent(index, ev, dragDropField, fileField, submitButtonArray);
    }

}
