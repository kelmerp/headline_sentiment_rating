sources = ["fox", "cnn"]

function BlankGraph () {

  w = 1200
  h = 450

  svg = d3.select("body")
              .append('svg')
              .attr("width", w)
              .attr("height", h);


  xScale = d3.scale.linear()
      .domain([1164931200, 1380153600])
     .range([0,w]);

  yScale = d3.scale.linear()
      .domain([0.3,-0.3])
      .range([0,h]);
}


function addToGraph (source) {

  var self = this;
  this.plotPoints = []
  this.source = source

  d3.json("/"+source, function(error, data){
      console.log(data)
      data.forEach(function(d){
        self.plotPoints.push([d.date, d.score])
      });

    self.makeCircles(self.plotPoints);

  });


}


addToGraph.prototype.makeCircles = function(points) {

  console.log(points);
  svg.select("circle")
           .data(points)
           .enter()
           .append("circle")
           .attr("date", function(d){return d[0]})
           .attr('class', this.source)
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
            // console.log(d)
              console.log(d)
              console.log(xScale(d[0]))
              return xScale(d[0]);
           })
       .attr("cy", function(d) {
          return yScale(d[1]);
       })
       .attr("r", function(d) {
           return 1 //Math.sqrt(h - d[1]);
       });

};


BlankGraph.prototype.makeAxis = function() {
        console.log(svg)
        xAxis = d3.svg.axis()
            // .tickValues()
          .tickFormat(function(d) {
            console.log(d);
            var myDate = new Date( d * 1000);
            console.log(myDate);
            year = myDate.getUTCFullYear();
            month = myDate.getUTCMonth() + 1;
            console.log(year);
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
            .call(xAxis);

      svg.append("g")
          .attr("class", "axis")
          .attr("transform", "translate("+50+",0)")
          .call(yAxis);
};









$(document).ready(function() {

  graph = new BlankGraph()
  // graph.makeAxis()

  $.each(sources, function(index, val) {
    // new addToGraph(val)
  });



  });
