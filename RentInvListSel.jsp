<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, rciutility.StoreSelect, java.sql.*, java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=RentInvListSel.jsp&APPL=ALL");
}
else
{
      if(session.getAttribute("REINVLST")==null){ response.sendRedirect("index.jsp"); }

      StoreSelect StrSelect = null;
      String sStrAllowed = session.getAttribute("STORE").toString();
      String sUser = session.getAttribute("USER").toString();

      if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
      {
        StrSelect = new StoreSelect(10);
      }
      else
      {
         Vector vStr = (Vector) session.getAttribute("STRLST");
         String [] sStrAlwLst = new String[ vStr.size()];
         Iterator iter = vStr.iterator();

         int iStrAlwLst = 0;
         while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

         if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
         else StrSelect = new StoreSelect(new String[]{sStrAllowed});
      }

      String [] sStrAlw = StrSelect.getStrLst();

%>
<title>Rent Inv</title>
<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
  td.Cell3 {font-size:12px; text-align:center; vertical-align:top}

  div.dvRent { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}

  div.dvHelp { position:absolute;border: none;text-align:center; width: 50px;height:50px; 
     top: 0; right: 50px; font-size:11px; white-space: nowrap;}  
  a.helpLink { background-image:url("/scripts/Help02.png"); display:block;
     height:50px; width:50px; text-indent:-9999px; } 
     
  div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
  div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }

  tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; top: expression(this.offsetParent.scrollTop-3);}
  tr.TblRow { background:wite; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:middle; font-size:11px }


  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
 

<script name="javascript">
var Dpt = new Array();
var StrList = new Array();

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{ 
	setBoxclasses(["BoxName",  "BoxClose"], ["dvPoNum"]);
	document.getElementById("tbody1").style.display="none";
	document.getElementById("tbody2").style.display="none";
	document.getElementById("tbody3").style.display="none";
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   else
   {
     document.all.tdDate3.style.display="none"
     document.all.tdDate4.style.display="block"
   }
   doSelDate(type)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(type)
{
   document.all.tdDate3.style.display="block"
   document.all.tdDate4.style.display="none"
   document.all.AvlFrDate.value = "NEXTWEEK"
   document.all.AvlToDate.value = "NEXTWEEK"
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.AvlFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  df.AvlToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
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
// check(uncheck) all classes
//==============================================================================
function chkAllCls(bcheck, type)
{
   for(var i=0; i < Dpt.length; i++)
   {
      var cbDptNm = type + Dpt[i] + "Cls";
      var cbDpt = document.all[cbDptNm];
      if(cbDpt != null)
      { 
      	for(var j=0; j < cbDpt.length; j++)
      	{
         	cbDpt[j].checked = bcheck;
      	}
      }	
   }
}

//==============================================================================
// check(uncheck) all store
//==============================================================================
function chkAllStr(bcheck)
{   
   for(var i=0, k=0; i < StrList.length; i++)
   {
 	 var objnm = StrList[i];
     document.all[objnm].checked = bcheck;
   }
}

//==============================================================================
// Validate form
//==============================================================================
function Validate(dwnl)
{
  var error = false;
  var msg = "";

  var cls = new Array();
  var clsfnd = false;

  for(var i=0, k=0; i < Dpt.length; i++)
  {
	var cbDptNm = "R" + Dpt[i] + "Cls";
	var cbDpt = document.all[cbDptNm];
    if(cbDpt != null)
    {
    	for(var j=0; j < cbDpt.length; j++)
    	{
       		if(cbDpt[j].checked) { cls[k++] = cbDpt[j].value; clsfnd = true; }
    	}
    }
    
    var cbDptNm = "L" + Dpt[i] + "Cls";
	var cbDpt = document.all[cbDptNm];
    if(cbDpt != null)
    {
    	for(var j=0; j < cbDpt.length; j++)
    	{
       		if(cbDpt[j].checked) { cls[k++] = cbDpt[j].value; clsfnd = true; }
    	}
    }
    
    var cbDptNm = "W" + Dpt[i] + "Cls";
	var cbDpt = document.all[cbDptNm];	
    if(cbDpt != null)
    {
    	if(cbDpt.checked) { cls[k++] = cbDpt.value; clsfnd = true; }    	
    }
    
    var cbDptNm = "B" + Dpt[i] + "Cls";
	var cbDpt = document.all[cbDptNm];	
    if(cbDpt != null)
    {
    	for(var j=0; j < cbDpt.length; j++)
    	{
       		if(cbDpt[j].checked) { cls[k++] = cbDpt[j].value; clsfnd = true; }
    	}    	
    }
    
  }
  if(!clsfnd){ error= true; msg += "Please, check at least 1 class."}
  

  var str = new Array();
  var strfnd = false;

  for(var i=0, k=0; i < StrList.length; i++)
  {
	var objnm = StrList[i];
    if(document.all[objnm].checked){ str[k++]=document.all[objnm].value; strfnd=true; }
  }
  if(!strfnd){ error= true; msg += "Please, check at least 1 store."}


  if (error) alert(msg);
  else{ sbmPlan( cls, str ) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(cls, str, frdate, todate)
{
  var url = null;
  url = "RentInvList.jsp?"

  for(var i=0; i < cls.length; i++)
  {
     url += "&Cls=" + cls[i]
  }
  for(var i=0; i < str.length; i++)
  {
     url += "&Str=" + str[i]
  }
  url += "&Sort=ITEM"

  //alert(url)
  window.location.href=url;
}
//==============================================================================
//check all classes for selected department 
//==============================================================================
function chkDptCls(type, dpt)
{
	var cbDptNm = type + dpt + "Cls";
	var cbDpt = document.all[cbDptNm];
	
	var arr = cbDpt.length != null; 
	 
	if(arr)
	{
		for(var i=0; i < cbDpt.length; i++)
		{
			cbDpt[i].checked = true;	   	
    	}
	}
	else
	{
		cbDpt.checked = true;
	}
}
//==============================================================================
//check all classes for selected department 
//==============================================================================
function setSelGrp()
{
	var grpobj = document.all.Grp;
	for(var i=0; i < grpobj.length; i++)
	{
		var tbody = document.getElementById("tbody" + (i+1));
		if(grpobj[i].checked)
		{			
		    tbody.style.display="block"; 
		}
		else
		{
			tbody.style.display="none";
		}
	}
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvRent" class="dvRent"></div>
<div id="dvPoNum" class="dvRent"></div>
<!-------------------------------------------------------------------->
<div id="dvHelp" class="dvHelp">
<a  class="helpLink" href="Intranet Reference Documents/4.0%20Inventory%20List.pdf" title="Click here for help" target="_blank">&nbsp;</a>
</div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle>
        <B>Retail Concepts Inc.
        <BR>Rental Inventory List</B>

         
        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>
        <br>
        <input name="Grp" id="Grp" type="radio" value="S" onclick="setSelGrp()">Skis/Snowboard &nbsp;
        <input name="Grp" id="Grp" type="radio" value="W" onclick="setSelGrp()">Water Sport &nbsp;
        <input name="Grp" id="Grp" type="radio" value="B" onclick="setSelGrp()">Bikes &nbsp;
       
      <TABLE border=0>
       <tbody id="tbody1">
        <tr>
        	<td vAlign=top align=middle colspan=10>
        		<a class="Small" href="javascript: chkAllCls(true, 'R')">Select all Categories</a>, &nbsp;
          		<a class="Small" href="javascript: chkAllCls(false, 'R')">Reset</a>
        	<td>
        </tr>         
        <TR>
          <TD vAlign=top align=middle>
        <!-- ======================= Department ============================ -->
        <%String sStmtDpt = "select cdpt, dnam, count(*) as numofcls"
           + " from IpTsFil.IpClass inner join IpTsFil.IpDepts on ddpt=cdpt"
           + " where exists( select 1 from Rci.ReInv where ccls=eicls)" 
           + " and cdpt not in (964, 973, 968, 969, 982)"
           + " group by cdpt, dnam"
           + " order by cdpt";
         System.out.println(sStmtDpt); 
        
          RunSQLStmt runsql = new RunSQLStmt();
          runsql.setPrepStmt(sStmtDpt);
          ResultSet rs = runsql.runQuery();
          int i=0;
          
          while(runsql.readNextRecord())
          {
             String sDpt = runsql.getData("cdpt").trim();
             String sDptNm = runsql.getData("dnam");
             int iNumOfCls = Integer.parseInt(runsql.getData("numofcls"));
         %>

          <TD vAlign=top style="<%if(i > 0){%>border-left:2px solid darkred;<%}%>font-size=10px;padding:10px;font-weight:bold" nowrap>
               <a href="javascript: chkDptCls('R','<%=sDpt%>')"><%=sDptNm%></a>

              <script>Dpt[<%=i%>]="<%=sDpt%>"</script>
              <table border=0>

          <%String sStmtCls = "select ccls, clnm"
               + " from IpTsFil.IpClass"
               + " where exists( select 1 from Rci.ReInv where ccls=eicls )"
               + " and cdpt=" + sDpt
               + " order by ccls";
          
          System.out.println(sStmtCls); 
             RunSQLStmt runsql1 = new RunSQLStmt();
             runsql1.setPrepStmt(sStmtCls);
             ResultSet rs1 = runsql1.runQuery();
             while(runsql1.readNextRecord())
             {
               String sCls = runsql1.getData("ccls").trim();
               String sClsNm = runsql1.getData("clnm").trim();
             %>
               <tr style="font-size=10px">
                <td>
                 <input type="checkbox" class="Small" name="R<%=sDpt%>Cls" value="<%=sCls%>" > <%=sClsNm%>
                </td>
               </tr>
          <%}%>

           </table>
            <%i++;%>
            </TD>
       <%}%>
         </td>
        </TR>
    
        
    <TR><TD class="Cell" >&nbsp;</TD></TR>
    <TR><TD style="border-bottom:darkred solid 1px" colspan="10" >&nbsp;</TD></TR>        
    <!-- ============== Lease ======================== -->
    <TR>
    	<TD vAlign=top align=middle colspan=10>    
          	<a class="Small" href="javascript: chkAllCls(true, 'L')">Select all Categories</a>, &nbsp;
          	<a class="Small" href="javascript: chkAllCls(false, 'L')">Reset</a>
        </TD>
    </TR>
    <TR>
          <TD vAlign=top align=middle>
        <!-- ======================= Department ============================ -->
        <%sStmtDpt = "select cdpt, dnam, count(*) as numofcls"
           + " from IpTsFil.IpClass inner join IpTsFil.IpDepts on ddpt=cdpt"
           + " where " //exists( select 1 from Rci.ReInv where ccls=eicls)"
           //+ " and
           + " cdpt in (973, 968, 969)"
           + " group by cdpt, dnam"
           + " order by cdpt";
        
          //System.out.println(sStmtDpt); 
          runsql = new RunSQLStmt();
          runsql.setPrepStmt(sStmtDpt);
          rs = runsql.runQuery();
          
          while(runsql.readNextRecord())
          {
             String sDpt = runsql.getData("cdpt").trim();
             String sDptNm = runsql.getData("dnam");
             int iNumOfCls = Integer.parseInt(runsql.getData("numofcls"));
         %>

          <TD vAlign=top style="<%if(i > 0){%>border-left:2px solid darkred;<%}%>font-size=10px;padding:10px;font-weight:bold" nowrap>
            <a href="javascript: chkDptCls('L','<%=sDpt%>')"><%=sDptNm%></a>

              <script>Dpt[<%=i%>]="<%=sDpt%>"</script>
              <table border=0>

          <%String sStmtCls = "select ccls, clnm"
               + " from IpTsFil.IpClass"
               + " where exists( select 1 from Rci.ReInv where ccls=eicls )"
               + " and cdpt=" + sDpt
               + " order by ccls";
             RunSQLStmt runsql1 = new RunSQLStmt();
             runsql1.setPrepStmt(sStmtCls);
             ResultSet rs1 = runsql1.runQuery();
             while(runsql1.readNextRecord())
             {
               String sCls = runsql1.getData("ccls").trim();
               String sClsNm = runsql1.getData("clnm").trim();
             %>
               <tr style="font-size=10px">
                <td>
                 <input type="checkbox" class="Small" name="L<%=sDpt%>Cls" value="<%=sCls%>" > <%=sClsNm%>
                </td>
               </tr>
          <%}%>

           </table>
            <%i++;%>
            </TD>
       <%}%>
         </td>
        </TR>
        
       </tbody>
       
       <tbody id="tbody2"> 
        
        <TR><TD class="Cell" >&nbsp;</TD></TR>
    	<TR><TD style="border-bottom:darkred solid 1px" colspan="10" >&nbsp;</TD></TR>        
    	<!-- ============== Lease ======================== -->
        
        <TR>
          <TD vAlign=top align=middle>
        <!-- ======================= Department ============================ -->
        <%sStmtDpt = "select cdpt, dnam, count(*) as numofcls"
           + " from IpTsFil.IpClass inner join IpTsFil.IpDepts on ddpt=cdpt"
           + " where " //exists( select 1 from Rci.ReInv where ccls=eicls)"
           //+ " and
           + " cdpt in ( 982 )"
           + " group by cdpt, dnam"
           + " order by cdpt";
        
          //System.out.println(sStmtDpt); 
          runsql = new RunSQLStmt();
          runsql.setPrepStmt(sStmtDpt);
          rs = runsql.runQuery();
          
          while(runsql.readNextRecord())
          {
             String sDpt = runsql.getData("cdpt").trim();
             String sDptNm = runsql.getData("dnam");
             int iNumOfCls = Integer.parseInt(runsql.getData("numofcls"));
         %>

          <TD vAlign=top style="<%if(i > 0){%>border-left:2px solid darkred;<%}%>font-size=10px;padding:10px;font-weight:bold" nowrap>
            <a href="javascript: chkDptCls('W','<%=sDpt%>')"><%=sDptNm%></a>

              <script>Dpt[<%=i%>]="<%=sDpt%>"</script>
              <table border=0>

          <%String sStmtCls = "select ccls, clnm"
               + " from IpTsFil.IpClass"
               + " where "
               + " cdpt=" + sDpt
               + " order by ccls";
             RunSQLStmt runsql1 = new RunSQLStmt();
             runsql1.setPrepStmt(sStmtCls);
             ResultSet rs1 = runsql1.runQuery();
             while(runsql1.readNextRecord())
             {
               String sCls = runsql1.getData("ccls").trim();
               String sClsNm = runsql1.getData("clnm").trim();
             %>
               <tr style="font-size=10px">
                <td>
                 <input type="checkbox" class="Small" name="W<%=sDpt%>Cls" value="<%=sCls%>" > <%=sClsNm%>
                </td>
               </tr>
          <%}%>

           </table>
            <%i++;%>
            </TD>
       <%}%>
         </td>
        </TR>
        
       </tbody>
       
       <!-- ======================= Bikes ============================ -->
       
       <tbody id="tbody3">
          
        <TR><TD class="Cell" >&nbsp;</TD></TR>
    	<TR><TD style="border-bottom:darkred solid 1px" colspan="10" >&nbsp;</TD></TR>        
    	<!-- ============== Lease ======================== -->
        
        <TR>
          <TD vAlign=top align=middle>
        <!-- ======================= Department ============================ -->
        <%sStmtDpt = "select cdpt, dnam, count(*) as numofcls"
           + " from IpTsFil.IpClass inner join IpTsFil.IpDepts on ddpt=cdpt"
           + " where " //exists( select 1 from Rci.ReInv where ccls=eicls)"
           //+ " and
           + " cdpt in ( 964 )"
           + " group by cdpt, dnam"
           + " order by cdpt";
        
          //System.out.println(sStmtDpt); 
          runsql = new RunSQLStmt();
          runsql.setPrepStmt(sStmtDpt);
          rs = runsql.runQuery();
          
          while(runsql.readNextRecord())
          {
             String sDpt = runsql.getData("cdpt").trim();
             String sDptNm = runsql.getData("dnam");
             int iNumOfCls = Integer.parseInt(runsql.getData("numofcls"));
         %>

          <TD vAlign=top style="<%if(i > 0){%>border-left:2px solid darkred;<%}%>font-size=10px;padding:10px;font-weight:bold" nowrap>
            <a href="javascript: chkDptCls('B','<%=sDpt%>')"><%=sDptNm%></a>

              <script>Dpt[<%=i%>]="<%=sDpt%>"</script>
              <table border=0>

          <%String sStmtCls = "select ccls, clnm"
               + " from IpTsFil.IpClass"
               + " where "
               + " cdpt=" + sDpt
               + " order by ccls";
             RunSQLStmt runsql1 = new RunSQLStmt();
             runsql1.setPrepStmt(sStmtCls);
             ResultSet rs1 = runsql1.runQuery();
             while(runsql1.readNextRecord())
             {
               String sCls = runsql1.getData("ccls").trim();
               String sClsNm = runsql1.getData("clnm").trim();
             %>
               <tr style="font-size=10px">
                <td>
                 <input type="checkbox" class="Small" name="B<%=sDpt%>Cls" value="<%=sCls%>" > <%=sClsNm%>
                </td>
               </tr>
          <%}%>

           </table>
            <%i++;%>
            </TD>
       <%}%>
         </td>
        </TR>
        
       </tbody>
       
       
       
       
        
        <TR><TD class="Cell" >&nbsp;</TD></TR>
        <!-- ======================= Store ============================ -->
       <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell3" colspan=5>Stores: &nbsp;
            <a class="Small" href="javascript: chkAllStr(true)">All Stores</a>, &nbsp;
            <a class="Small" href="javascript: chkAllStr(false)">Reset</a>
          <br>

        <%String sStmt = "select store"
           + " from RCI.ReStr"
           + " where store in (";

          String sComa = "";
          for(i=0; i < sStrAlw.length; i++)
          {
             if(sStrAlw[i] != null){ sStmt += sComa + sStrAlw[i]; sComa = ","; }
          }
          sStmt +=  ")" ;
          sStmt += " order by store";

          runsql = new RunSQLStmt();
          runsql.setPrepStmt(sStmt);
          rs = runsql.runQuery();
          int j=0;

          while(runsql.readNextRecord())
          {
             String sStr = runsql.getData("store").trim();
         %>
           &nbsp; &nbsp;<input type="checkbox" class="Small" name="Str<%=j%>" value="<%=sStr%>" ><%=sStr%>              
           <script>StrList[StrList.length] = "Str<%=j%>"</script>
           <%j++;%>   
       <%}%>
         
         </TD>
       </TR>
       <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="5" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
           </TD>
          </TR>
          
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>