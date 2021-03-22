<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, rciutility.StoreSelect, java.sql.*, java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null )
{
     response.sendRedirect("SignOn1.jsp?TARGET=SupOrdListSel.jsp&APPL=ALL");
}
else
{

    StoreSelect StrSelect = null;
    String sStr = null;
    String sStrName = null;

    String [] sStrLst = null;
    String [] sStrLstName = null;
    int iNumOfStr = 0;

    String sStrAllowed = session.getAttribute("STORE").toString();
    String sUser = session.getAttribute("USER").toString();
    int iStrAlwLst = 0;

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      StrSelect = new StoreSelect(15);
    }
    else
    {
      Vector vStr = (Vector) session.getAttribute("STRLST");
      String [] sStrAlwLst = new String[ vStr.size()];
      Iterator iter = vStr.iterator();

     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
     else StrSelect = new StoreSelect(new String[]{sStrAllowed});
    }

    iNumOfStr = StrSelect.getNumOfStr();
    sStrLst = StrSelect.getStrLst();
    sStrLstName = StrSelect.getStrNameLst();

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
  td.Cell3 {font-size:12px; text-align:center; vertical-align:top}

  div.dvRent { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}


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
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var StrLst = [<%=sStr%>];
var StrLstNm = [<%=sStrName%>];
var StrAllowed = "<%=sStrAllowed%>";
var blockRow= "table-row";
var blockCell= "table-cell";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ blockRow = "block"; blockCell="block"; }
	
	setStrSel();  
	document.all.tdDate3.style.display=blockCell;  
	document.all.tdDate4.style.display="none";
}
//==============================================================================
// set store selection in array
//==============================================================================
function setStrSel()
{

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
   document.all.FrDate.value = "ALLDATES"
   document.all.ToDate.value = "ALLDATES"
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
// Check all or reset check boxes
//==============================================================================
function chkAllChkbox(objNm, bcheck)
{
   var cbObj = document.all[objNm];
   for(var i=0; i < cbObj.length; i++)
   {
       cbObj[i].checked = bcheck;
   }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(dwnl)
{
  var dummy = "</table>";
  var error = false;
  var msg = "";

  var sts = new Array();
  var stsfnd = false;
  var stssel = document.all.Sts;

  for(var i=0, k=0; i < stssel.length; i++)
  {
    if(stssel[i].checked) { sts[k++] = stssel[i].value; stsfnd = true; }
  }
  if(!stsfnd){ error= true; msg += "Please, check at least 1 status."}

  var str = new Array();
  var strfnd = false;
  var strsel = document.all.Str;

  if(StrLst.length > 2)
  {
     for(var i=0, j=0; i < strsel.length; i++)
     {
        if(strsel[i].checked) { str[j] = strsel[i].value; j++; strfnd = true;}
     }
  }
  else
  {
     if(document.all.Str.checked) { str[0] = document.all.Str.value; strfnd = true;}
  }
  if(!strfnd){ error= true; msg += "Please, check a store."}

  // order date
  var frdate = document.all.FrDate.value;
  var todate = document.all.ToDate.value;

  if (error) alert(msg);
  else{ sbmSupOrdLst( sts, str, frdate, todate ) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSupOrdLst(sts, str, frdate, todate)
{
  var url = "SupOrderList.jsp?"

  for(var i=0; i < sts.length; i++)
  {
     url += "&Sts=" + sts[i]
  }

  for(var i=0; i < str.length; i++)
  {
     url += "&Str=" + str[i]
  }
  url += "&Sort=ORDER"
       + "&FrDate=" + frdate
       + "&ToDate=" + todate

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// go to individual contract
//==============================================================================
function gotoOrder()
{
   if(document.all.Cont.value.trim() == "")
   {
       alert("Please, enter contract number.")
   }
   else
   {
      var url = "SupOrderInfo.jsp?Ord=" + document.all.Cont.value.trim()
      window.open(url);
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
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle>
        <B>Supply Orders</B>
        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>

      <TABLE border=0>
        <TBODY>

        <!-- ======================= Statuses ============================ -->

         <TR>
          <TD class="Cell2" colspan=4>
            Status:
         <TR>
          <TD class="Cell3" colspan=4>
            <a class="Small" href="javascript: chkAllChkbox('Sts', true)">All Statuses</a>, &nbsp;
            <a class="Small" href="javascript: chkAllChkbox('Sts', false)">Reset</a>
            <br>
           <%String sStmt = "select PtConst"
            + " from RCI.SuConst"
            + " where PtGrp ='STATUS'"
            + " order by PtSort";

            RunSQLStmt runsql = new RunSQLStmt();
            runsql.setPrepStmt(sStmt);
            ResultSet rs = runsql.runQuery();
            int j=0;

            String sComa= "";
            while(runsql.readNextRecord())
            {
               String sSelSts = runsql.getData("PtConst").trim();
            %>
              <%=sComa%>&nbsp;<input type="checkbox" class="Small" name="Sts" value="<%=sSelSts%>"
               <%if(!sSelSts.equals("Cancelled")){%> checked<%}%>><%=sSelSts%>
              <%j++;%>
              <%sComa=",";%>
           <%}%>
          </TD>
         </TR>

       <!-- ======================= Store ============================ -->
       <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell2" colspan=4>Stores: &nbsp;
        </tr>
        <TR>
          <TD class="Cell3" colspan=4>
            <a class="Small" href="javascript: chkAllChkbox('Str', true)">All Stores</a>, &nbsp;
            <a class="Small" href="javascript: chkAllChkbox('Str', false)">Reset</a>
            <br>

            <%for(int i=0; i < iNumOfStr; i++){%>
              <%if(i > 0 && i % 16 == 0){%><br><%}%>
              <input class="Small" name="Str" type="checkbox" value="<%=sStrLst[i]%>" checked><%=sStrLst[i]%> &nbsp;
            <%}%>
          </TD>
       </TR>
        <!-- ============== select date ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Select Order Week</TD></tr>

        <TR>
          <TD id="tdDate3" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(2)">Optional Week Selection</button>
          </td>
          <TD id="tdDate4" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text" value="ALLDATES" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int k=0; k < 20; k++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" value="ALLDATES" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 600, 400, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates(2)">All Dates</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">

               <br><br><a href="SupOrderInfo.jsp" target="_blank">New Order</a>&nbsp;
               <br><br>
                 <span style="font-size:12px;">
                   Go to Order # &nbsp; <input name="Cont" size=10 maxlength=10>
                   <button onClick="gotoOrder()" class="Small">Go</button>
                 </span>
           </TD>
          </TR>

          <!-- =============== Item Groups ================================= -->
          <tr>
           <td align=center>
          <%sStmt = "select IGGRP, IgName"
             + " from RCI.SUITMGRP"
             + " order by IGSORT";

            runsql = new RunSQLStmt();
            runsql.setPrepStmt(sStmt);
            rs = runsql.runQuery();
            %>
            <br>
            <span style="font-size:12px;text-decoration:underline">Click links below to display a list of supplies available for order in each category.</span>
            <table border="0" cellPadding=0 cellSpacing=0>
              <tr>
                <%while(runsql.readNextRecord()){%>
                <%
                   String sItmGrp = runsql.getData("IgGrp").trim();
                   String sItmGrpNm = runsql.getData("IgName").trim();
                %>
                   <td style="font-size:11px;padding-top:12px; padding-right:5px;padding-left:5px;">
                       <a href="SupOrdAllClsList.jsp?Grp=<%=sItmGrp%>&GrpNm=<%=sItmGrpNm%>"><%=sItmGrpNm%><a>
                   </td>
                <%}%>
               </td>
              </tr>
            </table>
          </tr>

         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>