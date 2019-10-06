document.addEventListener('turbolinks:load', () => {
    let sub = App.cable.subscriptions.create('TestChannel', {
        connected: () => {
            console.log('connected')
        },
        disconnected: () => {
            console.log('disconnected')
            sub = null
        },
        received: (data) => {
            let testDiv = document.querySelector('#test')
            testDiv.innerHTML = '<p>' + data + '/100' + '</p>'
            console.log('data received')
          console.log(data)
        }
    });
});