document.addEventListener('turbolinks:load', () => {
    let checkAllButtons = document.querySelectorAll("[id^='select_all']");
    let deleteButtons = document.querySelectorAll("input[id^='delete-selected']");
    checkAllButtons.forEach((checkAll, index) => {
        let idName = checkAll.id.split('_');
        let selector;
        if (idName.length > 2) {
            selector = '#selected_' + idName[2] + '_'
        }
        else {
            selector = '#selected_'
        }
        let checkBoxAll = document.querySelectorAll(selector);

        checkAll.addEventListener('click', () => {
            if (checkAll.checked) {

                checkBoxAll.forEach((e) => {
                    e.checked = true;
                    deleteButtons[index].disabled = false
                })
            }
            else {
                checkBoxAll.forEach((e) => {
                    e.checked = false;
                    deleteButtons[index].disabled = true
                })
            }
        });

        checkBoxAll.forEach((e) => {
            e.addEventListener('click', () => {
                let checkedOne = Array.prototype.slice.call(checkBoxAll).some(x => x.checked);
                deleteButtons[index].disabled = !checkedOne;
            })
        })


    })
});
