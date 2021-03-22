<%@ page import="rciutility.StoreSelect, java.sql.*, java.util.*"%>
<%  
StoreSelect strlst = null;

String sStrAllowed = null;
String sUser = null;
   //----------------------------------
   // Application Authorization
   //----------------------------------

   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=DcFrtBill.jsp&APPL=ALL");
   }
   else
   {
	     sStrAllowed = session.getAttribute("STORE").toString();
	   	 sUser = session.getAttribute("USER").toString();
	     
	   	 System.out.println(" sStrAllowed=" + sStrAllowed);
	   	 
	   	 if(sStrAllowed.equals("59") || sStrAllowed.equals("99")){ sStrAllowed = "ALL"; }

	     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
	     {
	       strlst = new StoreSelect(6);
	     }	      
	     else
	     {
	       Vector vStr = (Vector) session.getAttribute("STRLST");
	       String [] sStrAlwLst = new String[ vStr.size()];
	       Iterator iter = vStr.iterator();

	       int iStrAlwLst = 0;
	       while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

	       if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
	       else strlst = new StoreSelect(new String[]{sStrAllowed});
	    }

	    String sStrJsa = strlst.getStrNum();
	    String sStrNameJsa = strlst.getStrName();

   
%>
<script name="javascript">
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad(){
  // populate store dropdown box
  doStrSelect();
  // populate date with yesterdate
  doSelDate();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var df = document.forms[0];
    var stores = [<%=sStrJsa%>];
    var storeNames = [<%=sStrNameJsa%>];
    
    var beg = 0;
    if(stores.length <= 2){beg=1;}
    
    for (var i=0; beg < stores.length; i++, beg++ )
    {
      df.STORE.options[i] = new Option(stores[beg] + " - " + storeNames[beg],stores[beg]);
    }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate(){
  var df = document.forms[0];
  var date = new Date();
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  date = new Date(new Date() - 365 * 86400000);
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// Validate form entry fields
//==============================================================================
function Validate() {
  var from = new Date(document.forms[0].FromDate.value)
  var to = new Date(document.forms[0].ToDate.value)
  var minYear=1999
  var maxYear= (new Date()).getFullYear();
  var error = false;
  var msg;
  var str = document.forms[0].STORE.value
  var rep


  // validate from date
  if (document.forms[0].FromDate.value == null
  || (new Date(from)) == "NaN")
  {
    msg = " Please, enter report from date\n"
    error = true;
  }
  else {document.forms[0].FromDate.value = (from.getMonth()+1) + "/" + from.getDate() + "/" + from.getFullYear()}

  if (from.getFullYear() < minYear){
    msg = from.getFullYear() + " is less that minimum year allowed\n"
    error = true;
  }
  if (from.getFullYear() > maxYear){
    msg = from.getFullYear() + " is greater that maximum year allowed\n"
    error = true;
  }

  // validate to date
  if (document.forms[0].ToDate.value == null
  || (new Date(to)) == "NaN")
  {
    msg = " Please, enter report to date\n"
    error = true;
  }
  else {document.forms[0].ToDate.value = (to.getMonth()+1) + "/" + to.getDate() + "/" + to.getFullYear()}

  if (to.getFullYear() < minYear){
    msg = to.getFullYear() + " is less that minimum year allowed\n"
    error = true;
  }
  if (to.getFullYear() > maxYear){
    msg = from.getFullYear() + " is greater that maximum year allowed\n"
    error = true;
  }


  for(var i=0; i < document.forms[0].repType.length; i++){
    if (document.forms[0].repType[i].checked == true){
      rep = document.forms[0].repType[i].value
    }
  }

  // All store cannot be selected for report type detail item
  if (document.forms[0].STORE.value=="ALL" && rep=="D")
  {
    msg = "Please, select store for Detail by Item report"
    error = true;
  }

  if (error) alert(msg);
  return error == false;
}
//==============================================================================
// submit form
//==============================================================================
function submitForms()
{
   var url= "servlet/dcfrtbill.DcFrtBill?";
   var reptyp = "P"
   var filter = "A"

   for(var i=0; i < document.forms[0].repType.length; i++)
   {
    if (document.forms[0].repType[i].checked == true){
      reptyp = document.forms[0].repType[i].value
    }
  }

  for(var i=0; i < document.forms[0].CtnSel.length; i++)
   {
    if (document.forms[0].CtnSel[i].checked == true){
      filter = document.forms[0].CtnSel[i].value
    }
  }


   if (reptyp=="D" ) url="DstCtnItem.jsp?";

   url += "STORE=" + document.forms[0].STORE.value
        + "&FromDate=" +  document.forms[0].FromDate.value
        + "&ToDate=" +  document.forms[0].ToDate.value
        + "&repType=" + reptyp
        + "&filter=" + filter

    if (document.forms[0].FrtB.value.trim() != "")
    {
       if(document.forms[0].FrtBillType[0].checked)
       {
            url = "FrtBillPrt.jsp?"
                + "FrtB=" +  document.forms[0].FrtB.value.trim();
       }
       else
       {
    	   url = "servlet/dcfrtbill.DcFrtBill?STORE=ALL&FrtBill=" + document.forms[0].FrtB.value.trim()
    		   + "&FromDate=01/01/0001&ToDate=01/01/0001&repType=B&filter=A"
       }
      
    }

   //alert(url)
   window.location.href=url
}

 
</script>

<!-- import calendar functions -->
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
        <BR>Daily Freight Bill Report</B>

       <!-- -->
      <FORM  method="GET" onSubmit="return Validate(this)" action="javascript:submitForms()" name="REPORT" >
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DTb1 align=right >Store:</TD>
          <TD class=DTb1 align=left>
             <SELECT name="STORE"></SELECT>
          </TD>
        </TR>
        <!-- ======================== From Date ======================================= -->
        <TR>
          <TD class=DTb1 align=right >From Date:</TD>
          <TD><input name="FromDate" type="text" size=10 maxlength=10>
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].FromDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <!-- ======================== To Date ======================================= -->
        <TR>
          <TD class=DTb1 align=right >To Date:</TD>
          <TD><input name="ToDate" type="text" size=10 maxlength=10>
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD style="border-bottom: darkred solid 1px;" colspan="2">&nbsp;</TD>
        </TR>
        <TR>
          <TD class=DTb1 align=right >Freight Bill:</TD>
          <TD><input name="FrtB" type="text" size=12 maxlength=12>
            <input type="radio" name="FrtBillType" value="M" checked>Manifest &nbsp; &nbsp;
            <input type="radio" name="FrtBillType" value="R">Report
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD style="border-bottom: darkred solid 1px;" colspan="2">&nbsp;</TD>
        </TR>
        <TR>
            <TD>Report Details:</TD>
              <TD class=DTb1 align=left>
                <INPUT type="radio" name="repType" value="N">All Freight Bill Summary &nbsp;&nbsp;
                <INPUT type="radio" name="repType" value="O" checked>Open Freight Bill Summary<br>
                <INPUT type="radio" name="repType" value="P">Pallets&nbsp;&nbsp;&nbsp;
                <INPUT type="radio" name="repType" value="C">Cartons&nbsp;&nbsp;&nbsp;
                <INPUT type="radio" name="repType" value="B">Pallets/Cartons&nbsp;&nbsp;&nbsp;<br>
                <INPUT type="radio" name="repType" value="D">Detail By Item
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD style="border-top: darkred solid 1px;" colspan="2">&nbsp;</TD>
        </TR>

        <TR>
            <TD>Carton Selection:</TD>
              <TD class=DTb1 align=left>
                <INPUT type="radio" name="CtnSel" value="A" checked>All&nbsp;&nbsp;&nbsp;
                <INPUT type="radio" name="CtnSel" value="E">Missing/Damages
                <INPUT type="radio" name="CtnSel" value="C">Audit/Compliance
        </TR>

        <!-- =============================================================== -->
        <TR>
            <TD style="border-bottom: darkred solid 1px;" colspan="2">&nbsp;</TD>
        </TR>
        <TR>
            <TD></TD>
            <TD class=DTb1 align=left colSpan=5>&nbsp;&nbsp;&nbsp;&nbsp;
               <INPUT type=submit value=Submit name=SUBMIT >
           </TD>
          </TR>
       <!-- =============================================================== -->
        </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%} %>
