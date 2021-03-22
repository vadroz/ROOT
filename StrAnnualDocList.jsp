<%@ page import="rciutility.StoreSelect, java.io.File, java.util.*, rciutility.RunSQLStmt"%>
<%
Date sessDate = null;
long lElapse = 99999;

if(session.getAttribute("DATE")!=null)
{
  sessDate = (Date)session.getAttribute("DATE");
  lElapse = (new Date()).getTime() -   sessDate.getTime();
}

if (session.getAttribute("USER")==null || session.getAttribute("EMPSALARY")==null || lElapse > 3000)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrAnnualDocList.jsp&APPL=ALL");
}
else
{

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   String sStrAllowed = session.getAttribute("STORE").toString();
   String sUser = session.getAttribute("USER").toString();

   if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
   {
     StrSelect = new StoreSelect(10);
   }
   else
   {
       Vector vStr = (Vector) session.getAttribute("STRLST");
       String [] sStrAlwLst = new String[ vStr.size()];
       Iterator iter = vStr.iterator();

       int iStrAlwLst = 0;
       while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

       if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
       else StrSelect = new StoreSelect(new String[]{sStrAllowed});

   }

    int iNumOfStr = StrSelect.getNumOfStr();
    String [] sStrLst = StrSelect.getStrLst();
    String [] sStrEncLst = new String[iNumOfStr];
    String [] sRegLst = new String[iNumOfStr];

    RunSQLStmt runsql = new RunSQLStmt();
    String stmt = "select sstr, sreg, Enc_Num"
     + " from rci.InStrEnc inner join iptsfil.ipStore on store = sstr"
     + " where store in(";
    String sComa = "";
    for(int i=0; i < iNumOfStr; i++)
    {
      stmt += sComa + sStrLst[i];
      sComa = ",";
    }
    stmt += ")";

    //out.println(stmt);

    runsql.setPrepStmt(stmt);
    runsql.runQuery();

   int iArg = 0;
   Vector<String> vStr = new Vector<String>();
   Vector<String> vFolder = new Vector<String>();
   Vector<String> vReg = new Vector<String>();
   while(runsql.readNextRecord())
   {
	  vStr.add(runsql.getData("sstr"));
	  vReg.add(runsql.getData("sreg"));
	  vFolder.add(runsql.getData("Enc_Num"));
	  iArg++;
   }
%>

<meta http-equiv="refresh" content="10; url=index.jsp">


<script type="text/javascript">
</script>

<body>
<table width="100%" border=0>
    <tr bgColor="ivory">
       <td ALIGN="center" VALIGN="TOP" width="10%">
         <b>Retail Concepts Inc.
         <br>Link to Store Employee Annual Review Document Folder
         </b>
       </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
         <a href="index.jsp"><font color="red" size="-1">Home</font></a>
         <br>
      </td>
   </tr>
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
        <%if (sStrAllowed != null && sStrAllowed.startsWith("ALL")){%>
            <a href="\\rciweba\review$" target="_blank">Annual Review Documents</a>
        <%}
        else{%>
            <%for(int i=0; i < vStr.size(); i++){%>
                <a href="\\rciweba\<%=vFolder.get(i)%>$" target="_blank">Annual Review Documents for Store <%=vStr.get(i)%></a><br>
            <%}%>
        <%}%>
         <br>
      </td>
   </tr>
</table>

<%}%>

