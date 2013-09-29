$(document).ready(function() {
  console.log("ran");

  var margin = {top: 20, right: 80, bottom: 30, left: 50},
      width = 960 - margin.left - margin.right,
      height = 500 - margin.top - margin.bottom;

  var parseDate = d3.time.format.utc("%a_%b_%d_%YT%H:%M:%S.%LZ").parse;
// Mon Sep 23 2013 18:17:36 GMT-0500 (CDT) 
  var x = d3.time.scale()
      .range([0, width]);

  var y = d3.scale.linear()
      .range([height, 0]);

  var color = d3.scale.category10();

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");

  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left");

  // var line = d3.svg.line()
  //     .interpolate("basis")
  //     .x(function(d) { return x(d.date); })
  //     .y(function(d) { return y(d.temperature); });

  var svg = d3.select("body").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


  d3.json("/cnn", function(error, data) {
    console.log(data);
    console.log(error);
    // data.forEach(function(d) {
    //   console.log(typeof String(d.date));
    //   date = String(d.date)
    //   d.date = parseDate(d.date);
    // });
    color.domain(d3.keys(data[0]).filter(function(key) { return key !== "date"; }));
    data.forEach(function(d) {
      // console.log(d)
      d.date = parseDate(d.date);
    });

    var cities = color.domain().map(function(name) {
      return {
        name: name,
        values: data.map(function(d) {
          return {date: d.date, temperature: +d[name]};
        })
      };
    });

    x.domain(d3.extent(data, function(d) { console.log(d); return parseDate(String(d.date)); }));

    y.domain([
      d3.min(cities, function(c) { return d3.min(c.values, function(v) { return v.temperature; }); }),
      d3.max(cities, function(c) { return d3.max(c.values, function(v) { return v.temperature; }); })
    ]);

    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);
      // debugger;

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", "2em")
        .style("text-anchor", "end")
        .text("Temperature (ºF)");
      // debugger;

    svg.selectAll("circle")
       .data(data)
       .enter()
       .append("circle")
      .attr("cx", function(d) {
        console.log(d);
        console.log(d.date);
        // console.log(parseDate(d.date));
        console.log(parseDate(String(d.date)));
        var date = x(parseDate(String(d.date)));
        console.log(date);
        return x(date);
      })
      .attr("cy", function(d) {
        console.log(d.cnn)
        return y(d.cnn);
      })
      .attr("r", 5);

    var city = svg.selectAll(".city")
        .data(cities)
      .enter().append("g")
        .attr("class", "city");
      // debugger;

    // city.append("path")
    //     .attr("class", "line")
    //     .attr("d", function(d) { return line(d.values); })
    //     .style("stroke", function(d) { return color(d.name); });
      // debugger;

  // var totalLength = path.node().getTotalLength();
  //   path
  //   .attr("stroke-dasharray", totalLength + " " + totalLength)
  //   .attr("stroke-dashoffset", totalLength)
  //   .transition()
  //     .duration(5000)
  //     .ease('linear')
  //     .attr("stroke-dashoffset", 0);


  //   city.append("text")
  //       .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
  //       .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.temperature) + ")"; })
  //       .attr("x", 3)
  //       .attr("dy", ".35em")
  //       .text(function(d) { return d.name; });
  });
});