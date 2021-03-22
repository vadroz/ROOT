<%@ page import="salesigns01.ProdSignDiv, java.util.*, java.text.*, java.io.*"%>
<%
   String sSelDiv = request.getParameter("Div");
   String sSelVen = request.getParameter("Ven");

   if (sSelVen == null){ sSelVen = " "; }
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ProdSignDiv.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

   String sUser = session.getAttribute("USER").toString();
   ProdSignDiv prods = new ProdSignDiv(sSelDiv, sSelVen, sUser);
%>
<html>
<head>
<title>Product Signs By Div</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#eeeeee; font-family:Arial; font-size:10px }
        tr.DataTable9 { background: LemonChiffon; font-family:Arial; font-size:10px; text-align:center;}

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable21 {background:pink; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
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
        #tdAllInv { display: none; }
        #tdAvlInv { display: block; }

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

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
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

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
        <b>Retail Concepts Inc.
        <br>Product Information signs
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="ProdSignDivSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
          <th class="DataTable">Download<br>(Class-Vendor-Style-Color-Size)</th>
          <th class="DataTable">Div</th>
          <th class="DataTable">Vendor</th>
          <!--  th class="DataTable">Beginning<br>Date</th -->
          <!--  th class="DataTable">Ending<br>Date</th-->
          <th class="DataTable">Style Description</th>
          <th class="DataTable">Sign<br>Exists</th>
        </tr>
  <!-------------------------- Order List ------------------------------->
      <%
       while(prods.getNext())
       {
          prods.getProdSignDiv();
          String sDiv = prods.getDiv();
          String sCls = prods.getCls();
          String sVen = prods.getVen();
          String sSty = prods.getSty();
          String sClr = prods.getClr();
          String sSiz = prods.getSiz();
          String sBegDt = prods.getBegDt();
          String sEndDt = prods.getEndDt();
          String sDesc = prods.getDesc();
          String sVenNm = prods.getVenNm();

          
          String sLink = "/Signs/Products/Division " + sDiv + "/" + sCls + "." + sVen + "." + sSty + "." + sClr;
          if(!sSiz.equals("0000")){ sLink += "." + sSiz; }
          sLink += ".doc";

          String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT" + sLink;
          File f = new File(sPath);
         
          if(!f.exists())
          {
        	 sLink = "/Signs/Products/Division " + sDiv + "/" + sCls + "." + sVen + "." + sSty + "." + sClr;
             if(!sSiz.equals("0000")){ sLink += "." + sSiz; }
                  sLink += ".pdf"; 
             sPath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT" + sLink;
             f = new File(sPath);
          }
      %>
         <tr class="DataTable1">
           <td class="DataTable">
           	 <%if(f.exists()){%>
           	 	<a href="<%=sLink%>" target="_blank"><%=sCls%>-<%=sVen%>-<%=sSty%>
               		<%if(!sClr.equals("000")){%>-<%=sClr%><%}%>
               		<%if(!sSiz.equals("0000")){%>-<%=sSiz%><%}%>
             	</a>
             <%} else {%>
                    <%=sCls%>-<%=sVen%>-<%=sSty%>
               		<%if(!sClr.equals("000")){%>-<%=sClr%><%}%>
               		<%if(!sSiz.equals("0000")){%>-<%=sSiz%><%}%>
             <%}%>
           </td>
           <td class="DataTable2"><%=sDiv%></td>
           <td class="DataTable"><%=sVenNm%></td>
           <!--  td class="DataTable2"><%=sBegDt%></td -->
           <!--  td class="DataTable2"><%=sEndDt%></td -->
           <td class="DataTable"><%=sDesc%></td>
           <td class="DataTable2"><%if(f.exists()){%>Yes<%} else {%>&nbsp;<%}%></td>
         </tr>
      <%}%>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>


<%  prods.disconnect();
  }%>