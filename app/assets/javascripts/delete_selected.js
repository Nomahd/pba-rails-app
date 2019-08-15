document.addEventListener('turbolinks:load', () => {
    let checkAll = document.querySelector('#select_all');
    let checkBoxAll = document.querySelectorAll("[id^='selected']");
    let deleteButton = document.querySelector('#delete-selected');
    if (checkAll != null) {
        checkAll.addEventListener('click', () => {
            if (checkAll.checked) {
                checkBoxAll.forEach((e) => {
                    e.checked = true;
                    deleteButton.disabled = false
                })
            }
            else {
                checkBoxAll.forEach((e) => {
                    e.checked = false;
                    deleteButton.disabled = true
                })
            }
        });
    }

    if (checkBoxAll != null) {
        checkBoxAll.forEach((e) => {
            e.addEventListener('click', () => {
                let checkedOne = Array.prototype.slice.call(checkBoxAll).some(x => x.checked)
                deleteButton.disabled = !checkedOne;
            })
        })

    }
});
