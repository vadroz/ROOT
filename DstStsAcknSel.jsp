<%@ page import="rciutility.ClassSelect, rciutility.StoreSelect, rciutility.RunSQLStmt, java.sql.*, java.util.*"%>
<%
   StoreSelect IssStrSel = null; //issuing stores
   StoreSelect DstStrSel = null; // destination stores
   String sIssStr = null;
   String sIssStrName = null;
   String sDstStr = null;
   String sDstStrName = null;

   //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;
  String sUser = null;
  String sAppl = "TRANSFER";

  if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
  {
     response.sendRedirect("SignOn1.jsp?TARGET=DstStsAcknSel.jsp&APPL=" + sAppl + "&" + request.getQueryString());
  }
  else {
     sAccess = session.getAttribute("ACCESS").toString();
     sUser = session.getAttribute("USER").toString();
     sStrAllowed = session.getAttribute("STORE").toString();
  // -------------- End Security -----------------
  Vector vStr = (Vector) session.getAttribute("STRLST");
  String [] sStrAlwLst = new String[ vStr.size()];
  Iterator iter = vStr.iterator();

  int iStrAlwLst = 0;
  while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

   if (sStrAllowed != null) {
     if (sStrAllowed.startsWith("ALL"))
     {
       DstStrSel = new StoreSelect(0);
     }
     else
     {
       if (vStr.size() > 1) { DstStrSel = new StoreSelect(sStrAlwLst); }
       else DstStrSel = new StoreSelect(new String[]{sStrAllowed});
     }
   }

   sDstStr = DstStrSel.getStrNum();
   sDstStrName = DstStrSel.getStrName();

   IssStrSel = new StoreSelect(11);
   sIssStr = IssStrSel.getStrNum();
   sIssStrName = IssStrSel.getStrName();
   
   //  get all divisions
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

<script name="javascript">

var BegFiscalYr = "<%=sBegFiscYr%>"

var aDiv = new Array();
<%for(int i=0; i < sDivArr.length; i++){%>aDiv[i]="<%=sDivArr%>"; <%}%>

function bodyLoad(){
  // populate store dropdown box
  doStrSelect();
  // populate date with yesterdate
  doFromDate();
  doToDate();
}

//------------------------------------------------------------------------------
// Load Stores
//------------------------------------------------------------------------------
function doStrSelect() {
    var df = document.forms[0];
    var DstStr = [<%=sDstStr%>];
    var DstStrNames = [<%=sDstStrName%>];
    var IssStr = [<%=sIssStr%>];
    var IssStrNames = [<%=sIssStrName%>];

    df.IStore.options[0] = new Option("All Inter-stores",IssStr[0]);
    for (idx = 1; idx < IssStr.length; idx++)
    {

       df.IStore.options[idx] = new Option(IssStr[idx] + " - " + IssStrNames[idx], IssStr[idx]);
    }

    for (idx = 1; idx < DstStr.length; idx++)
    {
       df.DStore.options[idx-1] = new Option(DstStr[idx] + " - " + DstStrNames[idx],DstStr[idx]);
    }
}

//------------------------------------------------------------------------------
// populate From date with 09/01/2002
//------------------------------------------------------------------------------
function  doFromDate(){
  var df = document.forms[0];
  //var date = new Date(new Date() - 30 * 86400000);
  var date = new Date(BegFiscalYr);
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//------------------------------------------------------------------------------
// populate date with yesterdate
//------------------------------------------------------------------------------
function  doToDate(){
  var df = document.forms[0];
  var date = new Date(new Date() - 86400000);
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

// Validate form entry fields
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

  if (error) alert(msg);
  return error == false;
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

        <BR>Distribution Acknowledgement - Select</B>

       <!-- -->
      <FORM  method="GET" onSubmit="return Validate(this)" action="DstStsInq.jsp" name="DSTINQ" >
      <TABLE>
        <TBODY>

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
             <input name="RecSrc" type="hidden" value="A">
             <input name="Status" value=" " type="hidden">
             <input name="PageType" value="A" type="hidden">
          </TD>
        </TR>

        <!-- ------------- Multiple Divisions  ----------------------------- -->
        <TR id="trMult" style="display:none;">
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
                
               <input name="mDiv" class="Small" type="checkbox" value="<%=sDivArr[i]%>" checked>               
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
            <TD></TD>
            <TD class=DTb1 align=left colSpan=5>&nbsp;&nbsp;&nbsp;&nbsp;
               <INPUT type=submit value=Submit name=SUBMIT >
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