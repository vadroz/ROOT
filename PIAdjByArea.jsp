<%@ page import="inventoryreports.PIAdjByArea, java.util.*"%>
<%
 String sSelDiv = request.getParameter("Div");
 String sSelStr = request.getParameter("Str");
 String sSelAdj = request.getParameter("Adj");
 String sSelNoCnt = request.getParameter("NoCnt");
 String sPiCal = request.getParameter("PiCal");
 String sSort = request.getParameter("Sort");

 if (sSelAdj == null){ sSelAdj = "0"; }
 if (sSelNoCnt == null){ sSelNoCnt = "0"; }
 if (sSort == null){ sSort = "Div"; }

//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=PIAdjByArea.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    
    System.out.println(sSelDiv +"|"+ sSelStr +"|"+ sSelAdj +"|"+ sSelNoCnt	+"|"+ sPiCal +"|"+ sSort +"|"+ sUser);
    
    PIAdjByArea adjarea = new PIAdjByArea(sSelDiv, sSelStr, sSelAdj, sSelNoCnt, sPiCal, sSort, sUser);
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}


        tr.DataTable { background:#ececec; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:darkred;}
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        .Small {font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;border: black solid 2px; width:200; background-color:#ccffcc; z-index:10;text-align:center; font-size:12px}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
    .Small {margin-top:3px; font-size:10px }

</style>
<script language="JavaScript1.2">

//--------------- Global variables -----------------------

//--------------- End of Global variables ----------------
function bodyLoad()
{
}
//==============================================================================
// show adjustment
//==============================================================================
function ShowAdjData(cls, ven, sty)
{
  var url="PIDtlAdj.jsp?STORE=<%=sSelStr%>"
  + "&DIVISION=ALL&DEPARTMENT=ALL"
  + "&CLASS=" + cls
  + "&VENDOR=" + ven
  + "&STYLE=" + sty
  + "&SORT=GROUP"
  + "&PICal=<%=sPiCal%>"
  + "&BYCHAIN=Y"

  //alert(url);
  window.open(url);
}
//==============================================================================
// re-sort report
//==============================================================================
function resort(sort)
{
   //PIAdjByArea.jsp?Div=ALL&Str=64&Adj=10&PiCal=201412
   //PIAdjByArea.jsp?Div=ALL&Str=64&Adj=10&PICal=201412&Sort=VendorNm
   var url="PIAdjByArea.jsp?Div=<%=sSelDiv%>"
    + "&Str=<%=sSelStr%>"
    + "&Adj=<%=sSelAdj%>"
    + "&PiCal=<%=sPiCal%>"
    + "&Sort=" + sort

  //alert(url);
  window.location.href = url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body onload="bodyLoad()">

 <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
<!-------------------------------------------------------------------->
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>PI Initial Review - Highest (by Division)
      <br>Store: <%=sSelStr%>
      <br></b>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="PIAdjByAreaSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
          <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp;
    </tr>
    <tr VALIGN="TOP">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      Highlighted <span style="background:pink;">Area #'s</span> are the Top 5% of areas in your Area Recount List.
<!-------------------------------------------------------------------->
      <table class="DataTable" border=1 cellPadding="0" cellSpacing="0" >
       <thead>
        <tr>
          <th class="DataTable" rowspan=2>
             <a href="javascript: resort('Div')">Div</a>
          </th>
	  <th class="DataTable" rowspan=2>
            <a href="javascript: resort('Item')">Long Item Number<br>Cls-Ven-Sty-Clr-Siz</a>;
          </th>
          <th class="DataTable" rowspan=2>Description<br>&nbsp;<br>&nbsp;</th>
          <th class="DataTable" rowspan=2>Vendor Style<br>&nbsp;<br>&nbsp;</th>
          <th class="DataTable" rowspan=2>
             <a href="javascript: resort('VendorNm')">Vendor<br>Name</a>
          </th>
          <th class="DataTable" rowspan=2>Short SKU<br>link to<br>(Sku History)</th>
          <th class="DataTable" rowspan=2>Alternate<br>UPC's</th>
          <th class="DataTable" rowspan=2>Counted<br>in Areas&nbsp;<br>&nbsp;</th>
          <th class="DataTable" rowspan=2>File<br>Retail</th>
          <th class="DataTable" colspan=2>Units</th>
          <th class="DataTable" colspan=4>Total Adjustments</th>
        </tr>

        <tr>
          <th class="DataTable">P.I.<br>Count</th>
          <th class="DataTable">Computer<br>On Hand</th>
          <th class="DataTable">Units</th>
          <th class="DataTable">Valued<br>Cost</th>
          <th class="DataTable">File<br>Retail</th>
          <th class="DataTable">A<br>d<br>j</th>
        </tr>
       </thead>
       <tbody style="overflow: auto">
<!------------------------------- Data Detail --------------------------------->
    <%String sSvDiv="";%>
    <%String sSvVen="";%>
    <%while(adjarea.getNext())
    {
      adjarea.getItmList();
      String sDiv = adjarea.getDiv();
      String sCls = adjarea.getCls();
      String sVen = adjarea.getVen();
      String sSty = adjarea.getSty();
      String sClr = adjarea.getClr();
      String sSiz = adjarea.getSiz();
      String sSku = adjarea.getSku();
      String sDesc = adjarea.getDesc();
      String sVenSty = adjarea.getVenSty();
      String sCost = adjarea.getCost();
      String sRet = adjarea.getRet();
      String sStrCost = adjarea.getStrCost();
      String sStrRet = adjarea.getStrRet();
      String sPhyInv = adjarea.getPhyInv();
      String sBookInv = adjarea.getBookInv();
      String [] sArea = adjarea.getArea();
      String [] sTop5Prc = adjarea.getTop5Prc();
      String sAdj = adjarea.getAdj();
      String sVenName = adjarea.getVenName();
      String sAdjCost = adjarea.getAdjCost();
      String sAdjRet = adjarea.getAdjRet();
      String sUpc = adjarea.getUpc();

    %>
      <!----------------- beginning of table ------------------------>
          <%if(!sSvDiv.equals(sDiv) && sSort.equals("Div") ||
               !sSvVen.equals(sVen) && sSort.equals("VendorNm")){%>
              <tr class="DataTable">
                <td style="background: white; font-size: 10px" colspan="16">&nbsp;</td>
              </tr>
             <%sSvDiv = sDiv;%>
             <%sSvVen = sVen;%>
          <%}%>
              <tr class="DataTable" id="trItem">
                <td class="DataTable"><%=sDiv%></td>
                <td class="DataTable1" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
                <td class="DataTable1" nowrap><%=sDesc%></td>
                <td class="DataTable1"><%=sVenSty%></td>
                <td class="DataTable1"><%=sVenName%></td>
                <td class="DataTable">
                	<a href="PIItmSlsHst.jsp?Sku=<%=sSku%>&STORE=<%=sSelStr%>&FromDate=01/01/0001&ToDate=12/31/2999&PICal=<%=sPiCal%>"><%=sSku%></a>
                </td>
                <td class="DataTable"><%=sUpc%></td>
                <td class="DataTable1">
                  <%String sComa="";%>
                  <%for(int i=0; i < sArea.length; i++){%><%=sComa%>
                  <a href="PIWIRep.jsp?STORE=<%=sSelStr%>&AREA=<%=sArea[i]%>&PICal=<%=sPiCal%>" target="_blank" 
                   <%if(sTop5Prc[i].equals("Y")){%>style="background:pink"<%}%> >&nbsp;<%=sArea[i]%>&nbsp;</a>
                  <%sComa=",";%><%}%>
                </td>
                <td class="DataTable2"><%=sStrRet%></td>
                <td class="DataTable2"><%=sPhyInv%></td>
                <td class="DataTable2"><%=sBookInv%></td>
                <td class="DataTable2"><%=sAdj%></td>
                <td class="DataTable2"><%=sAdjCost%></td>
                <td class="DataTable2"><%=sAdjRet%></td>
                <td class="DataTable2"><a href="javascript: ShowAdjData('<%=sCls%>','<%=sVen%>','<%=sSty%>') "> A </a></td>
              </tr>
           <%}%>
        </tbody>
      </table>
     </td>
    </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </form>
 </body>
</html>


<%
adjarea.disconnect();
adjarea = null;
}%>