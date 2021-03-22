<%@ page import="java.text.*, java.util.*, rciutility.RunSQLStmt, java.sql.ResultSet"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   //if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuOrdLstSel.jsp&APPL=ALL");
   }
   else
   {
	   String sStmt = "Select BXSITE, BXNAME, BXPROD"
				  + " from RCI.MOSNDBX"
				  + " order by BXSITE"		      
			   ;
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		ResultSet rs = runsql.runQuery();
		   	  
		Vector<String> vSbId = new Vector();
		Vector<String> vSbName = new Vector();
		Vector<String> vSbProdTest = new Vector();
		while(runsql.readNextRecord())
		{
			vSbId.add(runsql.getData("BXSITE").trim());
		   	vSbName.add(runsql.getData("BXNAME").trim());
		   	vSbProdTest.add(runsql.getData("BXPROD").trim());
	    }
		rs.close();
		runsql.disconnect();
%>
<title>Mozu_Order_List</title>
<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvMozuSandBox { position:absolute; background-attachment: scroll;
              border:ridge; width:250; background-color:#cccfff; z-index:10;
              text-align:center; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var SbId = new Array();
<%for(int i=0; i < vSbId.size(); i++){%>SbId[<%=i%>] = "<%=vSbId.get(i)%>";<%}%>
var SbName = new Array();
<%for(int i=0; i < vSbName.size(); i++){%>SbName[<%=i%>] = "<%=vSbName.get(i)%>";<%}%>
var SbProdTest = new Array();
<%for(int i=0; i < vSbProdTest.size(); i++){%>SbProdTest[<%=i%>] = "<%=vSbProdTest.get(i)%>";<%}%>

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
   document.all.tdDate2.style.display="block"
   document.all.tdDate3.style.display="block"
   document.all.tdDate4.style.display="none"
   doSelDate(1)
   
   showMozuSandBox(); 
}
//==============================================================================
//link to PO info
//==============================================================================
function showMozuSandBox()
{
	var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
	  + "<tr class='DataTable1'>"
	     + "<td class='DataTable' nowrap>Sandbox:</td>"
	     + "<td class='DataTable' nowrap>&nbsp;"
	        + "<input name='SandBox' readOnly><br>"
	  + "</tr>"
	  + "<tr class='DataTable1'>"
		 + "<td class='DataTable' nowrap>&nbsp;</td>"
		 + "<td class='DataTable' nowrap>&nbsp;"
	        + "<select name='selSandBox' onchange='setSandBox(this)'> &nbsp; "	        
	     + "</td>"
	  + "</tr>"
	html += "</table>"

	document.all.dvMozuSandBox.style.pixelLeft= 10;
	document.all.dvMozuSandBox.innerHTML = html;	
	
	// populate with sandbox
	document.all.selSandBox.options[0] = new Option("--- Select Sandbox ---","");
	for(var i=0, j=1; i < SbId.length; i++, j++)
	{
		document.all.selSandBox.options[j] = 
			new Option(SbId[i] + " - " + SbName[i] + " " + SbProdTest[i], SbId[i]);
	}
	document.all.SandBox.value = SbId[0];
}
//==============================================================================
//set sandbox id
//==============================================================================
function setSandBox(sel)
{
	document.all.SandBox.value = sel.options[sel.selectedIndex].value;
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
   if(type==1)
   {
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      document.all.OrdFrDate.value = "MONTH"
      document.all.OrdToDate.value = "MONTH"
   }
   else
   {
      document.all.tdDate3.style.display="block"
      document.all.tdDate4.style.display="none"
      document.all.ShpFrDate.value = "ALL"
      document.all.ShpToDate.value = "ALL"
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;

  if(type==1)
  {
    var date = new Date(new Date() - 7 * 86400000);
    df.OrdFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    var date = new Date(new Date() - 86400000);
    df.OrdToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
  else
  {
    var date = new Date(new Date() - 86400000);
    df.ShpFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    df.ShpToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
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
function Validate()
{
  var error = false;
  var msg = "";

  // selected status
  var sts = new Array();
  var sel = false
  for (var i=0; i < document.all.Sts.length; i++)
  {
     if(document.all.Sts[i].checked) sts[i] = document.all.Sts[i].value;
     sel = true;
  }
  if(!sel) {error = false; msg += "Select at least 1 status"}

  // order date
  var ordfrdate = document.all.OrdFrDate.value;
  var ordtodate = document.all.OrdToDate.value;
  // order date
  var shpfrdate = document.all.ShpFrDate.value;
  var shptodate = document.all.ShpToDate.value;
  
  var site = document.all.SandBox.value.trim();

  if (error) alert(msg);
  else{ sbmOrdList(site, sts, ordfrdate, ordtodate, shpfrdate, shptodate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmOrdList(site, sts, ordfrdate, ordtodate, shpfrdate, shptodate)
{
  var url = null;
  url = "MozuOrdLst.jsp?"
      + "OrdFrDate=" + ordfrdate
      + "&OrdToDate=" + ordtodate
      + "&ShpFrDate=" + shpfrdate
      + "&ShpToDate=" + shptodate
      + "&Site=" + site

  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i] }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// Validate searched Order
//==============================================================================
function ValidateOrder()
{
  var error = false;
  var msg = "";

  var ord = document.all.Order.value;
  if (isNaN(ord)) { msg = "Order must be numeric."; error = true; }
  else if( ord <= 0) { msg = "Order number must be greater than 0."; error = true; }

  var site = document.all.SandBox.value.trim();
  
  if (error) alert(msg);
  else{ sbmOrder(site, ord) }
  return error == false;
}
//==============================================================================
// submit searched Order
//==============================================================================
function sbmOrder(site, ord)
{
  var url = "MozuOrdInfo.jsp?Site=" + site
   + "&Order=" + ord

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(chko)
{
   var sts = document.all.Sts;
   var mark = false;
   if (chko.checked) mark = true;
   for(var i=0; i < sts.length; i++) { sts[i].checked = mark }
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvMozuSandBox" class="dvMozuSandBox"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Mozu Order List - Selection</B>
        <br><a href="../" class="small"><font color="red">Home</font></a>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Order Statuses</TD>
        </tr>
        <tr>
            <TD class="Cell2" colspan=5>
              <input class="Small" onclick="chkStsAll(this)" name="StsAll" type="checkbox" value="All" checked>All
        <tr>        
            <TD class="Cell1" nowrap>
              <input class="Small" name="Sts" type="checkbox" value="Open" checked>Open<br>
              <input class="Small" name="Sts" type="checkbox" value="Submitted" checked>Submitted <br>
              <input class="Small" name="Sts" type="checkbox" value="Pending" checked>Pending<br>
              <input class="Small" name="Sts" type="checkbox" value="PendingReview" checked>PendingReview
            <TD class="Cell1" nowrap>
              <input class="Small" name="Sts" type="checkbox" value="Accepted" checked>Accepted <br>
              <input class="Small" name="Sts" type="checkbox" value="Awaiting Payment" checked>Completed<br>
              <input class="Small" name="Sts" type="checkbox" value="Completed" checked>Cancelled<br>
              <input class="Small" name="Sts" type="checkbox" value="Cancelled" checked>Closed
            <TD class="Cell1" nowrap>
              <input class="Small" name="Sts" type="checkbox" value="Validated" checked>Validated<br>
              <input class="Small" name="Sts" type="checkbox" value="Errored" checked>Errored<br>           
            </TD>
        </TR>

        <!-- ============== select Order changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select order dates when item was added or modified</TD></tr>

        <TR>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdFrDate')">&#60;</button>
              <input class="Small" name="OrdFrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.OrdFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'OrdToDate')">&#60;</button>
              <input class="Small" name="OrdToDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'OrdToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 600, 400, document.all.OrdToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
          </TD>
        </TR>
        <!-- ============== select Shipping changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select shipping dates when item was added or modified</TD></tr>

        <TR>
          <TD id="tdDate3" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(2)">Optional Shipping Date Selection</button>
          </td>
          <TD id="tdDate4" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ShpFrDate')">&#60;</button>
              <input class="Small" name="ShpFrDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ShpFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ShpFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ShpToDate')">&#60;</button>
              <input class="Small" name="ShpToDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ShpToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 600, 400, document.all.ShpToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates(2)">All Date</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        
        <TR>
            <TD align=center valign=top colSpan=5><br>
               <INPUT class=Small type=text name="Order" size=10 maxlength=10>&nbsp;
               <button onClick="ValidateOrder()">Get Order</button>
           </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
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