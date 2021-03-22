<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=WarrantyClaimListSel.jsp&APPL=ALL");
}
else
{
   int iSpace = 6;

   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();

   String sPrepStmt = "select Claim_Sts, Sts_Desc from rci.OWCLMSTS order by CSSORT";
   //System.out.println(sPrepStmt);

   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();

   Vector vClmSts = new Vector();
   Vector vClmStsDesc = new Vector();

   while(runsql.readNextRecord())
   {
      vClmSts.add(runsql.getData("Claim_Sts"));
      vClmStsDesc.add(runsql.getData("Sts_Desc"));
   }

   String [] sClmSts = new String[vClmSts.size()];
   vClmSts.toArray((String []) sClmSts );
   String [] sClmStsDesc = new String[vClmStsDesc.size()];
   vClmStsDesc.toArray((String []) sClmStsDesc );

   runsql.disconnect();
   runsql = null;

%>

<style>
 body {background:ivory;}
 table.Tb1 { background:#FFE4C4;}
 td.DTb1 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
 td.DTb11 { border-right: darkred solid 1px; align:left;
            padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
 .Small { font-size: 10px }
</style>


<script name="javascript">
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  document.all.tdDate1.style.display="block"
  document.all.tdDate2.style.display="none"
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(show)
{
   document.all.tdDate1.style.display="none"
   document.all.tdDate2.style.display="block"
   doSelDate()
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   document.all.FromDate.value = "01/01/0001"
   document.all.ToDate.value = "12/31/2999"
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(){
  var df = document.forms[0];
  var date = new Date(new Date() - 7 * 86400000);
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  date = new Date(new Date());
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
function Validate() {
  var error = false;
  var msg = "";
  var sts = false
  
  //selling stores
  var strobj = document.forms[0].StrGrp;
  var strchk = false;
  
  for(var i=0; i < strobj.length; i++) { if(strobj[i].checked){ strchk = true; } }
  if (!strchk){ msg += "\nPlease, check at least 1 selling store\n"; error = true; }
  
  // validate status
  for(var i=0; i < document.forms[0].ClmSts.length; i++)
  {
     if(document.forms[0].ClmSts[i].checked) sts = true;
  }
  // validate from date
  if (!sts)
  {
    msg = " Please, check at least 1 status\n"
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
   var from = document.forms[0].FromDate.value
   var to = document.forms[0].ToDate.value

   var url = "WarrantyClaimList.jsp?From=" +  from
           + "&To=" + to
   // set requered statuses
   for(var i=0; i < document.forms[0].ClmSts.length; i++)
   {
      if(document.forms[0].ClmSts[i].checked) url += "&Status=" + document.forms[0].ClmSts[i].value
   }
   
   //selling stores
   var strobj = document.forms[0].StrGrp;
   for(var i=0; i < strobj.length; i++) 
   { 
	   if(strobj[i].checked)
	   { 
		   url += "&Str=" + strobj[i].value; 
	   } 
   }

   //alert(url)
   window.location.href=url
}
//==============================================================================
//check/reset store
//==============================================================================
function checkStr( grp )
{
	var str = null;
	str = document.all.StrGrp; 

	for(var i=0; i < str.length; i++){ str[i].checked = false; }

	if(grp !="RESET")
	{
   		for(var i=0; i < str.length; i++)
   		{
      		if(grp=="ALL"){ str[i].checked = true; }
      		if(grp=="SCH" && (str[i].value == "35" || str[i].value == "46" || str[i].value == "50")){ str[i].checked = true; }
      		if(grp=="SAS" && (str[i].value == "63" || str[i].value == "64" || str[i].value == "68")){ str[i].checked = true; }
   		}
	}
}
</script>

<!-- import calendar functions -->
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>


<html>
<head>
<title>Patio Furniture Warranty Claim List</title>
</head>
<body onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture - Warranty Claim List Selection</B>

       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

       <!-- -->
      <FORM  method="GET" onSubmit="return Validate(this)" action="javascript:submitForms()" name="REPORT" >
      <TABLE>
        <TBODY>
        <!-- ============= Selling Stores ============================================= -->
        <TR>
            <td><b>Select Selling Stores: </b></td>
            <TD style="padding-top: 10px; padding-bottom: 10px;" align=left valign=top colspan=5>

              <INPUT type="checkbox" name="StrGrp" value="35" checked>35 &nbsp;
              <INPUT type="checkbox" name="StrGrp" value="46" checked>46 &nbsp;
              <INPUT type="checkbox" name="StrGrp" value="50" checked>50 &nbsp; &nbsp;

              <INPUT type="checkbox" name="StrGrp" value="86" checked>86 &nbsp; &nbsp;

              <INPUT type="checkbox" name="StrGrp" value="63" checked>63 &nbsp;
              <INPUT type="checkbox" name="StrGrp" value="64" checked>64 &nbsp;
              <INPUT type="checkbox" name="StrGrp" value="68" checked>68 &nbsp; &nbsp;

              <br><a href="javascript: checkStr('ALL')" style="font-size:12px;">All</a>, &nbsp;
                  <a href="javascript: checkStr('SCH')" style="font-size:12px;">DC Area</a>, &nbsp;
                  <a href="javascript: checkStr('SAS')" style="font-size:12px;">NE Area</a>, &nbsp;
                  <a href="javascript: checkStr('RESET')" style="font-size:12px;">Reset</a> &nbsp;
            </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD style="padding-top: 10px; border-bottom: darkred solid 1px; padding-bottom: 10px;" align=center valign=top colspan=2>
              <b><u>Select Warranty Status</u></b>
            </TD>
        </TR>
        <TR>
            <TD class=DTb11 >
               <%for(int i=0; i < sClmSts.length; i++){%>
                  <%if(!sClmSts[i].equals("CLOSED") && !sClmSts[i].equals("CANCEL")){%>
                     <input type="checkbox" name="ClmSts" value="<%=sClmSts[i]%>" checked><%=sClmStsDesc[i]%><br>
                  <%}%>
               <%}%>
            </TD>
            <TD class=DTb1>
               <%for(int i=0; i < sClmSts.length; i++){%>
                  <%if(sClmSts[i].equals("CLOSED") || sClmSts[i].equals("CANCEL")){%>
                      <input type="checkbox" name="ClmSts" value="<%=sClmSts[i]%>"><%=sClmStsDesc[i]%><br>
                  <%}%>
               <%}%>
            </TD>
        </TR>
        <!-- ======================== From Date ======================================= -->
        <TR>
          <TD class=DTb1 id="tdDate1" colspan=2 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates()">Optional Date Selection</button>
          </td>
          <TD class=DTb1 id="tdDate2"  colspan=2 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDate')">&#60;</button>
              <input class="Small" name="FromDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].FromDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates()">All Date</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD style="border-top: darkred solid 1px; padding-top: 10px;" class=DTb1 align=center colSpan=5>&nbsp;&nbsp;&nbsp;&nbsp;
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
<%}%>