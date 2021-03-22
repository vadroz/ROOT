<%@ page import="java.util.*"%>
<%
    int iNumOfPage = Integer.parseInt(request.getParameter("Page"));
    Calendar cal = Calendar.getInstance();
%>
<html>
<head>
<style>
        body {background:white; text-align: left; vertical-align: top;}
        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.DataTable { width: 100%; border: black solid 1px; background: white; text-align:center; vertical-align: top;}
        th.PgHdg { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;
                   vertical-align: top; font-size:22px }
        th.PgHdg1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;
                    vertical-align: top;  font-size:14px }
        th.PgHdg2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;
                    vertical-align: top; font-size:14px }

        th.PgHdg3 { border: lightgrey ridge 5px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;
                    vertical-align: top; font-size:14px }
        th.PgHdg4 { border: black solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;
                    vertical-align: top; font-size:12px }

        td.DataTable  { background:white; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        text-align:left; font-family:Arial;font-size:14px }
        td.DataTable1 { background:white; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        text-align:right; font-size:14px }
        td.DataTable2 { background:white; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        text-align:center; font-size:14px }

        td.DataTable3 { background:white; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        text-align:left; font-size:18px; font-weight:bold}

        input {border:none; background:white; border-bottom: black solid 1px; font-size:12px }

        .PageBreak( dispaly:none; page-break-after:always)

        .small{ text-align:left; font-family:Arial; font-size:10px;}
@media print
{
        input {border:none; background:white; font-size:12px }
}


</style>
<SCRIPT language="JavaScript1.2">
//------------------------------------------------------------------------------
// global variables
//------------------------------------------------------------------------------
var selWkDay = new Array();
var selDate = new Array();
var selPromo = new Array();
var selPayee = new Array();
var selSize = new Array();
var selSect = new Array();
var selCost = new Array();
var selRate = new Array();
var selWkend = new Array();
//---------------------------------------------------------
// work on loading time
//---------------------------------------------------------
function bodyLoad()
{
   selWkDay = opener.selWkDay;
   selDate = opener.selDate;
   selPromo = opener.selPromo;
   selPayee = opener.selPayee;
   selSize = opener.selSize;
   selSect = opener.selSect;
   selCost = opener.selCost;
   selRate = opener.selRate;
   selWkend = opener.selWkend;

   for(var i=0; i < selWkDay.length; i++ )
   {
      document.all["Pub"+i].innerHTML="Publication:<br>" + selPayee[i][0];
      addLine(i);
   }
}
//------------------------------------------------------------------------
// save Customer Information (hide table after entry)
//------------------------------------------------------------------------
function addLine(id)
{
    var tbody = document.getElementById("T" + id).getElementsByTagName("TBODY")[0];



    for(var i=0; i < selWkDay[id].length; i++ )
    {
      var row = document.createElement("TR");

      var td1 = document.createElement("td");
      td1.appendChild(document.createTextNode(selWkDay[id][i] + " " + selDate[id][i]));
      td1.className="DataTable";

      var td2 = document.createElement("td")
      td2.className="DataTable";
      td2.appendChild (document.createTextNode(selSize[id][i]))

      var td3 = document.createElement("td")
      td3.innerHTML="<input value='" + selRate[id][i] + "'>";

      var td4 = document.createElement("td")
      td4.className="DataTable2";
      td4.innerHTML="<input value='" + selSect[id][i] + "'>";

      var td5 = document.createElement("td")
      td5.className="DataTable1";
      td5.innerHTML="<input value='" + selCost[id][i] + "'>";



      row.appendChild(td1);
      row.appendChild(td2);
      row.appendChild(td3);
      row.appendChild(td4);
      row.appendChild(td5);
      tbody.appendChild(row);
   }

   // Instruction
   row = document.createElement("TR");
   var td6 = document.createElement("td")
   td6.className="DataTable3";
   td6.colSpan="5";
   td6.innerHTML= "<br><br><br>Other Instruction: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Far forward, above the fold, turn page<br>"
   + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
   + "MUST HAVE 2 TEARSHEETS OF EACH AD !!!!! "
   + "<br><input size=150><br><input size=150><br><input size=150>"
   row.appendChild(td6);
   tbody.appendChild(row);
}

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}
</SCRIPT>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad()" >
   <%for(int i=0; i < iNumOfPage; i++) {%>
     <table id="T<%=i%>" class='DataTable' cellPadding="0" cellSpacing="0">
       <tr>
          <th class="PgHdg" colspan=5><u>Sun & Ski Sports</u></th>
       </tr>
       <tr>
          <th class="PgHdg1" colspan=5>4001 Greenbriar, Ste. 100<br>Ph:281-340-500 ext. 331 &nbsp;&nbsp;&nbsp;Fx: 281-340-5017</th>
       </tr>
       <tr>
          <th class="PgHdg1" id="Pub<%=i%>" colspan=2>Publication:</th>
          <th class="PgHdg1" colspan=2>Rep: <input></th>
          <th class="PgHdg1">Date: &nbsp;&nbsp;&nbsp;&nbsp;
           <input value="<%=cal.get(cal.MONTH)%>/<%=cal.get(cal.DATE)%>/<%=cal.get(cal.YEAR)%>"> <br>
                             New: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input value="xx"> <br>
                             Revised: <input></th>
       </tr>
       <tr>
          <th class="PgHdg3" colspan=5> <u>Insertion Order</u></th>
       </tr>
       <tr>
          <th>&nbsp;</th>
       </tr>
       <tr>
          <th class="PgHdg4" >Insertion<br>Date:</th>
          <th class="PgHdg4" >Size</th>
          <th class="PgHdg4" >Inch Rate</th>
          <th class="PgHdg4" >Positioning</th>
          <th class="PgHdg4" >Net Cost</th>
       </tr>
     </table>
     <%if( i+1 < iNumOfPage) {%><div style="page-break-after:always"></div><%}%>
   <%}%>
</body>
</html>


