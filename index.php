<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>Images</title>
	<style type="text/css">
		*{ padding:0; margin:0; }
		body{
			font-size:12px;
			background:#f8f8f8;
			font-family:Arial;
			-webkit-text-size-adjust:none;
			-webkit-tap-highlight-color:rgba(0,0,0,0);
		}
		div{
			background:#f90;
			line-height:40px;
			font-size:30px;
			cursor:pointer;
			text-align:center;
			width:80px;
			color:#fff;
			position:fixed;
			z-index:2;
			left:0;
			top:50%;
			margin-top:-20px;
			-webkit-box-shadow:1px 1px 2px rgba(0,0,0,.3);
		}
		ul{
			display:block;
			padding-left:50px;
			padding-top:10px;
		}
		li{
			line-height:30px;
			text-align:center;
			background:#fff;
			width:200px;
			margin:0 0 10px 10px;
			display:inline-block;
			border:5px solid #eee;
			-webkit-box-shadow:1px 1px 1px rgba(0,0,0,.2);
		}
		li img{
			display:block;
		}
		li img:hover{
			-webkit-filter:sepia(.3);
		}
	</style>
</head>
<body>
<ul>
<?php
date_default_timezone_set('UTC');
foreach(glob("*") as $page){
if( strpos($page, '_200') > 0 ){
?>
<li>
	<img src="<?php echo $page; ?>" />
	<?php echo $page; ?>
</li>
<?php 
	}
}
?>
</ul>
</body>
</html>
