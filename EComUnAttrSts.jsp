<%@ page import="ecommerce.EComUnAttrSts"%>
<%
    String sSrchDiv = request.getParameter("Div");
    String sSrchDpt = request.getParameter("Dpt");
    String sSrchCls = request.getParameter("Cls");
    String sSrchVen = request.getParameter("Ven");
    String sDetail = request.getParameter("Dtl");
    String sSort = request.getParameter("Sort");

    if(sSort==null) sSort = "GRP";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComUnAttrSts.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    EComUnAttrSts prodlst = new EComUnAttrSts(sSrchDiv, sSrchDpt, sSrchCls, sSrchVen, sDetail, sSort, sUser);

    int iNumOfProd = prodlst.getNumOfProd();
    String sColGrp = null;
    String sColGrpName = null;
    if(sSrchDiv.equals("ALL") && sSrchDpt.equals("ALL") && sSrchCls.equals("ALL"))
    { sColGrp = "Div"; sColGrpName = "Division Name"; }
    else if(sSrchDpt.equals("ALL") && sSrchCls.equals("ALL")) { sColGrp = "Dpt"; sColGrpName = "Department Name"; }
    else if(sSrchCls.equals("ALL")){ sColGrp = "Class"; sColGrpName = "Class Name"; }

%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
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

</style>


<script name="javascript1.3">
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}

//==============================================================================
// show by Child or Parents
//==============================================================================
function showDtl(dtl)
{

   var url = "EComUnAttrSts.jsp?"
           + "Div=<%=sSrchDiv%>"
           + "&Dpt=<%=sSrchDpt%>"
           + "&Cls=<%=sSrchCls%>"
           + "&Ven=<%=sSrchVen%>"
           + "&Dtl=" + dtl
           + "&Sort=<%=sSort%>";
   //alert(url)
   window.location.href=url;
}

//==============================================================================
// drill down to next level
//==============================================================================
function drilldown(grp, level)
{
   var url = "EComUnAttrSts.jsp?"
   if(level=="Div") { url += "Div=" + grp; } else { url += "Div=<%=sSrchDiv%>"; }
   if(level=="Dpt") { url += "&Dpt=" + grp; } else { url += "&Dpt=<%=sSrchDpt%>"; }
   if(level=="Class") { url += "&Cls=" + grp; } else { url += "&Cls=<%=sSrchCls%>"; }
   url += "&Ven=<%=sSrchVen%>"
        + "&Dtl=<%=sDetail%>"
        + "&Sort=<%=sSort%>";
   //alert(url)
   window.location.href=url;
}

//==============================================================================
// show Items list
//==============================================================================
function showItems(grp, level, whse)
{
   // Div=1 Dpt=ALL Cls=ALL Ven=ALL Whse=70 Web=0 From=ALL To=ALL Site=ALL MarkDownl=0
   // Excel=N Parent= Pon=
   var url = "EComItmLst.jsp?";
   if (level == "Div") { url += "Div=" + grp.trim() + "&Dpt=ALL&Cls=ALL"; }
   else if (level == "Dpt") { url += "Div=ALL&Dpt=" + grp.trim() + "&Cls=ALL"; }
   else if (level == "Class") { url += "Div=ALL&Dpt=ALL&Cls=" + grp.trim(); }

   url += "&Ven=<%=sSrchVen%>"
        + "&Whse=" + whse
        + "&Site=ALL&Web=0&From=ALL&To=ALL&Site=ALL&MarkDownl=0&Excel=N&Parent=&Pon=&MarkedWeb=B&InvAvl=70"
   //alert(url)
   window.location.href=url;
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
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Item Status List
        <br>Division:<%=sSrchDiv%>&nbsp;&nbsp;&nbsp;
            Department:<%=sSrchDpt%>&nbsp;&nbsp;&nbsp;
            Class:<%=sSrchCls%>
        <br><%if(sDetail.equals("P")){%>Information based on Class-Vendor-Style level<%}%>
        <%if(sDetail.equals("I")){%>Information based on Item level<%}%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComItmStsSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <%if(sDetail.equals("P")){%><a href="javascript: showDtl('I')">By Items</a><%}%>
        <%if(sDetail.equals("I")){%><a href="javascript: showDtl('P')">By Cls-Ven-Sty</a><%}%>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable"><%=sColGrp%></th>
             <th class="DataTable"><%=sColGrpName%></th>
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable">With Stock<br>70</th>
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable">W/O Stock in 70<br>With BSR in 70</th>
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable">With Stock in 1<br>W/O Stock in 70</th>
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable">Total</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfProd; i++ )
         {
            prodlst.setDetail();
            String sGrp = prodlst.getGrp();
            String sGrpName = prodlst.getGrpName();
            String sGrpTot = prodlst.getGrpTot();
            String sOnhand70 = prodlst.getOnhand();
            String sBsr70 = prodlst.getBsr70();
            String sOnhand01 = prodlst.getOnhand01();
        %>

            <tr id="trProd" class="DataTable">
            <td class="DataTable2" nowrap><%=sGrp%></td>
            <%if(!sColGrp.equals("Class")) {%>
                 <td class="DataTable1" nowrap><a class="Small" href="javascript: drilldown('<%=sGrp%>', '<%=sColGrp%>')"><%=sGrpName%></a></td>
            <%}
              else {%>
                 <td class="DataTable1" nowrap><a class="Small" href="javascript: showItems('<%=sGrp%>', '<%=sColGrp%>', 'ALL')"><%=sGrpName%></a></td>
              <%}%>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><a class="Small" href="javascript: showItems('<%=sGrp%>', '<%=sColGrp%>', '70')"><%=sOnhand70%></a></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sBsr70%></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><a class="Small" href="javascript: showItems('<%=sGrp%>', '<%=sColGrp%>', '01')"><%=sOnhand01%></a></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sGrpTot%></td>
          </tr>
       <%}%>
       <!-- -------------------------- Total ------------------------------- -->
       <%
          prodlst.setTotal();
          String sGrp = prodlst.getGrp();
          String sGrpName = prodlst.getGrpName();
          String sGrpTot = prodlst.getGrpTot();
          String sOnhand70 = prodlst.getOnhand();
          String sBsr70 = prodlst.getBsr70();
          String sOnhand01 = prodlst.getOnhand01();
       %>
       <tr id="trProd" class="DataTable1">
            <td  class="DataTable1" colspan=2 nowrap >Total</td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sOnhand70%></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sBsr70%></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sOnhand01%></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable2" nowrap><%=sGrpTot%></td>
         </tr>
     </table>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   prodlst.disconnect();
   prodlst = null;
   }
%>