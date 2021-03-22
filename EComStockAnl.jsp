<%@ page import="ecommerce.EComStockAnl"%>
<%
    String [] sSrchStr = request.getParameterValues("Str");
    String sSrchComp = request.getParameter("CompTo");
    String sSrchDiv = request.getParameter("Div");
    String sSrchDpt = request.getParameter("Dpt");
    String sSrchCls = request.getParameter("Cls");
    String sSrchVen = request.getParameter("Ven");
    String sSrchSty = request.getParameter("Sty");
    String sSkuLvl = request.getParameter("SkuLvl");
    String sSort = request.getParameter("Sort");
    String sUniq = request.getParameter("Uniq");
    
    if(sSrchDiv==null) { sSrchDiv = "ALL"; }
    if(sSrchDpt==null) { sSrchDpt = "ALL"; }
    if(sSrchCls==null) { sSrchCls = "ALL"; }
    if(sSrchVen==null) { sSrchVen = "ALL"; }
    if(sSrchSty==null) { sSrchSty = "ALL"; }
    if(sSort==null) { sSort = "GRP"; }
    if(sSkuLvl==null) { sSkuLvl = "N"; }
    if(sUniq==null) { sUniq = "N"; }
    
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComStockAnl.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    /*System.out.println(
      sSrchDiv + "|" + sSrchDpt + "|" + sSrchCls + "|" + sSrchVen + "|" + sSrchSty + "|" + sSkuLvl  
    );*/ 
    EComStockAnl itemlst = new EComStockAnl(sSrchStr, sSrchComp, sSrchDiv, sSrchDpt, sSrchCls, sSrchVen, sSrchSty
    		               , sSkuLvl, sUniq, sSort, sUser);
    int iNumOfStr = itemlst.getNumOfStr();
    String [] sStrLst = itemlst.getStrLst();
    int iNumOfItm = itemlst.getNumOfItm();
    
    String sStrJsa = itemlst.cvtToJavaScriptArray(sSrchStr);
    
%>
<HTML>
<HEAD>
<title>ECom Str Inv Analysis</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:moccasin;font-family: Verdanda}
        table.DataTable { background:moccasin; }

        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable0 { background: red; font-size:12px }
        tr.DataTable1 { background: white; font-size:12px }
        
        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { background: #cccfff; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable22 { background: #ccffcc; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}               
                       

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvTooltip { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:15; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        tr.Prompt { background: lavender; font-size:10px }
        tr.Prompt1 { background: seashell; font-size:10px }
        tr.Prompt2 { background: LightCyan; font-size:11px }

        th.Prompt { background:#FFCC99; text-align:ceneter; vertical-align:midle; font-family:Arial; font-size:11px; }
        td.Prompt { padding-left:3px; padding-right:3px; text-align:left; vertical-align:top; font-family:Arial;}
        td.Prompt1 { padding-left:3px; padding-right:3px; text-align:center; vertical-align:top; font-family:Arial;}
        td.Prompt2 { padding-left:3px; padding-right:3px; text-align:right; font-family:Arial; }
        td.Prompt3 { padding-left:3px; padding-right:3px; text-align:left; vertical-align:midle; font-family:Arial;}


</style>


<script>
//------------------------------------------------------------------------------
var NumOfItm = <%=iNumOfItm%>;
var StrArr = [<%=sStrJsa%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
   
   document.all.trHdr.style.left= document.documentElement.scrollLeft - 1;
   document.all.trHdr1.style.left= document.documentElement.scrollLeft - 1;
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//--------------------------------------------------------
// drill down to next level
//--------------------------------------------------------
function drill(grp, grpnm)
{
	var url = "EComStockAnl.jsp?"
    if(grp=="DIV"){ url += "&Div=" + grpnm }
	else if(grp=="DPT"){ url += "&Div=<%=sSrchDiv%>&Dpt=" + grpnm }
	else if(grp=="CLS"){ url += "&Div=<%=sSrchDiv%>&Dpt=<%=sSrchDpt%>&Cls=" + grpnm }
	else if(grp=="VEN"){ url += "&Div=<%=sSrchDiv%>&Dpt=<%=sSrchDpt%>&Cls=<%=sSrchCls%>&Ven=" + grpnm }
    else if(grp=="STY"){ url += "&Div=<%=sSrchDiv%>&Dpt=<%=sSrchDpt%>&Cls=<%=sSrchCls%>&Ven=<%=sSrchVen%>&Sty=" + grpnm }    
	for(var i=0; i < StrArr.length; i++)
	{
		url += "&Str=" + StrArr[i];
	}
	url += "&CompTo=<%=sSrchComp%>";
	url += "&SkuLvl=<%=sSkuLvl%>";
	url += "&Sort=<%=sSort%>"; 
	url += "&Uniq=<%=sUniq%>"
	
    window.location.href=url;
}
//==============================================================================
// show table with different sorting
//==============================================================================
function resort(sort)
{
   var url = "EComStockAnl.jsp?"
           + "Div=<%=sSrchDiv%>"
           + "&Dpt=<%=sSrchDpt%>"
           + "&Cls=<%=sSrchCls%>"
           + "&Ven=<%=sSrchVen%>"
           + "&Sty=<%=sSrchSty%>"
           + "&Uniq=<%=sUniq%>"
           ;
           
   for(var i=0; i < StrArr.length; i++) { url += "&Str=" + StrArr[i]; }
   url += "&CompTo=<%=sSrchComp%>";
   url += "&Sort=" + sort;    
   url += "&SkuLvl=<%=sSkuLvl%>";
   url += "&Uniq=<%=sUniq%>"
       	        
   //alert(url)
   window.location.href=url;
}
//==============================================================================
//show table with different sorting
//==============================================================================
function setDtlLvl(lvl)
{
   var url = "EComStockAnl.jsp?"
        + "Div=<%=sSrchDiv%>"
        + "&Dpt=<%=sSrchDpt%>"
        + "&Cls=<%=sSrchCls%>"
        + "&Ven=<%=sSrchVen%>"
        + "&Sty=<%=sSrchSty%>"
   for(var i=0; i < StrArr.length; i++) { url += "&Str=" + StrArr[i]; }
   url += "&CompTo=<%=sSrchComp%>";
   url += "&Sort=<%=sSort%>";
   url += "&SkuLvl=" + lvl;
   url += "&Uniq=<%=sUniq%>"
    	        
   //alert(url)
   window.location.href=url;
}
//==============================================================================
//show ecom, RCI or both line of inventory
//==============================================================================
function showInv(inv)
{
   var rci = document.all.tdRci;
   var vol = document.all.tdVol;
   
   var disprci = "block";
   var dispvol = "block";
   if(inv=='1'){ dispvol = "none"; }
   if(inv=='2'){ disprci = "none"; }
   
   for(var i=0; i < rci.length;i++) { rci[i].style.display=disprci; }
   for(var i=0; i < vol.length;i++) { vol[i].style.display=dispvol; }
}
//--------------------------------------------------------
// update store analysis
//--------------------------------------------------------
function updStrAnl()
{
	var url = "EComStockAnlUpd.jsp"; 
	window.frame1.location.href=url;  
	alert("ECOM Stock Analysis File have been submited.\nYou will get an e-mail to inform of completion.");
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
<!-------------------------------------------------------------------->
<div id="dvTooltip" class="dvTooltip"></div>
<!-------------------------------------------------------------------->
<div style="clear: both; overflow: AUTO; width: 100%; height: 100%; POSITION: relative; color:black;">

<TABLE width="100%" border=0>
  <TBODY>
  <TR bgcolor="moccasin" style="z-index: 100; position: relative; top: expression(this.offsetParent.scrollTop);">
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Stock Analysis
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComStockAnlSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        
        <%if(!sSkuLvl.equals("Y") && sSrchSty.equals("ALL")){%><a href="javascript:setDtlLvl('Y')">SKU Level</a><%}
        else if(sSkuLvl.equals("Y") && sSrchSty.equals("ALL")){%><a href="javascript:setDtlLvl('N')">SKU Collapse</a><%}%>
        &nbsp;&nbsp;&nbsp;&nbsp;
        
        
        Inventory:   RCI<input type="radio" name="SelInv" value="1" onclick="showInv('1')"/>&nbsp;&nbsp;
        ECOM<input type="radio" name="SelInv" value="2" onclick="showInv('2')"/>&nbsp;&nbsp;
        Both<input type="radio" name="SelInv" value="3" onclick="showInv('3')" checked />
        
        &nbsp;&nbsp;
        <a href="javascript:updStrAnl()">Update Store Inv</a>
       </TD>
    </tr>
    <TR bgcolor="moccasin" >   
     <TD vAlign=top align=middle>
     <%int iColHdg=3;%>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">         
         <tr class="DataTable" id="trHdr" style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop - 3);">
             <th class="DataTable">Div<%iColHdg++;%></th>
             <%if(!sSrchDiv.equals("ALL") || sSkuLvl.equals("Y")){ iColHdg++; %><th class="DataTable">Dpt</th><%}%>
             <%if(!sSrchDpt.equals("ALL") || sSkuLvl.equals("Y")){ iColHdg++; %><th class="DataTable">Class</th><%}%>
             <%if(!sSrchCls.equals("ALL") || sSkuLvl.equals("Y")){ iColHdg++; %><th class="DataTable">Ven</th><%}%>     
             <%if(!sSrchVen.equals("ALL") || sSkuLvl.equals("Y")){ iColHdg++; %><th class="DataTable">Sty</th><%}%>
             <%if(!sSrchSty.equals("ALL") || sSkuLvl.equals("Y")){ iColHdg++; %><th class="DataTable">Long Item Number</th><%}%>        
             <th class="DataTable">Description</th>
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable">&nbsp;Unque</th>
             <th class="DataTable" colspan="<%=iNumOfStr%>">Store</th>
        </tr>     
        <tr class="DataTable" id="trHdr1" style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop - 3);">
             <th class="DataTable" colspan=<%=iColHdg%>>&nbsp;</th>
             <%for(int i=0; i < iNumOfStr; i++){%>
                 <th class="DataTable"><%=sStrLst[i]%></th>
             <%}%>
        </tr>     
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfItm; i++ )
         {
            itemlst.setItem();
            String sDiv = itemlst.getDiv();
            String sDpt = itemlst.getDpt();
            String sCls = itemlst.getCls();
            String sVen = itemlst.getVen();
            String sSty = itemlst.getSty();
            String sClr = itemlst.getClr();
            String sSiz = itemlst.getSiz();
            String sUnqVol = itemlst.getUnqVol();
            String sUnqRci = itemlst.getUnqRci();             
            String [] sVolQty = itemlst.getVolQty();
            String [] sStrQty = itemlst.getStrQty();
            String sDesc = itemlst.getDesc();
        %>
         <tr id="trProd" class="DataTable">
            <td id="tdDiv" class="DataTable1" rowspan=2 nowrap ><a href="javascript:drill('DIV', '<%=sDiv%>')"><%=sDiv%></a></td>
            <%if(!sSrchDiv.equals("ALL") || sSkuLvl.equals("Y")){%><td id="tdDpt"  rowspan=2  class="DataTable2" nowrap><a href="javascript:drill('DPT', '<%=sDpt%>')"><%=sDpt%></a></td><%} %>
            <%if(!sSrchDpt.equals("ALL") || sSkuLvl.equals("Y") ){%><td id="tdDpt"  rowspan=2 class="DataTable2" nowrap><a href="javascript:drill('CLS', '<%=sCls%>')"><%=sCls%></a></td><%}%>
            <%if(!sSrchCls.equals("ALL") || sSkuLvl.equals("Y") ){%><td id="tdDpt"  rowspan=2 class="DataTable2" nowrap><a href="javascript:drill('VEN', '<%=sVen%>')"><%=sVen%></a></td><%}%>
            <%if(!sSrchVen.equals("ALL") || sSkuLvl.equals("Y") ){%><td id="tdDpt"  rowspan=2 class="DataTable2" nowrap><a href="javascript:drill('STY', '<%=sSty%>')"><%=sSty%></a></td><%}%>
            <%if(!sSrchSty.equals("ALL") || sSkuLvl.equals("Y") ){%><td id="tdDpt"  rowspan=2 class="DataTable1" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td><%}%>           
            <td class="DataTable1" rowspan=2 nowrap><%=sDesc%></td>
            
            <th id="tdRci" class="DataTable">RCI</th>
            <td id="tdRci" class="DataTable1" nowrap><%=sUnqRci%></td>
            <%for(int j=0; j < iNumOfStr; j++){%>               
               <td id="tdRci" class="DataTable2<%if(j==iNumOfStr-1){%>1<%}%>" nowrap><%=sStrQty[j]%></td>               
             <%}%>
             </tr>
             <tr id="trProd" class="DataTable1">
             <th id="tdVol" class="DataTable">ECOM</th>
             <td id="tdVol" class="DataTable1" nowrap><%=sUnqVol%></td>
             <%for(int j=0; j < iNumOfStr; j++){%>               
               <td id="tdVol" class="DataTable2<%if(j==iNumOfStr-1){%>2<%}%>" nowrap><%=sVolQty[j]%></td>               
             <%}%>
             </tr>
       <%}%>

       <tr class="DataTable1">
         <th class="DataTable2" colspan=22 id="thBotTotal"></th>
       </tr>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
   </div>
</BODY></HTML>
<%
   itemlst.disconnect();
   }
%>
