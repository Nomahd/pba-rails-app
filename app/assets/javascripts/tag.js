document.addEventListener('turbolinks:load', () => {

    let categories = ['genre', 'theme', 'special'];
    preventCommas(categories);
    setAppearButtons(categories);
    setAddTagButtons(categories);
    setCreateTagButtons(categories);

    categories.forEach((category) => {
        setDeleteButtons(category);
    });


});

function preventCommas(categories) {
    categories.forEach((category) => {
        let newField = document.querySelector('#new-' + category + '-field');
        if ( newField != null) {
            newField.addEventListener('keypress', (e) => {
                if (e.key === ',') {
                    e.preventDefault();
                }
            })
        }
    });

}

function setAppearButtons(categories) {
    categories.forEach((category) => {
        let createNewTagButton = document.querySelector('#btn-new-' + category);
        if (createNewTagButton != null) {
            createNewTagButton.addEventListener('click', () => {
                document.querySelector('#new-' + category).style.display = 'inline';
                document.querySelector('#new-'+ category + '-row').style.marginLeft = '20px';
                document.querySelector('#' + category + '-status').style.visibility = 'visible';
                createNewTagButton.remove()
            })
        }
    })
}
function setCreateTagButtons(categories) {
    categories.forEach((category) => {
        let createTagButton = document.querySelector('#btn-create-' + category);
        if (createTagButton != null) {
            createTagButton.addEventListener('click', () => {
                let inputField = document.querySelector('[id$="' + category + '_list"]');
                let old = inputField.value;
                let oldArray = old.split(',');
                let newTagField = document.querySelector('#new-' + category + '-field');
                let newTag = newTagField.value;
                if (newTag && !oldArray.includes(newTag)) {
                    inputField.value = old + ',' + newTagField.value;
                    let tagGroup = document.querySelector('#' + category + '-tag-group');
                    tagGroup.insertAdjacentHTML('beforeend', generateTagHtml(newTag));
                    newTagField.value = "";
                    setDeleteButtons();
                }
            })
        }
    })
}

function setAddTagButtons(categories) {
    categories.forEach((category) => {
        let addTagButton = document.querySelector('#btn-add-' + category);
        if (addTagButton != null) {
            addTagButton.addEventListener('click', () => {
                let inputField = document.querySelector('[id$="' + category + '_list"]');
                let old = inputField.value;
                let oldArray = old.split(',');
                let tagList = document.querySelector('#' + category + '_tags');
                let newTag = tagList.options[tagList.selectedIndex].value;
                if (newTag && !oldArray.includes(newTag)) {
                    inputField.value = old + ',' + newTag;
                    let tagGroup = document.querySelector('#' + category + '-tag-group');
                    tagGroup.insertAdjacentHTML('beforeend', generateTagHtml(newTag));
                    setDeleteButtons(category);
                }

            })
        }    })
}
function setDeleteButtons(category) {
    let deleteButtons = document.querySelectorAll('.tag-delete');
    if (deleteButtons != null) {
        deleteButtons.forEach((element) => {
            element.addEventListener('click', () => {
                element.parentElement.parentElement.remove();
                let inputField = document.querySelector('[id$="' + category + '_list"]');
                let tag = element.parentElement.parentElement.id;
                tag = tag.substr(4);
                let tagIndex = inputField.value.search(tag);
                if (tagIndex > -1) {
                    inputField.value = inputField.value.slice(0, tagIndex) + inputField.value.slice(tagIndex + tag.length, inputField.value.length)
                }
            })
        });
    }
}

function generateTagHtml(name) {
    return '<div id="tag-' + name + '" class="tag">\n' +
        '  <div class="tag-content">\n' +
        '    <span class="tag-name"></span>'
        + name +
        '    <button type="button" class="tag-delete">&#10005;</button>\n' +
        '  </div>\n' +
        '</div>';
}