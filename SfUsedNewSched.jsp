<%

%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<meta http-equiv="refresh">

<style>
body {text-align: center;}
span.Msg {  border: black solid 2px; width:800; background-color:yellow; z-index:10;
               text-align: center; font-size:18px;               
               padding: 10px;               
}          
</style>
<title>Store Force</title>

<script>
setInterval("blinkIt()",500); 
//==============================================================================
//blink it
//==============================================================================
function blinkIt() 
{
	var s = document.all.Msg; 
	s.style.backgroundColor =(s.style.backgroundColor =='yellow')  ?'red':'yellow';	
}

</script>
</head>
 <body>
 <img src="Sun_ski_logo4.png"/>
  <br><br><br><br>
 <span class="Msg" id='Msg'>This is no longer used. Please logon and use the StoreForce version.
 Any question - ask Store Ops.  
 </span>
 <br><br><br><a href="../"><font color="red" size="-1">Home</font></a>
  </body>
</html>
