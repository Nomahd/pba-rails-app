document.addEventListener('turbolinks:load', () => {
    let audioFileField = document.querySelector('#audio-file-field');
    let audioFilenameField = document.querySelector('#audio-filename-field');

    audioFileField.addEventListener('input', (e) => {
        if (audioFileField.value === '') {
            audioFilenameField.disabled = false
        }
        else {
            audioFilenameField.value = '';
            audioFilenameField.disabled = true
        }
    })

    audioFilenameField.addEventListener('input', (e) => {
        if (audioFilenameField.value === '') {
            audioFileField.disabled = false
        }
        else {
            audioFileField.value = null;
            audioFileField.disabled = true
        }
    })
});