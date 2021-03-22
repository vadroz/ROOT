<%@ page import="java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComCustOrdLstSel.jsp");
}
else
{
%>
<HTML>
<HEAD>
<title>E-Commerce Last Customer Order - Select</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>
<style>
  body {background:ivory;}
</style>

<script name="javascript1.2">
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  popSelDate();
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function popSelDate()
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.From.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// re-submit
//==============================================================================
function sbmOrdListReq()
{
   var from = document.all.From.value
   var url = "EComCustOrdLst.jsp?"
           + "&From=" + from
           + "&Action=UPLOAD"
   //alert(url);
   window.location.href=url
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// re-submit
//==============================================================================
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0 id="tblSite">
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce - Customer E-Mail Addresses Sending to ELab
        </B><br>
       <br><a href="/"><font color="red" size="-1">Home</font></a>&#62;
       <font size="-1">This Page.</font><br><br>

       From Date:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'From')">&#60;</button>
              <input class="Small" name="From" type="text" size=10 maxlength=10 readOnly>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'From')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 150, document.all.From)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>&nbsp; &nbsp; &nbsp;
       <button onClick="sbmOrdListReq();">Download</button>
    </td>
  <tr>
</table>

</body>
<%}%>



