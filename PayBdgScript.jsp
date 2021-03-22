<%@ page import="payrollreports.SetPBScript"%>
<%
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekend = request.getParameter("WEEK");
   String sEmpNum = request.getParameter("EmpNum");


  SetPBScript pbScript = new SetPBScript(sStore, sWeekend, sEmpNum);

  int iNumOfEnt = pbScript.getNumOfEnt();
  String [] sStr = pbScript.getStr();
  String [] sSchDate = pbScript.getSchDate();
  String [] sEmp = pbScript.getEmp();
  String [] sGrp = pbScript.getGrp();
  String [] sUser = pbScript.getUser();
  String [] sDate = pbScript.getDate();
  String [] sTime = pbScript.getTime();
  String [] sAction = pbScript.getAction();
  String [] sVersion = pbScript.getVersion();
  String [] sPgm = pbScript.getPgm();

  pbScript.disconnect();

%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-size:10px }
        td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial }

        tr.Divider { background:darkred; font-size:1px }

</style>
<SCRIPT language="JavaScript">

function bodyLoad(){
}

</SCRIPT>
</head>
<body  onload="bodyLoad();">

 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr bgColor="moccasin">
     <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Payroll Budget History Log</b><br>


        <font size="+1" ><b>Store:&nbsp;<%=sStore + " - " + sThisStrName%>
        </b></font>
        <p><a href="../"><font color="red">Home</font></a>&#62;
        <!-- a href="StrScheduling.html"><font color="red">Payroll</font></a -->
        <a href="PayBdgScrSel.jsp"><font color="red">Select</font></a>&#62;
        This page
      </td>
    </tr>

    <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" >
             <tr>
                  <th class="DataTable" >Store<br></th>
                  <th class="DataTable" >Schdule<br>Date</th>
                  <th class="DataTable" >Group</th>
                  <th class="DataTable" >Employee</th>
                  <th class="DataTable" >Action</th>

                  <th class="DataTable" >User</th>
                  <th class="DataTable" >Last<br>Date</th>
                  <th class="DataTable" >Last<br>Time</th>
                  <th class="DataTable" >Version</th>
                  <th class="DataTable">Program</th>
             </tr>

             <%
                 String SvVersn = null;
                 if(sVersion != null && sVersion.length > 0){SvVersn = sVersion[0];}
             %>

             <%for(int i=0; i < iNumOfEnt; i++){%>
                <%if(!SvVersn.equals(sVersion[i])){%>
                   <tr class="Divider"><td colspan=10>&nbsp;</td></tr>
                <%}%>
                <tr class="DataTable">
                   <td class="DataTable"><%=sStr[i]%></td>
                   <td class="DataTable"><%=sSchDate[i]%></td>
                   <td class="DataTable"><%=sGrp[i]%></td>
                   <td class="DataTable"><%=sEmp[i]%></td>
                   <td class="DataTable"><%=sAction[i]%></td>

                   <td class="DataTable"><%=sUser[i]%></td>
                   <td class="DataTable"><%=sDate[i]%></td>
                   <td class="DataTable"><%=sTime[i]%></td>

                   <td class="DataTable"><%=sVersion[i]%></td>
                   <td class="DataTable"><%=sPgm[i]%></td>
                 </tr>
                 <%SvVersn = sVersion[i];%>
             <%}%>
       </table>

<!------------- end of data table ------------------------>

       </td>
    </tr>
  </table>

</body>
</html>
