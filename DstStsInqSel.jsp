<%@ page import="rciutility.ClassSelect, rciutility.StoreSelect, rciutility.RunSQLStmt, java.sql.*, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=DstStsInqSel.jsp&APPL=ALL");
}
else
{
   String sStrAllowed = session.getAttribute("STORE").toString();
   String sUser = session.getAttribute("USER").toString();   
   int iStrAlwLst = 0;
	   
   // get issuing store list
   StoreSelect issStr = new StoreSelect(0);
   String sIStr = issStr.getStrNum();
   String sIStrName = issStr.getStrName();
   issStr=null;
   
  StoreSelect dstStr = new StoreSelect(0);   
  String sDStr = dstStr.getStrNum();
  String sDStrName = dstStr.getStrName();
  dstStr = null;
  
  String sCurStr = "ALL";
  if (sStrAllowed != null && !sStrAllowed.startsWith("ALL"))
  {
	  sCurStr = sStrAllowed;
  }
  
  
  ClassSelect select = new ClassSelect();
  String [] sDivArr = select.getDivArr();

  
  // begining of fiscal year
  String sPrepStmt = "select char(piyb, usa) as piyb"   	 	
   	+ " from rci.Fsyper"
  	+ " where pida=current date";
  ResultSet rslset = null;
  RunSQLStmt runsql = new RunSQLStmt();
  runsql.setPrepStmt(sPrepStmt);		   
  runsql.runQuery();
  
  String sBegFiscYr = null;
  if(runsql.readNextRecord()){ sBegFiscYr = runsql.getData("piyb"); }
  
%>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var BegFiscalYr = "<%=sBegFiscYr%>"
var CurStr = "<%=sCurStr%>";
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
  if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
  // populate store dropdown box
  doStrSelect();
  // populate date with yesterdate
  doFromDate();
  doToDate();
  
  setOldValue();
  
  setDiv(true)
}
//==============================================================================
// set priviously entered value
//==============================================================================
function setOldValue()
{
	if(document.forms[0].SvRecSrc.value != "")
	{
		for(var i=0; i < document.forms[0].RecSrc.length; i++)
		{
		   if(document.forms[0].RecSrc[i].value == document.forms[0].SvRecSrc.value) 
		   { 
			   document.forms[0].RecSrc.selectedIndex = i;			   
		   }
		}
		
		for(var i=0; i < document.forms[0].IStore.length; i++)
		{
		   if(document.forms[0].IStore[i].value == document.forms[0].SvIssStr.value) 
		   { 
			   document.forms[0].IStore.selectedIndex = i;	
			   break;
		   }
		}
		for(var i=0; i < document.forms[0].DStore.length; i++)
		{
		   if(document.forms[0].DStore[i].value == document.forms[0].SvDstStr.value) 
		   { 
			   document.forms[0].DStore.selectedIndex = i;
			   break;
		   }
		}
		
		document.forms[0].Distro.value = document.forms[0].SvDistro.value;
		document.forms[0].FromDate.value = document.forms[0].SvFrDt.value;
		document.forms[0].ToDate.value = document.forms[0].SvToDt.value;
		
		for(var i=0; i < document.forms[0].Status.length; i++)
		{
		   if(document.forms[0].Status[i].value == document.forms[0].SvSts.value) 
		   { 
			   document.forms[0].Status.selectedIndex = i;			   
		   }
		}
	}
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var df = document.forms[0];
    var istores = [<%=sIStr%>];
    var istoreNames = [<%=sIStrName%>];
    var dstores = [<%=sDStr%>];
    var dstoreNames = [<%=sDStrName%>];

    df.IStore.options[0] = new Option("All Inter-stores",istores[0]);
    df.IStore.options[1] = new Option("All Locations (include warehouse)", "ALLIW");
    for (idx = 2; idx < istores.length; idx++)
    {
       df.IStore.options[idx] = new Option(istores[idx] + " - " + istoreNames[idx],istores[idx]);
    }

    if(dstores.length > 2)
    {
    	df.DStore.options[0] = new Option(dstoreNames[0],dstores[0]);
    	df.DStore.options[1] = new Option("All Stores (exclude warehouse)", "ALLEW");
    	for (idx = 2; idx < dstores.length; idx++)
    	{
       		df.DStore.options[idx] = new Option(dstores[idx] + " - " + dstoreNames[idx], dstores[idx]);
       		if(CurStr != "ALL" && CurStr == dstores[idx])
       		{
       			df.DStore.selectedIndex = idx;
       		}
    	}
    	df.DStore.options[dstores.length] = new Option("1,70, 59, 99 - stores","DCSUM");
    }
    else
    {
    	var beg = 1; 
        for (var i=0; beg < dstores.length; i++, beg++ )
        {
          df.DStore.options[i] = new Option(dstores[beg] + " - " + dstoreNames[beg],dstores[beg]);
        }
    }	
    	
}

//==============================================================================
// populate From date with 09/01/2002
//==============================================================================
function  doFromDate(){
  var df = document.forms[0];
  var date = new Date(new Date() - 90 * 86400000); //new Date(BegFiscalYr);
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doToDate(){
  var df = document.forms[0];
  var date = new Date();
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// Validate form entry fields
//==============================================================================
function Validate() {
  var vld = new Date(document.forms[0].FromDate.value)
  var minYear= 2002
  var maxYear= (new Date()).getFullYear();
  var error = false;
  var msg;
  var istr = document.forms[0].IStore.value
  var dstr = document.forms[0].DStore.value
  var rep

  if(isNaN(document.forms[0].Distro.value))
  {
    msg = "Distribution Document Number must be numeric or blank\n"
    error = true;
  }

  if (document.forms[0].FromDate.value == null
  || (new Date(vld)) == "NaN")
  {
    msg = " Please, enter report date\n"
    error = true;
  }
  else {document.forms[0].FromDate.value = (vld.getMonth()+1) + "/" + vld.getDate() + "/" + vld.getFullYear()}

  if (vld.getFullYear() < minYear){
    msg = vld.getFullYear() + " is less that minimum year allowed\n"
    error = true;
  }
  if (vld.getFullYear() > maxYear){
    msg = vld.getFullYear() + " is greater that maximum year allowed\n"
    error = true;
  }

  document.forms[0].IStrName.value = document.forms[0].IStore[document.forms[0].IStore.selectedIndex].text.trim();
  document.forms[0].DStrName.value = document.forms[0].DStore[document.forms[0].DStore.selectedIndex].text.trim();

  var pick = document.all.Pick.value;
  
  if (error) alert(msg);
  else
  {
	  document.forms[0].SvRecSrc.value = document.forms[0].RecSrc[document.forms[0].RecSrc.selectedIndex].value;
	  document.forms[0].SvIssStr.value = document.forms[0].IStore[document.forms[0].IStore.selectedIndex].value;
	  document.forms[0].SvDstStr.value = document.forms[0].DStore[document.forms[0].DStore.selectedIndex].value;
	  document.forms[0].SvDistro.value = document.forms[0].Distro.value;
	  document.forms[0].SvFrDt.value = document.forms[0].FromDate.value;
	  document.forms[0].SvToDt.value = document.forms[0].ToDate.value;
	  document.forms[0].SvSts.value = document.forms[0].Status[document.forms[0].Status.selectedIndex].value;
	    }
  return error == false;
}
//==============================================================================
//Validate form entry fields
//==============================================================================
function setDiv(chk)
{
	var mDiv = document.forms[0].mDiv;
	for(var i=0; i < mDiv.length; i++)
	{
		mDiv[i].checked = chk;
	}
}
</script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<SCRIPT language=JavaScript>
		document.write("<style>body {background:ivory;}");
		document.write("table.Tb1 { background:#FFE4C4;}");
		document.write("td.DTb1 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }");
		document.write("</style>");
</SCRIPT>

<html>
<head>
<title>
Freight Bill Report
</title>
</head>
<body onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:helpdesk@retailconcepts.cc">Mail to IT</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Distribution Status Inquiry - Select</B>

       <!-- -->
      <FORM  method="GET" onSubmit="return Validate(this)" action="DstStsInq.jsp" name="DSTINQ" >
      <TABLE>
        <TBODY>

        <TR>
            <TD>Type of Transfer:</TD>
              <TD class=DTb1 align=left>
                <Select name="RecSrc">
                  <Option value="A" selected>Active</Option>
                  <Option value="H">History</Option>
                  <Option value="B">Both</Option>
                </Select>
        </TR>


        <TR>
          <TD class=DTb1 align=right >Issuing Store:</TD>
          <TD class=DTb1 align=left>
             <SELECT name="IStore"></SELECT>
             <input name="IStrName" type="hidden">
          </TD>
        </TR>

        <TR>
          <TD class=DTb1 align=right >Destination Store:</TD>
          <TD class=DTb1 align=left>
             <SELECT name="DStore"></SELECT>
             <input name="DStrName" type="hidden">
             <input name="PageType" value="I" type="hidden">
          </TD>
        </TR>

        <!-- ------------- Multiple Divisions  ----------------------------- -->
        <TR id="trMult">
           <TD class="DTb1" >Division:
             <br><a href="javascript: setDiv(true);" >All</a>
             <br><a href="javascript: setDiv(false);" >Reset</a> 
           </TD>
           <TD nowrap>
             <%for(int i=0; i < sDivArr.length; i++){
            	 if(sDivArr[i].equals("1") || sDivArr[i].equals("2") || sDivArr[i].equals("3")
            		|| sDivArr[i].equals("4") || sDivArr[i].equals("5") || sDivArr[i].equals("6")
            		|| sDivArr[i].equals("7") || sDivArr[i].equals("8") || sDivArr[i].equals("9")
            		)
            	 {
            		 sDivArr[i] = "0" + sDivArr[i];
            	 } 
             %>
                
               <input name="mDiv" class="Small" type="checkbox" value="<%=sDivArr[i]%>"><%=sDivArr[i]%>               
               &nbsp; &nbsp; &nbsp;
               <%if(i == 14 || i > 15 && i % 14 == 0){%><br><%}%>
             <%}%>
           </TD>
        </tr>
        <!-- ------------- End Multiple Divisions  ------------------------- -->





        <TR>
          <TD class=DTb1 align=right >Distro No:</TD>
          <TD><input name="Distro" type="text" size=5 maxlength=5>
          </TD>
        </TR>
        
        <TR>
          <TD class=DTb1 align=right >PO:</TD>
          <TD><input name="Ponum" type="text" size=12 maxlength=10>
          </TD>
        </TR>
        
        <TR>
          <TD class=DTb1 align=right >Allocation:</TD>
          <TD><input name="Alloc" type="text" size=12 maxlength=10>
          </TD>
        </TR>
        
        <TR>
          <TD class=DTb1 align=right >Receipt:</TD>
          <TD><input name="Receipt" type="text" size=12 maxlength=10>
          </TD>
        </TR>
        <TR>
          <TD class=DTb1 align=right >Pick #:</TD>
          <TD><input name="Pick" type="text" size=7 maxlength=10>
          </TD>
        </TR>

        <TR>
          <TD class=DTb1 align=right >From Date:</TD>
          <TD><input name="FromDate" type="text" size=10 maxlength=10>
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].FromDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>

        <TR>
          <TD class=DTb1 align=right >To Date:</TD>
          <TD><input name="ToDate" type="text" size=10 maxlength=10>
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <TR>
            <TD>Distribution Status:</TD>
              <TD class=DTb1 align=left>
                <Select name="Status">
                <Option value=" ">Any Status</Option>
                <Option value="R">Ready</Option>
                <Option value="C">Pending</Option>
                <Option value="M">Manifest</Option>
                <Option value="P">Pending shp</Option>
                <Option value="T" selected>In transit</Option>
                <Option value="A">Acknowledge</Option>
                <Option value="E">Rcv Errors</Option>
                </Select>
        </TR>
        <TR>
            <TD></TD>
            <TD class=DTb1 align=left colSpan=5>&nbsp;&nbsp;&nbsp;&nbsp;
               <INPUT type=submit value=Submit name=SUBMIT >
               <input type="hidden" name="SvRecSrc">
               <input type="hidden" name="SvIssStr">
               <input type="hidden" name="SvDstStr">
               <input type="hidden" name="SvDistro">
               <input type="hidden" name="SvFrDt">
               <input type="hidden" name="SvToDt">
               <input type="hidden" name="SvSts">
           </TD>
          </TR>
        </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%}%>