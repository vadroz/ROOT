<%@ page import="payrollreports.PsWkSchedPrt,  rciutility.SetStrEmp"%>
<%
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekEnd = request.getParameter("WEEKEND");

 // get employee number by hours
   PsWkSchedPrt wkprt = new PsWkSchedPrt(sStore, sWeekEnd);

   String [] sWeek = wkprt.getWeeks();
   int iNumOfEmp = wkprt.getNumOfEmp();
   String [] sEmpName = wkprt.getEmpName();
   String [][] sHrsType = wkprt.getHrsType();
   String [][] sBegTime = wkprt.getBegTime();
   String [][] sEndTime = wkprt.getEndTime();
   String [] sEmpTotHr = wkprt.getEmpTotHr();

   wkprt.disconnect();

   SetStrEmp StrEmp = null;
   if(sWeekEnd.substring(sWeekEnd.lastIndexOf("/")).equals("2099")) { StrEmp =  new SetStrEmp(sStore,"BASE"); }
   else StrEmp =  new SetStrEmp(sStore,"RCI");

   String [] sEmpLNum = StrEmp.getEmpNum();
   String [] sEmpLName = StrEmp.getEmpName();
   String [] sEmpEMail = StrEmp.getEmpEMail();
   StrEmp.disconnect();

%>

<html>
<head>

<style>body {background:white;}
    a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
    table.DataTable { border: darkred solid 1px;background:white;text-align:center;}
    th.DataTable { background:#FFCC99;padding-top:3px; padding-left:3px;padding-right:3px; padding-bottom:3px; border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
    td.DataTable { background:white; padding-top:3px; padding-bottom:3px; padding-left:3px;padding-right:3px;
                   border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
    td.DataTable1 {padding-left:3px;padding-right:3px; padding-top:3px; padding-bottom:3px;
                    border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
    td.DataTable2 {background: gold; padding-left:3px;padding-right:3px; padding-top:3px; padding-bottom:3px;
                    border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
    td.DataTable3 {background: #afdcec;padding-left:3px;padding-right:3px; padding-top:3px; padding-bottom:3px;
                    border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
    td.DataTable4 {background: #99c68e;padding-left:3px;padding-right:3px; padding-top:3px; padding-bottom:3px;
                    border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }

    div.dvEMail { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}

   button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
   textarea.small{ text-align:left; font-family:Arial; font-size:10px;}
   input.small{ text-align:left; font-family:Arial; font-size:10px;}
   
   .Small{ font-size:11px;}

</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var EmpNum = new Array(<%=sEmpLNum.length%>)
var EmpName = new Array(<%=sEmpLName.length%>)
var EmpEMail = new Array(<%=sEmpEMail.length%>)

<%for(int i=0; i < sEmpLNum.length; i++){%>EmpNum[<%=i%>] = "<%=sEmpLNum[i]%>"; EmpName[<%=i%>] = "<%=sEmpLName[i]%>";   EmpEMail[<%=i%>] = "<%=sEmpEMail[i]%>";<%}%>
//--------------- End of Global variables ----------------
//==============================================================================
// email employee schedule
//==============================================================================
function sendSchedByEmail(empName, emailaddr)
{
   var html = "<form name='frmEmail'"
       + " METHOD=Post ACTION='javascript: sbmSchedByEmail()'"
       + "Send Individule Schedule to " + empName + "<br>"
       + "<table border=1 style='font-size:10px'><tr>"
       + "<th align=left>Subject:</th><td align=left><input class='Small' name='subject' value='Weekly schdule'></td>"
       + "</tr>"
       + "<tr>"
       + "<th align=left>To:</th><td align=left><input class='Small' name='to'></td>"
       + "</tr>"
       + "<tr>"
       + "<th align=left>Cc:</th><td align=left><input class='Small' name='cc'></td>"
       + "</tr>"
       + "<tr>"
       + "<th align=left>Bcc:</th><td align=left><input class='Small' name='bcc'></td>"
       + "</tr>"
       + "</table>"
       + "<input name='emp' type='hidden'>"
       + "<INPUT class='Small'  TYPE='submit' VALUE='Submit'>"
       + "<button class='Small'  onClick='hideEMail()'>Cancel</button>"
     + "</form>"

   document.all.dvEMail.innerHTML = html;
   document.all.dvEMail.style.width=250;
   document.all.dvEMail.style.pixelLeft=230;
   document.all.dvEMail.style.pixelTop=document.documentElement.scrollTop+150;
   document.all.dvEMail.style.visibility="visible"

   document.all.emp.value = empName.substring(0, 4);
   if(emailaddr == null){ popEMailToAddr(empName); }
   else{ document.frmEmail.to.value = emailaddr; }
}
//==============================================================================
// populate email To address
//==============================================================================
function popEMailToAddr(empName)
{
   var emp = empName.substring(0, 4);
   for(var i=0; i < EmpNum.length; i++)
   {
      if(emp == EmpNum[i])
      {
         document.frmEmail.to.value = EmpEMail[i];
         break;
      }
   }
}
//==============================================================================
// run sending email
//==============================================================================
function sbmSchedByEmail()
{
   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmEml"

   var html = "<form name='frmSbmEml'"
       + " METHOD=Post ACTION='SendEmail.jsp'"
       + "<br><input class='Small' name='subject'>"
       + "<input class='Small' name='from'>"
       + "<input class='Small' name='to'>"
       + "<input class='Small' name='cc'>"
       + "<input class='Small' name='bcc'>"
       + "<input name='body' type='hidden'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmeml = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.from.value = "gm<%=sStore%>@retailconcepts.cc";
   window.frame1.document.all.subject.value=frmeml.subject.value;
   window.frame1.document.all.to.value=frmeml.to.value;
   window.frame1.document.all.cc.value=frmeml.cc.value;
   window.frame1.document.all.bcc.value=frmeml.bcc.value;
   window.frame1.document.all.body.value=getSchedTbl();

   window.frame1.document.frmSbmEml.submit();
   hideEMail();

   saveEmpEMail();
}

//==============================================================================
// show email address entry panel
//==============================================================================
function getSchedTbl()
{
    var style = "<style>" + document.styleSheets[0].cssText + "</style>"

    var hdr = "<b>Retail Concepts, Inc</b>"
       + " <br><h1>Employee Work Schedule</h1><br>"
       + " <b>Store:&nbsp;<%=sStore + " - " + sThisStrName%>"
       + " <br>Week Ending:&nbsp;<%=sWeekEnd%>"
       + " </b><p>"

    var table = document.all.tbSched.outerHTML;

    var pos = table.indexOf("<A");
    while(pos >= 0)
    {
      var epos = pos + eval(table.substring(pos+1).indexOf("')")) + 5;
      var replstr = table.substring(pos, epos)
      table = table.substring(0, pos) + table.substring(epos);
      pos = table.indexOf("<A");
    }

    var body = style + "<html>" + hdr + table + "</html>"
    return body;
}

//==============================================================================
// save email
//==============================================================================
function saveEmpEMail()
{
   var emp = document.frmEmail.emp.value;
   var email = document.frmEmail.to.value;

   var url = "PsEmpEmailSave.jsp?"
     + "Emp=" + emp
     + "&EMail=" + email

   window.frame2.location.href = url;


   for(var i=0; i < EmpNum.length; i++)
   {
      if(emp == EmpNum[i])
      {
         EmpEMail[i]=email;
         break;
      }
   }

   window.frame2.close();
}
//==============================================================================
// hide email panel
//==============================================================================
function hideEMail()
{
   document.all.dvEMail.style.visibility="hidden"
}
</SCRIPT>
</head>
<body>
<!----------------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=1 height="0" width="0"></iframe>
<iframe  id="frame2"  src="" frameborder=1 height="0" width="0%"></iframe>
<!----------------------------------------------------------------------------->
<div id="dvEMail" class="dvEMail"></div>
<!----------------------------------------------------------------------------->

    <table border="0" width="100%" height="100%">
             <tr bgColor="White">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc</b>
      <br><h1>Employee Work Schedule</h1><br>
<!-------------------------------------------------------------------->
        <b>Store:&nbsp;<%=sStore + " " + sThisStrName%>
           <br>Week Ending:&nbsp;<%=sWeekEnd%>
        </b>
      <p>
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <font size="-1">This page</font>
        <br>
        <span  class="Small">Click your DM's name to send the schedule to him:
       <a class="Small" href="javascript: sendSchedByEmail('Andy Christ','achrist@sunandski.com')">Andy Christ</a> &nbsp;
       <a class="Small" href="javascript: sendSchedByEmail('Stan Paoli', 'spaoli@sunandski.com')">Stan Paoli</a> &nbsp;
       <a class="Small" href="javascript: sendSchedByEmail('Kelly Knight','kknight@sunandski.com')">Kelly Knight</a> &nbsp;
       </span>
        
        
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0" id="tbSched">
         <tr>
           <th class="DataTable" rowspan="2">Employee</th>
           <th class="DataTable" colspan="7">Days</th>
           <th class="DataTable" rowspan="2">Total<br>Hours</th>
         </tr>
             <%for(int i=0; i < 7; i++){%>
                <th class="DataTable" ><%=sWeek[i]%></th>
             <%}%>
         <tr>
         </tr>
         <%for(int i=0; i < iNumOfEmp; i++ ){%>
           <tr>
             <td class="DataTable" ><a href="javascript: sendSchedByEmail('<%=sEmpName[i]%>', null)"><%=sEmpName[i]%></a></td>

             <%for(int j=0; j < 7; j++){%>
                <%if(sHrsType[i][j].trim().equals("REG")) {%>
                      <td class="DataTable1" ><%=sBegTime[i][j]%> - <%=sEndTime[i][j]%></td><%}
                  else if(sHrsType[i][j].trim().equals("OFF")) {%>
                      <td class="DataTable2" >Request Off</td><%}
                  else if(sHrsType[i][j].trim().equals("VAC")) {%>
                       <td class="DataTable3" >Vacation</td><%}
                  else if(sHrsType[i][j].trim().equals("HOL")) {%>
                       <td class="DataTable4" >Holiday</td><%}
                  else if(sHrsType[i][j].trim().equals("")) {%>
                       <td class="DataTable1" >&nbsp;</td><%}%>

             <%}%>
             <td class="DataTable1" ><%=sEmpTotHr[i]%></td>
           </tr>
         <%}%>
      </table>
      <!----------------------- end of table ------------------------>
    </td>
   </tr>
  </table>
 </body>
</html>
