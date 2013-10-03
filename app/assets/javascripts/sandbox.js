
function BlankGraph () {


  w = $("#scatter").width();
  h = $("#scatter").height();
  padding = 30;

  svg = d3.select("#scatter")
              .append('svg')
              .attr("width", w)
              .attr("height", h)

}

function Calendar (data,source) {

  this.el = $('.'+source);
  this.source = source;
  this.visible = false;
  this.button = $("#calendarButtons ."+source);
  var self = this;

  var calendarData =  _.map(data,function (el,i,list) {
                    day = [];
                    day[0] = moment.unix(el[0]).format('YYYY-MM-DD');
                    day[1] = el[1];
                    day[2] = el[2];
                    return day;
                  });


  this.data = calendarData
  // this.drawCalendar(this.data);

this.button.on('click', function(event) {
    event.preventDefault();
    if (!self.el.hasClass('visible')){
      self.drawCalendar(self.data);

      $("#calendarButtons").children().removeClass('visible');
      self.el.addClass('visible');
    }
  });

    if (this.el.hasClass('visible')) {self.drawCalendar(self.data)};
  // console.log(this.source);
  // console.log(calendarData);

}

function grabSources (argument) {
    var plotPoints =[];

    d3.json("/scatter", function(error, data){

      data.forEach(function(d){
        plotPoints.push([d.date, d.score, d.source])
      });
      $("#waiting").remove()

    xScale = d3.scale.linear()
        .domain([d3.min(plotPoints, function (d) { return d[0] }),d3.max(plotPoints, function(d) { return d[0]; })])
        .range([padding,w-(padding/2)]);

    yScale = d3.scale.linear()
        .domain([0.1,-0.1])
        .range([padding,h-padding]);

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
  this.button = $('#scatterButtons .'+source);
  this.circleGroup = svg.append('svg:g');
  this.linePlot = svg.append('path');
  this.visible = true;
  console.log(source);
  this.calendar = new Calendar(data,source);

  // d3.json("/scatter", function(error, data){
  //     data.forEach(function(d){
  //       self.plotPoints.push([d.date, d.score, d.source])
  //     });
  // // });

  // sources = _.groupBy(self.plotPoints, function(d){return d[2]});

  this.makeCircles(this.data)
  var months = monthlyAverages(this.data);
  this.makeLine(months, source);
  graph.makeAxis()


  this.button.on('click', function(event) {
    event.preventDefault();
    // console.log(self.circleGroup)
    if (self.visible == true){
          self.circleGroup.transition()
              .style('opacity',0);
          self.linePlot.transition()
              .style('opacity',0);

          self.button.removeClass('selected');
          self.visible = false;

    }
    else{
          self.circleGroup.transition()
              .style('opacity',1);
          self.linePlot.transition()
              .style('opacity',1);

          self.button.addClass('selected');
          self.visible = true;
    }
  });
}


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
            .ticks(6)


      svg.append("g")
            .attr("class", "axis")
            .attr("transform", "translate("+(0)+"," + ((h/2)) + ")")
            // .attr("transform", "translate("+25+",0")
            .call(xAxis);

      svg.append("g")
          .attr("class", "axis")
          .attr("transform", "translate("+padding+",0)")
          .call(yAxis);
};







$(document).ready(function() {
  $("#waiting").prepend("<h2>Loading...</h2><img alt='Slipnslide' src='/assets/deal_with_it.gif'>")
  // Calendar();
  graph = new BlankGraph()

  grabSources();
});

