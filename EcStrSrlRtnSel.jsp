<!DOCTYPE HTML > 
<%@ page import="java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EcStrSrlRtnSel.jsp&APPL=ALL");
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

<title>ECom-Return</title>


<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="http://digitalbush.com/wp-content/uploads/2014/10/jquery.maskedinput.js"></script>

<script name="javascript">
var CstProp = null;
var Cust = null;
var SelStr = "<%=sSelStr%>";

jQuery(function($){ $("#Cust").mask("999-999-9999");	});
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  //document.all.tdDate1.style.display="inline"
  //document.all.tdDate2.style.display="none"
  $('.Date2').hide();
  
  setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(datety)
{
    $('.Date1').hide();
	$('.Date2').toggle();
  
    doSelDate(datety)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(datety)
{
      $('.Date1').toggle();
	  $('.Date2').hide();
	  
      document.all.FrOrdDate.value = "01/01/0001";
      document.all.ToOrdDate.value = "12/31/2999";
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(datety)
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
   
  var cust = document.all.Cust.value.trim();
   
  var ord = document.all.Order.value.trim().toUpperCase();
  if(ord != "" && (isNaN(ord) || eval(ord) == 0)){error=true; msg += br + "Order is not numeric or 0."; br = "<br>";}

  var sku = document.all.Sku.value.trim().toUpperCase();
  if(sku != "" && (isNaN(sku) || eval(sku) == 0)){error=true; msg += br + "SKU is not numeric or 0."; br = "<br>";}

  var rtnsts = new Array();
  var stschk = false;
  if(SelStr == "ALL")
  {  
	  if(document.all.Sts[0].checked)
	  {
		  rtnsts[0] = document.all.Sts[0].value;
		  stschk = true;
	  }	 
	  if(document.all.Sts[1].checked)
	  {
		  rtnsts[1] = document.all.Sts[1].value;
		  stschk = true;
	  }	
  }
  else { rtnsts[0] = "ALL"; stschk = true; }
  
  if( !stschk ){error=true; msg += br + "Please select return Status."; br = "<br>";}
  
  var frdate = document.all.FrOrdDate.value;
  var todate = document.all.ToOrdDate.value;
  
  if(cust=="" ){ cust = "ALL"; }
  if(ord=="" ){ ord = "ALL"; }
  if(sku=="" ){ sku = "ALL"; }
  
  if(SelStr != "ALL" && cust=="ALL" && ord=="ALL" && sku=="ALL" && frdate=="01/01/0001" && todate=="12/31/2999" )
  {
	  error=true; msg += br + "Please select at least one parameter or date range"; br = "<br>";
  }    
  
  if (error) document.all.tdError.innerHTML = msg;
  else { sbmRep(cust, ord, sku, rtnsts, frdate, todate);  }
  return error == false;
}
//==============================================================================
// unmask
//==============================================================================
function unmask(phone)
{
	var nphn = "";
	for(var i=0; i < phone.length; i++)
	{
		if(phone.substring(i, i+1) != "("
		   && phone.substring(i, i+1) != ")"
		   && phone.substring(i, i+1) != "-"
		   && phone.substring(i, i+1) != " "
		)
		{ 
			nphn += phone.substring(i, i+1); 
		}
	}
	return nphn
}
//==============================================================================
// submit form
//==============================================================================
function sbmRep(cust, ord, sku, rtnsts, frdate, todate) 
{   
   var url = "EcStrSrlRtn.jsp?Cust=" + cust
     + "&Order=" + ord
     + "&Sku=" + sku
	 + "&FrDate=" +  frdate
     + "&ToDate=" + todate

    for(var i=0; i < rtnsts.length; i++)
    {
   		url += "&Sts=" + rtnsts[i];
    }
   
   //alert(url)
   window.location.href=url
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
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
        <BR>ECOM Item Return - Selection</B>

       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

       <!-- -->
      <TABLE  border="0">
        <!-- ======================== Customer ======================================= -->
        <TR>
          <td>Customer:</td>
          <td><input id="Cust" name="Cust"  tabindex="3" type="text"/></td>
                    
        </TR> 
        <!-- ======================== Order ======================================= -->
        <TR>
          <td>Order:</td>
          <td><input name="Order"></td>          
        </TR>  
        <!-- ======================== SKU ======================================= -->
        <TR>
          <td>SKU:</td>
          <td><input name="Sku"></td>          
        </TR>
        <!-- ======================== Processed ======================================= -->
        <%if(sSelStr.equals("ALL")){%>
        	<TR>
          		<td>Status:</td>
          		<td>
          		   <input name="Sts" type="checkbox" value="Submitted" checked>Submitted &nbsp; &nbsp; &nbsp;
          		   <input name="Sts" type="checkbox" value="Processed" >Processed          		   
          		</td>          
        	</TR>
        <%}%> 
        <!-- ======================== From Date ======================================= -->
        <TR>
          <td id="tdDate1" class="Date1" colspan=2 style="text-align:center;" >   
             <button class="Small" id="btnSelOrdToday" onclick="showDates('SEASON')">Date Selection</button> &nbsp
          </td>
        </tr>
        <tr>  
          <TD id="tdDate2" class="Date2" colspan=2>
             <b>Quote Date From:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrOrdDate')">&#60;</button>
              <input class="Small" name="FrOrdDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 150, document.all.FrOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>Quote Date To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToOrdDate')">&#60;</button>
              <input class="Small" name="ToOrdDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 700, 150, document.all.ToOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelOrdDates" onclick="showAllDates('ORD')">All Date</button>
          </TD>
        </TR>
        

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