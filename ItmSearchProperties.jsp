<%@ page import="onhand01.ItmSearchProperties"%>
<%
  String sSearch = request.getParameter("Search");
  String sSelDiv = request.getParameter("DIV");
  String sSelDpt = request.getParameter("DPT");
  String sSelCls = request.getParameter("CLS");
  String sSelVen = request.getParameter("VEN");

  if(sSelDiv==null) sSelDiv = " ";
  if(sSelDpt==null) sSelDpt = " ";
  if(sSelCls==null) sSelCls = " ";
  if(sSelVen==null) sSelVen = " ";

  int iNumOfRtn = 0;
  String [] sRtnVal = null;
  String [] sRtnValName = null;

  String [] sRtnCls = null;
  String [] sRtnClsName = null;


  String sTitle = sSearch;


  //System.out.println(sSearch + " " + sSelVen);

  ItmSearchProperties selitml = new ItmSearchProperties(sSearch, sSelDiv, sSelDpt, sSelCls, sSelVen);

  if(sSearch.equals("DIV"))
  {
    iNumOfRtn = selitml.getNumOfDiv();
    sRtnVal = selitml.getDiv();
    sRtnValName = selitml.getDivName();
    sTitle = "Division";
  }
  else if(sSearch.equals("DPT"))
  {
    iNumOfRtn = selitml.getNumOfDpt();
    sRtnVal = selitml.getDpt();
    sRtnValName = selitml.getDptName();
    sTitle = "Department";
  }
  else if(sSearch.equals("CLASS"))
  {
    iNumOfRtn = selitml.getNumOfCls();
    sRtnVal = selitml.getCls();
    sRtnValName = selitml.getClsName();
    sTitle = "Class";
  }

  else if(sSearch.equals("VENDOR"))
  {
    iNumOfRtn = selitml.getNumOfVen();
    sRtnVal = selitml.getVen();
    sRtnValName = selitml.getVenName();
    sRtnCls = selitml.getCls();
    sRtnClsName = selitml.getClsName();
    sTitle = "Vendor";
  }

  selitml.disconnect();
%>

<html>
<head>

<style>
 body {background:ivory;scrollbar-base-color: saddlebrown}
 title { background:red}
 a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
 table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
 th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:10px }
 td.DataTable { background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }
</style>

<SCRIPT language="JavaScript">
function bodyLoad()
{
 self.focus();
}
//==============================================================================
// sent selected employee number back to opener document
//==============================================================================
function sentValue(div, divName){
  opener.document.forms[0].<%=sSearch%>.value=div;
  window.close();
}

</SCRIPT>
</head>

<body  onload="bodyLoad();" >
  <p align="center">

  <table class="DataTable" width="100%">
   <tr>
     <th class="DataTable"><%=sTitle%></th>
     <%if(sSearch.equals("VENDOR")) {%>
       <th class="DataTable" >Class</th>
       <th class="DataTable" >Class Name</th>
    <%}%>
   </tr>
   <%for(int i=0; i < iNumOfRtn; i++){%>
      <tr>
        <td class="DataTable">
           <a href="javascript:sentValue('<%=sRtnVal[i]%>', ' ')"><%=sRtnVal[i]%> - <%=sRtnValName[i]%></a>
        </td>
        <%if(sSearch.equals("VENDOR")) {%>
            <td class="DataTable"><%=sRtnCls[i]%></td>
            <td class="DataTable"><%=sRtnClsName[i]%></td>
        <%}%>
      </tr>
   <%}%>
  </table>
 </body>
</html>