document.addEventListener('DOMContentLoaded', () => {
    let progress = 0;
    let processed = 0;
    let total = -1;
    let failArray = [];
    let sub = App.cable.subscriptions.create('ProgressChannel', {
        connected: () => {
            let meta = document.querySelector('#csv-meta');
            let url = '/' + meta.getAttribute('locale') + '/' + meta.getAttribute('model') + '/bulk_execute';
            Rails.ajax({
                url: url,
                type: 'POST',
                data: 'id=' + meta.getAttribute('csv_id')
            })
        },
        disconnected: () => {
            sub = null
        },
        received: (data) => {
            if(data.total != null) {
                document.querySelector('#csv-progress-div').style.visibility = 'visible';
                document.querySelector('#csv-current').innerHTML = '0';
                document.querySelector('#csv-total').innerHTML = data.total;
                total = data.total
                if (progress > 0) {
                    document.querySelector('#csv-current').innerHTML = progress.toString();
                    document.querySelector('#csv-inner-progress').style.width = (progress / total) * 100 + '%';
                    document.querySelector('#csv-inner-progress').innerHTML = Math.round((progress / total) * 100) + '%';
                }
            }
            else if (data === 'success') {
                progress++;
                processed++;
                document.querySelector('#csv-current').innerHTML = progress.toString();
                document.querySelector('#csv-inner-progress').style.width = (progress / total) * 100 + '%';
                document.querySelector('#csv-inner-progress').innerHTML = Math.round((progress / total) * 100) + '%';
            }

            else if (data.fail != null) {
                processed++;
                failArray.push(data.fail)
            }
            if(processed === total) {
                if (processed === 0 && total === 0) {
                    document.querySelector('#csv-inner-progress').style.width = '100%';
                    document.querySelector('#csv-inner-progress').innerHTML = '100%';
                }
                document.querySelector('#csv-meta').innerHTML = I18n.t('bulk_error');
                if (failArray.length > 0) {
                    document.querySelector('#csv-fail-div').style.visibility = 'visible';
                    failArray.sort((a, b) => {
                        if (a.line < b.line) {
                            return -1;
                        }
                        if (a.line > b.line) {
                            return 1;
                        }
                        return 0;
                    });
                    failArray.forEach((value) => {
                        let row = document.querySelector('#csv-fail-table').insertRow();
                        row.insertCell(0).innerHTML = value.line;
                        let errors = '';
                        value.errors.forEach((msg) => {
                            errors = errors + msg + '\n';
                        });
                        row.insertCell(1).innerHTML = errors;
                    })
                }
                else {
                    document.querySelector('#csv-meta').innerHTML = I18n.t('bulk_success');
                }

                sub.unsubscribe();
            }
        }
    });
});


