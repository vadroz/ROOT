<%@ page import="ecommerce.EComItmAsgStat"%>
<%
String [] sSelStr = request.getParameterValues("Str");
String sDateGrp = request.getParameter("DateGrp");
String sFrDate = request.getParameter("FrDate");
String sToDate = request.getParameter("ToDate");
String sSort = request.getParameter("Sort");
    if(sSort==null) sSort = "STR";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComItmAsgStat.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String sUser = session.getAttribute("USER").toString();
    
    System.out.println(sSelStr[0] + "|" + sDateGrp + "|" + sFrDate + "|"
          + sToDate + "|" + sSort + "|" + sUser);                             
    EComItmAsgStat itmasgn = new EComItmAsgStat(sSelStr, sDateGrp, sFrDate, sToDate, sSort, sUser);
    //EComItmAsgStat([] sStr, sGrp, sDateGrp, sFrDate,  sToDate, sSort,  sUser)

    int iNumOfItm = itmasgn.getNumOfItm();
    int iNumOfPer = itmasgn.getNumOfPer();
    String [] sPerBeg = itmasgn.getPerBeg();
    String [] sPerEnd = itmasgn.getPerEnd();
    String [] sPerNm = itmasgn.getPerNm();

    // authorized to changed assign store and notes
    boolean bAssign = sAuthStr.equals("ALL");
    // authorized to changed send str and notes
    boolean bSend = !sAuthStr.equals("ALL");

    String sStrAllowed = session.getAttribute("STORE").toString();
    String sStrArr = itmasgn.cvtToJavaScriptArray(sSelStr);
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}

        table.DataTable { font-size:10px }

        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable2 { background:#cccfff;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable3 { background:darkred;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
         
        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }
        tr.Divider { background: darkred; font-size:2px }
        
        
        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2t { background: #ccffcc; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        .Small {font-size:10px }
        .btnSmall {font-size:8px; display:none;}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; vertical-align:top; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

</style>


<script name="javascript1.2">
//==============================================================================
// Global variables
//==============================================================================
var StrAllowed = "<%=sStrAllowed%>";
var AStr = [<%=sStrArr%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// resort table
//==============================================================================
function resort(sort)
{  
  url = "EComItmAsgStat.jsp?Sort=" + sort
    + "&FrDate=<%=sFrDate%>"
    + "&ToDate=<%=sToDate%>"
    + "&DateGrp=<%=sDateGrp%>" 
  for(var i=0; i < AStr.length; i++) { url += "&Str=" + AStr[i]; }
    
  window.location.href=url;
}
//==============================================================================
// highlight row
//==============================================================================
function hiliRow(obj, turn)
{
	if(turn){ obj.style.color="darkred"; obj.style.fontWeight = 'bold';}
	else{obj.style.color="black"; obj.style.fontWeight = 'normal';}
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
    <TD vAlign=top align=left><B>Retail Concepts Inc.
        <BR>E-Commerce: Store Fulfillment Summary
        <BR>Selected Period: 
        <%if(sDateGrp.equals("MONTH")){%><%=sPerNm[0]%> - <%=sPerNm[iNumOfPer-2]%><%}
          else if(sDateGrp.equals("NONE") || sDateGrp.equals("DATE")) {%><%=sPerBeg[0]%> - <%=sPerEnd[iNumOfPer-2]%><%}
          else {%><%=sPerEnd[0]%> - <%=sPerEnd[iNumOfPer-2]%><%}%>
        </B>        
        <br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComItmAsgStatSel.jsp" class="small"><font color="red">Select</font></a>&#62;

        <font size="-1">This Page.</font>&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
         <tr class="DataTable">
             <th class="DataTable" rowspan=3><a href="javascript:resort('ERRPRC')">Str</a></th>
             <%for(int i=0; i < iNumOfPer; i++){%>
                <th class="DataTable3" rowspan=3>&nbsp;</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>" colspan=<%if(i == iNumOfPer - 1){%>18<%} else {%>15<%}%>>
                   <%if(!sDateGrp.equals("MONTH")){%><%=sPerEnd[i]%><%}
                     else {%><%=sPerNm[i]%><%} %>
                </th>                             
             <%}%>
             <th class="DataTable3" rowspan=3>&nbsp;</th>
             <th class="DataTable" rowspan=3><a href="javascript:resort('SHPTOT')">% of Total<br>Qty<br>Shipped</a></th>
             <th class="DataTable3" rowspan=3>&nbsp;</th>
             <th class="DataTable" rowspan=3><a href="javascript:resort('ERRPRC')">Str</a></th>
         </tr>
         <tr class="DataTable">
             <%for(int i=0; i < iNumOfPer; i++){%>                             
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>" colspan=3>Assigned</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>" rowspan=2>&nbsp;</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>" 
                    colspan=<%if(i == iNumOfPer - 1){%>4<%} else {%>3<%}%>>Shipped</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>" rowspan=2>&nbsp;</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>" 
                    colspan=<%if(i == iNumOfPer - 1){%>4<%} else {%>3<%}%>>Cannot<br>Fill</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>" rowspan=2>&nbsp;</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>" 
                    colspan=<%if(i == iNumOfPer - 1){%>4<%} else {%>3<%}%>>Error</th>                    
             <%}%>
         </tr>

         <tr class="DataTable">
             <%for(int i=0; i < iNumOfPer; i++){%>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Ord</th>                
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Qty</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Ret</th>

                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Ord</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Qty</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Ret</th>
                <%if(i == iNumOfPer - 1){%><th class="DataTable2"><a href="javascript:resort('SHIPPRC')">%</a></th><%}%> 
                
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Ord</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Qty</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Ret</th>
                <%if(i == iNumOfPer - 1){%><th class="DataTable2"><a href="javascript:resort('CNFPRC')">%</a></th><%}%>
                
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Ord</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Qty</th>
                <th class="DataTable<%if(i == iNumOfPer - 1){%>2<%}%>">Ret</th>
                <%if(i == iNumOfPer - 1){%><th class="DataTable2"><a href="javascript:resort('ERRPRC')">%</a></th><%}%>
             <%}%>             
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfItm; i++ )
         {
            itmasgn.setItmList();

            String sStr = itmasgn.getStr();

       String [] sAsgOrd = itmasgn.getAsgOrd();
       String [] sAsgItm = itmasgn.getAsgItm();
       String [] sAsgQty = itmasgn.getAsgQty();
       String [] sAsgRet = itmasgn.getAsgRet();

       String [] sSndOrd = itmasgn.getSndOrd();
       String [] sSndItm = itmasgn.getSndItm();
       String [] sSndQty = itmasgn.getSndQty();
       String [] sSndRet = itmasgn.getSndRet();

       String [] sCnfOrd = itmasgn.getCnfOrd();
       String [] sCnfItm = itmasgn.getCnfItm();
       String [] sCnfQty = itmasgn.getCnfQty();
       String [] sCnfRet = itmasgn.getCnfRet();

       String [] sPrcShpOrd = itmasgn.getPrcShpOrd();
       String [] sPrcShpItm = itmasgn.getPrcShpItm();
       String [] sPrcShpQty = itmasgn.getPrcShpQty();
       String [] sPrcShpRet = itmasgn.getPrcShpRet();

       String [] sPrcCnfOrd = itmasgn.getPrcCnfOrd();
       String [] sPrcCnfItm = itmasgn.getPrcCnfItm();
       String [] sPrcCnfQty = itmasgn.getPrcCnfQty();
       String [] sPrcCnfRet = itmasgn.getPrcCnfRet();
       
       String [] sErrOrd = itmasgn.getErrOrd();
       String [] sErrItm = itmasgn.getErrItm();
       String [] sErrQty = itmasgn.getErrQty();   
       String [] sErrRet = itmasgn.getErrRet();

       String [] sPrcErrOrd = itmasgn.getPrcErrOrd();
       String [] sPrcErrItm = itmasgn.getPrcErrItm();
       String [] sPrcErrQty = itmasgn.getPrcErrQty();
       String [] sPrcErrRet = itmasgn.getPrcErrRet();
       String [] sPrcShpTot = itmasgn.getPrcShpTot();

       %>
       <%if(sStr.equals("Total")){%>       
          <tr class="Divider"><td colspan=100>&nbsp;</td></tr>
       <%}%>
         <tr class="DataTable<%if(sStr.equals("Total")){%>1<%}%>" 
                onmouseover="hiliRow(this, true)" onmouseout="hiliRow(this, false)">         
            <td class="DataTable" nowrap>
               <a href="EComSrlAsg.jsp?StsFrDate=<%=sPerEnd[0]%>&StsToDate=<%=sPerEnd[iNumOfPer-2]%>&Str=<%=sStr%>&Sts=Assigned&Sts=Printed&Sts=Picked&Sts=Shipped&Sts=Cannot Fill&Sts=Sold Out" target="_blank">
                  <%=sStr%></a>
            </td>           

            <%for(int j=0; j < iNumOfPer; j++){%>
               <th class="DataTable3">&nbsp;</th>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap><%=sAsgOrd[j]%></td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap><%=sAsgQty[j]%></td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap>$<%=sAsgRet[j]%></td>

               <th class="DataTable">&nbsp;</th>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap><%=sSndOrd[j]%></td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap><%=sSndQty[j]%></td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap>$<%=sSndRet[j]%></td>
               <%if(j == iNumOfPer - 1){%>
                   <td class="DataTable2t" nowrap><%=sPrcShpQty[j]%>%</td>
               <%}%> 
  
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap><%=sCnfOrd[j]%></td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap><%=sCnfQty[j]%></td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap>$<%=sCnfRet[j]%></td>
               <%if(j == iNumOfPer - 1){%>
                   <td class="DataTable2t" nowrap><%=sPrcCnfQty[j]%>%</td>
               <%}%>
               
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap><%=sErrOrd[j]%></td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap><%=sErrQty[j]%></td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap>$<%=sErrRet[j]%></td>
               <%if(j == iNumOfPer - 1){%>
                   <td class="DataTable2t" nowrap><%=sPrcErrQty[j]%>%</td>
               <%}%>                                
            <%}%>
            <th class="DataTable3">&nbsp;</th>
            <td class="DataTable" nowrap><%if(!sStr.equals("Total")){%><%=sPrcShpTot[iNumOfPer - 1]%>%<%}  else{%>&nbsp;<%}%></td>
            <th class="DataTable3">&nbsp;</th>
            <td class="DataTable" nowrap><%=sStr%></td>
          </tr>
       <%}%>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   itmasgn.disconnect();
   itmasgn = null;
   }
%>