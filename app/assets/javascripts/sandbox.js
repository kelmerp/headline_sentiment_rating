// sources = ["fox"]

function BlankGraph () {

  w = 1200
  h = 450
  padding = 60;

  svg = d3.select("#scatter")
              .append('svg')
              .attr("width", w)
              .attr("height", h);

transition = d3.transition()
    .duration(750)
    .ease("linear");
}

function grabSources (argument) {
    var plotPoints =[];

    d3.json("/scatter", function(error, data){

      data.forEach(function(d){
        plotPoints.push([d.date, d.score, d.source])
      });


    xScale = d3.scale.linear()
        .domain([d3.min(plotPoints, function (d) { return d[0] }),d3.max(plotPoints, function(d) { return d[0]; })])
        .range([padding,w - padding]);

    yScale = d3.scale.linear()
        .domain([0.3,-0.3])
        .range([0,h]);

    line = d3.svg.line()
        .interpolate("basis")
        .x(function (d) {
          return xScale(d[0]);
        })
        .y(function (d) {
          return yScale(d[1]);
        });

    sources = _.groupBy(plotPoints, function(d){return d[2]});

      _.each(sources,function(value,key,list){
      new newSource(value, key)});
      });
}


function newSource(data, source) {

  var self = this;

  this.data = data
  this.source = source
  this.button = $('#'+source);
  this.circleGroup = svg.append('svg:g');
  this.linePlot = svg.append('path');
  this.visible = true;

  // d3.json("/scatter", function(error, data){
  //     data.forEach(function(d){
  //       self.plotPoints.push([d.date, d.score, d.source])
  //     });
  // // });

  // sources = _.groupBy(self.plotPoints, function(d){return d[2]});

  this.makeCircles(this.data)
  var months = monthlyAverages(this.data);
  this.makeLine(months, source);


  this.button.on('click', function(event) {
    console.log(self.visible);
    event.preventDefault();
    // console.log(self.circleGroup)
    if (self.visible == true){
      console.log("self should say true ")
          self.circleGroup.transition()
              .style('opacity',0);
          self.linePlot.transition()
              .style('opacity',0);
      self.visible = false;

    }
    else{
          console.log("this is the else")
          self.circleGroup.transition()
              .style('opacity',1);
          self.linePlot.transition()
              .style('opacity',1);

      self.visible = true;
    }
      console.log("self should say false")
      console.log(self.visible);

    });

    graph.makeAxis()


  };


function oddIndexes (array) {
  var result = []
  for (var i = 0; i < array.length; i++) {
    if(i % 2 != 0) { // index is even
        result.push(array[i]);
    }
  }

  return result;
}

function monthlyAverages (points, source) {
  monthAverages = []
  var source = points[0][2]

  var linePoints = points

  _.each(linePoints,function (date) {
    date.pop();
  })

  // firstDate = _.last(points)[0];



  var months = _.groupBy(linePoints,function (day) {
                return Math.floor(day[0]/2629740);
              });

  _.map(months,function (month) {

    var midMonth = (month[0][0]+(2629740/2));

    flatMonth = oddIndexes(_.flatten(month));

    sum = _.reduce(flatMonth,function (memo,day) {
            return memo + day;

      });
    average = sum/month.length;

    monthAverages.push([midMonth,average]);

    });

    return monthAverages

   // makeLine(monthAverages, source);
}


newSource.prototype.makeCircles = function(points) {

  this.circleGroup.selectAll("circle")
           .data(points)
           .enter()
           .append("circle")
           .attr("date", function(d){return d[0]})
           .attr('class', function(d){ return d[2]})

          .attr("cx", function(d) {
                  return xScale(d[0]);
               })
           .attr("cy", function(d) {
              return yScale(d[1]);
           })
           .attr("r", function(d) {
               return 1 //Math.sqrt(h - d[1]);
           });

           return this.circleGroup;
};

newSource.prototype.makeLine = function(months, source) {
              this.linePlot
      .attr('class', 'line')
      .attr('class', source)
      .attr('d',function (d) {

        return line(months);
      })
};


BlankGraph.prototype.makeAxis = function() {
        xAxis = d3.svg.axis()
            // .tickValues()
          .tickFormat(function(d) {
            var myDate = new Date( d * 1000);
            year = myDate.getUTCFullYear();
            month = myDate.getUTCMonth() + 1;
            return month + "-" + year
          })
           .scale(xScale)
           .orient("bottom")
           // .ticks(30)

      yAxis = d3.svg.axis()
            .scale(yScale)
            .orient("left")

      svg.append("g")
            .attr("class", "axis")
            .attr("transform", "translate(0," + ((h/2)) + ")")
            // .attr("transform", "translate("+50+",0")

            .call(xAxis);

      svg.append("g")
          .attr("class", "axis")
          .attr("transform", "translate("+50+",0)")
          .call(yAxis);
};







$(document).ready(function() {

  graph = new BlankGraph()

  grabSources();

  // $.each(sources, function(index, val) {
  //   grabSources();
  // });



  });