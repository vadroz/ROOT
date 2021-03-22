<%@ page import="rciutility.SetStrEmp"%>
<%
  String sRtnNum = request.getParameter("EMPNUM");
  String sRtnName = request.getParameter("EMPNAME");
  String sForm = request.getParameter("FORM");
  String sType = request.getParameter("TYPE");
  String sFileType = request.getParameter("FILETYPE");
  String sStore = request.getParameter("STORE");

  if(sRtnNum==null) sRtnNum="EmpNum";
  if(sRtnName==null) sRtnName="EmpName";
  if(sForm==null) sForm="all";
  if(sType==null) sType="FIELD";
  if(sFileType == null) sFileType = "RCI";


  SetStrEmp allEmp = null;
  // get store list
  int iNumOfStr = 0;
  String [] sStr = null;
  String [] sStrName = null;
  int iNumOfEmp = 0;
  String [] sEmp = null;
  String [] sEmpName = null;
  String [] sDptName = null;
  String [] sDptType = null;
  String [] sTimeOffType = null;
  String [] sDayAvail = null;


  allEmp = new SetStrEmp(sFileType);
    // get store list
    iNumOfStr = allEmp.getNumOfStr();
    sStr = allEmp.getStr();
    sStrName = allEmp.getStrName();
    iNumOfEmp = allEmp.getNumOfStr();

  if(sFileType.equals("RCI"))
  {

  }
  else
  {

  }
%>

<html>
<head>
<SCRIPT language="JavaScript">
	document.write("<style>body {background:ivory;scrollbar-base-color: saddlebrown}");
        document.write("title { background:red}");
        document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
        document.write("table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}");
        document.write("th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:10px }");
        document.write("td.DataTable { background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }");
        document.write("</style>");

var RtnType = "<%=sType%>";
var Store = "<%=sStore%>";

function bodyLoad(){
 document.title.bgcolor="red";
 document.title = "RCI All Store Employee Selection List";
 self.focus();

 var obj = document.getElementById("S" + Store);
 obj.focus();

}

// sent selected employee number back to opener document
function sentValue(EmpNum, EmpName){

 if (RtnType == "FIELD")
 {
   opener.document.<%=sForm%>.<%=sRtnNum%>.value=EmpNum;
   opener.document.<%=sForm%>.<%=sRtnName%>.value=EmpName;
 }
 else
 {
   var idx = opener.document.<%=sForm%>.<%=sRtnNum%>.length;
   opener.document.<%=sForm%>.<%=sRtnNum%>.options[idx-1].text=EmpName;
   opener.document.<%=sForm%>.<%=sRtnNum%>.options[idx-1].value=EmpNum;
   opener.document.<%=sForm%>.<%=sRtnNum%>.selectedIndex=idx-1
 }
  window.close();
}


function goToStore(){
  var loc = document.all.STORE.options[document.all.STORE.selectedIndex].value;
  var obj = document.getElementById(loc);
  obj.focus();
}
</SCRIPT>

</head>
 <body  onload="bodyLoad();" >
 <p align="center">

  <SELECT name="STORE" >
  </SELECT>
  &nbsp;&nbsp;
  <button name="gotoStr" onclick="goToStore()">Find</button>
  <a name="Top"></a>


<%
  for(int i=0; i < iNumOfStr; i++){%>
    <script>
      var store = document.all.STORE;
      store.options[<%=i%>] = new Option("<%=sStr[i]%> - <%=sStrName[i]%>","S<%=sStr[i]%>");
    </script>
  <table class="DataTable" width="100%" id="S<%=sStr[i]%>">
   <tr>
     <th class="DataTable" colspan="3">Store:&nbsp;&nbsp;&nbsp;
        <%=sStr[i]%> - <%=sStrName[i]%>&nbsp;&nbsp;&nbsp;<a href="#Top">Top</a>
     </th>
   </tr>
<%  allEmp.setEmp(sStr[i]);
    iNumOfEmp = allEmp.getNumOfEmp();
    sEmp = allEmp.getEmpNum();
    sEmpName = allEmp.getEmpName();
    sDptName = allEmp.getDptName();
    for(int j=0; j < iNumOfEmp; j++){%>
    <tr>
      <td class="DataTable">
         <a href="javascript:sentValue('<%=sEmp[j]%>', '<%=sEmpName[j]%>')"><%=sEmp[j]%></a>
      </td>
      <td class="DataTable"><%=sEmpName[j]%></td>
      <td class="DataTable"><%=sDptName[j]%></td>
    </tr>
<%  }%>
  </table>
  <p>
<%}%>
 </body>
</html>
<%
  allEmp.disconnect();
%>