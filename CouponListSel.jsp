<%@ page import="java.sql.*, java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
String sAppl = "COUPENT";
if (session.getAttribute("USER")==null
    || session.getAttribute(sAppl)==null && !session.getAttribute("APPLICATION").equals(sAppl))
{
     response.sendRedirect("SignOn1.jsp?TARGET=RentContListSel.jsp&APPL=ALL");
}
else
{

%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvRent { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}


  div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
  div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }

  tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; top: expression(this.offsetParent.scrollTop-3);}
  tr.TblRow { background:wite; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:middle; font-size:11px }


  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	document.all.tdDate3.style.display="block"
  	document.all.tdDate4.style.display="none"
}

//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   else
   {
     document.all.tdDate3.style.display="none"
     document.all.tdDate4.style.display="block"
   }
   doSelDate(type)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(type)
{
   document.all.tdDate3.style.display="block"
   document.all.tdDate4.style.display="none"
   document.all.FrDate.value = "ALLDATES"
   document.all.ToDate.value = "ALLDATES"
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  df.FrDate.value = (date.getMonth()) + "/" + date.getDate() + "/" + date.getFullYear()
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
// Validate form
//==============================================================================
function Validate(dwnl)
{
  var error = false;
  var msg = "";

  var code = document.all.Code.value.trim();
  if(code != "" && isNaN(code)){ error=true; msg="The Code is not numeric";}
  else if(code != "" && !getScannedItem(code)){ error=true; msg="The Code is not found."}
  
  var type = null;
  for(var i=0; i < document.all.Type.length; i++)
  {
     if(document.all.Type[i].checked){ type = document.all.Type[i].value; break;}
  }

  var user = document.all.UserId.value.trim();
  if(document.all.selAllUsr.checked){ user = "ALL"; }
  
  var name = document.all.Name.value.trim().toUpperCase();
  var reimb = document.all.Reimb.value.trim();
  
  var active = null;
  for(var i=0; i < document.all.Active.length; i++)
  {
     if(document.all.Active[i].checked){ active = document.all.Active[i].value; break;}
  }

  // order date
  var frdate = document.all.FrDate.value;
  var todate = document.all.ToDate.value;

  if (error) alert(msg);
  else if(code == ""){ sbmList( type, frdate, todate, name, reimb, active, user ); }
  else if(code != ""){ sbmInfo( code ); }
  
  return error == false;
}
//==============================================================================
// Submit coupon list
//==============================================================================
function sbmList(type, frdate, todate, name, reimb, active, user)
{
  if(isIE){ nwelem = document.createElement("div"); }
	 else if(isSafari){ nwelem = document.createElement("div"); }
	 else{ nwelem = window.contentDocument.createElement("div");}
  
  nwelem.id = "dvSbmCoupLst"

  var html = "<form name='frmPostCoupLst'"
     + " METHOD=Post ACTION='CouponList.jsp'>"
     + "<input name='SelType'>"
     + "<input name='SelFrDate'>"
     + "<input name='SelToDate'>"
     + "<input name='SelName'>"
     + "<input name='SelReimb'>"
     + "<input name='SelActive'>"
     + "<input name='SelCby'>"  
     ;
   html += "</form>"

  nwelem.innerHTML = html;
  
  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.document.appendChild(nwelem); }
  else if(isIE){ window.document.body.appendChild(nwelem); }
  else if(isSafari){ window.document.body.appendChild(nwelem); }
  else{ window.contentDocument.body.appendChild(nwelem); }

  if(isIE || isSafari)
	 {
 	    document.all.SelType.value = type; 	 
		document.all.SelFrDate.value = frdate;
        document.all.SelToDate.value = todate;
        document.all.SelName.value = name;
        document.all.SelReimb.value = reimb;
        document.all.SelActive.value = active;
		document.all.SelCby.value= user;
		
		document.frmPostCoupLst.submit();
	 }
  else
  {
	  window.contentDocument.forms[0].SelType.value = type; 	
 	  window.contentDocument.forms[0].SelFrDate.value = frdate;
      window.contentDocument.forms[0].SelToDate.value = todate;
      window.contentDocument.forms[0].SelName.value = name;
      window.contentDocument.forms[0].SelReimb.value = reimb;
      window.contentDocument.forms[0].SelActive.value = active;
	  window.contentDocument.forms[0].SelCby.value= user;
	 	 
 	  window.contentDocument.forms[0].submit();
  }
  
}
//==============================================================================
//Submit coupon info
//==============================================================================
function sbmInfo(code)
{
	var url = "CouponInfo.jsp?Code=" + code;

	//alert(url)
	window.location.href=url;
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(code)
{
	var valid = true;
	var sku = null;
	var url = "CouponValidate.jsp?Code=" + code;

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
   		if (xmlhttp.readyState==4 && xmlhttp.status==200)
   		{
      		var  resp = xmlhttp.responseText;
      		var beg = resp.indexOf("<Valid>") + 7;
      		var end = resp.indexOf("</Valid>");
      		valid = resp.substring(beg, end) == "true";   		
      	}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();
 
	return valid;
}
//==============================================================================
// set User entry field visible/unvisible
//==============================================================================
function setUserDisp(sel)
{
   if(sel.checked)
   {
      document.all.spnUser.style.display= "none";
   }
   else
   {
     document.all.spnUser.style.display= "inline";
   }
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle>
        <B>Coupon/Tracking Id Code List</B>

        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1><br>

      <TABLE border=0>
        <TBODY>
        <!-- ============== select date ========================== -->
        <TR><TD class="Cell2" colspan=5>Select Type Of List</TD></tr>
        
        <TR>
          <TD colspan=4 align=center style="padding-top: 10px; font-size:12px" >
          Coupon/Tracking Id: 
             <input name="Code" class="Small" size="6" maxlength="4">
          </TD>
        </TR>
        <TR>
          <TD colspan=4 align=center style="padding-top: 10px; font-size:12px" >
             <input type="radio" name="Type" class="Small" value="COUPON">Coupon Id
             <input type="radio" name="Type" class="Small" value="TRACKING">Tracking Id
             <input type="radio" name="Type" class="Small" value="BOTH" checked>Both
          </td>
        </TR>   
          <!-- ============== select entered by ========================== -->
          <TR>
          <TD colspan=4 align=center style="padding-top: 10px; font-size:12px" >
             <span id="spnUser" style="display:none" ><input name="UserId" class="Small"  value=""></span>
             <input type="checkbox" name="selAllUsr" onClick="setUserDisp(this)" class="Small" value="ALL" checked>All User
             <br>Uncheck to enter user id
          </td>
          </TR>
                    
          <TR>
          <TD colspan=4 align=center style="padding-top: 10px; font-size:12px" >
             Name Contains: <input name="Name" class="Small" size="33" maxlength="30"> (optional)             
          </td>
          </TR>
          
          <TR>
          <TD colspan=4 align=center style="padding-top: 10px; font-size:12px" >
             Reimbursement: <input name="Reimb" class="Small" size="7" maxlength="5">% (optional)             
          </td>
          </TR>
          
          <TR>
          <TD colspan=4 align=center style="padding-top: 10px; font-size:12px" >
             Code is currently Active? 
             <input type="radio" name="Active" class="Small" value="B" checked>ALL &nbsp; &nbsp; &nbsp;
             <input type="radio" name="Active" class="Small" value="Y">Yes &nbsp; &nbsp; &nbsp;
             <input type="radio" name="Active" class="Small" value="N">No             
          </td>
          </TR>
          
        <!-- ============== select date ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select Entry Date</TD></tr>

        <TR>
          <TD id="tdDate3" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(2)">Optional Entry Date Selection</button>
          </td>
          <TD id="tdDate4" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text" value="ALLDATES" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int k=0; k < 20; k++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" value="ALLDATES" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates(2)">All Dates</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <br><INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
               &nbsp; &nbsp; &nbsp;
               <INPUT type=submit value="New Coupon/Track Id" name=SUBMIT onClick="sbmInfo('0000')">
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