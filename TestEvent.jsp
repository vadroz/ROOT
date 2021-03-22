<%@ page import="java.io.*, java.text.*"%>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"-->

<html>
<head>

<style>
  table.tbData { border-radius: 15px;}

  body {background:ivory;}
  div.dvStatus { position:fixed; top:30px; left:400px; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}



  thead tr {
         position: relative;
         top: expression(this.offsetParent.scrollTop);
        }
</style>

<SCRIPT language="JavaScript1.2">
//==============================================================================
// initialize
//==============================================================================
function bodyLoad()
{
   wrtDiv("1. bodyLoad()");
}
//==============================================================================
// key pressed
//==============================================================================
function isKeyPressed(event)
{
  if (event.altKey==1) { wrtDiv("The ALT key was pressed!"); }
  else { wrtDiv("The ALT key was NOT pressed!") }

  wrtDiv(" Button pressed: " + event.button);

  var x=event.clientX
  var y=event.clientY
  wrtDiv("client: X coords: " + x + ", Y coords: " + y);

  var x=event.screenX
  var y=event.screenY
  wrtDiv("screen: X coords: " + x + ", Y coords: " + y)

  wrtDiv(event.type)
}

//==============================================================================
// body scroll listener
//==============================================================================
function fScroll(event, obj)
{
  var x=obj.offsetLeft
  var y=obj.offsetTop

  wrtDiv("Scroll\n screen: X coords: " + x + ", Y coords: " + y)
}
//==============================================================================
// show status
//==============================================================================
function wrtDiv(text)
{
  var divtxt = document.all.dvStatus.innerHTML;
  if (divtxt == "") { document.all.dvStatus.innerHTML = text; }
  else { document.all.dvStatus.innerHTML += "<br>" + text; }
}
</SCRIPT>

</head>
<!-- ======================================================================= -->
<body onload="bodyLoad()" onmousedown="isKeyPressed(event)">

  <div id="dvStatus" class="dvStatus"></div>
<br><br>
  <table border=1 style="tbData">
    <thead>
      <tr id="thFixed"><th>col header</th><th>col header</th><th>col header</th></tr>
    </thead>
    <tbody>
       <%for(int i=0; i < 100; i++){%>
         <tr onmousewheel="fScroll(event, this)"><td>row <%=i%></td><td>row <%=i%></td><td>row <%=i%></td></tr>
       <%}%>
    </tbody>
  </table>
</body>
</html>
