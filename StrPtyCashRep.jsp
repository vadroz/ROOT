<%@ page import="storepettycash.StrPtyCashRep, java.util.*"%>
<%
    String sFrom = request.getParameter("FrWkEnd");
    String sTo = request.getParameter("ToWkEnd");
//----------------------------------
// Application Authorization
//----------------------------------
String sAppl = "PTYCSHAP";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !(session.getAttribute(sAppl) == null))
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrPtyCashRep.jsp");
}
else
{
    StrPtyCashRep strpty = new StrPtyCashRep(sFrom, sTo, session.getAttribute("USER").toString());

    int iNumOfTyp = strpty.getNumOfTyp();
    String [] sPtyType = strpty.getPtyType();
    String [] sPtyTypeDesc = strpty.getPtyTypeDesc();
    String [] sPtyTypeColHdg1 = strpty.getPtyTypeColHdg1();
    String [] sPtyTypeColHdg2 = strpty.getPtyTypeColHdg2();

    int iNumOfSpf = strpty.getNumOfSpf();
    String [] sSpiffType = strpty.getSpiffType();
    String [] sSpiffDesc = strpty.getSpiffDesc();
    String [] sSpiffColHdg1 = strpty.getSpiffColHdg1();
    String [] sSpiffColHdg2 = strpty.getSpiffColHdg2();

    int iNumOfStr = strpty.getNumOfStr();
    String [] sStr = strpty.getStr();
    String [][] sPtyAmt = strpty.getPtyAmt();
    String [][] sSpfAmt = strpty.getSpfAmt();
    String [] sStrSpent = strpty.getStrSpent();

    String sTotSpent = strpty.getTotSpent();
    String [] sTotPty = strpty.getTotPty();
    String [] sTotSpf = strpty.getTotSpf();

    boolean bAPDept = session.getAttribute("PTYCSHAP") != null;
%>

<HTML>
<HEAD>
<title>Store Petty Cash</title>
<META content="RCI, Inc." name="Store_Petty_Cash"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding-top:3px; padding-bottom:3px; text-align:center; font-size:11px;}
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:10px }
        th.DataTable4 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:10px }
        th.DataTable5 { background:#82caff ;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:10px }

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:12px; font-weight: bold }
        tr.DataTable2 { background: Azure; font-size:10px; font-weight: bold }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { background: #b0b0b0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEntry { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
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
        td.Comments { background: white; text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
</style>


<script name="javascript1.3">
var DisplayComments = "block";
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEntry", ["dvStatus"]]);
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvEntry.innerHTML = " ";
   document.all.dvEntry.style.visibility = "hidden";
}

</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>



<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvEntry" class="dvEntry"></div>
<div id="dvStatus" class="dvEntry"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Store Petty Cash Summary Report
        <br>From Weekending: <%=sFrom %>  To Weekending: <%=sTo%><br>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="StrPtyCashRepSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp; &nbsp;
        </button>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
            <th class="DataTable" rowspan=2>Store</th>
            <th class="DataTable" colspan=<%=iNumOfTyp%>>Pay Entry Types</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=<%=iNumOfSpf%>>Spiff Types</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" rowspan=2>Spent</th>
         </tr>

         <tr class="DataTable">
            <%for(int j=0; j < iNumOfTyp; j++ ){%>
               <th class="DataTable"><%=sPtyTypeColHdg1[j]%><br><%=sPtyTypeColHdg2[j]%></th>
            <%}%>
            <%for(int j=0; j < iNumOfSpf; j++ ){%>
               <th class="DataTable"><%=sSpiffColHdg1[j]%><br><%=sSpiffColHdg2[j]%></th>
            <%}%>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfStr; i++ ){%>
           <tr class="DataTable">
              <td class="DataTable2" nowrap><%=sStr[i]%></td>
              <%for(int j=0; j < iNumOfTyp; j++ ){%>
                 <td class="DataTable2"><%=sPtyAmt[i][j]%></td>
              <%}%>
              <th class="DataTable">&nbsp;</th>
              <%for(int j=0; j < iNumOfSpf; j++ ){%>
                 <td class="DataTable2"><%=sSpfAmt[i][j]%></td>
              <%}%>
              <th class="DataTable">&nbsp;</th>
              <td class="DataTable2"><%=sStrSpent[i]%></td>
           </tr>
       <%}%>
       <!-- ============================ Total =========================== -->
       <tr class="DataTable1">
           <td class="DataTable2" nowrap>Total</td>
           <%for(int j=0; j < iNumOfTyp; j++ ){%>
              <td class="DataTable2"><%=sTotPty[j]%></td>
           <%}%>
           <th class="DataTable">&nbsp;</th>
           <%for(int j=0; j < iNumOfSpf; j++ ){%>
              <td class="DataTable2"><%=sTotSpf[j]%></td>
           <%}%>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable2"><%=sTotSpent%></td>
         </tr>
     </table>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   strpty.disconnect();
   strpty = null;
   }
%>