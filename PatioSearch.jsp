<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   int iNumOfItm = 0;
   String [] sCls = null;
   String [] sVen = null;
   String [] sSty = null;
   String [] sClr = null;
   String [] sSiz = null;
   String [] sSku = null;
   String [] sItmDsc = null;
   String [] sVenSty = null;
   String [] sVenName = null;
   String [] sUpc = null;
   String [] sRet = null;
   String [] sOnHand = null;

   boolean bKiosk = session.getAttribute("USER") == null;
   String sUser = "KIOSK";
   if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }

   ResultSet rslset = null;
    RunSQLStmt runsql = new RunSQLStmt();

    String sPO = "0000000000";
    sPO = sPO.substring(0, 10 - sPONum.length()) + sPONum;

    String sPrepStmt = "select PDRCVDT, PDVSTY, PDUPC, PDSKU, PDDESC, PDCLRNM, PDSIZNM"
      + ", PDRQTY, PDRECUS, PDRECDT, PDRECTM"
      + " from rci.PoRcvD"
      + " where PdPoNum = " + sPO
      + " order by PDRCVDT desc, PDVSTY";

    System.out.println(sPrepStmt);

    runsql.setPrepStmt(sPrepStmt);
    runsql.runQuery();
    Vector vRcvDt = new Vector();
    Vector vVenSty = new Vector();
    Vector vUpc = new Vector();
    Vector vSku = new Vector();
    Vector vDesc = new Vector();
    Vector vClrNm = new Vector();
    Vector vSizNm = new Vector();
    Vector vRcvQty = new Vector();

    while(runsql.readNextRecord())
    {
       java.util.Date dWkend = sdfISO.parse(runsql.getData("PdRcvDt"));
       vRcvDt.add(sdfUSA.format(dWkend));
       vVenSty.add(runsql.getData("PdVSty"));
       vUpc.add(runsql.getData("PdUpc"));
       vSku.add(runsql.getData("PdSku"));
       vDesc.add(runsql.getData("PdDesc"));
       vClrNm.add(runsql.getData("PdClrNm"));
       vSizNm.add(runsql.getData("PdSizNm"));
       vRcvQty.add(runsql.getData("PdRQty"));
    }

    Iterator it = vRcvDt.iterator();
    int iSize = vRcvDt.size();
    String [] sRcvDt = new String[iSize];
    String [] sVenSty = new String[iSize];
    String [] sUpc = new String[iSize];
    String [] sSku = new String[iSize];
    String [] sDesc = new String[iSize];
    String [] sClrNm = new String[iSize];
    String [] sSizNm = new String[iSize];
    String [] sRcvQty = new String[iSize];

    vRcvDt.toArray((String []) sRcvDt);
    vVenSty.toArray((String []) sVenSty);
    vUpc.toArray((String []) sUpc);
    vSku.toArray((String []) sSku);
    vDesc.toArray((String []) sDesc);
    vClrNm.toArray((String []) sClrNm);
    vSizNm.toArray((String []) sSizNm);
    vRcvQty.toArray((String []) sRcvQty);

    runsql.disconnect();
    runsql = null;


%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:WhiteSmoke; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px;
                       border-right: darkred solid 1px;
                       text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px;
                       border-right: darkred solid 1px;
                       text-align:right;}

        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}

        select.Small {font-family:Arial; font-size  :10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<script language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//--------------------------------------------------------
// populate some fields on beginning
//--------------------------------------------------------
function bodyLoad()
{
}
</script>
</head>

<body onload="bodyLoad()">

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Vendor: <select name="selVen"></select>
      </b>

      <!-- ---------------------------------------------------------------- -->
      <!-- ---------------------------------------------------------------- -->

     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan=3>

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
            <th class="DataTable" nowrap>Class-Ven-Sty</th>
            <th class="DataTable" nowrap>Color</th>
            <th class="DataTable" nowrap>Size</th>
            <th class="DataTable">Short SKU</th>
            <th class="DataTable">UPC</th>
            <th class="DataTable">Item Description</th>
            <th class="DataTable">Vendor Style</th>
            <th class="DataTable">Vendor Name</th>
            <th class="DataTable">Chain<br>Retail</th>
            <th class="DataTable">Chain<br>On Hands</th>
            <th class="DataTable">Store<br>On Hands</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfItm; i++) {%>
              <tr class="DataTable">
                <td class="DataTable" onClick="getSelectedItem('<%=sSku[i]%>')" nowrap>
                         <%=sCls[i] + "-" + sVen[i] + "-" + sSty[i]%></td>
                <td class="DataTable" nowrap><%=sClr[i]%></td>
                <td class="DataTable" nowrap><%=sSiz[i]%></td>
                <td class="DataTable" nowrap><%=sSku[i]%></td>
                <td class="DataTable" nowrap><%=sUpc[i]%></td>
                <td class="DataTable" nowrap><%=sItmDsc[i]%></td>
                <td class="DataTable" nowrap><%=sVenSty[i]%></td>
                <td class="DataTable" nowrap><%=sVenName[i]%></td>
                <td class="DataTable1" nowrap><%=sRet[i]%></td>
                <td class="DataTable1" nowrap><%=sOnHand[i]%></td>
                <td class="DataTable1" nowrap>
                   <a href="servlet/onhand01.OnHands03?STORE=03&CLASS=<%=sCls[i]%>&VENDOR=<%=sVen[i]%>&STYLE=<%=sSty[i]%>&User=<%=sUser%>&OutSlt=HTML">
                      by Item
                   </a>
                </td>
              </tr>
           <%}%>
      </table>
      <% if(iNumOfItm < 14) {
           for(int i=0; i < 14; i++){%>
              <br>
      <%   }
        }%>
   <br>
      <!----------------------- end of table ------------------------>
  </table>

 </body>
</html>
