<%@ page import="java.util.*, java.text.*, worldcup.AgedInvContDiv, java.text.SimpleDateFormat"%>
<%
   String sDiv = request.getParameter("Div");
   String sDpt = request.getParameter("Dpt");
   String sSelDate = request.getParameter("Date");
   String sUser = session.getAttribute("USER").toString();

   if(sSelDate == null){ sSelDate = "LAST";}

if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=AgedInvContDiv.jsp&APPL=ALL" + "&" + request.getQueryString());
}
else
{
    AgedInvContDiv agegame = new AgedInvContDiv(sDiv, sDpt, sSelDate, sUser);

    int iNumOfStr = agegame.getNumOfStr();
    String [] sStore = agegame.getStore();

    int iNumOfGrp = agegame.getNumOfGrp();
    String [] sGrp = agegame.getGrp();
    String [] sGrpName = agegame.getGrpName();
    String [] sAgeSls = null;
    String [] sMargin = null;

    String sGrpColName = null;
    if(!sDpt.equals("ALL") ){ sGrpColName = "Class"; }
    else if(!sDiv.equals("ALL") ){ sGrpColName = "Department"; }
    else { sGrpColName = "Division"; }

    // Convert date to string, retreive current date
    String sDateLine = null;
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    if(sSelDate.equals("LAST"))
    {
       Date date = new Date((new Date()).getTime() - 86400000);
       sDateLine = "As of Date: " + sdf.format(date);
    }
    else if(sSelDate.equals("ALL"))
    {
       Date date = new Date((new Date()).getTime() - 86400000);
       sDateLine = "From 3/16/2009  Through " + sdf.format(date);
    }
    else { sDateLine = "As of Date: " + sSelDate; }

%>

<style>body {background:ivory;font-family: Verdanda}
         a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}
                 a:hover { color:red; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { background:#FFCC99; writing-mode: tb-rl; filter: flipv fliph;
                        padding-left:1px; padding-right:1px; padding-top:10px;
                        font-size:12px; text-align:left;}

        tr.DataTable { background: white; font-size:10px }
        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable2 { background: #ccccff; font-size:10px }
        tr.DataTable3 { background: #ccffcc; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable11 { background: #FFCC99; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvSelWk { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        #tdMargin { display: none; }
</style>
<html>
<head><Meta http-equiv="refresh"></head>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var GrpColName = "<%=sGrpColName%>"
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
   //setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);
   popDateSel();
}
//==============================================================================
// populate date selection dropdown menu
//==============================================================================
function popDateSel()
{
   var date = new Date(new Date() - 86400000);
   var SelDate = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

   document.all.selDate.options[0] = new Option("All Dates", "ALL");

   for(var i=1; SelDate != "3/15/2009" ;i++)
   {
      document.all.selDate.options[i] = new Option(SelDate, SelDate);
      date = new Date(date - 86400000);
      SelDate = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    }
}
//==============================================================================
// show report for another date
//==============================================================================
function sbmAnotherDate()
{
   var date = document.all.selDate.options[document.all.selDate.selectedIndex].value;

   var url = "AgedInvContDiv.jsp?"
   url += "Div=<%=sDiv%>&Dpt=<%=sDpt%>&Date=" + date;

   window.location.href = url;
}
//==============================================================================
// drill down to next level
//==============================================================================
function drilldown(grp)
{
   var url = "AgedInvContDiv.jsp?"

   if(GrpColName == "Division"){ url += "Div=" + grp + "&Dpt=ALL" }
   else if(GrpColName == "Department"){ url += "Div=<%=sDiv%>&Dpt=" + grp }
   url += "&Date=<%=sSelDate%>"

   window.location.href = url;
}
//==============================================================================
// drill down to Item Level
//==============================================================================
function showItemDtl(str, grp)
{
   if(str=="Total") { str = "ALL"; }
   var url = "AgedInvContItem.jsp?Str=" + str + "&Date=<%=sSelDate%>"

   if(grp=="ALL" && GrpColName == "Division"){ url += "&Level=ALL" + "&Grp=" + grp}
   else if(grp=="ALL" && GrpColName == "Department"){ url += "&Level=DIV" + "&Grp=<%=sDiv%>"}
   else if(grp=="ALL" && GrpColName == "Class"){ url += "&Level=DEPT" + "&Grp=<%=sDpt%>"}

   else if(GrpColName == "Division"){ url += "&Level=DIV" + "&Grp=" + grp}
   else if(GrpColName == "Department"){ url += "&Level=DEPT" + "&Grp=" + grp}
   else if(GrpColName == "Class"){ url += "&Level=CLASS" + "&Grp=" + grp}

   window.location.href = url;
}
//==============================================================================
// switch between sales and margin values that is displayed on screen.
//==============================================================================
function switchSls(obj)
{
   var aged = document.all.tdAge;
   var marg = document.all.tdMargin;
   var ageDisp = "none";
   var margDisp = "block";
   if(obj.value == "S"){ageDisp = "block"; margDisp = "none";}

   for(var i=0; i < aged.length; i++)
   {
     aged[i].style.display = ageDisp;
     marg[i].style.display = margDisp;
   }
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Aged Inventory Sales Contest By <%=sGrpColName%>
      <%if(sGrpColName.equals("Class")){%><br>Selected Department: <%=sDpt%><%}
        else if(sGrpColName.equals("Department")){%><br>Selected Division: <%=sDiv%><%}%>
      <br><%=sDateLine%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <th class="DataTable" rowspan=2><%=sGrpColName%></th>
          <th class="DataTable1" rowspan=2>All Stores</th>
          <th class="DataTable" colspan="<%=iNumOfStr%>">Store &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
            Date Selection: <select class="Small" name="selDate"></select> &nbsp;
            <button onclick="sbmAnotherDate()">go</button>
            <br><input type="radio" name="Sls" value="S" checked onClick="switchSls(this)">Sales &nbsp;  &nbsp; &nbsp;
                <input type="radio" name="Sls" value="M" onClick="switchSls(this)">Margin
          </th>
        </tr>
        <tr>
           <%for(int i=0; i < iNumOfStr; i++){%>
              <th class="DataTable">
                <%if(i < iNumOfStr - 1){%>
                <a href="javascript: showItemDtl('<%=sStore[i]%>', 'ALL')"><%=sStore[i]%></a><%} else {%><%=sStore[i]%><%}%>
              </th>
           <%}%>
        </tr>
     <!------------------------- Budget Group --------------------------------------->
     <%for(int i=0; i < iNumOfGrp; i++){%>
     <%
         agegame.setDivSls(i +1);
         sAgeSls = agegame.getAgeSls();
         sMargin = agegame.getMargin();
     %>
        <!-- Store Details -->
          <tr class="DataTable">
            <td class="DataTable11" nowrap>
              <%if(!sGrpColName.equals("Class") && !sGrpName[i].equals("OLD") ){%><a href="javascript: drilldown('<%=sGrp[i]%>')"><%=sGrp[i] + " - " + sGrpName[i]%></a><%}
                else {%><%=sGrp[i] + " - " + sGrpName[i]%><%}%>
            </td>

            <th class="DataTable" nowrap><%if(!sGrpName[i].equals("OLD")) {%><a href="javascript: showItemDtl('ALL', '<%=sGrp[i]%>')">A</a><%} else {%>&nbsp;<%}%></th>

            <%for(int j=0; j < iNumOfStr; j++){%>
               <td class="DataTable2" id="tdAge" nowrap>&nbsp;<%if(!sAgeSls[j].equals("0")){%>
                 <%if(j < iNumOfStr - 1){%><a href="javascript: showItemDtl('<%=sStore[j]%>', '<%=sGrp[i]%>')">$<%=sAgeSls[j]%></a><%} else {%>$<%=sAgeSls[j]%><%}%><%}%></td>
               <td class="DataTable2" id="tdMargin" nowrap>&nbsp;<%if(!sMargin[j].equals(".0")){%>
                 <%if(j < iNumOfStr - 1){%><a href="javascript: showItemDtl('<%=sStore[j]%>', '<%=sGrp[i]%>')"><%=sMargin[j]%>%</a><%} else {%>$<%=sMargin[j]%><%}%><%}%></td>
            <%}%>
        </tr>
     <%}%>
     <!------------------------- Report Total --------------------------------->
     <%
         agegame.setRepTot();
         sAgeSls = agegame.getAgeSls();
         sMargin = agegame.getMargin();
     %>
     <tr class="DataTable2">
        <td class="DataTable1" nowrap>Total</td>
        <td class="DataTable" nowrap>&nbsp;</td>
        <%for(int j=0; j < iNumOfStr; j++){%>
           <td class="DataTable2" id="tdAge" nowrap>&nbsp;<%if(!sAgeSls[j].equals("0")){%>$<%=sAgeSls[j]%><%}%></td>
           <td class="DataTable2" id="tdMargin" nowrap>&nbsp;<%if(!sMargin[j].equals(".0")){%><%=sMargin[j]%>%<%}%></td>
        <%}%>
     </tr>
   </table>
   <!----------------------- end of table ---------------------------------->
  </table>
 </body>

</html>
<%
  agegame.disconnect();
  agegame=null;
%>

<%}%>






