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
  d3.tsv('data.tsv', (data) ->
    for key in data
      bardata.push(key.value)
    margin =
      top: 30
      right: 30
      bottom: 40
      left: 50

    height = 400 - (margin.top + margin.bottom)
    width = 600 - (margin.left + margin.right)
    barWidth = 50
    barOffset = 5

    yScale = d3.scale.linear()
      .domain([0, d3.max(bardata)])
      .range([0, height])
    xScale = d3.scale.ordinal()
      .domain(d3.range(0, bardata.length))
      .rangeBands([0, width], 0.2, 0.5)
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
      .attr('width', width + margin.right + margin.left)
      .attr('height', height + margin.top + margin.bottom)
      .append('g')
        .attr('transform', 'translate(' + margin.left + ', ' + margin.right + ')')
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
            .duration(200)
            .style('opacity', 0.5)
            .style('fill', 'yellow')
        )
        .on('mouseout', () ->
          d3.select(this)
            .transition()
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
      .ease('elastic')
    vAxis = d3.svg.axis()
      .scale(yScale)
      .orient('left')
      .ticks(10)
    vGuide = d3.select('div#chartBar svg')
      .append('g')
    vGuideScale = d3.scale.linear()
      .domain([0, d3.max(bardata)])
      .range([height, 0])

    vAxis(vGuide)
    vGuide.attr('transform', 'translate(' + margin.left + ', ' + margin.top + ')')
    vGuide.selectAll('path')
      .style(
        fill: 'none'
        stroke: '#000'
      )
    vGuide.selectAll('line')
      .style(
        stroke: '#000'
      )

    hAxis = d3.svg.axis()
      .scale(xScale)
      .orient('bottom')
      .tickValues(xScale.domain().filter((d, i) ->
        if i % (bardata.length // 5)
          false
        else
          true
      ))
    hGuide = d3.select('div#chartBar svg')
      .append('g')
    hAxis(hGuide)
    hGuide.attr('transform', 'translate(' + margin.left + ', ' + (height + margin.top) + ')')
    hGuide.selectAll('path')
      .style(
        fill: 'none'
        stroke: '#000'
      )
    hGuide.selectAll('line')
      .style(
        stroke: '#000'
      )
  )

  width = 400
  height = 400
  radius = 200
  piedata = [
    label: "Barot"
    value: 20
  ,
    label: "Gerard"
    value: 50
  ,
    label: "Mike"
    value: 50
  ,
    label: "Gerards"
    value: 60
  ,
    label: "Mikes"
    value: 50
  ]
  colors = d3.scale.category20c()

  pie = d3.layout.pie()
    .value((d) ->
      d.value
    )
  arc = d3.svg.arc()
    .outerRadius(radius)
  myPie = d3.select('#pieChart')
    .attr('height', height)
    .attr('width', width)
    .append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', 'translate(' + (width - radius) + ', ' + (height - radius) + ')')
    .selectAll('path').data(pie(piedata))
      .enter()
      .append('g')
      .attr('class', 'slice')

  slices = d3.selectAll('g.slice')
    .append('path')
      .attr('fill', (d, i) ->
        colors(i)
      )
      .attr('d', arc)
  text = d3.selectAll('g.slice')
    .append('text')
    .text((d, i) ->
      d.data.label
    )
    .attr('text-anchor', 'middle')
    .attr('fill', 'white')
    .attr('transform', (d) ->
      d.innerRadius = 0
      d.outerRadius = radius
      'translate(' + arc.centroid(d) + ')'
    )

  w = 900
  h = 400
  circleWidth = 8
  fontFamily = "Bree Serif"
  fontSizeHighlight = "1.5em"
  fontSizeNormal = "1em"
  palette =
    lightgray: "#819090"
    gray: "#708284"
    mediumgray: "#536870"
    darkgray: "#475B62"
    darkblue: "#0A2933"
    darkerblue: "#042029"
    paleryellow: "#FCF4DC"
    paleyellow: "#EAE3CB"
    yellow: "#A57706"
    orange: "#BD3613"
    red: "#D11C24"
    pink: "#C61C6F"
    purple: "#595AB7"
    blue: "#2176C7"
    green: "#259286"
    yellowgreen: "#738A05"

  nodes = [
    name: "Parent"
  ,
    name: "child1"
  ,
    name: "child2"
    target: [0]
  ,
    name: "child3"
    target: [0]
  ,
    name: "child4"
    target: [1]
  ,
    name: "child5"
    target: [0, 1, 2, 3]
   ]
  links = []
  for node in nodes
    if node.target?
      for target in node.target
        links.push(
          source: node
          target: nodes[target]
        )
  vis = d3.select("body")
    .append("svg:svg")
      .attr("class", "stage")
      .attr("width", w)
      .attr("height", h)
  force = d3.layout.force()
    .nodes(nodes)
    .links([])
    .gravity(0.1)
    .charge(-1000)
    .size([w, h])
  link = vis.selectAll(".link")
    .data(links).enter()
      .append("line")
        .attr("class", "link")
        .attr("stroke", palette.gray)
        .attr("fill", "none")

  #TEXT
  node = vis.selectAll("circle.node")
    .data(nodes).enter()
      .append("g")
        .attr("class", "node")
        .on("mouseover", (d, i) ->
          if i > 0
            d3.select(this).selectAll("circle").transition().duration(250).style("cursor", "none").attr("r", circleWidth + 3).attr "fill", palette.orange
            d3.select(this).select("text").transition().style("cursor", "none").duration(250).style("cursor", "none").attr("font-size", "1.5em").attr("x", 15).attr "y", 5
          else
            d3.select(this).selectAll("circle").style "cursor", "none"
            d3.select(this).select("text").style "cursor", "none"
        )
        .on("mouseout", (d, i) ->
          if i > 0
            d3.select(this).selectAll("circle").transition().duration(250).attr("r", circleWidth).attr "fill", palette.pink
            d3.select(this).select("text").transition().duration(250).attr("font-size", "1em").attr("x", 8).attr "y", 4
        ).call(force.drag)

  #CIRCLE
  node.append("svg:circle")
    .attr("cx", (d) ->
      d.x
    ).attr("cy", (d) ->
      d.y
    )
    .attr("r", circleWidth).attr "fill", (d, i) ->
      if i > 0
        palette.pink
      else
        palette.purple

  #TEXT
  node.append("text").text((d, i) ->
    d.name
  )
  .attr("x", (d, i) ->
    if i > 0
      circleWidth + 5
    else
      -10
  )
  .attr("y", (d, i) ->
    if i > 0
      circleWidth + 0
    else
      8
  )
  .attr("font-family", "Bree Serif")
  .attr("fill", (d, i) ->
    if i > 0
      palette.paleryellow
    else
      palette.yellowgreen
  )
  .attr("font-size", (d, i) ->
    if i > 0
      "1em"
    else
      "1.8em"
  )
  .attr "text-anchor", (d, i) ->
    if i > 0
      "beginning"
    else
      "end"

  force.on "tick", (e) ->
    node.attr "transform", (d, i) ->
      "translate(" + d.x + "," + d.y + ")"
    link
      .attr("x1", (d) ->
        d.source.x
      )
      .attr("y1", (d) ->
        d.source.y
      )
      .attr("x2", (d) ->
        d.target.x
      )
      .attr "y2", (d) ->
        d.target.y

  force.start()
