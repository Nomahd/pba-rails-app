document.addEventListener('localeLoaded', function() {
    // Internet Explorer 6-11
    let isIE = !!document.documentMode;

// Edge 20+
    let isEdge = !isIE && !!window.StyleMedia;

    if (isIE || isEdge) {

        Swal.fire({
            text: I18n.t('browser_warning'),
            type: 'error',
            confirmButtonText: I18n.t("ok"),
        });
    }
});