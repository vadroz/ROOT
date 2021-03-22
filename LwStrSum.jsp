<%@ page import="java.util.*, java.text.*, layaway.LwStrSum"%>
<%
    String sFrDate = request.getParameter("FrDate");
    String sToDate = request.getParameter("ToDate");

    String sUser = session.getAttribute("USER").toString();

    LwStrSum lwsum = new LwStrSum(sFrDate, sToDate, sUser);

    int iNumOfStr = lwsum.getNumOfStr();
    String [] sStr = lwsum.getStr();
    String [] sQty = lwsum.getQty();
    String [] sRet = lwsum.getRet();
    String [] sCost = lwsum.getCost();

    lwsum.disconnect();
    lwsum = null;
%>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; font-family:Verdanda; font-size:10px }

        tr.DataTable  { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1  { background: LightGreen; font-family:Arial; font-size:10px }
        tr.DataTable2  { background: LightBlue; font-family:Arial; font-size:10px }

        td.DataTable {  padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:center }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable11 { background:#af7817; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable12 { background:silver; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable13 { background:gold; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable14 { background:pink; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:left }

        div.dvBonus { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        .small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
        #Var { display:none }
        #Prc { display:block }
        </style>

<script language="javascript">
FrDate = "<%=sFrDate%>";
ToDate = "<%=sToDate%>";

//==============================================================================
// initial page loads
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvBonus"]);
}
//==============================================================================
// initial page loads
//==============================================================================
function drilDown(str)
{
   var url = "LwItemLst.jsp?"
           + "Str=" + str
           + "&FrDate=" + FrDate
           + "&ToDate=" + ToDate
   //alert(url)
   window.location.href = url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

<html>
<head>
<title>Layway Store Summary</title>
</head>
<body onload="bodyLoad();">

<!-------------------------------------------------------------------->
<div class="dvBonus" id="dvBonus"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><b>Retail Concepts Inc.
        <BR>Layaway Store summary

        <br><%if(!sFrDate.equals("NONE")){%>From Weekending Date: <%=sFrDate%> &nbsp; &nbsp;
                                           Through Weekending Date: <%=sToDate%><%}
              else {%>Weekending Date: <%=sToDate%><%}%>
        </b>

      <br><p><a href="../"><font color="red"  size="-1">Home</font></a>&#62;
         <font size="-1">This page</font> &nbsp; &nbsp; &nbsp;
      <!------------- start Receipt table ------------------------>
      <table class="DataTable" border=1 cellPadding='0' cellSpacing='0'>
             <tr class="DataTable">
                <th class="DataTable">Store</th>
                <th class="DataTable">Qty</th>
                <th class="DataTable">Retail</th>
                <th class="DataTable">Cost</th>
              </tr>
      <!-- ============= Details =========================================== -->
         <%for(int i = 0; i < iNumOfStr; i++){%>
              <tr class="DataTable<%if(sStr[i].equals("Total")){%>1<%}%>">
                 <td class="DataTable1">
                   <%if(!sStr[i].equals("Total")){%>
                      <a href="javascript: drilDown('<%=sStr[i]%>')"><%=sStr[i]%></a>
                   <%} else {%>Total<%}%>
                 </td>
                 <td class="DataTable1"><%=sQty[i]%></td>
                 <td class="DataTable1">$<%=sRet[i]%></td>
                 <td class="DataTable1">$<%=sCost[i]%></td>
              </tr>
         <%}%>

       </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%
%>