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
        if (e.dataTransfer.files[0].type.startsWith("image/")) {
            let img = dragDrop.querySelector('.drag-drop img');
            fileField.files = e.dataTransfer.files;
            showPhoto(e.dataTransfer.files[0], img);
            let p = dragDrop.querySelector(".drag-drop p");
            p.style.display = 'none'
        }
    });
    fileField.addEventListener('input', (e) => {
        let img = dragDrop.querySelector('.drag-drop img');
        let p = dragDrop.querySelector(".drag-drop p");
        p.style.display = 'none';
        showPhoto(e.target.files[0], img)
    });

});

function showPhoto(file, img) {
    let reader = new FileReader();
    reader.addEventListener('load', (e) => {
        console.log(e)
        img.src = e.target.result
        img.style.width = '100%';
        img.style.height='100%';
    })
    reader.readAsDataURL(file)
}