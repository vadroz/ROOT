<%@ page import="classreports.ChallMainLst"%>
<%
    String sType  = request.getParameter("Type");

    if(sType == null){sType = "ALL";}

    String sUser = session.getAttribute("USER").toString();

    ChallMainLst chmainnl = new ChallMainLst(sType, sUser);
%>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable  { background:f0f0f0; font-family:Arial; font-size:10px }
        td.DataTable {  padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:center }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:left }

        div.dvBonus { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        .small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
        </style>

<script language="javascript1.2">
//==============================================================================
// initial page loads
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvBonus"]);
}
//==============================================================================
// get Bonuses recipient groups
//==============================================================================
function getChallBonuses(code, name)
{
  var url = "ChBonusLst.jsp?Code=" + code + "&Name=" + name
  window.frame1.location.href = url;
}
//==============================================================================
// get Bonuses recipient groups
//==============================================================================
function showBonuses(code, name, empGrp, type, bonusType, payBrnz, paySlvr, payGold)
{
  var hdr = name;

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidedvBonus();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popBonuses(empGrp, type, bonusType, payBrnz, paySlvr, payGold)
        + "</td></tr></table>"

  document.all.dvBonus.innerHTML=html
  document.all.dvBonus.style.pixelLeft= document.documentElement.scrollLeft + 600;
  document.all.dvBonus.style.pixelTop= document.documentElement.scrollTop + 100;
  document.all.dvBonus.style.visibility="visible"
}
//==============================================================================
// populate clinic panel
//==============================================================================
function popBonuses(empGrp, type, bonusType, payBrnz, paySlvr, payGold)
{
   var dummy = "<table>";
   var html = "<table style='background:#ccffcc; font-size=10px' border=1 cellPadding='0' cellSpacing='0' width='100%'>"
            + "<tr>"
              + "<th rowspan=2>Type</th>"
              + "<th rowspan=2>Employee<br>Group</th>"
              + "<th rowspan=2>Bonus<br>Type</th>"
              + "<th colspan=3>Rate/Amount</th>"
            + "</tr>"
            + "<tr>"
              + "<th>Bronze</th>"
              + "<th>Silver</th>"
              + "<th>Gold</th>"
            + "</tr>"

   for(var i=0; i < empGrp.length ;i++)
   {
       html += "<tr>"
               + "<td class='DataTable' nowrap>" + type[i] + "</td>"
               + "<td class='DataTable' nowrap>" + empGrp[i] + "</td>"
               + "<td class='DataTable' nowrap>" + bonusType[i] + "</td>"
               + "<td class='DataTable1' nowrap>$" + payBrnz[i] + "</td>"
               + "<td class='DataTable1' nowrap>$" + paySlvr[i] + "</td>"
               + "<td class='DataTable1' nowrap>$" + payGold[i] + "</td>"
             + "</tr>"
   }

   html += "<tr>"
              + "<td class='DataTable' colspan=7>"
                 + "<button class='small' onClick='hidedvBonus()'>Cancel</button>"
              + "</td>"
            + "</tr>";
   html += "</table>"
   return html;
}
//==============================================================================
// hide bonus panel
//==============================================================================
function hidedvBonus(){ document.all.dvBonus.style.visibility="hidden" }

//==============================================================================
// show Item Selection page
//==============================================================================
function showItemSel(code, name)
{
   url = "ChallItemSel.jsp?Code=" + code
       + "&Name=" + name.replaceSpecChar();
   //alert(url)
   window,location.href = url;
}

//==============================================================================
// select different challenge list
//==============================================================================
function getSelRepType()
{
   var type = document.all.SelListType.options[document.all.SelListType.selectedIndex].value;
   var url = "ChallMainLst.jsp?Type=" + type;
   window.location.href = url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

<html>
<head>
<title>
Challenge List
</title>
</head>
<body onload="bodyLoad();">

<!-------------------------------------------------------------------->
<div class="dvBonus" id="dvBonus"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><b>Retail Concepts Inc.
        <BR>Challenge List
        </b>

      <br><p><a href="../"><font color="red"  size="-1">Home</font></a>&#62;
         <font size="-1">This page</font> &nbsp; &nbsp; &nbsp; &nbsp;

      <span style="font-size:12px">Select List:</span>
      <select name="SelListType" class="small">
        <option value="ALL">All</option>
        <option value="CURRENT" selected>Active</option>
        <option value="FUTURE">Future</option>
        <option value="FUTCURR">Active and Future</option>
        <option value="PAST">Past</option>
      <select>
      <button class="small" onclick="getSelRepType()">Submit</button>
      <!------------- start Receipt table ------------------------>
      <table class="DataTable" border=1 cellPadding='0' cellSpacing='0'>
             <tr class="DataTable">
                <th class="DataTable" rowspan=2>Name</th>
                <th class="DataTable" rowspan=2>Description</th>
                <th class="DataTable" rowspan=2>Beginning<br>Date</th>
                <th class="DataTable" rowspan=2>Ending<br>Date</th>
                <th class="DataTable" rowspan=2>Person<br>Responsibile</th>

                <th class="DataTable" colspan=3>Bonus Levels
                    <br><span style="font-size=10px">(ie exceeds LY Sales)</span>
                </th>
                <th class="DataTable" rowspan=2>Bonus<br>Recepients</th>
                <th class="DataTable" colspan=4>Stages</th>
             </tr>

             <tr class="DataTable">
                <th class="DataTable">Bronze</th>
                <th class="DataTable">Silver</th>
                <th class="DataTable">Gold</th>

                <th class="DataTable">Stage</th>
                <th class="DataTable">Beginnig</th>
                <th class="DataTable">Ending</th>
                <th class="DataTable">Store</th>

             </tr>
      <!-- ============= Details =========================================== -->
      <%
         while(chmainnl.getNext())
         {
           chmainnl.getCodeList();
           int iNumOfChl = chmainnl.getNumOfChl();
           String [] sCode = chmainnl.getCode();
           String [] sName = chmainnl.getName();
           String [] sDesc = chmainnl.getDesc();
           String [] sBegDt = chmainnl.getBegDt();
           String [] sEndDt = chmainnl.getEndDt();
           String [] sResp = chmainnl.getResp();
           String [] sMainPg = chmainnl.getMainPg();
           String [] sLvlBrnz = chmainnl.getLvlBrnz();
           String [] sLvlSlvr = chmainnl.getLvlSlvr();
           String [] sLvlGold = chmainnl.getLvlGold();

           for(int i = 0; i < iNumOfChl; i++)
           {%>
              <tr class="DataTable">
                 <td class="DataTable2"><a href="javascript: showItemSel('<%=sCode[i]%>', '<%=sName[i]%>')"><%=sName[i]%></a></td>
                 <td class="DataTable2"><%=sDesc[i]%></td>
                 <td class="DataTable"><%=sBegDt[i]%></td>
                 <td class="DataTable"><%=sEndDt[i]%></td>
                 <td class="DataTable2"><%=sResp[i]%></td>
                 <td class="DataTable1"><%=sLvlBrnz[i]%>%</td>
                 <td class="DataTable1"><%=sLvlSlvr[i]%>%</td>
                 <td class="DataTable1"><%=sLvlGold[i]%>%</td>
                 <th class="DataTable"><a href="javascript: getChallBonuses('<%=sCode[i]%>', '<%=sName[i]%>')">Bonus</a></th>

              <%
                 chmainnl.getStgChall(sCode[i]);
                 int iNumOfStg = chmainnl.getNumOfStg();
                 String [] sStage = chmainnl.getStage();
                 String [] sStgBegDa = chmainnl.getStgBegDa();
                 String [] sStgEndDa = chmainnl.getStgEndDa();
                 String [][] sStgStr = chmainnl.getStgStr();
              %>
                 <td class="DataTable"><%for(int j = 0; j < iNumOfStg; j++) {%><%=sStage[j]%><br><%}%></td>
                 <td class="DataTable"><%for(int j = 0; j < iNumOfStg; j++) {%><%=sStgBegDa[j]%><br><%}%></td>
                 <td class="DataTable"><%for(int j = 0; j < iNumOfStg; j++) {%><%=sStgEndDa[j]%><br><%}%></td>
                 <td class="DataTable2">
                    <%for(int j = 0; j < iNumOfStg; j++) {
                        for(int k = 0; k < sStgStr[j].length; k++){%><%=sStgStr[j][k]%>&nbsp;<%}%><br>
                    <%}%>
                 </td>
              </tr>
         <%}
    }
      %>

       </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%
  chmainnl.disconnect();
  chmainnl = null;
%>