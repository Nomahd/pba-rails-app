document.addEventListener('turbolinks:load', () => {
    setButtons();

    document.addEventListener('tableAdd', () => {
        setButtons();
    })
});


function setButtons() {
    let selectAllButtons = document.querySelectorAll("[id^='select_all']");
    let deleteSelectedButtons = document.querySelectorAll("input[id^='delete-selected']");

    selectAllButtons.forEach((selectAllButton, index) => {
        let selector;
        let idName = selectAllButton.id.split('_');
        if (idName.length > 2) {
            selector = '#selected_' + idName[2] + '_'
        }
        else {
            selector = '#selected_'
        }
        let checkBoxAll =  document.querySelectorAll(selector);
        checkBoxAll.forEach((checkBox) => {
            checkBox.addEventListener('click', () => {
                let checkedOne = Array.prototype.slice.call(checkBoxAll).some(x => x.checked);
                deleteSelectedButtons[index].disabled = !checkedOne;
            })
        });

        selectAllButton.addEventListener('click', () => {
            if (selectAllButton.checked) {

                checkBoxAll.forEach((selectBox) => {
                    selectBox.checked = true;
                    deleteSelectedButtons[index].disabled = false
                })
            }
            else {
                checkBoxAll.forEach((selectBox) => {
                    selectBox.checked = false;
                    deleteSelectedButtons[index].disabled = true
                })
            }
        });
    });
}