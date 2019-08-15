document.addEventListener('turbolinks:load', () => {
    let startDateYear = document.querySelector('#_search_date_start_1i');
    let startDateMonth = document.querySelector('#_search_date_start_2i');
    let startDateDay = document.querySelector('#_search_date_start_3i');

    let endDateYear = document.querySelector('#_search_date_end_1i');
    let endDateMonth = document.querySelector('#_search_date_end_2i');
    let endDateDay = document.querySelector('#_search_date_end_3i');

    const dateArray = [startDateYear, startDateMonth, startDateDay, endDateYear, endDateMonth, endDateDay];
    if (startDateYear != null) {
        dateArray.forEach((ele) => {
            ele.addEventListener('change', (selector) => {
                if (selector.target.selectedIndex === 0) {
                    dateArray.forEach((ele) => {
                        ele.selectedIndex = 0;
                    })
                }
                else {
                    dateArray.forEach((ele, i) => {
                        if (ele.selectedIndex === 0) {
                            if (i <= 2) {
                                ele.selectedIndex = 1;
                            }
                            else {
                                ele.selectedIndex = ele.options.length - 1;
                            }
                        }
                    })
                }
            })
        })
    }
});