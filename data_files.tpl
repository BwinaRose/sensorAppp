<html>
<head>
  <script src="https://d3js.org/d3.v4.js"></script>
  <script type="text/javascript">
 function histogram_d3() {
   sel = document.getElementById('fn');
   fname = sel.options[sel.selectedIndex].value

   // set the dimensions and margins of the graph
var margin = {top: 30, right: 10, bottom: 30, left: 60},
    width = 450 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;

// removes any previous svg objects on page
d3.select("#chart1").select("svg").remove();
d3.select("#chart2").select("svg").remove();
d3.select("#chart3").select("svg").remove();
// append the svg objects to the body of the page
var g1 = d3.select("#chart1")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");
var g2 = d3.select("#chart2")
    .append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");
var g3 = d3.select("#chart3")
    .append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");

//Read the data
d3.csv("http://localhost:8080/datafiles/"+fname,

  // When reading the csv, I must format variables:
  function(d){
    return { time : d3.timeParse("%H:%M:%S")(d.time), pm1 : d.pm1, pm2 : d.pm2, pm10 : d.pm10 }
  },
  // Now I can use this dataset:
  function(data) {

    // Add X axis --> it is a date format
    var x1 = d3.scaleTime()
      .domain(d3.extent(data, function(d) { return d.time; }))
      .range([ 0, width ]);
    g1.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x1));

    // Add Y axis
    var y1 = d3.scaleLinear()
      .domain([0, d3.max(data, function(d) { return +d.pm1; })])
      .range([ height, 0 ]);
    g1.append("g")
      .call(d3.axisLeft(y1));

    // Add the line
    g1.append("path")
      .datum(data)
      .attr("fill", "none")
      .attr("stroke", "steelblue")
      .attr("stroke-width", 1.5)
      .attr("d", d3.line()
        .x(function(d) { return x1(d.time) })
        .y(function(d) { return y1(d.pm1) })
        )

        var x2 = d3.scaleTime()
          .domain(d3.extent(data, function(d) { return d.time; }))
          .range([ 0, width ]);
        g2.append("g")
          .attr("transform", "translate(0," + height + ")")
          .call(d3.axisBottom(x2));

        // Add Y axis
        var y2 = d3.scaleLinear()
          .domain([0, d3.max(data, function(d) { return +d.pm2; })])
          .range([ height, 0 ]);
        g2.append("g")
          .call(d3.axisLeft(y2));

    g2.append("path")
      .datum(data)
      .attr("fill", "none")
      .attr("stroke", "red")
      .attr("stroke-width", 1.5)
      .attr("d", d3.line()
        .x(function(d) { return x2(d.time) })
        .y(function(d) { return y2(d.pm2) })
        )

        var x3 = d3.scaleTime()
          .domain(d3.extent(data, function(d) { return d.time; }))
          .range([ 0, width ]);
        g3.append("g")
          .attr("transform", "translate(0," + height + ")")
          .call(d3.axisBottom(x3));

        // Add Y axis
        var y3 = d3.scaleLinear()
          .domain([0, d3.max(data, function(d) { return +d.pm10; })])
          .range([ height, 0 ]);
        g3.append("g")
          .call(d3.axisLeft(y3));

    g3.append("path")
      .datum(data)
      .attr("fill", "none")
      .attr("stroke", "yellow")
      .attr("stroke-width", 1.5)
      .attr("d", d3.line()
        .x(function(d) { return x3(d.time) })
        .y(function(d) { return y3(d.pm10) })
        )

    // Titles on graphs
    g1.append("text")
      .attr("x", (width / 2))
      .attr("y", 0 - (margin.top / 2))
      .attr("text-anchor", "middle")
      .style("font-size", "16px")
      .style("text-decoration", "underline")
      .text("PM1");

    g2.append("text")
      .attr("x", (width / 2))
      .attr("y", 0 - (margin.top / 2))
      .attr("text-anchor", "middle")
      .style("font-size", "16px")
      .style("text-decoration", "underline")
      .text("PM2.5");

    g3.append("text")
      .attr("x", (width / 2))
      .attr("y", 0 - (margin.top / 2))
      .attr("text-anchor", "middle")
      .style("font-size", "16px")
      .style("text-decoration", "underline")
      .text("PM10");
      })
       }

// function histogramWork(){
//   // X axis: scale and draw:
//    var x = d3.scaleLinear()
//        .domain([0, 1000])     // can use this instead of 1000 to have the max of data: d3.max(data, function(d) { return +d.price })
//        .range([0, width]);
//    svg.append("g")
//        .attr("transform", "translate(0," + height + ")")
//        .call(d3.axisBottom(x));
//
//    // set the parameters for the histogram
//    var histogram = d3.histogram()
//        .value(function(d) { return d.price; })   // I need to give the vector of value
//        .domain(x.domain())  // then the domain of the graphic
//        .thresholds(x.ticks(70)); // then the numbers of bins
//
//    // And apply this function to data to get the bins
//    var bins = histogram(data);
//
//    // Y axis: scale and draw:
//    var y = d3.scaleLinear()
//        .range([height, 0]);
//        y.domain([0, d3.max(bins, function(d) { return d.length; })]);   // d3.hist has to be called before the Y axis obviously
//    svg.append("g")
//        .call(d3.axisLeft(y));
//
//    // append the bar rectangles to the svg element
//    svg.selectAll("rect")
//        .data(bins)
//        .enter()
//        .append("rect")
//          .attr("x", 1)
//          .attr("transform", function(d) { return "translate(" + x(d.x0) + "," + y(d.length) + ")"; })
//          .attr("width", function(d) { return x(d.x1) - x(d.x0) -1 ; })
//          .attr("height", function(d) { return height - y(d.length); })
//          .style("fill", "#69b3a2")}

 </script>
</head>
<form onsubmit="histogram_d3();return false;">
<select name='filename' id='fn'>
    %for file_name in listdirs:
      <option>{{file_name}}</option>
    %end
</select>
<input value="Show" type='submit'></input>
</form>

<div id="graphs">
<span id="chart1"></span>
<span id="chart2"></span>
<span id="chart3"></span>
</div>

</html>
