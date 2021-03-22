<%@ page import="payrollreports.BfdgAvgWageSave, java.util.*, java.sql.*"%>
<%
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sSelBdgGrp = request.getParameter("BdgGrp");
   String sFrStr = request.getParameter("FrStr");
   String sToStr = request.getParameter("ToStr");

   String [] sStr = request.getParameterValues("Str");
   String [] sBdgGrp = request.getParameterValues("Bdg");
   String [] sSubGrp = request.getParameterValues("Sub");
   String [] sWeek = request.getParameterValues("Week");

   String [] sActStr = request.getParameterValues("ActStr");
   String [] sActBdg = request.getParameterValues("ActBdg");
   String [] sActSub = request.getParameterValues("ActSub");

   String sAction = request.getParameter("Action");
   String sApply = request.getParameter("Apply");

   Enumeration eQry = request.getParameterNames();


if (session.getAttribute("USER")!=null)
{
  String sUser = session.getAttribute("USER").toString();
  Hashtable htTyAvg = new Hashtable();
  Hashtable htLyAvg = new Hashtable();

  if(!sAction.equals("COPY_LY_CLC"))
  {
    while(eQry.hasMoreElements())
    {
       String sParam = (String)eQry.nextElement();
       String sValue = request.getParameter(sParam);

       if(sParam.indexOf("Avg") >= 0)
       {
          htTyAvg.put(sParam.substring(3), sValue);
       }
       else if(sParam.indexOf("PPLy") >= 0)
       {
          htLyAvg.put(sParam.substring(4), sValue);
       }
    }

    BfdgAvgWageSave bgavgwsav = new BfdgAvgWageSave();

    Enumeration eTyAvg = htTyAvg.keys();
    while(eTyAvg.hasMoreElements())
    {
        String key = (String) eTyAvg.nextElement();
        String sTYAvg = (String) htTyAvg.get(key);
        String sLYAvg = (String) htLyAvg.get(key);
        int is = key.indexOf("S");
        int ib = key.indexOf("B");
        int iw = key.indexOf("W");
        int ig = key.indexOf("G");

        boolean selstr = false;
        for(int i=0; i < sActStr.length; i++)
        {
           if(sActStr[i].equals(sStr[Integer.parseInt(key.substring(is+1, ib))])){selstr=true; break;}
        }
        boolean selbdg = false;
        for(int i=0; i < sActBdg.length; i++)
        {
           if(sActBdg[i].equals(sBdgGrp[Integer.parseInt(key.substring(ib+1, iw))])){selbdg=true; break;}
        }

        boolean selsub = false;
        for(int i=0; i < sActSub.length; i++)
        {
           if(sActSub[i].equals(sSubGrp[Integer.parseInt(key.substring(ig+1))])){selsub=true; break;}
        }

        if(selstr && selbdg && selsub)
        {
           String str = sStr[Integer.parseInt(key.substring(is+1, ib))];
           String bdg = sBdgGrp[Integer.parseInt(key.substring(ib+1, iw))];
           String wk =  sWeek[Integer.parseInt(key.substring(iw+1, ig))];
           String sub = sSubGrp[Integer.parseInt(key.substring(ig+1))];

           System.out.println(str + "|" + bdg + "|" + sub + "|" + wk + "|" + sTYAvg + "|" + sLYAvg
            + "|" + sApply + "|" + sAction + "|" + sUser);
           bgavgwsav.saveAvgWage(str, bdg, sub, wk, sTYAvg, sLYAvg, sApply, sAction, sUser);
        }
    }
  }
  else
  {
	 System.out.println(sAction + "|" + sUser); 
     BfdgAvgWageSave bgavgwsav = new BfdgAvgWageSave();
     for(int i=0; i < sStr.length; i++)
     {
         bgavgwsav.clcCommAvg(sStr[i], sWeek[0], sAction, sUser);
     }
  }
%>
<script language="javascript">
parent.window.location.reload();
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<%} else{%>
<script language="javascript">
  alert("Your session is expired. Please sign on.")
</script>

<%}%>