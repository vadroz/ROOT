<%@ page import="discountcard.DiscountCardLst ,java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=DiscountCardLst.jsp&APPL=ALL");
   }
   else
   {
      DiscountCardLst dclist = new DiscountCardLst(session.getAttribute("USER").toString());

      int iNumOfCard = dclist.getNumOfCard();
      String [] sDcName = dclist.getDcName();

      dclist.disconnect();
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable3 {background:#e7e7e7; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
// submit Card panel
//==============================================================================
function sbmCard(card, id)
{
   var url = "DiscountCard.jsp?Card=" + card.replaceSpecChar();
   //alert(url)
   window.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>Discount Card List</b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
        <th class="DataTable" nowrap>Discount Card Name</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
     <%for(int i=0; i < iNumOfCard; i++) {%>
         <tr  class="DataTable">
            <td class="DataTable"><a href="javascript: sbmCard('<%=sDcName[i].trim()%>')"><%=sDcName[i]%></a></td>
         </tr>
     <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>
<%}%>