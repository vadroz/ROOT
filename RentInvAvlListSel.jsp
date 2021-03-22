<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, rciutility.StoreSelect, java.sql.*, java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null )
{
      response.sendRedirect("SignOn1.jsp?TARGET=RentInvAvlListSel.jsp&APPL=ALL");
}
else
{
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

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvHelp { position:absolute;border: none;text-align:center; width: 50px;height:50px; 
     top: 0; right: 50px; font-size:11px; white-space: nowrap;}
  
    
  a.helpLink { background-image:url("/scripts/Help02.png"); display:block;
     height:50px; width:50px; text-indent:-9999px; }
     

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

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var Dpt = new Array();
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvPoNum"]);

  doSelDate();
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.AvlFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
// Validate form
//==============================================================================
function chkAllCls(dpt, bcheck)
{
   var cbDptNm = "D" + dpt + "Cls";
   var cbDpt = document.all[cbDptNm];
   for(var i=0; i < cbDpt.length; i++)
   {
       cbDpt[i].checked = bcheck;
   }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(dwnl)
{
  var error = false;
  var msg = "";

  var dpt = new Array();
  var dptfnd = false;

  if(Dpt.length > 1)
  {
     for(var i=0, k=0; i < document.all.Dpt.length; i++)
     {
       if(document.all.Dpt[i].checked) { dpt[k++] = document.all.Dpt[i].value; dptfnd = true; }
     }
  }
  else
  {
    if(document.all.Dpt.checked) { dpt[0] = document.all.Dpt.value; dptfnd = true; }
  }

  if(!dptfnd){ error= true; msg += "Please, check at least 1 department.\n"}

  var str = null;
  var strfnd = false;

  for(var i=0; i < Str.length; i++)
  {
    if(document.all.Str[i].checked) { str = document.all.Str[i].value; strfnd = true; break;}
  }
  if(!strfnd){ error= true; msg += "Please, check a store.\n"}

  // order date
  var frdate = document.all.AvlFrDate.value;

  if (error) alert(msg);
  else{ sbmPlan( dpt, str, frdate ) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(dpt, str, frdate)
{
  var url = "RentInvAvlList.jsp?"

  for(var i=0; i < dpt.length; i++)
  {
     url += "&Dpt=" + dpt[i]
  }
  url += "&Sort=ITEM"
       + "&Str=" + str
       + "&FrDate=" + frdate

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check/uncheck department selection
//==============================================================================
function chkDpt(turn)
{
   var dpt = document.all.Dpt;
   for(var i=0; i < dpt.length; i++){ dpt[i].checked=turn; }
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
<a  class="helpLink" href="Intranet Reference Documents/Inventory Availability.pdf" title="Click here for help" target="_blank">&nbsp;</a>
</div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle>
        <B>Check Availability</B>

        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>

      <TABLE border=0>
        <TBODY>

        <!-- ======================= Department ============================ -->
        <%String sStmtDpt = "select cdpt, dnam, count(*) as numofcls"
           + " from IpTsFil.IpClass inner join IpTsFil.IpDepts on ddpt=cdpt"
           + " where exists( select 1 from Rci.ReInv where ccls=eicls )"
           + " group by cdpt, dnam"
           + " order by cdpt";
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
         <TR>
          <TD class="Cell1" colspan=4>
            <input type="checkbox" class="Small" name="Dpt" value="<%=sDpt%>" checked><%=sDptNm%>
            <script>Dpt[<%=i%>]="<%=sDpt%>";</script><%i++;%>
          </TD>
         </TR>
       <%}%>
       <TR>
          <TD class="Cell1" colspan=4>
            <button class="Small" onclick="chkDpt(true)">All</button> &nbsp;
            <button class="Small" onclick="chkDpt(false)">reset</button>            
          </TD>
         </TR>


       <!-- ======================= Store ============================ -->
       <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell1" colspan=4>Stores:

        <%sStmtDpt = "select store"
           + " from RCI.ReStr"
           + " where store in (";

          String sComa = "";
          for(int j=0; j < sStrAlw.length; j++)
          {
             if(sStrAlw[j] != null){ sStmtDpt += sComa + sStrAlw[j]; sComa = ","; }
          }
          sStmtDpt +=  ")" ;
          sStmtDpt += " order by store";


          runsql = new RunSQLStmt();
          runsql.setPrepStmt(sStmtDpt);
          rs = runsql.runQuery();
          int j=0;

          while(runsql.readNextRecord())
          {
             String sStr = runsql.getData("store").trim();
             sComa= "";
         %>
           <%=sComa%>&nbsp;<input type="radio" class="Small" name="Str" value="<%=sStr%>"><%=sStr%>
              <%j++;%>
              <%sComa=",";%>
       <%}%>
       <%if(j==1){%><script>document.all.Str.checked=true;</script><%}%>
       <input type="hidden" name="Str" value="DUMMY" style="display:none;">

         </TD>
       </TR>
        <!-- ============== select Shipping changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>

        <TR>
          <TD id="tdDate4" colspan=4 align=center style="padding-top: 10px;" >
             <b>Start Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'AvlFrDate')">&#60;</button>
              <input class="Small" name="AvlFrDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'AvlFrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.AvlFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>