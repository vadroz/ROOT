<%@ page import="ecommerce.EcItmRmvLst"%>
<%
   String sSelDiv = request.getParameter("Div");
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null && session.getAttribute("ECOMDWNL")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EcItmRmvLst.jsp&APPL=ALL");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      EcItmRmvLst itmrmvl = new EcItmRmvLst(sSelDiv, sSelDpt, sSelCls, sSelVen, sUser);
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
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center;}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
              text-align:center; font-size:10px}
        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
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
// mark Item for removing from Volusion
//==============================================================================
function markRemove(cls, ven, sty, obj)
{
   action = "ADD";
   if( !obj.checked ) { action = "DLT"; }

   var url = "EcItmRmvSave.jsp?"
       + "Cls=" + cls
       + "&Ven=" + ven
       + "&Sty=" + sty
       + "&Action=" + action
   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Item(Parent) Removal List
        <br>Selected
            Div: <%=sSelDiv%>&nbsp;&nbsp;
            Dpt: <%=sSelDpt%>&nbsp;&nbsp;
            Class: <%=sSelCls%>&nbsp;&nbsp;
            Vendor: <%=sSelVen%>&nbsp;&nbsp;
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="EcItmRmvLstSel.jsp"><font color="red" size="-1">Select</font></a>&#62;
      <font size="-1">This Page</font>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
         <th class="DataTable" rowspan=2 nowrap>R<br>e<br>m<br>o<br>v<br>e</th>
         <th class="DataTable" rowspan=2 nowrap>Div</th>
         <th class="DataTable" rowspan=2 nowrap>Dpt</th>
         <th class="DataTable" rowspan=2 nowrap>Class-Ven-Sty</th>
         <th class="DataTable" rowspan=2>Desc</th>
         <th class="DataTable" rowspan=2>Manufacturer</th>
         <th class="DataTable" rowspan=2>Model</th>
         <th class="DataTable" colspan=2 nowrap>Sun & Ski<br>Site</th>
         <th class="DataTable" colspan=2 nowrap>Ski Chalet<br>Site</th>
      </tr>
      <tr  class="DataTable">
         <th class="DataTable">Exist</th>
         <th class="DataTable">Ready</th>
         <th class="DataTable">Exist</th>
         <th class="DataTable">Ready</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
      <%
        while( itmrmvl.getNext() )
        {
           int iNumOfItm = itmrmvl.getNumOfItm();

           if (iNumOfItm > 0)
           {
             itmrmvl.setItmList();
             String [] sDiv = itmrmvl.getDiv();
             String [] sDpt = itmrmvl.getDpt();
             String [] sCls = itmrmvl.getCls();
             String [] sVen = itmrmvl.getVen();
             String [] sSty = itmrmvl.getSty();
             String [] sDesc = itmrmvl.getDesc();
             String [] sMfg = itmrmvl.getMfg();
             String [] sModel = itmrmvl.getModel();
             String [] sSass = itmrmvl.getSass();
             String [] sSassReady = itmrmvl.getSassReady();
             String [] sSkch = itmrmvl.getSkch();
             String [] sSkchReady = itmrmvl.getSkchReady();
             String [] sRemove = itmrmvl.getRemove();
      %>
             <%for(int i=0; i < iNumOfItm; i++) {%>
               <tr class="DataTable">
                 <td class="DataTable">
                    <input type="checkbox" class="Small" name="Remove"
                       onClick="markRemove('<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', this)"
                       <%if(sRemove[i].equals("Y")){%>checked<%}%>>
                 </td>
                 <td class="DataTable"><%=sDiv[i]%></td>
                 <td class="DataTable"><%=sDpt[i]%></td>
                 <td class="DataTable"><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i]%></td>
                 <td class="DataTable"><%=sDesc[i]%></td>
                 <td class="DataTable"><%=sMfg[i]%></td>
                 <td class="DataTable"><%=sModel[i]%></td>
                 <td class="DataTable1"><%=sSass[i]%></td>
                 <td class="DataTable1"><%=sSassReady[i]%></td>
                 <td class="DataTable1"><%=sSkch[i]%></td>
                 <td class="DataTable1"><%=sSkchReady[i]%></td>
               </tr>
             <%}%>
        <%}%>
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
<%
    itmrmvl.disconnect();
    itmrmvl = null;
%>
<%}%>