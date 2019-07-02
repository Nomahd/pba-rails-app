document.addEventListener('turbolinks:load', function() {
    checkBrowser();
});

function checkBrowser() {

// Internet Explorer 6-11
    let isIE = !!document.documentMode;

// Edge 20+
    let isEdge = !isIE && !!window.StyleMedia;

    if (isIE || isEdge) {
        let language = window.navigator.language;
        if (language === "ja") {
            alert("インターネットエクスプローラーかエッジ以外のブラウザはこのサイトが正しく機能するために使ったほうがいいです。")
        }
        else {
            alert("A browser besides Internet Explorer or Edge should be used for this site to function correctly.")
        }
    }
}