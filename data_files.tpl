
<html>
<head>
  <script src="https://d3js.org/d3.v4.js"></script>
  <!-- <script src="http://d3js.org/d3.v3.min.js"></script> -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script type="text/javascript" src="/static/plotting.js"></script>
  <script type="text/javascript" src="/static/d3.slider.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <style>
.ui-slider {
	position: relative;
	text-align: left;
}
.ui-slider .ui-slider-handle {
	position: absolute;
	z-index: 2;
	width: 2.2em;
	height: 2.2em;
	cursor: default;
    background:#FDF8E4;
	-ms-touch-action: none;
	touch-action: none;
}
.ui-slider-horizontal {
	height: 1.8em;
    background:#846733;
}
</style>
<script>
  $(function() {
    $( "#slider1" ).slider({
  value: 50
});
  });
  </script>

<!--
  function sliderAdd(){
    d3.select("#slider1").call(d3.slider());
  }
  </script> -->
</head>

<nav>
  <a href="/">Home</a>
</nav>
<form onsubmit="plotGraphs();window.setInterval(plotGraphs,1000);return false;">
<select name='filename' id='filename'>
    %for file_name in listdirs:
      <option>{{file_name}}</option>
    %end
</select>
<input value="Show" type='submit'></input>
</form>

   <div style="width: 400px;" id="slider1">slider</div>

<div id="graphs">
<span id="chart1" ></span>
<span id="chart2"></span>
<span id="chart3"></span>
</div>
<!-- <script>sliderAdd()</script> -->

</html>
