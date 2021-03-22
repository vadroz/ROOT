<%@ page import="java.util.*"%>
<%
%>

<style type="text/css">

</style>


<html>
<head>
 <style>
  input.cbBox01 { visibility: hidden; }
  .checkboxOne {width: 40px;height: 10px;background: #555;margin: 20px 80px;position: relative;border-radius: 3px;}
  .checkboxOne label {	display: block;	width: 16px;height: 16px;border-radius: 50%;
     -webkit-transition: all .5s ease;-moz-transition: all .5s ease;-o-transition: all .5s ease;
     -ms-transition: all .5s ease;
    transition: all .5s ease;cursor: pointer;position: absolute;top: -3px;left: -3px;background: #ccc;}
    
  .checkboxOne input[type=checkbox]:checked + label {left: 27px;}  
 </style>
</head> 
 
  <body>
    <h1>Test check box</h1>
    
    
    <section>
  <!-- Checbox One -->
  <h3>Checkbox One</h3>
  	<div class="checkboxOne">
  		<input class="cbBox01" type="checkbox" value="1" id="checkboxOneInput" name="" onchange="window.status=this.checked"/>
	  	<label for="checkboxOneInput"></label>
  	</div>
</section>
    
  </body>
</html>




