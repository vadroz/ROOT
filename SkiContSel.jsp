<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MarkdownInqSel.jsp&APPL=ALL");
   }
   else
   {      

      //============================================
      // get current fiscal year
      java.util.Date dCurDate = new java.util.Date();
      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      String sCurDate = sdf.format(dCurDate);

      String sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
        + " where pida='" + sCurDate + "'";
      //System.out.println(sPrepStmt);
      ResultSet rslset = null;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      runsql.runQuery();
      runsql.readNextRecord();
      String sYear = runsql.getData("pyr#");
      String sMonth = runsql.getData("pmo#");
      String sMnend = runsql.getData("pime");
      runsql.disconnect();
      runsql = null;
%>

<title>Skiing Contest</title>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var CurYear = "<%=sYear%>";
var CurMonth = eval("<%=sMonth%>") - 1;
 
var blockRow = "table-row";
var blockCell = "table-cell";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ blockRow = "block"; blockCell = "block"; }
	
  	showWkend();   
  	
}
 
//==============================================================================
// populate date selection
//==============================================================================
function showWkend()
{
    var date = new Date(new Date() - 86400000);

    // from sales date
    var day = 0;
    for(var i=0; i < 7; i++)
    {
       day = date.getDay();
       if (date.getDay()==0){ break; }
       date = new Date(date.getTime() - -86400000);
    }
      
    document.all.Wkend.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}
 
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";
  
  // sales date
  var wkend = document.all.Wkend.value;
  
  if (error) alert(msg);
  else{ sbmSlsRep( wkend ); }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep( wkend )
{
  var url = null;
  url = "SkiCont.jsp?Date=" + wkend;
  
  //alert(url)
  window.location.href=url;
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
   document.all.VenName.value = vennm
   document.all.Ven.value = ven
}

 

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
  var button = document.all[id];
  var date = new Date(button.value);

  date.setHours(18);

  if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

  if(direction == "DOWN" && ymd=="WK") { date = new Date(new Date(date) - 86400000 * 7 ); }
  else if(direction == "UP" && ymd=="WK") { date = new Date(new Date(date) - -86400000 * 7 ); }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script src="Calendar.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<TABLE class="tbl05">
  <TBODY>

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Peak Season Skiing Contest - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR id="trWeek">
          <TD class="Cell">Week: </TD>
          <TD class="Cell2">
             <button class="Small" name="Down" onClick="setDate('DOWN', 'Wkend', 'WK')">w-</button>
             <input class="Small" name="Wkend" type="text"  size=10 maxlength=10>&nbsp;
             <button class="Small" name="Up" onClick="setDate('UP', 'Wkend', 'WK')">w+</button>
               &nbsp;&nbsp;&nbsp;
             <a href="javascript:showCalendar(1, null, null, 300, 300, document.all.Wkend)" >
             <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

          </TD>
          
        </TR>
                 
         
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD class="Cell2" colSpan=4>
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