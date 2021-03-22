<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
    String sFrDate = request.getParameter("From");
    String sToDate = request.getParameter("To");
    String sOrder = request.getParameter("Order");
    
    SimpleDateFormat sdfYmd = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfMdy = new SimpleDateFormat("MM/dd/yyyy");
    
    if(sFrDate == null){ sFrDate = sdfYmd.format(new java.util.Date()); }
    if(sToDate == null){ sToDate = sdfYmd.format(new java.util.Date()); }
    
    

	String sStmt = "Select "
	  + " AWSITE,AWORD,digits(AWCLS) as AWCLS, digits(AWVEN) as AWVEN, digits(AWSTY) as AWSTY" 
	  + ", digits(AWCLR) as AWCLR, digits(AWSIZ) as AWSIZ" 
	  + ",AWSKU,AWGRP,AWSTR,AWORQTY,AWAVQTY"
	  + ",AWASQTY,AWSHTOST,AWSMETH,AWSTSSTR,AWRET,AWTRET,AWZIP,AWSTAGE,AWRATIO,AWSLSPT,AWDSTPT,AWSAMST"
	  + ",AWSMSTPT, AWST70PT, AWALWSPT, AWTOTPT, AwPrcDt, AwPrcTm, AwPlace"
	  + ", case when v1Sn is not null then char(v1Sn) else 'NONE' end as v1Sn"
	  + ", case when v1Str is not null then char(v1Str) else 'NONE' end as v1Str"
	  + ", case when v1Sts is not null then char(v1Sts) else 'NONE' end as v1Sts"
	  + ",ides"	  
      + ",case when (select '1' from rci.MoAlcWks where AsSite=AwSite and AsOrd=AwOrd"
      + " fetch first 1 row only) is null then 'N' else 'Y' end as comb"       
	  + " from RCI.MoALCWK"
	  + " left join rci.MoOrPasV1 on v1site=AwSite and v1ord=AwOrd and v1sku=AwSku and v1str=AwStr"
	  
	  + " inner join IpTsFil.IpItHdr on isku=AwSku"
	  + " where AwPrcDt >='" + sFrDate + "' and AwPrcDt <= '" + sToDate + "'";
	   
	if(sOrder != null && !sOrder.trim().equals("")){ sStmt += " and AwOrd = " + sOrder; }
	
	sStmt += " order by AwOrd, AWSKU, AWASQTY desc, AwPlace";
	 
	System.out.println(sStmt);  
	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();

	Vector vOrd = new Vector();
	Vector vCls = new Vector();
	Vector vVen = new Vector();
	Vector vSty = new Vector();
	Vector vClr = new Vector();
	Vector vSiz = new Vector();
	Vector vSku = new Vector();
	Vector vGrp = new Vector();
	Vector vStr = new Vector();
	Vector vOrQty = new Vector();
	Vector vAvlQty = new Vector();
	Vector vAsgQty = new Vector();
	Vector vShpMeth = new Vector();
	Vector vStsStr = new Vector();
	Vector vToZip = new Vector();
	Vector vRatio = new Vector();
	Vector vSlsPoint = new Vector();
	Vector vDistPoint = new Vector();
	Vector vSameStrPoint = new Vector();
	Vector vAllwStrPoint = new Vector();
	Vector vTotPoint = new Vector();
	Vector vSameStr = new Vector();
	Vector vStr70Point = new Vector();
	Vector vSn = new Vector();
	Vector vAsgStr = new Vector();
	Vector vAsgSts = new Vector();
	Vector vDesc = new Vector();
	Vector vProcDt = new Vector();
	Vector vProcTm = new Vector();
	Vector vPlace = new Vector();
	Vector vComb = new Vector();
	boolean bRecordFound = false;
		
	while(runsql.readNextRecord())
	{
		bRecordFound = true;
		vOrd.add(runsql.getData("AwOrd").trim());
	    vCls.add(runsql.getData("AwCls").trim());
	    vVen.add(runsql.getData("AwVen").trim());
	    vSty.add(runsql.getData("AwSty").trim());
	    vClr.add(runsql.getData("AwClr").trim());
	    vSiz.add(runsql.getData("AwSiz").trim());
	    vSku.add(runsql.getData("AwSku").trim());
	    vGrp.add(runsql.getData("AwGrp").trim());
	    vStr.add(runsql.getData("AwStr").trim());
	    vOrQty.add(runsql.getData("AwOrQty").trim());
	    vAvlQty.add(runsql.getData("AwAvQty").trim());
	    vAsgQty.add(runsql.getData("AwAsQty").trim());
	    vShpMeth.add(runsql.getData("AwSMeth").trim());
	    vStsStr.add(runsql.getData("AwStsStr").trim());
	    vToZip.add(runsql.getData("AwZip").trim());
	    vRatio.add(runsql.getData("AwRatio").trim());
	    vSlsPoint.add(runsql.getData("AwSlsPt").trim());
	    vDistPoint.add(runsql.getData("AwDstPt").trim());
	    vSameStrPoint.add(runsql.getData("AwSmStPt").trim());
	    vStr70Point.add(runsql.getData("AwSt70Pt").trim());
	    vAllwStrPoint.add(runsql.getData("AwAlwSPt").trim());
	    vTotPoint.add(runsql.getData("AwTotPt").trim());
	    vSameStr.add(runsql.getData("AwSamSt").trim());	    
	    vSn.add(runsql.getData("v1Sn").trim());
	    vAsgStr.add(runsql.getData("v1Str").trim());
	    vAsgSts.add(runsql.getData("v1sts").trim());
	    vDesc.add(runsql.getData("ides").trim());
	    vProcDt.add(runsql.getData("AwPrcDt").trim());
	    vProcTm.add(runsql.getData("AwPrcTm").trim());
	    vPlace.add(runsql.getData("AwPlace").trim());
	    vComb.add(runsql.getData("comb").trim());
	}
	
	rs.close();
	runsql.disconnect();
%>
<HTML>
<HEAD>
<title>Mozu Pick Logic</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:12px} a:visited.small { color:blue; font-size:12px}  a:hover.small { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:12px;}
        
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:9px }

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: white; font-size:12px }
        tr.DataTable2 { background: yellow; font-size:12px }
        tr.DataTable12 { background: yellow; font-size:12px }
        tr.DataTable3 { background: pink; font-size:12px }
        

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DTError{color:red; font-size:12px;}               

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

              
        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:350; height:450px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:200; background: lavender; z-index:10;
              text-align:center; font-size:10px}   
            
        div.dvIntern { width:350; height:445px; overflow:scroll; }      

        
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
               

        tr.Prompt { font-size:10px }
        tr.Prompt1 { font-size:10px }
        tr.Prompt2 { font-size:11px }

        th.Prompt { background:#FFCC99; text-align:ceneter; vertical-align:midle; font-family:Arial; font-size:11px; }
        td.Prompt { padding-left:3px; padding-right:3px; text-align:left; vertical-align:top; font-family:Arial;}
        td.Prompt1 { padding-left:3px; padding-right:3px; text-align:center; vertical-align:top; font-family:Arial;}
        td.Prompt2 { padding-left:3px; padding-right:3px; text-align:right; font-family:Arial; }
        td.Prompt3 { padding-left:3px; padding-right:3px; text-align:left; vertical-align:midle; font-family:Arial;}


</style>


<script language="javascript1.3">
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   setSelectPanelShort();
}
//==============================================================================
//set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
var hdr = "Select Report Parameters";

var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  + "<tr>"
    + "<td class='BoxName' nowrap>" + hdr + "</td>"
    + "<td class='BoxClose' valign=top>"
      +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
    + "</td></tr>"
html += "<tr><td class='Prompt' colspan=2>"
html += "</td></tr></table>"

document.all.dvSelect.innerHTML=html;
document.all.dvSelect.style.pixelLeft= document.documentElement.scrollLeft + 10;
document.all.dvSelect.style.pixelTop= document.documentElement.scrollTop + 20;
}
//==============================================================================
//set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
var hdr = "Select Report Parameters";

var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
  + "<tr>"
    + "<td class='BoxName' nowrap>" + hdr + "</td>"
    + "<td class='BoxClose' valign=top>"
      +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
    + "</td></tr>"
html += "<tr><td class='Prompt' colspan=2>"

html += popSelWk()

html += "</td></tr></table>"
document.all.dvSelect.innerHTML=html;

var date = new Date();
document.all.From.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
document.all.To.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}
//==============================================================================
//populate Column Panel
//==============================================================================
function popSelWk()
{
var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
  + "<tr class='Prompt' id='trDt1'>"
     + "<td class='Prompt' colspan=3><u>Date Selection:</u>&nbsp</td>"
  + "</tr>"

  + "<tr class='Prompt' id='trDt2'>"
    + "<td class='Prompt' id='td2Dates' width='30px'>From:</td>"
    + "<td class='Prompt' id='td2Dates'>"
       + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;From&#34;)'>&#60;</button>"
       + "<input name='From' class='Small' size='10' readonly>"
       + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;From&#34;)'>&#62;</button>"
    + "</td>"
    + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 420, 170, document.all.From)'>"
      + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
  + "</tr>"
  + "<tr class='Prompt' id='trDt2'>"
    + "<td class='Prompt' id='td2Dates' width='30px'>To:</td>"
    + "<td class='Prompt' id='td2Dates'>"
       + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;To&#34;)'>&#60;</button>"
       + "<input name='To' class='Small' size='10' readonly>"
       + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;To&#34;)'>&#62;</button>"
    + "</td>"
    + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 420, 250, document.all.To)'>"
      + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
  + "</tr>"
  + "<tr class='Prompt' id='trDt2'>"
     + "<td class='Prompt' id='td2Dates' width='30px'>Order:</td>"
     + "<td class='Prompt' id='td2Dates'>"
       + "<input name='Order' maxlength=10 size=10>"
     + "</td>"
  + "</tr>"   

  
panel += "<tr class='Prompt'><td class='Prompt1' colspan=3>"
     + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
     + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

panel += "</table>";

return panel;
}
//==============================================================================
// validate entry
//==============================================================================
function Validate()
{
	var error = false;
	var msg = "";
	var br = "";
	
	var from = document.all.From.value;
	var to = document.all.To.value;
	
	var order = document.all.Order.value.trim();
	if(order != "" && isNaN(order)){ error=true; msg = "\nOrder number is not numeric." }
	
	if(error){alert(msg)}
	else{ sbmLogic( from, to, order ) }
}
//==============================================================================
//validate entry
//==============================================================================
function sbmLogic( from, to, order )
{
	if (order != "")
	{ 
		from = "0001-01-01";
		to = "2999-12-31";
    }
	
	var url = "EComTestPickLogic.jsp?From=" + from + "&To=" + to 
	  + "&Order=" + order
	//alert(url)
	window.location.href=url;
}

//==============================================================================
//populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
   var button = document.all[id];
   var date = new Date(button.value);

   if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
   else if(direction == "UP") date = new Date(new Date(date) - -86400000);
   button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// get combination
//==============================================================================
function getComb(ord)
{
   var url = "MozuTestPickLogicShip.jsp?ord=" + ord;
   window.frame1.location.href=url; 
}   
//==============================================================================
// set combination
//==============================================================================
function setComb(seq, numItm, str, ship)
{	 
	var hdr = "Item Pick Combinations"
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>"
	        + popComb(seq, numItm, str, ship)
	     + "</td></tr>"
	   + "</table>"

	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	  document.all.dvItem.style.visibility = "visible";	 
}
//==============================================================================
// populate quantity and status change panel
//==============================================================================
function popComb(seq, numItm, str, ship)
{	 
	var panel = "<div class='dvIntern'>" 
	 + "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
		+ "<tr class='DataTable'>"
	      + "<th class='DataTable' colspan=3>Number of Items:" + numItm[0] + "</th>"	    	      
	    + "</tr>"
	    + "<tr class='DataTable'>"
	      + "<th class='DataTable'>Seq<br>#</th>"
	      + "<th class='DataTable'>Stores</th>"
	      + "<th class='DataTable'>Ships</th>"	      
	    + "</tr>";
	    
	for(var i=0; i < seq.length; i++)
	{
	   panel += "<tr class='DataTable'>"
	       + "<td class='DataTable'>" + seq[i] + "</td>"
	       + "<td class='DataTable1'>" + str[i] + "</td>"
	       + "<td class='DataTable'>" + ship[i] + "</td>"
	     + "</tr>";
	}
	 
	panel += "</table></div>"
	 + "<br><button onClick='hidePanel();' class='Small'>Cancel</button>"
	   
	 return panel;
}
	
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
    document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
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
<div id="dvSelect" class="dvSelect"></div>
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce - Test Pick Logic
        </B><br>
        

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable">Order</th>
             <th class="DataTable">Cls-Ven-Sty-Clr-Siz</th>
             <th class="DataTable">Sku</th>
             <th class="DataTable">Item Description</th>
             <th class="DataTable">Grp</th>
             <th class="DataTable">Str</th>
             <th class="DataTable">Ord<br>Qty</th>
             <th class="DataTable">Avl<br>Qty</th>
             <th class="DataTable">Asg<br>Qty</th>
             <th class="DataTable">Ship<br>Method</th>
             <th class="DataTable">S-T-S<br>Str</th>
             <th class="DataTable">Ship<br>To<br>Zip</th>
             <th class="DataTable">Ratio</th>
             <th class="DataTable">Sls<br>Point</th>
             <th class="DataTable">Dist<br>Point</th>
             <th class="DataTable">Same<br>Str<br>Point</th>
             <th class="DataTable">Str<br>70<br>Point</th>
             <th class="DataTable">Allow<br>Str<br>Point</th>
             <th class="DataTable">Total<br>Point</th> 
             <th class="DataTable">Same<br>Str</th>
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable">S/N</th>
             <th class="DataTable">Str</th>
             <th class="DataTable">Status</th>
             <th class="DataTable">Processed<br>Date/Time</th>
             <th class="DataTable">Place</th>
           </tr>
       <!-- ============================ Details =========================== -->
   <%if(bRecordFound){%>    
       <%String sSvOrd = (String) vOrd.get(0); 
         String sClass = "DataTable1";
         boolean bNewOrd = false;%>       
       <%for(int i=0; i < vOrd.size(); i++ )
         {            
        %>      
           <%String sOrd = (String) vOrd.get(i);           
           if(!sOrd.equals(sSvOrd)){bNewOrd = true;}
           if(bNewOrd && vAsgQty.get(i).equals("0")){sClass = "DataTable";}
           if(bNewOrd && !vAsgQty.get(i).equals("0")){sClass = "DataTable1";}
           if(bNewOrd && (vGrp.get(i).equals("9") || vGrp.get(i).equals("5"))){sClass = "DataTable3";}
           sSvOrd = (String) vOrd.get(i);
           String sAddClass = "";
           if(!vAsgQty.get(i).equals("0")){sAddClass = "2";}
          %>
          
          <%if(bNewOrd){%>
          <tr class="DataTable">
             <th class="DataTable3">Order</th>
             <th class="DataTable3">Cls-Ven-Sty-Clr-Siz</th>
             <th class="DataTable3">Sku</th>
             <th class="DataTable3">Item Description</th>
             <th class="DataTable3">Grp</th>
             <th class="DataTable3">Str</th>
             <th class="DataTable3">Ord.Q</th>
             <th class="DataTable3">Avl.Q</th>
             <th class="DataTable3">Asg.Q</th>
             <th class="DataTable3">S.Mthd</th>
             <th class="DataTable3">STS Str</th>
             <th class="DataTable3">Ship Zip</th>
             <th class="DataTable3">Ratio</th>
             <th class="DataTable3">Sls Pt</th>
             <th class="DataTable3">Dst Pt</th>
             <th class="DataTable3">SSt Pt</th>
             <th class="DataTable3">Str 70</th>             
             <th class="DataTable3">Alw Pt</th>
             <th class="DataTable3">Tot Pt</th>
             <th class="DataTable3">Same Str</th>             
             <th class="DataTable">&nbsp;</th>
             <th class="DataTable3">S/N</th>
             <th class="DataTable3">Str</th>
             <th class="DataTable3">Status</th>
             <th class="DataTable">Date/Time</th>
             <th class="DataTable">Place</th>
           </tr>
          <%}%>
          
         <tr id="trProd" class="<%=sClass%><%=sAddClass%>">
            <td class="DataTable1" nowrap >
               <%if((i==0 || bNewOrd) && vComb.get(i).equals("Y") ){%>
                   <a href="javascript: getComb('<%=vOrd.get(i)%>')"><%=vOrd.get(i)%></a><%}
               else {%><%=vOrd.get(i)%><%}%>
            </td>
            <td class="DataTable1" nowrap ><%=vCls.get(i)%>-<%=vVen.get(i)%>-<%=vSty.get(i)%>-<%=vClr.get(i)%>-<%=vSiz.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vSku.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vDesc.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vGrp.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vStr.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vOrQty.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vAvlQty.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vAsgQty.get(i)%></td>
            <td class="DataTable" nowrap ><%=vShpMeth.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vStsStr.get(i)%></td>
            <td class="DataTable1" nowrap ><%=vToZip.get(i)%></td>
            <td class="DataTable2" nowrap ><%=vRatio.get(i)%></td>
            <td class="DataTable2" nowrap ><%=vSlsPoint.get(i)%></td>
            <td class="DataTable2" nowrap ><%=vDistPoint.get(i)%></td>
            <td class="DataTable2" nowrap ><%=vSameStrPoint.get(i)%></td>
            <td class="DataTable2" nowrap ><%=vStr70Point.get(i)%></td>
            <td class="DataTable2" nowrap ><%=vAllwStrPoint.get(i)%></td>            
            <td class="DataTable2" nowrap ><%=vTotPoint.get(i)%></td>
            <td class="DataTable" nowrap ><%=vSameStr.get(i)%></td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable" nowrap ><%=vSn.get(i)%></td>
            <td class="DataTable" nowrap ><%=vAsgStr.get(i)%></td>
            <td class="DataTable" nowrap ><%=vAsgSts.get(i)%></td>
            <td class="DataTable" nowrap ><%=sdfMdy.format(sdfYmd.parse(vProcDt.get(i).toString()))%>&nbsp;<%=vProcTm.get(i)%></td>
            <td class="DataTable" nowrap ><%=vPlace.get(i)%></td>
         </tr>
         <%bNewOrd = false;%>
       <%}%>
    <%}%>
       
    </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
