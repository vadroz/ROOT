<%@ page import="inventoryreports.PiWiRentRew"%>
<%
  String sStore = request.getParameter("STORE");
  String sPiYearMo = request.getParameter("PICal");

  PiWiRentRew invrep = new PiWiRentRew(sStore, "ALL", "A", sPiYearMo.substring(0, 4), sPiYearMo.substring(4), "Y", "ALL");
  invrep.setAllArea();

  int iNumOfArea = invrep.getNumOfArea();
  String [] sArea = invrep.getArea();
  String [] sQty = invrep.getAllQty();
  String [] sTotAllQty = invrep.getTotAllQty();
  String [] sMbr = invrep.getMbr();

  invrep.disconnect();
%>

<html>
<head>

<style>
        body {background:ivory;}

        tr.Count {dispaly:block}

        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       border-top: darkred solid 1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background:cornsilk;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }

        div.dvSelWk { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        .Small { font-size:10px; }
</style>
<SCRIPT language="JavaScript">
//=======================================================
var NumOfArea = "<%=iNumOfArea%>"
//=======================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);
}

//==============================================================================
// show all or only missed areas
//==============================================================================
function colapse()
{
  var ruleNum = 1;
  var style = document.styleSheets[0].rules[ruleNum].style.display;
  if(style != "none")
  {
    document.styleSheets[0].rules[ruleNum].style.display="none";
  }
  else
  {
    document.styleSheets[0].rules[ruleNum].style.display="block";
  }
}
//==============================================================================
// delete scanned area from selected member
//==============================================================================
function dltArea(mbr, area)
{
  var hdr = "Delete Items for Area " + area;

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popDltArea(mbr, area)

   html += "</td></tr></table>"

   document.all.dvSelWk.innerHTML = html;
   document.all.dvSelWk.style.pixelLeft= 400;
   document.all.dvSelWk.style.pixelTop= 100;
   document.all.dvSelWk.style.visibility = "visible";
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popDltArea(mbr, area)
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td style='font-size:12px; font-weight:bold; color:red; text-decoration:underline; white-space:nowrap;' colspan=2>"
          + "Are you sure you want to delete this area?"
       + "</td>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt' width='20%'>Area: &nbsp;</td>"
       + "<td class='Prompt'>" + area + "</td>"
    + "</tr>"

    + "<tr>"
       + "<td class='Prompt' width='20%' nowrap>Scanned into: &nbsp;</td>"
       + "<td class='Prompt'>" + mbr + "</td>"
    + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='sbmDltArea(&#34;" + mbr + "&#34;,&#34;" + area + "&#34;)' class='Small'>Delete</button> &nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
  panel += "</table>";

  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvSelWk.innerHTML = " ";
   document.all.dvSelWk.style.visibility = "hidden";
}

//==============================================================================
// submit area deletion
//==============================================================================
function sbmDltArea(mbr, area)
{
   var url = "PiWiSave.jsp?Store=<%=sStore%>&Mbr=" + mbr + "&Area=" + area
     + "&PICal=<%=sPiYearMo%>"
     + "&Action=DLTAREA"

   //alert(url)
   window.frame1.location = url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

   <table border="0" width="100%" height="100%">
    <tr bgColor="moccasin">
     <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Cycle Count Area Summary (Rental Equipment)
      <br>Store:<%=sStore%></b><br>
<!------------- end of store selector ---------------------->
        <p style="font-size:10px"><a href="../"><font color="red">Home</font></a>&#62;
        <a href="PIWIRewRentSel.jsp"><font color="red">Selection</font></a>&#62;
        This page
<!------------- start of dollars table ------------------------>
      <table class="DataTable" width="50%"  align="center" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" colspan="4">
                 <a href="javascript:colapse();">Show All or only Missed Areas</a></th>
        </tr>
        <tr>
          <th class="DataTable">Area<br/>#</th>
          <th class="DataTable">Number<br>Of<br> Pairs</th>
          <th class="DataTable" width="10%">Scanned into</th>
          <th class="DataTable" width="5%">Delete</th>
        </tr>
        <!-- ---------------------- Detail Loop ----------------------- -->
        <%for(int i=0; i < iNumOfArea; i++){%>
           <tr <%if(!sQty[i].equals("Missed Area")){%>class="Count"<%}%>>
             <td class="DataTable">
                <a href="PIWIRewRent.jsp?STORE=<%=sStore%>&AREA=<%=sArea[i]%>&PICal=<%=sPiYearMo%>&Mbr=<%=sMbr[i]%>"><%=sArea[i]%></a></td>

             <td class="DataTable">
               <%if(!sQty[i].equals("Missed Area")){%>
                 <%=sQty[i]%>
               <%}
                 else {%><font color="red"><%=sQty[i]%></font><%}%>
             </td>
             <td class="DataTable"><%=sMbr[i]%></td>
             <td class="DataTable"><a href="javascript: dltArea('<%=sMbr[i]%>', '<%=sArea[i]%>')">D</a></td>
           </tr>
        <%}%>

        <!----------------------- totals -------------------------------->
        <tr>
             <td class="DataTable1">Areas 1 - 99 Total</td>
             <td class="DataTable1"><%=sTotAllQty[0]%></td>
             <td class="DataTable1">&nbsp;</td>
             <td class="DataTable1">&nbsp;</td>
        </tr>
        <tr>
             <td class="DataTable1">Other Areas Total</td>
             <td class="DataTable1"><%=sTotAllQty[1]%></td>
             <td class="DataTable1">&nbsp;</td>
             <td class="DataTable1">&nbsp;</td>
        </tr>
        <tr>
             <td class="DataTable1">Store Total</td>
             <td class="DataTable1"><%=sTotAllQty[2]%></td>
             <td class="DataTable1">&nbsp;</td>
             <td class="DataTable1">&nbsp;</td>
        </tr>
       <!----------------------- end totals ----------------------------->
       </table>

<!------------- end of data table ------------------------>

                </td>
            </tr>
       </table>

        </body>
      </html>
