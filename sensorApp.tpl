<!DOCTYPE html>
<meta charset="utf-8">

<html>
  <head>
    <style>
    .h1{
      color: black;
      font-family:Arial Black,Gadget,sans-serif;
      font-weight:172;
      text-align:center;
      text-shadow:-2px 2px blue;
      font-size:34px;
      text-transform:uppercase;
    }

    .h3{
      padding: 50px;
    }

    .mainBG{
      opacity: 0.5;
      position:absolute;
      width:100%;
    }

    .div1{
      border: 5px outset blue;
      background-image: url(https://i.imgur.com/qJPcfNs.png);
      background-size: cover;
    }

    .mainPage{
      margin: 15px;
    }

    .liveData{
      float:left;
      width:50%;

    }

    .listData{
      float:right;
      width:50%;
    }
  </style>
    <!--css in here-->
      <script src="https://d3js.org/d3.v4.js"></script>
  </head>

  <body>
    <title>Sensor App</title>

    <div class="div1">
      <h1 class='h1'>OPC Data</h1>
    </div>



  <div class="mainPage">

    <div class="liveData">
      <h3 class="h3">RealTimeData</h3>
        <select>
          <option value="">device</option>
          <option value="">Raspberry Pi #1</option>
          <option value="">placeholder</option>
        </select>



      </div>


      <div class="listData">
        <a href='http://localhost:8080/datafiles'><h3 class='h3'>Data Files</h3></a>
    <!--   SEARCH BAR /// include later once i can get the datafiles to display on a page
      <form>
        <div class=”search-box”>
          <input type=”text” class=”search-by-name” name=”name” placeholder="YYYY-MM-DD.txt">
          <button type=”submit”>Search</button>
        </div>
      </form>
    -->
      </div>
    </div>

  </body>
</html>
