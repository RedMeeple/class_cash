 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.

app.students = {
  
  cashChart: function (dates, cashAmount) {
    dates.unshift('dates');
    cashAmount.unshift('cash');

    var chart = c3.generate({
      bindto: '.cash-chart',
      data: {
        x: 'dates',
        xFormat: '%Y-%m-%d',
        columns: [
          dates,
          cashAmount
        ]
      },
      axis: {
        y: {
          label: {
            text: 'Close Price',
            position: 'outer-middle'
          }
        },
        x: {
          type: 'timeseries',
          label: {
            text: 'Time',
            position: 'outer-middle'
          },
          tick: {
            fit: false,
            format: function (d) {
              return d.toLocaleDateString();
            }
          }
        }
      }
    });
  }
}
