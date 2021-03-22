<%@ page import="rciutility.RunSQLStmt, java.sql.*
	, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%   
   String sFromDt = request.getParameter("From");
   String sToDt = request.getParameter("To");
   if(sFromDt == null){ sFromDt = "0001-01-01"; }
   if(sToDt == null){ sToDt = "2999-12-31"; }
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=WstOrdLst.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
      String sStrAllowed = session.getAttribute("STORE").toString();    
              	  
  	  String sPrepStmt = "select TOORD, TOCUST, TOSTS, TORECUS, char(TORECDT, usa) as toRecDt, char(TORECTM, usa) as ToRecTm" 
  	   + ", (select count(*) from rci.TkBikTi where tbord=toord) as bikt_count"
  	   + ", (select count(*) from rci.TkSkiTi where tiord=toord) as skit_count"
  	   + ", (select count(*) from rci.TkSnbTi where Sbord=toord) as snbt_count"
  	   + ", (select count(*) from rci.TkXcsTi where Crord=toord) as xcst_count"
  	   
       + ", (select TbStr from rci.TkBikTi where tbord=toord fetch first 1 row only) as bikt_str"
       + ", (select TiStr from rci.TkSkiTi where tiord=toord fetch first 1 row only) as skit_str"
       + ", (select SbStr from rci.TkSnbTi where Sbord=toord fetch first 1 row only) as snbt_str"
       + ", (select CrStr from rci.TkXcsTi where Crord=toord fetch first 1 row only) as xcst_str"
  	   
  	   
	   + ", (select trim(CSFNAM) concat ' ' concat trim(CSLNAM) from rci.TkCust " 
  	   + " where Cscust= tocust) as custnm"
  	   + " from rci.TKORDH"
  	   + " where TORECDT >= '" + sFromDt + "'"
       + " and TORECDT <= '" + sToDt + "'"
  	   + " order by TOORD";       	
  	      	
  	  System.out.println(sPrepStmt);
  	       	
  	  ResultSet rslset = null;
  	  RunSQLStmt runsql = new RunSQLStmt();
  	  runsql.setPrepStmt(sPrepStmt);		   
  	  runsql.runQuery();
  	  
      Vector<String> vOrd = new Vector<String>();
      Vector<String> vCust = new Vector<String>();
      Vector<String> vStr = new Vector<String>();
      Vector<String> vSts = new Vector<String>();
      Vector<String> vRecUs = new Vector<String>();
      Vector<String> vRecDt = new Vector<String>();
      Vector<String> vRecTm = new Vector<String>();
      
      Vector<String> vBikTiCnt = new Vector<String>();
      Vector<String> vSkiTiCnt = new Vector<String>();
      Vector<String> vSnbTiCnt = new Vector<String>();
      Vector<String> vXcsTiCnt = new Vector<String>();
      
      Vector<String> vCustNm = new Vector<String>();
  	    		   		   
  	  while(runsql.readNextRecord())
  	  {
  		  vOrd.add(runsql.getData("toord").trim());
  		  vCust.add(runsql.getData("tocust").trim());
  		  
  		  vSts.add(runsql.getData("toSts").trim());
  		  vRecUs.add(runsql.getData("toRecUs").trim());
  		  vRecDt.add(runsql.getData("toRecDt").trim());
  	      vRecTm.add(runsql.getData("toRecTm").trim());
  	      vBikTiCnt.add(runsql.getData("bikt_count").trim());
  	      vSkiTiCnt.add(runsql.getData("skit_count").trim());
  	      vSnbTiCnt.add(runsql.getData("snbt_count").trim());
  	      vXcsTiCnt.add(runsql.getData("xcst_count").trim());
  	      String cst = runsql.getData("custnm");
  	      if(cst == null ) { cst = "";}
  	      vCustNm.add(cst);
  	      
  	      String str = ""; 
	      if(runsql.getData("bikt_str") != null ) { str +=  " " + runsql.getData("bikt_str");}
	      if(runsql.getData("skit_str") != null ) { str +=  " " + runsql.getData("skit_str");}
	      if(runsql.getData("snbt_str") != null ) { str +=  " " + runsql.getData("snbt_str");}
	      if(runsql.getData("xcst_str") != null ) { str +=  " " + runsql.getData("xcst_str");}
	      
	      vStr.add(str);
  	  }  
  	  
  	  CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
  	  String [] sOrd = vOrd.toArray(new String[]{});
  	  String [] sCust = vCust.toArray(new String[]{});
  	  String [] sSts = vSts.toArray(new String[]{});
  	  String [] sRecUs = vRecUs.toArray(new String[]{});
  	  String [] sRecDt = vRecDt.toArray(new String[]{});
  	  String [] sRecTm = vRecTm.toArray(new String[]{});
  	  
  	  String [] sBikTiCnt = vBikTiCnt.toArray(new String[]{});
  	  String [] sSkiTiCnt = vSkiTiCnt.toArray(new String[]{});
  	  String [] sSnbTiCnt = vSnbTiCnt.toArray(new String[]{});
  	  String [] sXcsTiCnt = vXcsTiCnt.toArray(new String[]{});
  	  String [] sCustNm = vCustNm.toArray(new String[]{});
  	  String [] sStr = vStr.toArray(new String[]{});
%>


<html>
<head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<style type="text/css" media="print">
  @page { transform: rotate(90deg); }
  .NonPrt  { display:none; }
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var NewClsNm = null;
 

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
}
//==============================================================================
// add Ctl comments
//==============================================================================
function chgCls( txcode, avacode, action)
{
   var hdr = "Add Tax Category";
   if(action == "UPD_CLS"){ hdr = "Update Tax Category";}
   else if(action == "DLT_CLS"){ hdr = "Delete Tax Category";}

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popClsPanel(txcode, avacode, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width=250;
   document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 200;
   document.all.dvItem.style.pixelTop = document.documentElement.scrollTop + 95;
   document.all.dvItem.style.visibility = "visible";
  
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popClsPanel( txcode, avacode, action)
{
  var panel = "<table border=1 width=100% cellPadding='0' cellSpacing='0'>"
  panel += "<tr>"
     + "<td class='td49' nowrap>Tax Category:</td>"
     + "<td class='td48' nowrap><input name='TxCat' size=30 maxlength=25></td>"
   + "</tr>"
   + "<tr>"
   	  + "<td class='td49' nowrap>Avalara Code:</td>"
   	  + "<td class='td48' nowrap><input name='AvaCode' size=25 maxlength=20></td>"
   + "</tr>"   

  panel += "<tr>";
  panel += "<td class='td50' colspan=2><br><br><button onClick='ValidateCls(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"  
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
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
 
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<title>WST List</title>

<body onload="bodyLoad()"> 
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
   <table  class="tbl01" id="tblClaim">
     <tr>       
      <td ALIGN="center" VALIGN="TOP"nowrap>      
      <span id="spnHdrImg"><img src="Sun_ski_logo4.png" height="50px" alt="Sun and Ski Patio"></span>
      <br><b>Workshop Tickets
      <br>
       </b>
       </td>       
      </tr>

    <tr class="NonPrt">
      <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        &nbsp;&nbsp;&nbsp;
      </td>
    </tr>
     
    <tr>
      <td colspan=3 align=center>
         <table class="tbl02">
           <tr class="trHdr01">              
              <th class="th02" rowspan=2 nowrap>Order</th>
              <th class="th02" rowspan=2 nowrap>Customer</th>
              <th class="th02" rowspan=2 nowrap>Store</th>
              <th class="th02" rowspan=2 nowrap>Status</th>
              <th class="th02" rowspan=2 nowrap>Created</th>
              <th class="th02" colspan=4 nowrap>Tickets</th>
           </tr>
           <tr class="trHdr01">  
              <th class="th02" nowrap>Bike<br>Tikets</th>
              <th class="th02" nowrap>Ski<br>Tikets</th>
              <th class="th02" nowrap>SB<br>Tikets</th>
              <th class="th02" nowrap>X-Ski<br>Tikets</th>
           </tr>
            
           <%String sCss1="trDtl04";%>
           <%for(int i=0; i < sOrd.length; i++){
                if(sCust[i].equals("0")){ sCust[i] = "&nbsp;"; }
                if(sBikTiCnt[i].equals("0")){ sBikTiCnt[i] = "&nbsp;"; }
                if(sSkiTiCnt[i].equals("0")){ sSkiTiCnt[i] = "&nbsp;"; }
                if(sSnbTiCnt[i].equals("0")){ sSnbTiCnt[i] = "&nbsp;"; }
                if(sXcsTiCnt[i].equals("0")){ sXcsTiCnt[i] = "&nbsp;"; }
                
           %>
              <tr class="<%=sCss1%>">
                 <td class="td11" nowrap><%=sOrd[i]%></td>
                 <td class="td11" nowrap><%=sCust[i]%> - <%=sCustNm[i]%></td>
                 <td class="td11" nowrap><%=sStr[i]%></td>
                 <td class="td11" nowrap><%=sSts[i]%></td>
                 <td class="td11" nowrap><%=sRecDt[i]%> <%=sRecTm[i]%></td>
                 <td class="td11" nowrap><%=sBikTiCnt[i]%></td>
                 <td class="td11" nowrap><%=sSkiTiCnt[i]%></td>
                 <td class="td11" nowrap><%=sSnbTiCnt[i]%></td>
                 <td class="td11" nowrap><%=sXcsTiCnt[i]%></td>
              </tr>
           <%}%>
           <!----------------------- end of table ------------------------>                 
         </table>
      </td>
    </tr>
    
    
   </table>
 </body>
</html>
<%}%>






