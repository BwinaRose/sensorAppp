
<html>
<head>
  <script src="https://d3js.org/d3.v4.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="/js/plotting.js"></script>
</head>
<form onsubmit="plotGraphs();window.setInterval(plotGraphs,1000);return false;">
<select name='filename' id='filename'>
    %for file_name in listdirs:
      <option>{{file_name}}</option>
    %end
</select>
<input value="Show" type='submit'></input>
</form>

<div id="graphs">
<span id="chart1" ></span>
<span id="chart2"></span>
<span id="chart3"></span>
</div>

</html>
