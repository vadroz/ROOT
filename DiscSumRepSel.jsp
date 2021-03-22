<%@ page import="java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=DiscSumRepSel.jsp&APPL=ALL");
   }
   else
   {
      
%>
<HTML>
<HEAD>
<title>Discount By Code Summary Selection</title>
<META content="RCI, Inc." name="E-Commerce">

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

</HEAD>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<script name="javascript">

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	doSelDate();
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function doSelDate()
{
	var df = document.all;

	var date = new Date(new Date() - 7 * 86400000);
    df.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    var date = new Date(new Date() - 86400000);
    df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
//populate date with yesterdate
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
// find object postition
//==============================================================================
function objPosition(obj)
{
   var pos = new Array(2);
   pos[0] = 0;
   pos[1] = 0;
   // position menu on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
	var error = false;
  	var msg = "";

  	var frdt = document.all.FrDate.value.trim();
  	var todt = document.all.ToDate.value.trim();
  	
  	var chkbox = document.getElementById("TechDiv");
  	var techdiv = "N";
  	if(chkbox.checked){ techdiv = "Y"; }
  	
  	var radio = document.getElementsByName("Bogo");
    var bogo = null;
    for(var i=0; i < radio.length; i++)
    {	 
  	  if(radio[i].checked){ bogo = radio[i].value; break; }
    }
    
    radio = document.getElementsByName("Code");
    var code = null;
    for(var i=0; i < radio.length; i++)
    {	 
  	  if(radio[i].checked){ code = radio[i].value; break; }
    }
    
    radio = document.getElementsByName("Cust");
    var cust = null;
    for(var i=0; i < radio.length; i++)
    {	 
  	  if(radio[i].checked){ cust = radio[i].value; break; }
    }
    
  	if (error) alert(msg);
  	else{ sbmAudit(frdt, todt, techdiv, bogo, code, cust); }
  	return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmAudit(frdt, todt, techdiv, bogo, code, cust)
{
	var url = null;
  	url = "DiscSumRep.jsp?"

  	url += "FrDate=" + frdt
      + "&ToDate=" + todt
      + "&InclDiv=" + techdiv
      + "&Bogo=" + bogo
      + "&Code=" + code
      + "&Cust=" + cust
    ;
  
  	//alert(url)
  	window.location.href=url;
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Discount By Code Summary - Selection</B>
        <br>
          <a href="/"><font color="red" size="-1">Home</font></a>
      <TABLE border=0>
        <TBODY>    
        
        <TR>
          <TD id="tdDate2"  align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 400, 250, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 800, 250, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
          </TD>
        </TR>   
        
        <!-- ================================================================================================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
            <TD  align=center valign ="top" nowrap>
              <input class="Small" name="TechDiv" type="checkbox" value="Y">  
              Include divisions 95,96,97,98</b>
            </td>
        </TR>      
        <tr>
            <TD  align=center valign ="top" nowrap>      
              <span style="font-size:10px;">
                (Generic sales for: Special Orders, Rentals, and Ski/Bike labor will skew discount results)
                </span>
            </td>
        </TR>
        
        <!-- ================================================================================================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
            <TD align=center nowrap>
                <b>Advertised BOGO Discounts</b><br><span style="font-size:10px;">(applies codes 02 or 12)</span>
            </td>
        </TR>
        <tr>    
        	<TD  align=left nowrap>                
              <input class="Small" name="Bogo" id="Bogo1" type="radio" value="1" checked> exclude BOGO &nbsp; &nbsp;
              <input class="Small" name="Bogo" id="Bogo2" type="radio" value="2"> include BOGO &nbsp; &nbsp;
              <input class="Small" name="Bogo" id="Bogo3" type="radio" value="3"> only BOGO 
            </td>
        </TR>
        <tr>
            <TD align=center style="font-size:10px;" nowrap>
                (BOGO sales sold at 50% off are typically "authorized" and should be excluded)

            </td>
        </TR>
        <!-- ================================================================================================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
            <TD  colspan=2 align=center  nowrap>
                <b>Marketing Code:</b>
            </td>
        </TR>
        <tr>    
        	<TD align=left  nowrap>                
              <input class="Small" name="Code" id="Bogo1" type="radio" value="1" checked>Do not filter on Marketing Code <span style="font-size:10px;">(show all discounts)</span> &nbsp; &nbsp;
              <input class="Small" name="Code" id="Bogo2" type="radio" value="2">Has a Marketing Code only &nbsp; &nbsp;
              <input class="Small" name="Code" id="Bogo3" type="radio" value="3">Has NO Marketing Code
            </td>
        </TR>
        <tr>
            <TD align=center style="font-size:10px;" nowrap>
                (Selection is to include/exclude discounts IF a "Marketing Code" was attached to the discount)

            </td>
        </TR>
        <!-- ================================================================================================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
            <TD align=center  nowrap>
                <b>Customer Phone #'s:</b>
            </td>
        </TR>
        <tr>    
        	<TD align=left  nowrap>                
              <input class="Small" name="Cust" id="Bogo1" type="radio" value="1" checked>Do not filter on Customer Phone #'s <span style="font-size:10px;">(show all discounts)</span> &nbsp; &nbsp;
              <input class="Small" name="Cust" id="Bogo2" type="radio" value="2">Exclude Store (Walk-In) customer phone #'s &nbsp; &nbsp;
              <input class="Small" name="Cust" id="Bogo3" type="radio" value="3">Include Only Store (Walk-In) Customer phone #'s
            </td>
        </TR>
        <tr>
            <TD align=center style="font-size:10px;" nowrap>
                (Selection to include/include discounts that were rung under a the store's default (Walk-In Customer) main Phone #)

            </td>
        </TR>
        <!-- ================================================================================================= -->

        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center>
               <button onClick="Validate()">Submit</button>
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>
