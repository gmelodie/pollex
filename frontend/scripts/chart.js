google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(drawChart);
function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['Option', 'Percentage'],
    ['Opção 1', 10],
    ['Opção 2', 25],
    ['Opção 3', 8],
    ['Opção 4', 25],
    ['Opção 5', 32]
  ])
  var options = {
    pieHole: 0.7,
    pieSliceText: "none",
  }
  var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
  chart.draw(data, options);

  function resizeChart () {
    chart.draw(data, options);
  }
  if (document.addEventListener) window.addEventListener('resize', resizeChart);
  else if (document.attachEvent) window.attachEvent('onresize', resizeChart);
  else window.resize = resizeChart;
}