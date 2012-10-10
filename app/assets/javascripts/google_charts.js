player_chart = window.player_chart

function drawChart(chart_div, graph_title, graphData) {  
  var data = google.visualization.arrayToDataTable(graphData);
  
  var options = {
    title: graph_title,
    // is3D: true,
    height: 200,
    legend: 'none',
    fontSize: 10,
    chartArea: { top:20 },
    colors: ['#4C8EFB'] // colors of the nodes are defined here
    // range: 0
  };

  var chart = new google.visualization.BarChart(document.getElementById(chart_div));
  chart.draw(data, options);
}

function playerChart() {
  drawChart('br_chart', 'Br', player_chart)
}