<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=CouponSalesSel.jsp&APPL=ALL");
   }
   else
   {
      String sPrepStmt = "select acod, anam, adsc, acpsi, acpei from rci.advcode"
           + " order by acod";
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      runsql.runQuery();
      String sCode = "";
      String sName = "";
      String sDisc = "";
      String sStart = "";
      String sEnd = "";
%>
<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  table.Coupon { font-size:10px }
  th.Coupon { background:#FFCC99;padding-top:3px; padding-bottom:3px;text-align:center; font-family:Verdanda; font-size:12px }

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
	
  	showDates()
}

//==============================================================================
// show optional date selection button
//==============================================================================
function showDates()
{
      var date = new Date(new Date() - 86400000);

      // to sales date
      document.all.SlsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

      // from sales date
      var day = 0;
      for(var i=0; i < 7; i++)
      {
         day = date.getDay();
         if (date.getDay()==0){ break; }
         date = new Date(date.getTime() - 86400000);
      }
      document.all.SlsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

  if(direction == "DOWN" && ymd=="MON") { date.setMonth(date.getMonth()-1); }
  else if(direction == "UP" && ymd=="MON") { date.setMonth(date.getMonth()+1); }

  if(direction == "DOWN" && ymd=="YEAR") { date.setYear(date.getFullYear()-1); }
  else if(direction == "UP" && ymd=="YEAR") { date.setYear(date.getFullYear()+1); }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


//==============================================================================
// Validate form
//==============================================================================
function Validate(max)
{
  var error = false;
  var msg = " ";
  
  var type = null;
  for(var i=0; i < document.all.Type.length; i++)
  {
     if(document.all.Type[i].checked){ type = document.all.Type[i].value; break;}
  }

  slsfrdate = document.all.SlsFrDate.value;
  slstodate = document.all.SlsToDate.value;

  var name = document.all.Name.value.trim().toUpperCase();
  var reimb = document.all.Reimb.value.trim();
  
  var code = new Array();
  for(var i=0, j=0; i < max; i++)
  {
     var boxnm = "Code" + i;
     if(document.all[boxnm].checked){ code[j++] = document.all[boxnm].value}
  }
  
  if(name == "" && reimb == "" && code.length < 1){ error=true; msg += "Please, select at least 1 coupon code." }
  
  if (error) alert(msg);
  else{ sbmSlsRep(slsfrdate, slstodate, code, name, reimb, type); }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep(frdate, todate, code, name, reimb, type)
{
  	if(isIE){ nwelem = document.createElement("div"); }
	else if(isSafari){ nwelem = document.createElement("div"); }
	else{ nwelem = window.contentDocument.createElement("div");}
 
 	nwelem.id = "dvSbmCoupLst"

 	var html = "<form name='frmPostCoupLst'"
    	+ " METHOD=Post ACTION='CouponSales.jsp'>"
    	+ "<input name='SelFrDate'>"
    	+ "<input name='SelToDate'>"
    	+ "<input name='SelName'>"
    	+ "<input name='SelReimb'>"
    	+ "<input name='SelType'>"
    	;
    	    	
    for(var i=0; i < code.length + 1; i++)
    {
    	html += "<input name='SelCode'>";
    }
  	html += "</form>"

 	nwelem.innerHTML = html;
 
 	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.document.appendChild(nwelem); }
 	else if(isIE){ window.document.body.appendChild(nwelem); }
 	else if(isSafari){ window.document.body.appendChild(nwelem); }
 	else{ window.contentDocument.body.appendChild(nwelem); }

 	if(isIE || isSafari)
	{
	    document.all.SelFrDate.value = frdate;
    	document.all.SelToDate.value = todate;
        document.all.SelName.value = name;
        document.all.SelReimb.value = reimb;
        document.all.SelType.value = type;
        
        for(var i=0; i < code.length; i++)
        {
        	document.all.SelCode[i].value = code[i];
        }
		
		document.frmPostCoupLst.submit();
	 }
 	else
 	{
	   	window.contentDocument.forms[0].SelFrDate.value = frdate;
       	window.contentDocument.forms[0].SelToDate.value = todate;
       	window.contentDocument.forms[0].SelName.value = name;
       	window.contentDocument.forms[0].SelReimb.value = reimb;
       	window.contentDocument.forms[0].SelType.value = type;
       	
       	for(var i=0; i < code.length; i++)
        {
        	window.contentDocument.forms[0].SelCode.value = code[i];
        }
	   	 
	   	window.contentDocument.forms[0].submit();
 	}
  	
 }
//==============================================================================
// close Submitting frame
//==============================================================================
function closeFrame()
{
   window.frame1.close();
   alert("Report has been submitted")
}


//==============================================================================
// unselect boxes
//==============================================================================
function resetBox(max)
{
   for(var i=0, j=0; i < max; i++)
   {
     var boxnm = "Code" + i;
     document.all[boxnm].checked = false;
  }
}

var dummy = "</table";

</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <!--TR><TD height="20%"><IMG src="Sun_ski_logo4.png"></TD></TR -->

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Multiple Code Sales Review/Export - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>&nbsp; &nbsp; &nbsp; &nbsp;
      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <!-- ============== select Coupon/Tracking Type ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Select Type Of List</b></u></TD></tr>
        
        <TR>
          <TD colspan=4 align=center style="padding-top: 10px; font-size:12px" >
             <input type="radio" name="Type" class="Small" value="COUPON">Coupon Id
             <input type="radio" name="Type" class="Small" value="TRACKING" checked>Tracking Id
             <input type="radio" name="Type" class="Small" value="BOTH" >Both
          </td>
        </TR>   
        
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        
        <TR><TD class="Cell2" colspan=4><b><u>Select Sales Dates</b></u></TD></tr>
        <TR  id="trWeek">
          <TD colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date: </b>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'DAY')">d-</button>
              <input class="Small" name="SlsFrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 150, 150, document.all.SlsFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date: </b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'DAY')">d-</button>
              <input class="Small" name="SlsToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 700, 150, document.all.SlsToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </td>
        </tr>
        
        
        <TR  id="trWeek">
          <TD colspan=4 align=left style="padding-top: 10px;" >
             <b>Name Contained:</b> 
             <input class="Small" name="Name" type="text" size=33 maxlength=30> &nbsp; (optional)             
          </TD>
        </TR>
        <TR  id="trWeek">
          <TD colspan=4 align=left style="padding-top: 10px;" >
             <b>Reimbursement:</b> 
             <input class="Small" name="Reimb" type="text" size=5 maxlength=5>% &nbsp; (optional)             
          </TD>
        </TR>     
      <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Coupon selection</b></u></TD></tr>
        <TR  id="trCoupon">
          <TD colspan=4 align=center style="padding-top: 10px;" >
        <div id="dvCoupon" style="background:white; height: 300px; width:500px;
                 margin: 0 auto; overflow: auto; border: 1px solid gray;">
        <table class="Coupon" border=1 cellPadding="0" cellSpacing="0">
          <tr>
            <th class="Coupon">Select</th>
            <th class="Coupon">Code</th>
            <th class="Coupon">Name</th>
            <th class="Coupon">Discount</th>
            <th class="Coupon">Start Date</th>
            <th class="Coupon">Ending date</th>

          </tr>
        <%
           int i=0;
           while(runsql.readNextRecord())
           {
              sCode = runsql.getData("acod");
              sName = runsql.getData("anam");
              sDisc = runsql.getData("adsc");
              sStart = runsql.getData("acpsi");
              sEnd = runsql.getData("acpei");
         %>

            <tr>
                <td><input name="Code<%=i++%>" type="checkbox" value="<%=sCode%>"></td>
                <td><%=sCode%></td>
                <td><%=sName%></td>
                <td><%=sDisc%></td>
                <td>&nbsp;<%if(sStart != null){%><%=sStart%><%}%></td>
                <td>&nbsp;<%if(sEnd != null){%><%=sEnd%><%}%></td>
            </tr>
        <%}%>
        </table>
        </div>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colSpan=4>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate('<%=i%>')">
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
               <button type=submit name=SUBMIT onClick="resetBox('<%=i%>')">Clear</button>
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