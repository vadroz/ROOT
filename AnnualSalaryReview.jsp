<%@ page import="employeecenter.AnnualSalaryReview, java.util.*"%>
<%
    String [] sStore = request.getParameterValues("Str");
    String [] sSelDpt = request.getParameterValues("Dept");
    String [] sSelTtl = request.getParameterValues("Ttl");
    String sType = request.getParameter("Type");
    String sSort = request.getParameter("Sort");

    if(sSort ==null){ sSort = "EMPNUM"; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("EMPSALARY")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=AnnualSalaryReview.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
     String sStrAllowed = session.getAttribute("STORE").toString();
     String sUser = session.getAttribute("USER").toString();
     Vector vStr = (Vector) session.getAttribute("STRLST");

     boolean bSalary = session.getAttribute("EMPSALARY") != null;

     boolean bStrAlwed = false;
     boolean bDistTot = false;
     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       bStrAlwed = true;
       if(sStrAllowed.startsWith("ALL")){bDistTot = true;}
     }
     else
     {
       Iterator iter = vStr.iterator();
       while (iter.hasNext())
       {
          for(int i=0; i < sStore.length; i++)
          {
             if (((String)iter.next()).equals(sStore[i]))
             {
                bStrAlwed = true; bDistTot = true; break;
             }
          }
          if(bStrAlwed){ break; }
       }
     }
     if(!bStrAlwed){ response.sendRedirect("AnnualSalaryReviewSel.jsp"); }

     if (!bSalary){sType = "H"; }

     AnnualSalaryReview salrev = new AnnualSalaryReview(sStore, sSelDpt, sSelTtl, sType, sSort, sUser);
     int iNumOfEmp = salrev.getNumOfEmp();

     int iNumOfReg = salrev.getNumOfReg();
     String [] sReg = salrev.getReg();

     int iNumOfStr = salrev.getNumOfStr();
     String [] sStrLst = salrev.getStrLst();

     String sStrJsa = salrev.cvtToJavaScriptArray(sStore);
     String sDptJsa = salrev.cvtToJavaScriptArray(sSelDpt);
     String sTtlJsa = salrev.cvtToJavaScriptArray(sSelTtl);
     sTtlJsa = sTtlJsa.replaceAll("&", "%26");

     String sBdgGrp = "";
     String sBdgAvg = "";
     String sBdgAdjp = "";
     String sBdgDpt = "";
     if(sStore.length == 1)
     {
        salrev.setBdgGrp();
        sBdgGrp = salrev.getBdgGrpJsp();
        sBdgAvg = salrev.getBdgAvgJsp();
        sBdgAdjp = salrev.getBdgAdjpJsp();
        sBdgDpt = salrev.getBdgDptJsp();
     }
     
     // set lockdown status
     String sLockSts = "";
     String sLockStsUser = "";
     String sLockStsDt = "";
     String sLockStsTm = "";
     if(sStore.length == 1)
     {
    	 salrev.setLockDown();
    	 sLockSts = salrev.getLockSts();
         sLockStsUser = salrev.getLockStsUser();
         sLockStsDt = salrev.getLockStsDt();
         sLockStsTm = salrev.getLockStsTm();
     }
     
     boolean bLockAllow = session.getAttribute("STRLOCK") != null;
%>
<HTML>
<HEAD>
<title>Annual_Review</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { background:darkred;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align: top; font-size:12px }               

        tr.DataTable { background: #E7E7E7; font-size:11px }
        tr.DataTable1 { background: cornsilk; font-size:11px }
        tr.DataTable2 { background: red; font-size:11px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; vertical-align:middle; white-space:}               
                       

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEmp { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>


<script name="javascript1.2">

var ArrSelStr = [<%=sStrJsa%>];
var ArrSelDpt = [<%=sDptJsa%>];
var ArrSelTtl = [<%=sTtlJsa%>];

var NumOfEmp = <%=iNumOfEmp%>;

var BdgGrp = [<%=sBdgGrp%>];
var BdgAvg = [<%=sBdgAvg%>];
var BdgAdjp = [<%=sBdgAdjp%>];
var BdgDpt = [<%=sBdgDpt%>];

var ArrPerf = [" ", "O", "V", "P", "I"];
var ArrPerfNm = ["--- select performance rating ---", "O = Outstanding", "V = Achiver", "P = Performer", "I = Improvement Required"];
var ArrLead = [" ", "1", "2", "3", "4"];
var ArrLeadNm = ["--- select leadership rating ---","1 = Exemplary", "2 = Effective", "3 = Acceptable", "4 = Deficient"];
var ArrPot = [" ", "*", "+", "=", "-"];
var ArrPotNm = ["--- select potential ---", "* = High Potential", "+ = Promotable", "= = Grow in Position", "- = Placement Issue"];

var TotalOnly = false;
var NumOfEmp = "<%=iNumOfEmp%>";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEmp"]);
   <%if(!sUser.equals("vrozen")){%>showAddInfo();<%}%>

   // minimize budget group averages panel
   if(ArrSelStr.length == 1){ setBdgPanelShort(); }
   else{ document.all.dvSelect.style.display="none"; }
}
//==============================================================================
// set Short form of select parameters
//==============================================================================
function setBdgPanelShort()
{
   var hdr = "Budget Group Average Matrix";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;
}
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var hdr = "Budget Group Average Matrix";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='MinimizeButton.bmp' onclick='javascript:setBdgPanelShort();' alt='Minimize'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popBdgGrp()

   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;

}
//==============================================================================
// populate Column Panel
//==============================================================================
function popBdgGrp()
{
  var panel = "<table border=1 cellPadding=0 cellSpacing=0 width='100%'>"
    + "<tr class='DataTable'>"
       + "<th class='DataTable'>Budget<br>Group</th>"
       + "<th class='DataTable'>Avg</th>"
       + "<th class='DataTable'>Adj<br>%</th>"
       + "<th class='DataTable'>Dept</th>"
     + "</tr>"

  for(var i=0; i < BdgGrp.length; i++)
  {
     panel += "<tr class='DataTable'>"
          + "<td  class='DataTable' nowrap>" + BdgGrp[i]  + "</td>"
          + "<td  class='DataTable' nowrap>" + BdgAvg[i]  + "</td>"
          + "<td  class='DataTable' nowrap>" + BdgAdjp[i]  + "</td>"
          + "<td  class='DataTable' nowrap>" + BdgDpt[i]  + "</td>"
       + "</tr>"
  }

  panel += "<tr><td class='Prompt1' colspan=4>"
        + "<button onClick='setBdgPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// update selected colimn cells
//==============================================================================
function RevUpdate(emp, empname, prc, rate, perf, leader, potenl, hors, dept, newdept)
{
   var colnm = null
   var size = 0;

   //check if order is paid off
   var hdr = "New Rate for: " + emp + " " + empname;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popRevPanel(emp)

   html += "</td></tr></table>"

   document.all.dvEmp.innerHTML = html;
   document.all.dvEmp.style.width = 250;
   document.all.dvEmp.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvEmp.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvEmp.style.visibility = "visible";

   if(hors == "S")
   {
      document.all.NewPrc.value = ""; document.all.NewPrc.readOnly=true;
      if(rate != "0") { document.all.NewRate.value = rate; }
   }
   else if(prc != "0") { document.all.NewPrc.value = prc; }
   else if(rate != "0") { document.all.NewRate.value = rate; }
   document.all.NewRate.focus()

   //setSelFlag(SelPerf, ArrPerf, ArrPerfNm, perf);
   //setSelFlag(SelLeader, ArrLead, ArrLeadNm, leader);
   //setSelFlag(SelPotenl, ArrPot, ArrPotNm, potenl);

   document.all.Perf.value = perf;
   //document.all.Leader.value = leader;
   //document.all.Potenl.value = potenl;
   document.all.NewDept.value = newdept;
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popRevPanel(emp)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt3' nowrap>Percent Increase<br> or Pay New Rate &nbsp; </td>"
           + "<td class='Prompt' colspan='2' nowrap>"
  panel += "% &nbsp; <input name=NewPrc class='Small' size='10' maxlength='10'>"
  panel += "<br>- or -<br>"
  panel += "$ &nbsp; <input name=NewRate class='Small' size='10' maxlength='10'>"
  panel += "</td>" + "</tr>"

  // for future use
  panel += "<tr ><td class='Prompt3' nowrap>Department&nbsp; </td>"
           + "<td class='Prompt' colspan='2' nowrap>"
              + "<input name=NewDept class='Small' size='3' maxlength='3'>"
           + "</td>" + "</tr>"

  panel += "<tr><td class='Prompt3' nowrap>Final Rating</td>"
     + "<td class='Prompt' colspan='2' nowrap>"
       + "<input name='Perf' class='Small' size='3' maxlength='5'>&nbsp;"
       //+ "<span style='font-family: Wingdings;'>&#231;</span>&nbsp;"
       //+ "<select name='SelPerf' onchange='setSelVal(this, document.all.Perf)' class='Small'></select>"
     + "</td>"
   + "</tr>"
   /*+ "<tr><td class='Prompt3' nowrap>Leadership Rating</td>"
     + "<td class='Prompt' colspan='2' nowrap>"
       + "<input name='Leader' class='Small' size='1' maxlength='1' readonly>&nbsp;"
       + "<span style='font-family: Wingdings;'>&#231;</span>&nbsp;"
       + "<select name='SelLeader' onchange='setSelVal(this, document.all.Leader)' class='Small'></select>"
     + "</td>"
   + "</tr>"
   + "<tr><td class='Prompt3' nowrap>Potential</td>"
     + "<td class='Prompt' colspan='2' nowrap>"
       + "<input name='Potenl' class='Small' size='1' maxlength='1' readonly>&nbsp;"
       + "<span style='font-family: Wingdings;'>&#231;</span>&nbsp;"
       + "<select name='SelPotenl' onchange='setSelVal(this, document.all.Potenl)' class='Small'></select>"
     + "</td>"
   + "</tr>"
*/


  panel += "<tr><td class='Prompt1' colspan='3'>"
        + "<button onClick='Validate(&#34;" + emp + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// set selected value in fields
//==============================================================================
function setSelVal(selobj, obj)
{
   obj.value = selobj.options[selobj.selectedIndex].value;
}
//==============================================================================
// set selection flags
//==============================================================================
function setSelFlag(selobj, arr, arrnm, curval)
{
    for(var i=0; i < arr.length; i++)
    {
        selobj.options[i] = new Option(arrnm[i], arr[i]);
    }
}
//==============================================================================
// save new rate
//==============================================================================
function Validate(emp)
{
   var newrate = document.all.NewRate.value.trim();
   var newprc = document.all.NewPrc.value.trim();
   var error=false;
   var msg = "";
   var rate = null;
   var newdept = document.all.NewDept.value.trim();

   if (newrate != "" && newprc != "" && eval(newprc) != 0) { error = true; msg = "Enter eather percentage or rate."}
   else if (isNaN(newprc)) { error = true; msg = "Percent of Increase is not a numeric value."}
   else if (isNaN(newrate)) { error = true; msg = "New Rate is not a numeric value."}
   else if (eval(newrate) < 0) { error = true; msg = "New Rate cannot be negative."}

   var perf = document.all.Perf.value.trim();
   if(isNaN(perf)){ error = true; msg += "\nFinal Rate value has not a numeric value." }
   else if (eval(perf) < 1 || eval(perf) > 5) { error = true; msg = "Final Rate m/b value from 1.0 through 5.0."}
   
   //var lead = document.all.Leader.value.trim();
   //var potnl = document.all.Potenl.value.trim();

   if (!error && eval(newprc) != 0) rate = "%" + newprc;
   else rate = newrate;

   if(error) { alert(msg) }
   else { sbmNewRate(emp, rate, perf, newdept); }
}
//==============================================================================
// save new rate
//==============================================================================
function sbmNewRate(emp, rate, perf, newdept)
{
   hidePanel();

   //if(potnl == "+"){potnl="P";}
   var url = "NewRateSave.jsp?Emp=" + emp
           + "&Rate=" + rate.replaceSpecChar()
           + "&Perf=" + perf
           + "&Action=ADD"
           + "&NewDept=" + newdept

   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;
}

//==============================================================================
// checked Employee for Review
//==============================================================================
function checkEmp(emp, chk, type)
{
   var action = null;
   if(type=="1" && chk.checked) { action = "MARK" }
   else if(type=="1" && !chk.checked) { action = "UNMARK" }
   else if(type=="2" && chk.checked) { action = "WRITE" }
   else if(type=="2" && !chk.checked) { action = "NOWRITE" }
   else if(type=="3" && chk.checked) { action = "GIVEN" }
   else if(type=="3" && !chk.checked) { action = "NOGIVEN" }

   var url = "NewRateSave.jsp?Emp=" + emp
           + "&Rate=0"
           + "&Action=" + action;

   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;
}
//==============================================================================
// save new rate
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// select Form year
//==============================================================================
function selectForm(emp, empname)
{
   var colnm = null
   var size = 0;

   //check if order is paid off
   var hdr = "Select Year for: " + emp + " " + empname;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popYearPanel(emp, empname)

   html += "</td></tr></table>"

   document.all.dvEmp.innerHTML = html;
   document.all.dvEmp.style.width = 250;
   document.all.dvEmp.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvEmp.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvEmp.style.visibility = "visible";

   year = (new Date()).getFullYear();
   document.all.Year.options[0] = new Option(year, year);
   document.all.Year.options[1] = new Option(year-1, year-1);
   document.all.Year.options[2] = new Option(year-2, year-2);
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popYearPanel(emp, empname)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt3' nowrap>Year</td>"
           + "<td class='Prompt' colspan='2'>"
  panel += "<select name=Year class='Small'></select>"
  panel += "</td>" + "</tr>"


  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='showForm(&#34;" + emp + "&#34;, &#34;" + empname + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// show Employee Form
//==============================================================================
function showForm(emp, empname)
{
   url = "EmpReview_SPAP103.jsp?Emp=" + emp
       + "&EmpName=" + empname
       + "&Year=" + document.all.Year.options[document.all.Year.selectedIndex].value
   //alert(url)
   window.location.href=url;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvEmp.innerHTML = " ";
   document.all.dvEmp.style.visibility = "hidden";
}

//==============================================================================
// resort table
//==============================================================================
function resort(sort)
{
  url = "AnnualSalaryReview.jsp?Type=<%=sType%>"

  for(var i=0; i < ArrSelStr.length; i++) { url += "&Str=" + ArrSelStr[i]; }
  for(var i=0; i < ArrSelDpt.length; i++) { url += "&Dept=" + ArrSelDpt[i]; }
  for(var i=0; i < ArrSelTtl.length; i++) { url += "&Ttl=" + ArrSelTtl[i]; }
  url += "&Sort=" + sort
  
  window.location.href=url;
}
//==============================================================================
// marked all employees for review
//==============================================================================
function checkAll()
{
   var url = "NewRateSave.jsp?Emp=ALL"

   for(var i=0; i < ArrSelStr.length; i++) { url += "&Str=" + ArrSelStr[i]; }
   for(var i=0; i < ArrSelDpt.length; i++) { url += "&Dept=" + ArrSelDpt[i]; }
   for(var i=0; i < ArrSelTtl.length; i++) { url += "&Ttl=" + ArrSelTtl[i]; }

   url += "&Action=CHECKALL";
   window.frame1.location.href=url;
}
//==============================================================================
// fold / unfold right part of the screen
//==============================================================================
function showAddInfo()
{
   var cell = document.all.AddInfo;
   var disp = "none";
   if(cell[0].style.display=="none"){ disp="block";}

   for(var i=0; i < cell.length; i++)
   {
      cell[i].style.display=disp;
   }
}
//==============================================================================
// fold / unfold
//==============================================================================
function setTotalOnly()
{
   var cell = "trDtl";

   var disp = "none";
   if (TotalOnly){ disp = "block"; }
   TotalOnly = !TotalOnly;

   for(var i=0; i < NumOfEmp; i++)
   {
      document.all[cell + i].style.display=disp;
   }
}
//==============================================================================
//set lock down status
//==============================================================================
function setLockdown()
{
	var lock = document.all.Lock;
	//check if order is paid off
	var hdr = "Change Store Annual Salary Review Status";

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	   + "<tr>"
	     + "<td class='BoxName' nowrap>" + hdr + "</td>"
	     + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>" + popLockdown(lock.checked)

	html += "</td></tr></table>"

	document.all.dvEmp.innerHTML = html;
	document.all.dvEmp.style.width = 250;
	document.all.dvEmp.style.pixelLeft= document.documentElement.scrollLeft + 300;
	document.all.dvEmp.style.pixelTop= document.documentElement.scrollTop + 100;
	document.all.dvEmp.style.visibility = "visible";
}
//==============================================================================
//populate lockdown status update
//==============================================================================
function popLockdown(sts)
{
	var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	if(sts)
	{
    	panel += "<tr><td style='color: red; font-size: 14px;' nowrap>You will lockdown store annual salary revew.</td></tr>"
	}
	else
	{
		panel += "<tr><td style='color: red; font-size: 14px;'  nowrap>You will unlock store annual salary revew.</td></tr>"
	}

    panel += "<tr><td class='Prompt1' colspan='3'>"
	   + "<button onClick='sbmLockdown(" + sts + ")' class='Small'>Submit</button>&nbsp;"
	   + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

	panel += "</table>";
	return panel;
}
//==============================================================================
//populate lockdown status update
//==============================================================================
function sbmLockdown(sts)
{
	hidePanel();
	var lock = "Y";
	if(!sts){ lock = " "; }
	
	var url = "NewRateSave.jsp?Str=" + ArrSelStr[0]
		+ "&Lock=" + lock
	    + "&Action=CHGLOCKSTS"	    
	//alert(sts + "|" + url)
	//window.location.href=url;
	window.frame1.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvEmp" class="dvEmp"></div>
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Annual Salary Review Worksheet Summary
        </B><br><font size="-1">(Excludes Sick, Vacation and Holiday pay and hours)</font>
        <br><font size="-1">(LY & LLY - Fiscal years)</font>
        <br>

        <a href="index.jsp" class="small"><font color="red">Home</font></a>&#62;
        <a href="AnnualSalaryReviewSel.jsp" class="small"><font color="red">Selection Screen</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: showAddInfo()">Fold/unfold</a>

        &nbsp;&nbsp;&nbsp;&nbsp;
        <a href="AnnualSalRevLst.jsp?<%=request.getQueryString()%>">excel</a>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: setTotalOnly()">Totals(only) - fold/unfold</a>
        <%if(sStore.length == 1) {%>
        <br>Lockdown Status <input name="Lock" type="checkbox" 
            <%if(sLockSts.equals("Y")) {%>checked<%}%> <%if(!bLockAllow){%>disabled<%}%>
            onclick="setLockdown()" value="Y">
            <%if(!sLockStsUser.equals("")) {%><%=sLockStsUser%>/<%=sLockStsDt%>/<%=sLockStsTm%><%}%>
        <%}%>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0">
         <tr class="DataTable">
             <th class="DataTable3" rowspan=3>No.</th>
             <th class="DataTable" colspan=4>Review<br>
              <button class="Small" onclick="checkAll()">Marked All for Review</button>
             </th>
             <th class="DataTable" rowspan=2>Rci#</th>
             <th class="DataTable" rowspan=3>D<br>t<br>l</th>
             <th class="DataTable" rowspan=2>Employee Name</th>
             <th class="DataTable" rowspan=2>Store</th>
             <th class="DataTable" rowspan=2>Dept</th>
             <th class="DataTable" rowspan=2>New<br>Dept</th>
             <th class="DataTable" rowspan=2>Title</th>
             <th class="DataTable" rowspan=2>Hire Date</th>
             <th class="DataTable" rowspan=2>H/S</th>
             <th class="DataTable" colspan=2>Average Rate</th>
             <th class="DataTable" rowspan=2>Old<br>Date</th>
             <th class="DataTable" rowspan=2>Current<br><%if(sType.equals("S")){%>Annual<br><%}%>Rate</th>             
             <th class="DataTable" rowspan=2>Effective<br>Date</th>
             <th class="DataTable" rowspan=2>Hours Worked<br>Last Year</th>
             <th class="DataTable" rowspan=2>C</th>
             <th class="DataTable" rowspan=2>ADP#</th>
             <th class="DataTable" colspan=2>Pay Increase</th>
             <th class="DataTable2" rowspan=3 id="AddInfo">&nbsp;</th>
             <th class="DataTable" rowspan=3 id="AddInfo">Last<br>Final<br>Rating<br>Score</th>
             <th class="DataTable" rowspan=3 id="AddInfo">Last<br>Dept</a></th>
             <th class="DataTable" rowspan=2 id="AddInfo">LY Hrs *<br>Base Rate</th>
             <th class="DataTable" rowspan=2 id="AddInfo">LY Hrs *<br>New<br>Base Rate</th>
             <th class="DataTable" rowspan=2 id="AddInfo">LY<br>Comm</th>
             <th class="DataTable" rowspan=2 id="AddInfo">TY<br>Comm</th>
             <th class="DataTable" rowspan=2 id="AddInfo">LY<br>Coordinator<br>Incentives</th>
             <th class="DataTable" rowspan=2 id="AddInfo">TY<br>Coors<br>Floor Leader<br>Incentives
               * Max Annual Payout
             </th>
             <th class="DataTable" rowspan=2 id="AddInfo">LY Hrs *<br>Base Rate +<br>Comm</th>
             <th class="DataTable" rowspan=2 id="AddInfo">TY Hrs *<br>Base Rate +<br>Comm</th>
             <th class="DataTable" rowspan=2 id="AddInfo">Diff</th>
             <th class="DataTable" rowspan=2 id="AddInfo">Weighted *</th>
             <th class="DataTable" rowspan=2 id="AddInfo">LY Sales</a></th>
             <th class="DataTable" rowspan=2 id="AddInfo">LY Sales<br>Per Hrs</th>
             <th class="DataTable" rowspan=2 id="AddInfo">Last<br>Pay<br>Period</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable" rowspan="2">Sched</th>
             <th class="DataTable" rowspan="2">Written</th>
             <th class="DataTable" rowspan="2">Given</th>

             <th class="DataTable">Final<br>Rating<br>Score</th>
             <!-- th class="DataTable">Leadershp<br>Rate</th>
             <th class="DataTable">Potential</th -->

             <th class="DataTable">LLY</th>
             <th class="DataTable">LY</th>
             <th class="DataTable">(Simple) %</th>
             <th class="DataTable"><%if(sType.equals("S")){%>Annual<br><%}%>New<br>Rate</th>
         </tr>
         <tr class="DataTable">
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('TYSCOREUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('TYSCOREDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('EMPNUMUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('EMPNUMDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('EMPNAMEUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('EMPNAMEDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('STRUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('STRDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('DEPTUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('DEPTDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('NEWDEPTUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('NEWDEPTDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('TITLEUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('TITLEDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('HIREDTUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('HIREDTDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('HORSUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('HORSDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('AVGRATE2UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('AVGRATE2DN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('AVGRATE1UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('AVGRATE1DN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th> 
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('OLDRATEUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('OLDRATEDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>        	
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('CURRATEUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('CURRATEDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>         	
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('EFFDATEUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('EFFDATEDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('LYWRKHRSUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('LYWRKHRSDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('COMMUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('COMMDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('ADPNUMUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('ADPNUMDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('NEWPRCUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('NEWPRCDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" nowrap>
         		<a href="javascript: resort('NEWRATEUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('NEWRATEDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('LYRATEUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('LYRATEDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('LYNEWRATEUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('LYNEWRATEDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('LYCOMUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('LYCOMDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('TYCOMUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('TYCOMDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('LYCOINUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('LYCOINDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('TYCOINUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('TYCOINDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('LYPAY_COMUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('LYPAY_COMDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('TYPAY_COMUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('TYPAY_COMDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('DIFFUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('DIFFDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('WGTAVGUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('WGTAVGDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('SALESUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('SALESDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('SLSHRSUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('SLSHRSDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>
         	<th class="DataTable" id="AddInfo" nowrap>
         		<a href="javascript: resort('LASTPYDTUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a>&nbsp;
         		<a href="javascript: resort('LASTPYDTDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
         	</th>         	
         </tr>
       <!-- ============================ Details =========================== -->
       <%boolean total = true; int iSect = 0;
         for(int i=0; i < iNumOfEmp; i++ )
         {
            salrev.setEmpList();
            String sEmp = salrev.getEmp();
            String sEmpName = salrev.getEmpName();
            String sStr = salrev.getStr();
            String sTitle = salrev.getTitle();
            String sRate = salrev.getRate();
            String sHireDate = salrev.getSalary();
            String sCommission = salrev.getCommission();
            String sAdp = salrev.getAdp();
            String sDept = salrev.getDept();
            String sHorS = salrev.getHorS();
            String sAvgRate1 = salrev.getAvgRate1();
            String sAvgRate2 = salrev.getAvgRate2();
            String sRate3 = salrev.getRate3();
            String sRatEffDt = salrev.getRatEffDt();
            String sNewPrc = salrev.getNewPrc();
            String sNewRate = salrev.getNewRate();
            String sPayAmt = salrev.getPayAmt();
            String sPayHrs = salrev.getPayHrs();
            String sMarked = salrev.getMarked();
            String sLyNewAmt = salrev.getLyNewAmt();
            String sLyPrc = salrev.getLyPrc();
            String sLyDiff = salrev.getLyDiff();
            String sRvwWrt = salrev.getRvwWrt();
            String sRvwGvn = salrev.getRvwGvn();
            String sPerf = salrev.getPerf();
            String sLeader = salrev.getLeader();
            String sPotenl = salrev.getPotenl();
            String sPerfNm = salrev.getPerfNm();
            String sLeaderNm = salrev.getLeaderNm();
            String sPotenlNm = salrev.getPotenlNm();
            String sSales = salrev.getSales();
            String sSlsHrs = salrev.getSlsHrs();
            String sLastPyDt = salrev.getLastPyDt();
            String sLLyCom = salrev.getLLyCom();
            String sLyCom = salrev.getLyCom();
            String sTyCom = salrev.getTyCom();
            String sLyCoin = salrev.getLyCoin();
            String sTyCoin = salrev.getTyCoin();
            String sLyPay_Com = salrev.getLyPay_Com();
            String sTyPay_Com = salrev.getTyPay_Com();
            String sNewDept = salrev.getNewDept();
            String sLyPerf = salrev.getLyPerf();
            String sLyDept = salrev.getLyDept();
            String sOldRate = salrev.getOldRate();

            // commission flag literal
            String sComType = "";
            if(sCommission.equals("R")) sComType = "Regular";
            else if(sCommission.equals("S")) sComType = "Special";
       %>
       <!-- ============ Total for marked employee ==========================-->
       <%if(!sMarked.equals("1") && total){%>
         <%if(bDistTot){%>
           <%for(int j=0; j < iNumOfStr; j++){%>
             <%
               salrev.setStrAvg();
               String sAvgCurRate = salrev.getAvgCurRate();
               String sAvgNewRate = salrev.getAvgNewRate();
               String sAvgIncrPrc = salrev.getAvgIncrPrc();
               String sTotAmt = salrev.getTotAmt();
               String sTotNewAmt = salrev.getTotNewAmt();
               String sTotPrc = salrev.getTotPrc();
               String sTotDiff = salrev.getTotDiff();
               String sTotSales = salrev.getTotSales();
               String sTotSlsHrs = salrev.getTotSlsHrs();
               String sTotLLyCom = salrev.getTotLLyCom();
               String sTotLyCom = salrev.getTotLyCom();
               String sTotTyCom = salrev.getTotTyCom();
               String sTotLyCoin = salrev.getTotLyCoin();
               String sTotTyCoin = salrev.getTotTyCoin();
               String sTotLyPay_Com = salrev.getTotLyPay_Com();
               String sTotTyPay_Com = salrev.getTotTyPay_Com();
               String sAvgScr = salrev.getAvgScr();
               String sLyAvgScr = salrev.getLyAvgScr();
             %>
            <tr class="DataTable1">
              <td class="DataTable1" nowrap colspan=4>Store: <%=sStrLst[j]%></td>
              <td class="DataTable1" nowrap><%=sAvgScr%></td>
              <td class="DataTable1" nowrap colspan=12>&nbsp;</td>
              <td class="DataTable" nowrap>$<%=sAvgCurRate%></td>
              <td class="DataTable1" nowrap colspan=4></td>
              <td class="DataTable" nowrap><%=sAvgIncrPrc%>%</td>
              <td class="DataTable" nowrap>$<%=sAvgNewRate%></td>

              <th class="DataTable2" id="AddInfo">&nbsp;</th>
              <td class="DataTable" id="AddInfo" nowrap><%=sLyAvgScr%></td>
              <td class="DataTable" id="AddInfo" nowrap>&nbsp</td>
              <td class="DataTable" id="AddInfo" nowrap><%=sTotAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotNewAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotDiff%></td>
              <td class="DataTable" id="AddInfo" nowrap>&nbsp;</td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSales%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSlsHrs%></td>
              <td class="DataTable1" id="AddInfo" nowrap>&nbsp;</td>
           </tr>
           <%}%>
           <%for(int j=0; j < iNumOfReg; j++){%>
             <%
               salrev.setRegAvg();
               String sAvgCurRate = salrev.getAvgCurRate();
               String sAvgNewRate = salrev.getAvgNewRate();
               String sAvgIncrPrc = salrev.getAvgIncrPrc();
               String sTotAmt = salrev.getTotAmt();
               String sTotNewAmt = salrev.getTotNewAmt();
               String sTotPrc = salrev.getTotPrc();
               String sTotDiff = salrev.getTotDiff();
               String sTotSales = salrev.getTotSales();
               String sTotSlsHrs = salrev.getTotSlsHrs();
               String sTotLLyCom = salrev.getTotLLyCom();
               String sTotLyCom = salrev.getTotLyCom();
               String sTotTyCom = salrev.getTotTyCom();
               String sTotLyCoin = salrev.getTotLyCoin();
               String sTotTyCoin = salrev.getTotTyCoin();
               String sTotLyPay_Com = salrev.getTotLyPay_Com();
               String sTotTyPay_Com = salrev.getTotTyPay_Com();
               String sAvgScr = salrev.getAvgScr();
               String sLyAvgScr = salrev.getLyAvgScr();
             %>
            <tr class="DataTable1">
              <!-- td class="DataTable1" nowrap colspan=3>District: <%=sReg[j]%>.  Total Average Rates and % of Increase</td -->
              <td class="DataTable1" nowrap colspan=4>District: <%=sReg[j]%></td>
              <td class="DataTable1" nowrap><%=sAvgScr%></td>
              <td class="DataTable1" nowrap colspan=12>&nbsp;</td>
              
              <td class="DataTable" nowrap>$<%=sAvgCurRate%></td>
              <td class="DataTable1" nowrap colspan=4></td>
              <td class="DataTable" nowrap><%=sAvgIncrPrc%>%</td>
              <td class="DataTable" nowrap>$<%=sAvgNewRate%></td>

              <th class="DataTable2" id="AddInfo">&nbsp;</th>
              <td class="DataTable" id="AddInfo" nowrap><%=sLyAvgScr%></td>
              <td class="DataTable" id="AddInfo" nowrap>&nbsp</td>
              <td class="DataTable" id="AddInfo" nowrap><%=sTotAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotNewAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotDiff%></td>
              <td class="DataTable" id="AddInfo" nowrap>&nbsp;</td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSales%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSlsHrs%></td>
              <td class="DataTable1" id="AddInfo" nowrap>&nbsp;</td>
           </tr>
           <%}%>
         <%}%>
       <%
           salrev.setRevEmpAvg();
           String sAvgCurRate = salrev.getAvgCurRate();
           String sAvgNewRate = salrev.getAvgNewRate();
           String sAvgIncrPrc = salrev.getAvgIncrPrc();
           String sTotAmt = salrev.getTotAmt();
           String sTotNewAmt = salrev.getTotNewAmt();
           String sTotPrc = salrev.getTotPrc();
           String sTotDiff = salrev.getTotDiff();
           String sTotSales = salrev.getTotSales();
           String sTotSlsHrs = salrev.getTotSlsHrs();
           String sTotLLyCom = salrev.getTotLLyCom();
           String sTotLyCom = salrev.getTotLyCom();
           String sTotTyCom = salrev.getTotTyCom();
           String sTotLyCoin = salrev.getTotLyCoin();
           String sTotTyCoin = salrev.getTotTyCoin();
           String sTotLyPay_Com = salrev.getTotLyPay_Com();
           String sTotTyPay_Com = salrev.getTotTyPay_Com();
           String sAvgScr = salrev.getAvgScr();
           String sLyAvgScr = salrev.getLyAvgScr();
       %>
           <tr class="DataTable1">
              <!--  td class="DataTable1" nowrap colspan=3>Total Average Rates and % of Increase</td -->
              <td class="DataTable1" nowrap colspan=4>Total</td>
              <td class="DataTable1" nowrap><%=sAvgScr%></td>
              <td class="DataTable1" nowrap colspan=12>&nbsp;</td>
              <td class="DataTable" nowrap>$<%=sAvgCurRate%></td>
              <td class="DataTable1" nowrap colspan=4></td>
              <td class="DataTable" nowrap><%=sAvgIncrPrc%>%</td>
              <td class="DataTable" nowrap>$<%=sAvgNewRate%></td>

              <th class="DataTable2" id="AddInfo">&nbsp;</th>
              <td class="DataTable" id="AddInfo" nowrap><%=sLyAvgScr%></td>
              <td class="DataTable" id="AddInfo" nowrap>&nbsp</td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotNewAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotDiff%></td>
              <td class="DataTable" id="AddInfo" nowrap>&nbsp;</td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSales%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSlsHrs%></td>
              <td class="DataTable1" id="AddInfo" nowrap>&nbsp;</td>
           </tr>
         <%  total = false;
           }%>
         <tr class="DataTable" id="trDtl<%=i%>">
            <td class="DataTable" nowrap><%=i+1%></td>
            <td class="DataTable" nowrap>
              <input type="checkbox" onClick="checkEmp('<%=sEmp%>', this, '1')" <%if(sMarked.equals("1")){%>checked<%}%>
              <%if(sLockSts.equals("Y")) {%>disabled<%}%>>
            </td>
            <td class="DataTable" nowrap>
              <%if(sMarked.equals("1")){%>
                  <input type="checkbox" onClick="checkEmp('<%=sEmp%>', this, '2')" <%if(sRvwWrt.equals("1")){%>checked<%}%> <%if(sLockSts.equals("Y")) {%>disabled<%}%>>
              <%} else {%>&nbsp<%}%>
            </td>
            <td class="DataTable" nowrap>
              <%if(sMarked.equals("1") && sRvwWrt.equals("1")){%>
                  <input type="checkbox" onClick="checkEmp('<%=sEmp%>', this, '3')" 
                     <%if(sRvwGvn.equals("1")){%>checked<%}%>>
              <%} else {%>&nbsp<%}%>
            </td>

            <td class="DataTable" nowrap><%=sPerf%></td>
            <!-- td class="DataTable" nowrap><%=sLeaderNm%></td>
            <td class="DataTable" nowrap><%=sPotenlNm%></td -->

            <td class="DataTable" nowrap>
            	<%if(!sLockSts.equals("Y")) {%><a href="javascript: RevUpdate('<%=sEmp%>', '<%=sEmpName%>', '<%=sNewPrc%>', '<%=sNewRate%>', '<%=sPerf%>', '<%=sLeader%>', '<%=sPotenl%>', '<%=sHorS%>', '<%=sDept%>', '<%=sNewDept%>')"><%=sEmp%></a><%} 
            	else {%><%=sEmp%><%}%>
            </td>
            <td class="DataTable" nowrap><a href="AnnualSlrEmp.jsp?Emp=<%=sEmp%>">Dtl</a></td>
            <td class="DataTable1" nowrap><%=sEmpName%></td>
            <td class="DataTable" nowrap><%=sStr%></td>
            <td class="DataTable" nowrap><%=sDept%></td>
            <td class="DataTable" nowrap><%=sNewDept%></td>
            <td class="DataTable" nowrap><%=sTitle%></td>
            <td class="DataTable" nowrap><%=sHireDate%></td>
            <td class="DataTable" nowrap><%=sHorS%></td>
            <td class="DataTable" nowrap><%=sAvgRate2%></td>
            <td class="DataTable" nowrap><%=sAvgRate1%></td>
            <td class="DataTable" nowrap><%=sOldRate%></td>
            <td class="DataTable" nowrap><%=sRate%></td>
            <td class="DataTable" nowrap><%=sRatEffDt%></td>
            <td class="DataTable2" nowrap><%=sPayHrs%></td>
            <td class="DataTable" nowrap><%=sCommission%></td>
            <td class="DataTable" nowrap><%=sAdp%></td>
            <td class="DataTable" nowrap><%=sNewPrc%>%</td>
            <td class="DataTable" nowrap>$<%=sNewRate%></td>

            <th class="DataTable2" id="AddInfo">&nbsp;</th>
            <td class="DataTable" id="AddInfo" nowrap><%=sLyPerf%></td>
            <td class="DataTable" id="AddInfo" nowrap><%=sLyDept%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sPayAmt%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sLyNewAmt%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sLyCom%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sTyCom%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sLyCoin%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sTyCoin%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sLyPay_Com%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sTyPay_Com%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sLyDiff%></td>
            <td class="DataTable" id="AddInfo" nowrap><%=sLyPrc%>%</td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sSales%></td>
            <td class="DataTable" id="AddInfo" nowrap>$<%=sSlsHrs%></td>
            <td class="DataTable" id="AddInfo" nowrap><%=sLastPyDt%></td>
          </tr>
       <%}%>


       <!-- ============ Total for marked employee (when all marked =========-->
       <%if(total){%>
         <%if(bDistTot){%>
         <%for(int j=0; j < iNumOfStr; j++){%>
             <%
               salrev.setStrAvg();
               String sAvgCurRate = salrev.getAvgCurRate();
               String sAvgNewRate = salrev.getAvgNewRate();
               String sAvgIncrPrc = salrev.getAvgIncrPrc();
               String sTotAmt = salrev.getTotAmt();
               String sTotNewAmt = salrev.getTotNewAmt();
               String sTotPrc = salrev.getTotPrc();
               String sTotDiff = salrev.getTotDiff();
               String sTotSales = salrev.getTotSales();
               String sTotSlsHrs = salrev.getTotSlsHrs();
               String sTotLLyCom = salrev.getTotLLyCom();
               String sTotLyCom = salrev.getTotLyCom();
               String sTotTyCom = salrev.getTotTyCom();
               String sTotLyCoin = salrev.getTotLyCoin();
               String sTotTyCoin = salrev.getTotTyCoin();
               String sTotLyPay_Com = salrev.getTotLyPay_Com();
               String sTotTyPay_Com = salrev.getTotTyPay_Com();
               String sAvgScr = salrev.getAvgScr();
               String sLyAvgScr = salrev.getLyAvgScr();
             %>
            <tr class="DataTable1">
              <td class="DataTable1" nowrap colspan=17>Store: <%=sStrLst[j]%></td>
              <td class="DataTable" nowrap>$<%=sAvgCurRate%></td>
              <td class="DataTable1" nowrap colspan=4></td>
              <td class="DataTable" nowrap><%=sAvgIncrPrc%>%</td>
              <td class="DataTable" nowrap>$<%=sAvgNewRate%></td>

              <th class="DataTable2" id="AddInfo">&nbsp;</th>
              <td class="DataTable" id="AddInfo" nowrap><%=sTotAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotNewAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotDiff%></td>
              <td class="DataTable" id="AddInfo" nowrap>&nbsp;</td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSales%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSlsHrs%></td>
              <td class="DataTable1" id="AddInfo" nowrap>&nbsp;</td>
           </tr>
           <%}%>
           <%for(int j=0; j < iNumOfReg; j++){%>
             <%
               salrev.setRegAvg();
               String sAvgCurRate = salrev.getAvgCurRate();
               String sAvgNewRate = salrev.getAvgNewRate();
               String sAvgIncrPrc = salrev.getAvgIncrPrc();
               String sTotAmt = salrev.getTotAmt();
               String sTotNewAmt = salrev.getTotNewAmt();
               String sTotPrc = salrev.getTotPrc();
               String sTotDiff = salrev.getTotDiff();
               String sTotSales = salrev.getTotSales();
               String sTotSlsHrs = salrev.getTotSlsHrs();
               String sTotLLyCom = salrev.getTotLLyCom();
               String sTotLyCom = salrev.getTotLyCom();
               String sTotTyCom = salrev.getTotTyCom();
               String sTotLyCoin = salrev.getTotLyCoin();
               String sTotTyCoin = salrev.getTotTyCoin();
               String sTotLyPay_Com = salrev.getTotLyPay_Com();
               String sTotTyPay_Com = salrev.getTotTyPay_Com();
               String sAvgScr = salrev.getAvgScr();
               String sLyAvgScr = salrev.getLyAvgScr();
            %>
            <tr class="DataTable1">
              <td class="DataTable1" nowrap colspan=17>Total Average Rates and % of Increase</td>
              <td class="DataTable" nowrap>$<%=sAvgCurRate%></td>
              <td class="DataTable1" nowrap colspan=4></td>
              <td class="DataTable" nowrap><%=sAvgIncrPrc%>%</td>
              <td class="DataTable" nowrap>$<%=sAvgNewRate%></td>

              <th class="DataTable2" id="AddInfo">&nbsp;</th>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotNewAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotDiff%></td>
              <td class="DataTable" id="AddInfo" nowrap>&nbsp;</td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSales%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSlsHrs%></td>
              <td class="DataTable1" id="AddInfo" nowrap>&nbsp;</td>
           </tr>
           <%}%>
         <%}%>
       <%
           salrev.setRevEmpAvg();
           String sAvgCurRate = salrev.getAvgCurRate();
               String sAvgNewRate = salrev.getAvgNewRate();
               String sAvgIncrPrc = salrev.getAvgIncrPrc();
               String sTotAmt = salrev.getTotAmt();
               String sTotNewAmt = salrev.getTotNewAmt();
               String sTotPrc = salrev.getTotPrc();
               String sTotDiff = salrev.getTotDiff();
               String sTotSales = salrev.getTotSales();
               String sTotSlsHrs = salrev.getTotSlsHrs();
               String sTotLLyCom = salrev.getTotLLyCom();
               String sTotLyCom = salrev.getTotLyCom();
               String sTotTyCom = salrev.getTotTyCom();
               String sTotLyCoin = salrev.getTotLyCoin();
               String sTotTyCoin = salrev.getTotTyCoin();
               String sTotLyPay_Com = salrev.getTotLyPay_Com();
               String sTotTyPay_Com = salrev.getTotTyPay_Com();
               String sAvgScr = salrev.getAvgScr();
               String sLyAvgScr = salrev.getLyAvgScr();
       %>
           <tr class="DataTable1">
              <td class="DataTable1" nowrap colspan=17>Total Average Rates and % of Increase</td>
              <td class="DataTable" nowrap>$<%=sAvgCurRate%></td>
              <td class="DataTable1" nowrap colspan=4></td>
              <td class="DataTable" nowrap><%=sAvgIncrPrc%>%</td>
              <td class="DataTable" nowrap>$<%=sAvgNewRate%></td>

              <th class="DataTable2" id="AddInfo">&nbsp;</th>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotNewAmt%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCom%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyCoin%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotLyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotTyPay_Com%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotDiff%></td>
              <td class="DataTable" id="AddInfo" nowrap>&nbsp;</td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSales%></td>
              <td class="DataTable" id="AddInfo" nowrap>$<%=sTotSlsHrs%></td>
              <td class="DataTable1" id="AddInfo" nowrap>&nbsp;</td>
           </tr>
         <%  total = false;
           }%>

     </table>

     <p style="text-align:left; font-size:12px">
       * Weighted Average:  Average of hourly wage is weighted by number of hours worked by employee.
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
     salrev.disconnect();
   }
%>