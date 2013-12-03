<!DOCTYPE html>

<html>
<head>
<title> conway's game o' life </title>
<link rel="stylesheet" type="text/css" href="/static/css/index.css" />
<link rel="apple-touch-icon" href="/static/apple-touch-icon.png" />
<link rel="shortcut icon" href="/static/favicon.ico" />
</head>

<body>

<h1> conway's game of life </h1>

<div class="game">
    <table class='life-table' border='1px'>
    </table>
</div>

<div class="controls">
<form action="#" name="controls">
    height: <input class="height-box" type="text" name="height" />
    width: <input class="width-box" type="text" name="width" />
    <br><br>
    <button type="button" class="play"> play </button>
    <button type="button" class="stop"> stop </button>
    <br><br>
    <div class="speed-div">
    <!--
    <input type="radio" name="speed" id="speedSlow" class="speed-box" value="slow" /> <label for="speedSlow">Slow</label>
    <input type="radio" name="speed" id="speedMedium" class="speed-box" value="medium" /> <label for="speedMedium">Medium</label>
    <input type="radio" name="speed" id="speedFast" class="speed-box" value="medium" /> <label for="speedFast">Fast</label>
    -->
    evolution speed (in milliseconds [>=100]):  <input type="text" class="speed-box" name="speed" />
    </div>
</form>
</div>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/static/js/index.js"></script>



</body>
</html>
