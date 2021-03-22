<!DOCTYPE HTML > 
<%@ page import="java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuStrSrlRtnSel.jsp&APPL=ALL");
   }
   else
   {
	   String sSelStr = "ALL";		
	   String sStrAllowed = session.getAttribute("STORE").toString();		
	   if(!sStrAllowed.startsWith("ALL")){ sSelStr = sStrAllowed; }
	   int iSpace = 6;
	   	   
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Item Return</title>


<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>

<script name="javascript">
var CstProp = null;
var Cust = null;
var SelStr = "<%=sSelStr%>";

//jQuery(function($){ $("#Cust").mask("999-999-9999");	});
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{   
  setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
  doSelDate()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{  
  var date = new Date(new Date() - 7 * 86400000);
  document.all.FrOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  date = new Date(new Date());
  document.all.ToOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
// Validate form entry fields
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";
  var br = "";
  document.all.tdError.innerHTML = "";
    
  var frdate = document.all.FrOrdDate.value;
  var todate = document.all.ToOrdDate.value;
    
  if (error) document.all.tdError.innerHTML = msg;
  else { sbmRep(frdate, todate);  }
  return error == false;
} 
//==============================================================================
// submit form
//==============================================================================
function sbmRep(frdate, todate) 
{   
   var url = "MozuSoldOutLst.jsp?From=" +  frdate
     + "&To=" + todate 
     
   //alert(url)
   window.location.href=url
}
</script>

<!-- import calendar functions -->
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<body onload="bodyLoad();" class="body">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->


<TABLE class="tbl05">
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Mozu Daily Sold Out Report - Selection</B>
        
       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>
       <br>&nbsp;

       <!-- -->
      <TABLE  border="0">
         
        <!-- ======================== From Date ======================================= -->
        <tr>  
          <TD id="tdDate2" class="Date2" colspan=2>
             <b>From:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrOrdDate')">&#60;</button>
              <input class="Small" name="FrOrdDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 150, document.all.FrOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToOrdDate')">&#60;</button>
              <input class="Small" name="ToOrdDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 700, 150, document.all.ToOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>              
          </TD>
        </TR>
        
        </tbody>

        <!-- =============================================================== -->
        <TR>
           <TD colspan=2 style="text-align:center"> 
               <button type=submit onclick="Validate()" name=SUBMIT >Submit</button>
           </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
           <TD colspan=2 style="color:red;text-align: left" id="tdError"></TD>
        </TR>
        
       <!-- =============================================================== -->
       </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%}%>