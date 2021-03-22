<%@ page import="payrollreports.MtxBdgAvgSave, java.util.*, java.sql.*"%>
<%
String [] sStr = request.getParameterValues("Str");
String [] sMon = request.getParameterValues("Mon");
String [] sGrp = request.getParameterValues("Grp");
String [] sAvg = request.getParameterValues("Avg");
String sCurMon = request.getParameter("CurMon");
String sAction = request.getParameter("Action");


String sAppl = "PRHIST";
if (session.getAttribute("USER") !=null && session.getAttribute(sAppl) != null)
{

    String sUser = session.getAttribute("USER").toString();

    MtxBdgAvgSave bmtxsav = new MtxBdgAvgSave();

    // Save company average wages
    if(sAction.equals("UPD_COMP_AVG"))
    {
       bmtxsav.saveCmpAvg(sGrp[0], sAvg[0], sAction, sUser);
    }
    // Save store average wages
    if(sAction.equals("UPD_STR_AVG"))
    {
       bmtxsav.saveStrAvg(sStr[0], sGrp, sAvg, sAction, sUser);
    }
    // Save store average wages just for one budget group
    if(sAction.equals("UPD_BDG_AVG"))
    {
       for(int i=0; i < sStr.length; i++)
       {
          bmtxsav.saveStrAvg(sStr[i], sGrp, new String[]{sAvg[i]}, "UPD_STR_AVG", sUser);
       }
    }

    // Save store monthly average wages
    if(sAction.equals("UPD_STR_MON_AVG"))
    {
       bmtxsav.saveMonAvg(sStr[0], sMon[0], sGrp, sAvg, sAction, sUser);
    }
    // Save store average wages just for one budget group and one month
    if(sAction.equals("UPD_MON_BDG_AVG"))
    {
       for(int i=0; i < sStr.length; i++)
       {
          bmtxsav.saveMonAvg(sStr[i], sMon[0], sGrp, new String[]{sAvg[i]}, "UPD_STR_MON_AVG", sUser);
       }
    }

    // apply company matrix to stores
    if(sAction.equals("APPLY_CMP_MTX") || sAction.equals("APPLY_STR_MTX_MON")
       || sAction.equals("APPLY_MON_MTX_BDG"))
    {
       System.out.println(sAction);
       bmtxsav.ApplyMtx(sStr, sGrp, sMon, sAction, sUser);
    }
    
 	// copy str/mon matrix to stores
    if(sAction.equals("COPY_MON_MTX_BDG"))
    {
       System.out.println(sAction);
       bmtxsav.CopyMtx(sStr, sGrp, sMon, sCurMon, sAction, sUser);
    }
%>
<script language="javascript">
var Action = "<%=sAction%>";

if(Action=="UPD_COMP_AVG")
{
   parent.restart();
}
if(Action == "UPD_STR_AVG" || Action == "UPD_STR_MON_AVG")
{
   parent.updStrBdgAvg();
}
if(Action == "UPD_BDG_AVG" || Action == "UPD_MON_BDG_AVG")
{
   parent.updGrpBdgAvg();
}
if(Action == "COPY_MON_MTX_BDG"){ parent.restart(); }	
</script>
<%
  bmtxsav.disconnect();
  bmtxsav = null;

}
  else {%>
  <script language="javascript">
    alert("Your session is expired, please sign on.")
  </script>
  <%}%>
