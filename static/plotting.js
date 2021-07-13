function csvToArray(str, delimiter = ",") {
    // slice from start of text to the first \n index
    // use split to create an array from string by delimiter
    const headers = str.slice(0, str.indexOf("\n")).split(delimiter);

    // slice from \n index + 1 to the end of the text
    // use split to create an array of each csv value row
    let rows = str.slice(str.indexOf("\n") + 1).split("\n");

    // remove empty rows, if any
    for(var i=0; i < rows.length; i+=1){
        if (rows[i].length < 1){
            rows.splice(i,1)
        }
    }

    // Map the rows
    // split values from each row into an array
    // use headers.reduce to create an object
    // object properties derived from headers:values
    // the object passed as an element of the array
    const arr = rows.map(function (row) {
        const values = row.split(delimiter);
        const el = headers.reduce(function (object, header, index) {
            object[header] = values[index];
            return object;
        }, {});
        return el;
    });

    // return the array
    return arr;
}

async function getData(url){
    const response = await fetch(url);
    let data = await response.text();
    data = csvToArray(data);
    return data;
}

async function plotGraphs() {
    sel = document.getElementById('filename');
    fname = sel.options[sel.selectedIndex].value
    console.log(fname);
    // set the dimensions and margins of the graph
    var margin = {top: 30, right: 10, bottom: 30, left: 60},
        width = 450 - margin.left - margin.right,
        height = 400 - margin.top - margin.bottom;

    // create
    var g1 = d3.create("svg:g");
    g1.attr("transform","translate(" + margin.left + "," + margin.top + ")");

    var g2 = d3.create("svg:g");
    g2.attr("transform","translate(" + margin.left + "," + margin.top + ")");

    var g3 = d3.create("svg:g");
    g3.attr("transform","translate(" + margin.left + "," + margin.top + ")");

    //Read the data
    numOfDataPoints = Math.floor(width * .2);
    data = await getData("http://localhost:8080/datafiles/"+fname);
    // plot only the last 20% of the data.  This will give the
    // illusion of a sliding window.
    data = await data.map(function(d) {
        return { time : d3.timeParse("%H:%M:%S")(d.time),
            pm1 : d.pm1, pm2 : d.pm2, pm10 : d.pm10 }
    }).slice(-numOfDataPoints);

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
        .attr("id","chart1-xaxis")
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

    // removes any previous svg objects on page
    d3.select("#chart1").select("svg").remove();
    d3.select("#chart2").select("svg").remove();
    d3.select("#chart3").select("svg").remove();

    // append the svg objects to the body of the page
    d3.select("#chart1")
        .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append(() => g1.node())

    d3.select("#chart2")
        .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append(() => g2.node())

    d3.select("#chart3")
        .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append(() => g3.node())

}
