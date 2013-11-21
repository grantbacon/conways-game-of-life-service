<!DOCTYPE html>

<html>
<head>
<title> game o' life </title>
<link rel="stylesheet" type="text/css" href="/static/css/index.css" />
<link rel="apple-touch-icon" href="/static/apple-touch-icon.png" />
<link rel="shortcut icon" href="/static/favicon.ico" />
</head>

<body>

<h1> the game of life </h1>
<hr>

<table class='life-table' border='1px'>
</table>

<hr>

<form action="#" name="controls">
    height: <input class="height-box" type="text" name="height" />
    width: <input class="width-box" type="text" name="width" />
    <br>
    <button type="button" class="play"> play </button>
    <button type="button" class="stop"> stop </button>
</form>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/static/js/index.js"></script>



</body>
</html>
