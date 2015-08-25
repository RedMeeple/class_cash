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
      legend: {
        show: false,
      },
      axis: {
        y: {
          label: {
            text: 'Wealth',
            position: 'outer-middle'
          }
        },
        x: {
          type: 'timeseries',
          label: {
            text: 'Date',
            position: 'outer-center'
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
  },

  behavior: function (data) {

    var obj = {};

    data.forEach(function(data, index) {
      obj[data[0]] = data[1];
    });

    var startYear = parseInt(data[data.length - 1][0].split('-')[0]);
    var endYear = parseInt(data[0][0].split('-')[0]);

    var width = 960;
    var height = 750;
    var cellSize = 25; // cell size

    var no_months_in_a_row = Math.floor(width / (cellSize * 7 + 50));
    var shift_up = cellSize * 3;

    var day = d3.time.format("%w"); // day of the week
    var day_of_month = d3.time.format("%e"); // day of the month
    var day_of_year = d3.time.format("%j");
    var week = d3.time.format("%U"); // week number of the year
    var month = d3.time.format("%m"); // month number
    var year = d3.time.format("%Y");
    var format = d3.time.format("%Y-%m-%d");

    var behavior = function (d) {
      if (d === true) {
        return "good";
      } else {
        return "bad";
      }
    };

    var svg = d3.select("#chart").selectAll("svg")
        .data(d3.range(startYear, endYear + 2))
      .enter().append("svg")
        .attr("width", width)
        .attr("height", height)
        .attr("class", "RdYlGn")
      .append("g");

    var rect = svg.selectAll(".day")
        .data(function(d) {
          return d3.time.days(new Date(d, 0, 1), new Date(d + 1, 0, 1));
        })
      .enter().append("rect")
        .attr("class", "day")
        .attr("width", cellSize)
        .attr("height", cellSize)
        .attr("x", function(d) {
          var month_padding = 1.2 * cellSize * 7 * ((month(d) - 1) % (no_months_in_a_row));
          return day(d) * cellSize + month_padding;
        })
        .attr("y", function(d) {
          var week_diff = week(d) - week(new Date(year(d), month(d) - 1, 1) );
          var row_level = Math.ceil(month(d) / (no_months_in_a_row));
          return (week_diff * cellSize) + row_level * cellSize * 8 - cellSize / 2 - shift_up;
        })
        .datum(format);

    var month_titles = svg.selectAll(".month-title")  // Jan, Feb, Mar and the whatnot
          .data(function(d) {
            return d3.time.months(new Date(d, 0, 1), new Date(d + 1, 0, 1)); })
        .enter().append("text")
          .text(monthTitle)
          .attr("x", function(d, i) {
            var month_padding = 1.2 * cellSize * 7 * ((month(d)-1) % (no_months_in_a_row));
            return month_padding;
          })
          .attr("y", function(d, i) {
            var week_diff = week(d) - week(new Date(year(d), month(d) - 1, 1) );
            var row_level = Math.ceil(month(d) / (no_months_in_a_row));
            return (week_diff * cellSize) + row_level * cellSize * 8 - cellSize - shift_up;
          })
          .attr("class", "month-title")
          .attr("d", monthTitle);

    var year_titles = svg.selectAll(".year-title")  // 2015, 2016 and the whatnot
          .data(function(d) {
            return d3.time.years(new Date(d, 0, 1), new Date(d + 1, 0, 1)); })
        .enter().append("text")
          .text(yearTitle)
          .attr("x", function(d, i) { return width / 2 - 100; })
          .attr("y", function(d, i) { return cellSize * 5.5 - shift_up; })
          .attr("class", "year-title")
          .attr("d", yearTitle);


    //  Tooltip Object

    var tooltip = d3.select("body")
      .append("div").attr("id", "tooltip")
      .style("position", "absolute")
      .style("z-index", "10")
      .style("visibility", "hidden")
      .text("a simple tooltip");


      // Beginning of mapping data

      rect.filter(function(d) {
            return d in obj;
          }).attr("class", function(d) {
            return 'day ' + behavior(obj[d]);
          })

      //  Tooltip

      rect.on("mouseover", mouseover);
      rect.on("mouseout", mouseout);
      function mouseover(d) {
        tooltip.style("visibility", "visible");
        var behavior_data = (obj[d] !== undefined) ? behavior(obj[d]) : 'no behavior';
        var behavior_text = d + ': ' + behavior_data;

        tooltip.transition()
                    .duration(200)
                    .style("opacity", .9);
        tooltip.html(behavior_text)
                    .style("left", (d3.event.pageX) + 30 + "px")
                    .style("top", (d3.event.pageY) + "px");
      }

      function mouseout (d) {
        tooltip.transition()
                .duration(500)
                .style("opacity", 0);
        var $tooltip = $("#tooltip");
        $tooltip.empty();
      }

    // Ending of mapping data

    function dayTitle (t0) {
      return t0.toString().split(" ")[2];
    }
    function monthTitle (t0) {
      return t0.toLocaleString("en-us", { month: "long" });
    }
    function yearTitle (t0) {
      return t0.toString().split(" ")[3];
    }
  }
}
