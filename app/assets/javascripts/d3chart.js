<script type="text/javascript" id="chart">
  // Create object for each, add to data array
  var d3Chart = function(data){

    // Set dimensions
    var barWidth = 10;
    var width = (barWidth + 10) * data.length;
    var height = 200;
    var padding = 50;

    // X = station
    var x = d3.scale.linear().domain([0, data.length]).range([0, width]);
    // Y = datapoint
    var y = d3.scale.linear().domain([0, d3.max(data, function(datum) { return datum.datapoint; })]).
      rangeRound([0, height]);

    // Add the canvas to the DOM, id = #chart
    var bar = d3.select("#chart").
      append("svg:svg").
      attr("width", width).
      attr("height", height + padding);

    // For each piece of data, add Rectangle
    bar.selectAll("rect").
      data(data).
      enter().
      append("svg:rect").
      attr("x", function(datum, index) { return x(index); }).
      attr("y", function(datum) { return height - y(datum.datapoint); }).
      attr("height", function(datum) { return y(datum.datapoint); }).
      attr("width", barWidth). // Width is var barWidth = 10
      attr("fill", color);

    // Add text to yAxis
    bar.selectAll(".yAxis").
      data(data).
      enter().append("svg:text").
      attr("class", "yAxis").
      //attr("x", function(datum, index) { return x(index) + barWidth; }).
      //attr("y", height).
      attr("text-anchor", "middle").
      attr("dx", function(datum, index) { return barWidth * index; }).
      attr("dy", "1em").
      attr("style", "font-size: 8; font-family: Helvetica, sans-serif").
      text(function(datum) { return datum.station;}).
      //attr("transform", "translate(0, 18)").
      attr('transform', function(d,i,j) { return 'rotate(-90 0,0)' });

    // Add text.xAxis
    // Add animation
  }
</script>
