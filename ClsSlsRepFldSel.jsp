<%@ page import="rciutility.StoreSelect"%>
<%

   String sDivSelType = request.getParameter("DivSelType");
   String sDiv = request.getParameter("DIVISION");
   // for multiple division selection
   String sDivArr = request.getParameter("DivArr");
   String sDivArrSel = request.getParameter("DivArrSel");
   String [] sDivMlt = request.getParameterValues("DIVM");

   String sDpt = request.getParameter("DEPARTMENT");
   String sCls = request.getParameter("CLASS");
   String sFrom = request.getParameter("FROM");
   String sTo = request.getParameter("TO");
   String sSelType = request.getParameter("DateType");
   String [] sStore = request.getParameterValues("STR");
   StringBuffer sbStrList = new StringBuffer();
   String coma = null;
   for(int i=0; i < sStore.length; i++)
   {
         if (coma != null) sbStrList.append(coma);
         if (sStore[i].trim().equals("CMPD")) sbStrList.append("COMP + DC");
         else sbStrList.append(sStore[i]);
         if (coma == null) coma = ", ";
   }

   boolean bKiosk = session.getAttribute("USER") == null;
   String sUser = "KIOSK";
   if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }

   StoreSelect strsel = new StoreSelect(4);
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStr = strsel.getStrLst();
%>
<!-- ---------------------------- Style -------------------------------- -->
<style>
  body {background:ivory;}
  table.FormTb { background:#FFE4C4;}
  td.FormTb { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
  td.FormTb1 { color: blue; text-align:right; font-weight: bold; padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
  td.FormTb2 { color: brown; text-align:left; font-weight: bold; padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }

  a.Date:link { color:blue; text-decoration:none }
   a.Date:visited { color:blue; text-decoration:none }
   a.Date:hover { color:red; text-decoration:none }

   .Small { font-size:10px }
</style>
<!-- ------------------------- End Style ------------------------------ -->

<script name="javascript">
var Store = new Array();
<%for(int i=0; i < sStore.length; i++){%> Store[<%=i%>] = "<%=sStore[i]%>"; <%}%>
var DivArr = [<%=sDivArr%>];
var DivArrSel = [<%=sDivArrSel%>];
var DivSelType = <%=sDivSelType%>;
DivSelType = !DivSelType;

//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  chgDivSelType();
  setMultDiv();

  var str = document.all.STR;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < Store.length; j++)
     {
        if(str[i].value == Store[j]){str[i].checked = true; }
     }
  }
}
//==============================================================================
// change Division Selection type - Multiple/Single
//==============================================================================
function chgDivSelType()
{
   var single = "none"
   var mult = "block"
   if (DivSelType) { single = "block"; mult = "none" }
   document.all.trDivSngl.style.display = single
   document.all.trMultDiv.style.display = mult

   DivSelType = !DivSelType;
   document.all.DivSelType.value = DivSelType;
}
//==============================================================================
// set Multiple Divisions
//==============================================================================
function setMultDiv()
{
   var html = "";

   //  populate the division list
   for (var i = 1; i < DivArr.length; i++)
   {
      html += "<input name='DIVM' type='checkbox' value='" + DivArr[i] + "'>"
            + DivArr[i] + "&nbsp; &nbsp;"
   }

   document.all.dvDivMult.innerHTML = html;


   for (var i = 0; i < DivArrSel.length; i++)
   {
      document.all.DIVM[DivArrSel[i]].checked = true;
   }
}
//==============================================================================
// reset store field
//==============================================================================
function rstStores(grp)
{
   var strchk = document.all.STR

   for(var i=0; i < strchk.length; i++)
   {
      strchk[i].checked = false;
      if(grp=="ALL") { strchk[i].checked = true}
      else if(grp=="CMP" && strchk[i].value != 1 && strchk[i].value != 2 && strchk[i].value != 6
        && strchk[i].value != 55 && strchk[i].value != 60 && strchk[i].value != 70
        && strchk[i].value != 71 && strchk[i].value != 75 && strchk[i].value != 85
        && strchk[i].value != 86 && strchk[i].value != 89 && strchk[i].value != 99
        && strchk[i].value != 100 && strchk[i].value != 101 && strchk[i].value != 102
        && strchk[i].value != 199 && strchk[i].value != 63 && strchk[i].value != 93
        && strchk[i].value != 56&& strchk[i].value != 59)
      { strchk[i].checked = true}
      else if(grp=="CMPD" && strchk[i].value != 2 && strchk[i].value != 6
        && strchk[i].value != 55 && strchk[i].value != 60 && strchk[i].value != 70
        && strchk[i].value != 71 && strchk[i].value != 75 && strchk[i].value != 85
        && strchk[i].value != 86 && strchk[i].value != 89 && strchk[i].value != 99
        && strchk[i].value != 100 && strchk[i].value != 101 && strchk[i].value != 102
        && strchk[i].value != 199 && strchk[i].value != 63 && strchk[i].value != 93
        && strchk[i].value != 56&& strchk[i].value != 59)
      { strchk[i].checked = true}
   }
}
//==============================================================================
// Validate form
//==============================================================================
  function Validate(){

  var error = false;
  var msg = " ";

  // check if atleast one box checked
  var sel = false;
  if (document.all.SLSRET.checked) sel = true;
  if (document.all.SLSCST.checked) sel = true;
  if (document.all.SLSUNT.checked) sel = true;

  if (document.all.GMRAMT.checked) sel = true;
  if (document.all.GMRPRC.checked) sel = true;

  if (document.all.ENDRET.checked) sel = true;
  if (document.all.ENDCST.checked) sel = true;
  if (document.all.ENDUNT.checked) sel = true;

  if (document.all.AGERET.checked) sel = true;
  if (document.all.AGECST.checked) sel = true;
  if (document.all.AGEUNT.checked) sel = true;

  if (document.all.AGPRET.checked) sel = true;
  if (document.all.AGPCST.checked) sel = true;
  if (document.all.AGPUNT.checked) sel = true;

  var str = document.all.STR
  var strchk = false;
  for(var i=0; i < str.length; i++)
  {
     if(str[i].checked) { strchk = true; }
  }
  if(!strchk)
  {
    msg += "Please, select at least one store.\n";
    error = true;
  }

  // check that at least division selected if multiple choice selected
  if(DivSelType)
  {
      var div = document.all.DIVM
      var divchk = false;
      var coma = "";
      var divarrsel = "";
      for(var i=0; i < div.length; i++)
      {
         if(div[i].checked) { divchk = true; divarrsel += coma + i; coma = ","}
      }
      if(!divchk)
      {
         msg += "Please, select at least one division.\n";
         error = true;
      }
      else
      {
         document.all.DivArrSel.value = divarrsel;
      }
  }




  if(!sel)
  {
    msg += "Please, check at least 1 Sales/Inventory property";
    error = true;
  }

  if (error) alert(msg);
  else
  {
    document.forms[0].DIVISION.value = document.forms[0].DIVISION.value.toUpperCase();
    document.forms[0].DEPARTMENT.value = document.forms[0].DEPARTMENT.value.toUpperCase();
    document.forms[0].CLASS.value = document.forms[0].CLASS.value.toUpperCase();
  }

  return error == false;
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, days)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * days);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * days);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-- saved from url=(0088)http://192.168.20.64:8080/servlet/formgenerator.FormGenerator?FormGrp=TICKETS&Form=BBT01 -->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>

    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>GM Data Download</B>

        <br><br><p><a href="<%if(!bKiosk) {%>index.jsp<%} else {%>Outsider.jsp<%}%>"><font color="red"  size="-1">Home</font></a>&#62;
        <a href="ClsSlsRepSel.jsp"><font color="red" size="-1">Select Items</font></a>&#62;
        <font size="-1">This page</font>

      <FORM  method="GET" action="ClsSlsRep02.jsp" onSubmit="return Validate(this)">
         <input type="hidden" name="SELTYPE" value="<%=sSelType%>">
         <input type="hidden" name="DivSelType">
         <input type="hidden" name="DivArr" value="<%=sDivArr%>">
         <input type="hidden" name="DivArrSel">

         <!-- --------------------------------------------- -->

      <TABLE border=1>
        <tr>
         <td class=FormTb align=center colspan=6><b><u>Previously selected report parameters</u></b><td>
        </tr>

        <!-- ============= Multiple Division Selection ===================== -->
        <tr id="trMultDiv">
          <td class=FormTb1 >Division:<br>
             <button class="Small" onclick="chgDivSelType()" >Single</button>
          </td>
          <td class=Small colspan=5><div id="dvDivMult"></div>

        <tr id="trDivSngl">
        <!-- ============= Single Division =========================================== -->
          <td class=FormTb1 >Division:<br>
             <button class="Small" onclick="chgDivSelType()" >Multiple</button>
          </td>
          <td class=FormTb2 >
             <input class="Small" maxlength="3" size="5" type="text"
                    name="DIVISION" value="<%=sDiv%>" >
          </td>

          <!-- ============= Department===================================== -->
          <td class=FormTb1 >Department:</td>
          <td class=FormTb2 >
             <input class="Small" maxlength="3" size="5" type="text"
                    name="DEPARTMENT" value="<%=sDpt%>" ></td>

       <!-- ============= Class ============================================ -->
          <td class=FormTb1 >Class:</td>
          <td class=FormTb2 >
             <input class="Small" maxlength="4" size="5" type="text"
                name="CLASS" value="<%=sCls%>"></td>
        </tr>
        <!-- ============= Store =========================================== -->
        <tr>
          <td class=FormTb1 >Store:</td>
          <td class=Small colspan=5><!--%=sbStrList.toString()% -->
               <button class="Small" onclick="rstStores('ALL')" value="ALL">ALL</button>
                <button class="Small" onclick="rstStores('CMP')" value="ALL">CMP</button>
                <button class="Small" onclick="rstStores('CMPD')" value="ALL">CMPD</button>
                <button class="Small" onclick="rstStores('NONE')" value="ALL">Reset</button>
                <br>&nbsp;

                <table border=0 cellPadding=0 cellSpacing=0 style="font-size:10px">
                   <%for(int i=0; i < iNumOfStr; i++){%>
                      <%if(i == iNumOfStr / 2){%><tr><%}%>
                      <td><input class="Small" name="STR" type="checkbox"  value="<%=sStr[i]%>"><%=sStr[i]%> &nbsp;</td>
                   <%}%>
                </table>
          </td>

        </tr>
        <tr>
          <td class=FormTb1 >From:</td>
          <td class=FormTb2 >
             <button class="Small" name="Down" onClick="setDate('DOWN', 'FROM', 28)">&#60;&#60;</button>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'FROM', 7)">&#60;</button>
             <input name="FROM"  maxlength=10 size=10 value="<%=sFrom%>">
             <button class="Small" name="Up" onClick="setDate('UP', 'FROM', 7)">&#62;</button>
             <button class="Small" name="Up" onClick="setDate('UP', 'FROM', 28)">&#62;&#62;</button>
          </td>
          <td class=FormTb1 >To:</td>
          <td class=FormTb2>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'TO', 28)">&#60;&#60;</button>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'TO', 7)">&#60;</button>
             <input name="TO"  maxlength=10 size=10 value="<%=sTo%>">
             <button class="Small" name="Up" onClick="setDate('UP', 'TO', 7)">&#62;</button>
             <button class="Small" name="Up" onClick="setDate('UP', 'TO', 28)">&#62;&#62;</button>
          </td>
        </tr>
      </TABLE>
      <TABLE border=0 >
        <tr>
          <td class=FormTb align=center colspan=8><br><b><u>Select report data</u></b></td>
        </tr>

        <!-- Sales -->
        <tr>
          <td class=FormTb align=left colspan=8><br><u>Retrieve Data For:</u></td>
        </tr>
        <tr>
           <td class=FormTb align=center colspan=2><u>&nbsp;&nbsp;Sales:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></td>
           <td class=FormTb align=center colspan=2><u>&nbsp;&nbsp;&nbsp;Gross Margin:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></td>
           <td class=FormTb align=center colspan=2><u>Ending Inventory:</u></td>
           <td class=FormTb align=center colspan=4><u>&nbsp;&nbsp;&nbsp;&nbsp;Aged Inventory:&nbsp;&nbsp;</u></td>
        </tr>
        <tr>
           <td class=FormTb align=right >Retail</td>
           <td class=FormTb align=left ><input type="checkbox" name="SLSRET" value="1"></td>
           <td class=FormTb align=right >GM Dollars</td>
           <td class=FormTb align=left><input type="checkbox" name="GMRAMT" value="1"></td>
           <td class=FormTb align=right >Retail</td>
           <td class=FormTb align=left><input type="checkbox" name="ENDRET" value="1"></td>
           <td class=FormTb align=right >Retail</td>
           <td class=FormTb align=left><input type="checkbox" name="AGERET" value="1"></td>
           <td class=FormTb align=right > - %</td>
           <td class=FormTb align=left><input type="checkbox" name="AGPRET" value="1"></td>

        </tr>
        <tr>
           <td class=FormTb align=right>Cost</td>
           <td class=FormTb align=left><input type="checkbox" name="SLSCST" value="1"></td>
           <td class=FormTb align=right >GM %:</td>
           <td class=FormTb align=left><input type="checkbox" name="GMRPRC" value="1"></td>
           <td class=FormTb align=right>Cost</td>
           <td class=FormTb align=left><input type="checkbox" name="ENDCST" value="1"></td>
           <td class=FormTb align=right>Cost</td>
           <td class=FormTb align=left><input type="checkbox" name="AGECST" value="1"></td>
           <td class=FormTb align=right> - %</td>
           <td class=FormTb align=left><input type="checkbox" name="AGPCST" value="1"></td>
        </tr>
        <tr>
           <td class=FormTb align=right>Units</td>
           <td class=FormTb align=left><input type="checkbox" name="SLSUNT" value="1"></td>
           <td class=FormTb colspan=2>&nbsp;</td>
           <td class=FormTb align=right>Units</td>
           <td class=FormTb align=left><input type="checkbox" name="ENDUNT" value="1"></td>
           <td class=FormTb align=right>Units</td>
           <td class=FormTb align=left><input type="checkbox" name="AGEUNT" value="1"></td>
           <td class=FormTb align=right> - %</td>
           <td class=FormTb align=left><input type="checkbox" name="AGPUNT" value="1"></td>
        </tr>



      <%if (sStore.length > 1 || sStore[0].equals("CMP")
         || sStore[0].equals("CMPD") || sStore[0].equals("ALL")){%>
        <tr>
          <td class=FormTb align=left><u>Presentation:</u></td>
        </tr>
        <tr>
           <td class=FormTb align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;By Store</td>
           <td class=FormTb align=left><input type="radio" name="DETAIL" value="D"></td>
           <td class=FormTb align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;By Store Summary</td>
           <td class=FormTb align=left><input type="radio" name="DETAIL" value="S" checked></td>
        </tr>
     <%}
     else {%>
       <input name="DETAIL" type="hidden" value="S">
     <%}%>

        <tr>
          <td class=FormTb align=left><u>Group by:</u></td>
        </tr>

     <tr>
           <td class=FormTb align=right><%for(int i=0; i<10; i++){%>&nbsp;<%}%>By Division</td>
           <td class=FormTb align=left><input type="radio" name="GROUP" value="DIV"></td>
           <td class=FormTb align=right>By Department</td>
           <td class=FormTb align=left><input type="radio" name="GROUP" value="DPT"></td>
           <td class=FormTb align=right>By Class</td>
           <td class=FormTb align=left><input type="radio" name="GROUP" value="CLS"></td>
           <td class=FormTb align=right>None</td>
           <td class=FormTb align=left><input type="radio" name="GROUP" value="NON" checked></td>
        </tr>

     <TR>
           <TD class=FormTb align=center colSpan=9>
               <INPUT type=submit value=Submit name=SUBMIT>&nbsp;&nbsp;
               <INPUT type="reset" name=Reset>
           </TD>
          </TR>

         </TBODY>
        </TABLE>
       </FORM>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
