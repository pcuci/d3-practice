Template.Chart.rendered = ->
  #d3.select('.item:nth-child(2)').text('select')
  #d3.selectAll('.item:nth-child(odd)').text('select')
  # d3.select('.item')
  #   .append("div")
  #   .html('<strong>selection</strong>')
  # d3.select('.item:nth-child(3)')
  #   .append("span")
  #   .html('<strong>selection</strong>')
  # d3.select('.item:nth-child(2)')
  #   .remove
  # d3.select('.item')
  #   .attr('class', 'highlight')
  # d3.select('.item:nth-child(3)')
  #   .classed(
  #     "highlight": true
  #     "item": false
  #     "bigger": true
  #   )
  # d3.select('.item:nth-child(4)')
  #   .style(
  #     'background': '#268BD2'
  #     'padding': '10px'
  #     'margin': '5px'
  #     'color': '#EEE8D5'
  #   )
  # d3.selectAll('.item')
  #   .data([true, true])
  #   .style('background', myStyles[0])

  myStyles = [
    width: 100
    name: "Barr Two"
    color: '#268BD2'
  ,
    width: 100
    name: "Paul Cuci"
    color: "#819090"
  ,
    width: 100
    name: "Barr Three"
    color: "#708284"
  ,
    width: 100
    name: "Bar None"
    color: "#536870"
  ,
    width: 100
    name: "Core None"
    color: "#475B62"
  ,
    width: 100
    name: "Boombastic New"
    color: "#0A2933"
  ]
  # d3.selectAll('.item')
  #   .data(myStyles)
  #   .style(
  #     'color': 'white'
  #     'background': (d) ->
  #       d.color
  #     'width': (d) ->
  #       d.width
  #   )
  d3.select('#chart')
    .selectAll('div')
    .data(myStyles)
    .enter()
    .append('div')
    .classed('item', true)
    .text((d) ->
      d.name
    )
    .style(
      'color': 'white'
      'background': (d) ->
        d.color
      'width': (d) ->
        d.width
    )
  d3.select('div#chart2')
    .append('svg')
      .attr('width', 600)
      .attr('height', 400)
      .style('background', "#949494")
    .append("rect")
      .attr('x', 200)
      .attr('y', 100)
      .attr('height', 200)
      .attr('width', 200)
      .style('fill', '#CB4B19')
  d3.select('svg')
    .append('circle')
      .attr('cx', '400')
      .attr('cy', '200')
      .attr('r', '50')
      .style('fill', '#840043')
  bardata = []

  for i in [1..20]
    bardata.push(Math.random() * i * 30)

  height = 400
  width = 600
  barWidth = 50
  barOffset = 5

  yScale = d3.scale.linear()
    .domain([0, d3.max(bardata)])
    .range([0, height])
  xScale = d3.scale.ordinal()
    .domain(d3.range(0, bardata.length))
    .rangeBands([0, width])
  colors = d3.scale.linear()
    .domain([0, bardata.length*0.33, bardata.length*0.66, bardata.length])
    .range(['#B58929', '#C61C6F', '#268BD2', '#85992C'])

  tempColor = '#000000'

  tooltip = d3.select('body')
    .append('div')
    .style('position', 'absolute')
    .style('padding', '0 10px')
    .style('background', 'white')
    .style('opacity', 0)

  myChart = d3.select('div#chartBar')
    .append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
      .style('background', '#C9D7D6')
        .selectAll('rect')
        .data(bardata)
        .enter()
        .append('rect')
        .style('fill', (d, i) ->
          colors(i)
        )
        .attr('width', xScale.rangeBand())
        .attr('x', (d, i) ->
          xScale(i)
        )
        .attr('height', 0)
        .attr('y', height)
      .on('mouseover', (d) ->
        tooltip.transition()
          .style('opacity', 0.9)
        tooltip.html(d)
          .style('left', (d3.event.pageX) + 'px')
          .style('top', (d3.event.pageY) + 'px')
        tempColor = this.style.fill
        d3.select(this)
          .transition()
          .delay(500)
          .duration(800)
          .style('opacity', 0.5)
          .style('fill', 'yellow')
      )
      .on('mouseout', () ->
        d3.select(this)
          .style('opacity', 1)
          .style('fill', tempColor)
      )
  myChart.transition()
    .attr('height', (d) ->
      yScale(d)
    )
    .attr('y', (d) ->
      height - yScale(d)
    )
    .delay((d, i) ->
      i * 7
    )
    .duration(1000)
    .ease('elastic')
