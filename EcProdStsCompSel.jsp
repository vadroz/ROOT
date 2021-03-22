<%@ page import="rciutility.RunSQLStmt, java.sql.*, rciutility.StoreSelect ,java.util.*, java.text.*"%>
<%
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EcProdStsCompSel.jsp&APPL=ALL");
}
else
{
    Vector vSaveDt = new Vector();
    String sStmt = "select SAVE_DATE"
        + " from rci.EcPrdHst"
        + " where SAVE_DATE <> '2099-12-31'"
        + " group by SAVE_DATE"
        + " order by SAVE_DATE desc"
        ;
    //System.out.println(sStmt);
    RunSQLStmt runsql = new RunSQLStmt();
    runsql.setPrepStmt(sStmt);
    ResultSet rs = runsql.runQuery();
    int iCount = 0;
    while(runsql.readNextRecord())
    {
       vSaveDt.add(runsql.getData("SAVE_DATE"));
    }
%>

<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var form = document.forms[0];
  var error = false;
  var msg = " ";

  var week1 = document.all.Week1.options[document.all.Week1.selectedIndex].value;
  var week2 = document.all.Week2.options[document.all.Week2.selectedIndex].value;

  if (error) { alert(msg) }
  else{ sbmReport(week1, week2) }
}
//==============================================================================
function sbmReport(week1, week2)
{
   url= "EComProdStsComp.jsp?Week1=" + week1
    + "&Week2=" + week2;

   //alert(url);
   window.location.href = url;
}
</script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce - Product Status Comparison Selection</B>

        <br><A class=blue href="/index.jsp">Home</A>

      <TABLE>
        <TBODY>
        <!-- ------------- Department  --------------------------------- -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell1">Weeks1:
             <select name="Week1" class="Small">
             <option value="12/31/2099">Current Date</option>
             <%for(int i=0; i < vSaveDt.size(); i++) {%>
                  <%
                     String sIso = vSaveDt.get(i).toString();
                     String sUsa = sIso.substring(5, 7) + "/" + sIso.substring(8) + "/" + sIso.substring(0, 4);
                  %>
                  <option value="<%=sUsa%>"><%=sUsa%></option>
             <%}%>
             </select>
             &nbsp; &nbsp;  &nbsp;  &nbsp;
             Weeks2:
             <select name="Week2" class="Small">
             <option value="12/31/2099">Current Date</option>
             <%for(int i=0, j=0; i < vSaveDt.size(); i++, j++) {%>
                  <%
                     String sIso = vSaveDt.get(i).toString();
                     String sUsa = sIso.substring(5, 7) + "/" + sIso.substring(8) + "/" + sIso.substring(0, 4);
                  %>
                  <option value="<%=sUsa%>"><%=sUsa%></option>
             <%}%>
             </select>

          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px">&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD align=center>
               <button onclick="Validate()">Submit</button>
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