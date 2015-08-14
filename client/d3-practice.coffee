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
  bardata = [
    20
    30
    45
    15
  ]

  height = 400
  width = 600
  barWidth = 50
  barOffset = 5

  d3.select('div#chartBar')
    .append('svg')
      .attr('width', width)
      .attr('height', height)
      .style('background', '#C9D7D6')
        .selectAll('rect')
        .data(bardata)
        .enter()
        .append('rect')
        .style('fill', '#C61C6F')
        .attr('width', barWidth)
        .attr('height', (d) ->
          d
        )
        .attr('x', (d, i) ->
          i * (barWidth + barOffset)
        )
        .attr('y', (d) ->
          height - d
        )
