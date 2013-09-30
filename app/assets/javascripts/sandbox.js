sources = ["fox"]

function BlankGraph () {

  w = 1200
  h = 450
  padding = 60;

  svg = d3.select("body")
              .append('svg')
              .attr("width", w)
              .attr("height", h);

}



function addToGraph (source) {

  var self = this;
  this.plotPoints = []
  this.source = source

  d3.json("/scatter", function(error, data){
      data.forEach(function(d){
        self.plotPoints.push([d.date, d.score, d.source])
      });
  // });

  sources = _.groupBy(self.plotPoints, function(d){return d[2]});





  xScale = d3.scale.linear()
      // .domain([1196121600, 1380153600])
      .domain([d3.min(self.plotPoints, function (d) { return d[0] }),d3.max(self.plotPoints, function(d) { return d[0]; })])
      .range([padding,w - padding]);

  yScale = d3.scale.linear()
      .domain([0.3,-0.3])
      .range([0,h]);

      d3.svg.line()
        .x(function  (d) {
            return x
        })

    line = d3.svg.line()
        .interpolate("basis")
        .x(function (d) {
          return xScale(d[0]);
        })
        .y(function (d) {
          return yScale(d[1]);
        });


    self.makeCircles(self.plotPoints);

    _.each(sources,function(value,key,list){
      months = monthlyAverages(value);
      self.makeLine(months, key);
    });
    // self.makeLine(sources)

    graph.makeAxis()


  });

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


addToGraph.prototype.makeCircles = function(points) {

  svg.selectAll("circle")
           .data(points)
           .enter()
           .append("circle")
           .attr("date", function(d){return d[0]})
           .attr('class', function(d){ return d[2]})
           // .attr
           // .attr("fill", function(d){
           //    var score = d[1]
           //    if(score > 0.0){
           //      return 'green'
           //    }
           //    else if (score < 0.0) {
           //      return 'red'
           //    }
           //    else {
           //      return 'purple'
           //    }
           // })
          // .attr('fill', function(this.source){

          // });

      .attr("cx", function(d) {
              return xScale(d[0]);
           })
       .attr("cy", function(d) {
          return yScale(d[1]);
       })
       .attr("r", function(d) {
           return 1 //Math.sqrt(h - d[1]);
       });


};

addToGraph.prototype.makeLine = function(months, source) {
      svg.append("path")
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

  $.each(sources, function(index, val) {
    new addToGraph(val)
  });



  });