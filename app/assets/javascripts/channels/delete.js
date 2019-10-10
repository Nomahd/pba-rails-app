document.addEventListener('DOMContentLoaded', () => {
    let progress = 0;
    let processed = 0;
    let total = -1;
    let failArray = [];
    let sub = App.cable.subscriptions.create('DeleteChannel', {
        connected: () => {
            let meta = document.querySelector('#delete-meta');
            let url = '/' + meta.getAttribute('locale') + '/options/delete_' + meta.getAttribute('model');
            Rails.ajax({
                url: url,
                type: 'POST',
            })
        },
        disconnected: () => {
            sub = null
        },
        received: (data) => {
            if(data.total != null) {
                document.querySelector('#delete-progress-div').style.visibility = 'visible';
                document.querySelector('#delete-current').innerHTML = '0';
                document.querySelector('#delete-total').innerHTML = data.total;
                total = data.total
                if (progress > 0) {
                    document.querySelector('#delete-current').innerHTML = progress.toString();
                    document.querySelector('#delete-inner-progress').style.width = (progress / total) * 100 + '%';
                    document.querySelector('#delete-inner-progress').innerHTML = Math.round((progress / total) * 100) + '%';
                }
            }
            else if (data === 'success') {
                progress++;
                processed++;
                document.querySelector('#delete-current').innerHTML = progress.toString();
                document.querySelector('#delete-inner-progress').style.width = (progress / total) * 100 + '%';
                document.querySelector('#delete-inner-progress').innerHTML = Math.round((progress / total) * 100) + '%';
            }
            if(processed === total) {
                if (processed === 0 && total === 0) {
                    document.querySelector('#delete-inner-progress').style.width = '100%';
                    document.querySelector('#delete-inner-progress').innerHTML = '100%';
                }
                document.querySelector('#delete-meta').innerHTML = I18n.t('bulk_success');
                sub.unsubscribe();
            }
        }
    });
});


