<%@ page import="mozu_com.MozuItmAsgStat"%>
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
   response.sendRedirect("SignOn1.jsp?TARGET=MozuItmAsgStat.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String sUser = session.getAttribute("USER").toString();
    
    System.out.println(sSelStr[0] + "|" + sDateGrp + "|" + sFrDate + "|"
          + sToDate + "|" + sSort + "|" + sUser);                             
    MozuItmAsgStat itmasgn = new MozuItmAsgStat(sSelStr, sDateGrp, sFrDate, sToDate, sSort, sUser);
   
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

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

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
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvOrd"]);
}
//==============================================================================
// resort table
//==============================================================================
function resort(sort)
{  
  url = "MozuItmAsgStat.jsp?Sort=" + sort
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
//==============================================================================
// get Order for selected date and status
//==============================================================================
function getOrdLst(str,begdt ,enddt, sts)
{
    var url = "MozuStatusOrdLst.jsp?Str=" + str
      + "&From=" + begdt
      + "&To=" + enddt
      + "&Sts=" + sts
      + "&Action=ByAssignedDate";
    ;
    window.frame1.location.href = url;
}
//==============================================================================
// show Order for selected date and status
//==============================================================================
function setOrdLst(str, from, to, site, ord, sku, asgdt, orddt, desc, cls, ven, sty, vennm, ret
		, ordsts, fflsts, paysts, oldpar )
{
	var hdr = "Str: " + str + " " + from + " " + to;
	  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvOrd&#34;);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" 
	       + popOrdLst(str, from, to, site, ord, sku, asgdt, orddt, desc, cls, ven, sty, vennm, ret
	    			, ordsts, fflsts, paysts, oldpar)
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvOrd.style.width = "400";}
	  else { document.all.dvItem.style.width = "auto";}
	   
	  document.all.dvOrd.innerHTML = html;
	  document.all.dvOrd.style.left=getLeftScreenPos() + 230;
	  document.all.dvOrd.style.top=getTopScreenPos() + 100;
	  document.all.dvOrd.style.visibility = "visible";	   
}
//==============================================================================
//populate order list for selected status
//==============================================================================
function popOrdLst(str, from, to, site, ord, sku, asgdt, orddt, desc, cls, ven, sty, vennm, ret
		, ordsts, fflsts, paysts, oldpar)
{
	var panel = "<table width='100%' cellPadding='0' cellSpacing='0' border=1>";
	panel += "<tr class='DataTable'>"
       + "<th class='DataTable'>Order</th>"
       + "<th class='DataTable'>Order<br>Date</th>"
       + "<th class='DataTable'>Assigned<br>Date</th>"
       + "<th class='DataTable' nowrap >Parent<br><span style='font-size: 10px;'>(Link to KIBO)</span></th>"
       + "<th class='DataTable'>SKU</th>"
       + "<th class='DataTable'>Description</th>"
       + "<th class='DataTable'>Vendor</th>"
       + "<th class='DataTable'>Ret</th>"
       + "<th class='DataTable'>L<br>o<br>g</th>"
    ;
		  
	for(var i=0; i < ord.length;i++)
	{
	    panel += "<tr class='DataTable'>"
	      + "<td nowrap class='DataTable'>" + ord[i] + "</td>"
	      + "<td nowrap class='DataTable'>" + orddt[i] + "</td>"
	      + "<td nowrap class='DataTable'>" + asgdt[i] + "</td>";
	      
	    if(oldpar == 'N')
	    {  
	    	panel += "<td nowrap class='DataTable'><a href='https://www.sunandski.com/p/" 
	        	+ cls[i] + ven[i] + sty[i] + "' target='_blank'>"
	      		+ cls[i] + ven[i] + sty[i] 
	      	+ "</a></td>";
	    }
	    else
	    {
	    	panel += "<td nowrap class='DataTable'><a href='https://www.sunandski.com/p/" 
	        	+ cls[i] + ven[i].substring(1) + sty[i].substring(3) + "' target='_blank'>"
	      		+ cls[i] + ven[i] + sty[i] 
	      	+ "</a></td>";
	    }
	    panel += "<td nowrap class='DataTable'>" + sku[i] + "</td>"
	      + "<td nowrap class='DataTable1'>" + desc[i] + "</td>"
	      + "<td nowrap class='DataTable1'>" + vennm[i] + "</td>"
	      + "<td nowrap class='DataTable'>" + ret[i] + "</td>"
	      + "<td nowrap class='DataTable'>" 
	         + "<a href='javascript: getStrCommt(&#34;" + str + "&#34;,&#34;" + site[i] + "&#34;, &#34;" + ord[i] 
	            + "&#34;,&#34;" + sku[i] + "&#34;) '>L</a>" 
	      + "</td>"
	      
	      + "</tr>";
    }
	
	panel += "<tr class='DataTable1'>"
	   + "<td nowrap class='DataTable' colspan=10>"
	   + "<button onClick='hidePanel(&#34;dvOrd&#34;);' class='Small'>Cancel</button>"
	   + "</td></tr>"
	
	return panel;
}
//==============================================================================
//retreive comment for selected store
//==============================================================================
function getStrCommt(str, site, ord, sku)
{
	url = "MozuSrlAsgCommt.jsp?"
   	 + "Site=" + site
   	 + "&Order=" + ord
   	 + "&Sku=" + sku
   	 + "&Str=" + str
   	 + "&Action=GETSTRCMMT"
   	 ;
 
if(isIE){ window.frame1.location.href = url; }
else if(isChrome || isEdge) { window.frame1.src = url; }
else if(isSafari){ window.frame1.location.href = url; }
}

//==============================================================================
//display comment for selected store
//==============================================================================
function showComments(site, order, sku, serial, str, type, emp, commt, recusr, recdt, rectm)
{
	var hdr = "Logging Information. Order:" + order ;
	var html = "<table width='100%' cellPadding='0' cellSpacing='0' border=0> "
  		+ "<tr class='DataTable'>"
    + "<td class='BoxName' nowrap>" + hdr + "</td>"
    + "<td class='BoxClose' valign=top>"
      +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
    + "</td></tr>"
 + "<tr><td class='Prompt' colspan=2>" + popLog(type,emp, commt, recusr, recdt, rectm, str, serial)
  + "</td></tr>"
+ "</table>"

if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "550";}
else { document.all.dvItem.style.width = "auto";} 

document.all.dvItem.innerHTML = html;
document.all.dvItem.style.left = getLeftScreenPos() + 100;
document.all.dvItem.style.top = getTopScreenPos() + 140;
document.all.dvItem.style.visibility = "visible";

}
//==============================================================================
//populate log andcomments panel
//==============================================================================
function popLog(type,emp, commt, recusr, recdt, rectm, str, serial)
{
	var panel = "<table width='100%' cellPadding='0' cellSpacing='0' border=1> "
 	+ "<tr  class='DataTable'>"
    + "<th class='DataTable'>Type</th>"
    + "<th class='DataTable'>S/N</th>"
    + "<th class='DataTable'>Store</th>"
    + "<th  class='DataTable' nowrap>Emp #</th>"
    + "<th class='DataTable'>Comment</th>"
    + "<th class='DataTable'>Recorded by</th>"
 	+ "</tr>"
	for(var i=0; i < commt.length; i++)
	{
   		panel += "<tr class='DataTable'>"
     	+ "<td class='DataTable' nowrap>" + type[i] + "</td>"
     	+ "<td class='DataTable' nowrap>" + serial[i] + "</td>"
   		if(str[i] != "0") { panel += "<td  class='DataTable' nowrap>" + str[i] + "&nbsp;</td>" }
   		else{ panel += "<td  class='DataTable' nowrap>H.O.&nbsp;</td>" }

   		panel += "<td  class='DataTable' nowrap>&nbsp;" + emp[i] + "</td>"
     	+ "<td class='DataTable1'>" + commt[i] + "</td>"
     	+ "<td class='DataTable' nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
	}

	panel += "</table>"
	+ "<p style='text-align:center;'>" 
 	+ "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button>&nbsp;"
 

	return panel;
}

//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel(div)
{
	var obj = document.all[div];
	obj.innerHTML = " ";
	obj.style.visibility = "hidden";	
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
<div id="dvOrd" class="dvItem"></div>
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
        <a href="MozuItmAsgStatSel.jsp" class="small"><font color="red">Select</font></a>&#62;

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
               <a href="MozuSrlAsg.jsp?StsFrDate=<%=sPerBeg[0]%>&StsToDate=<%=sPerEnd[iNumOfPer-2]%>&Str=<%=sStr%>&Sts=Assigned&Sts=Printed&Sts=Picked&Sts=Shipped&Sts=Cannot Fill&Sts=Sold Out" target="_blank">
                  <%=sStr%></a>
            </td>           

            <%for(int j=0; j < iNumOfPer; j++){
            	String sFrom = sPerBeg[0];
            	String sTo = sPerEnd[iNumOfPer-2];
            	if(j < iNumOfPer-2)
            	{
            		sFrom = sPerBeg[j];
            		sTo = sPerEnd[j];
            	}
            %>
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
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap>               
                   <%if(!sStr.equals("Total")){%>
                   		<a href="javascript: getOrdLst('<%=sStr%>','<%=sFrom%>','<%=sTo%>', 'CNF')"><%=sCnfOrd[j]%></a>
                   <%} else {%><%=sCnfOrd[j]%><%}%>
               </td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap><%=sCnfQty[j]%></td>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap>$<%=sCnfRet[j]%></td>
               <%if(j == iNumOfPer - 1){%>
                   <td class="DataTable2t" nowrap><%=sPrcCnfQty[j]%>%</td>
               <%}%>
               
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable<%if(j == iNumOfPer - 1){%>2t<%}%>" nowrap>
                   <%if(!sStr.equals("Total")){%>
                   <a href="javascript: getOrdLst('<%=sStr%>','<%=sFrom%>','<%=sTo%>', 'Error')"><%=sErrOrd[j]%></a>
                   <%} else {%><%=sErrOrd[j]%><%}%>
               </td>
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