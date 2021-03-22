  <%@ page import="menu.XGame2012Weekly, java.util.*"%>
<%
    // Charts and table for div 1 challenage
    XGame2012Weekly xgamed = new XGame2012Weekly();
    int iNumOfWk = xgamed.getNumOfWk();
    String [] sWeeks = xgamed.getWeeks();
    String [] sMonths = xgamed.getMonths();

    String [] sMon = new String[]{"April", "May", "June", "July", "August", "September"
      , "Ocober", "November", "December", "January", "February" , "March"};
%>
<SCRIPT language="JavaScript1.2">

</SCRIPT>

<table id="tbGame" width="100%">
  <tr>
    <td align="center" colspan=2>
       <span style="color: blue; font-size:30px; font-weight:bold; text-decoration:underline">2012 X Games</span>
<br>
<!-- ===================================================================== -->
       <span style="color: brown; font-size:14px; font-weight:bold;">Podium</span>
<!-- ===================================================================== -->
       <br><a href="../" class="small"><font color="red" size="-1">Home</font></a>
     </td>
   </tr>
   <tr>
     <td width="30%">&nbsp;</td>
     <td align="left">

     <table border=1 id="tbWTDPodium" style="font-size:16px;text-align:center" cellPadding="0" cellSpacing="0">
     <%String SvMon = null; %>
     <%for(int i=0; i < iNumOfWk; i++){%>
       <%
          SvMon = sMonths[i];
          xgamed.getWeeklyGame();

          int iNumOfStr = xgamed.getNumOfStr();
          String [] sWeek = xgamed.getWeek();
          String [] sStr = xgamed.getStr();
          String [] sPlace = xgamed.getPlace();
          String [] sSales = xgamed.getSales();
          String [] sPlan = xgamed.getPlan();
          String [] sVar = xgamed.getVar();
       %>

         <tr >
           <%String sClr="white";%>
           <td style="background: white; padding:3px;"><%=sWeeks[i]%><td>

           <%for(int j=0; j < iNumOfStr; j++){%>
             <%
               if(sPlace[j].equals("G")){ sClr="gold";}
               else if(sPlace[j].equals("S")){sClr="silver";}
               else if(sPlace[j].equals("B")){sClr="#B8860B;";}
             %>
             <td style="background: <%=sClr%>; padding:3px;"><%=sStr[j]%><td>
           <%}%>
         </tr>
         <!-- ===================================================================== -->
         <!-- Month Totals -->
         <!-- ===================================================================== -->

         <%if(i < iNumOfWk-1 && !SvMon.equals(sMonths[i+1])){
              xgamed.getMonthlyGame();

              iNumOfStr = xgamed.getNumOfStr();

              sWeek = xgamed.getWeek();
              sStr = xgamed.getStr();
              sPlace = xgamed.getPlace();
              sSales = xgamed.getSales();
              sPlan = xgamed.getPlan();
              sVar = xgamed.getVar();
              int iMon = Integer.parseInt(sWeek[0].trim())-1;
         %>
           <tr>
             <%sClr="white";%>
             <td style="background: white; padding:3px;text-align:left;"><%=sMon[iMon]%><td>

             <%for(int j=0; j < iNumOfStr; j++){%>
               <%
                 if(sPlace[j].equals("G")){ sClr="gold";}
                 else if(sPlace[j].equals("S")){sClr="silver";}
                 else if(sPlace[j].equals("B")){sClr="#B8860B;";}
               %>
               <td style="background: <%=sClr%>; padding:3px;"><%=sStr[j]%><td>
             <%}%>
           </tr>
           <tr><td style="background: darkred; font-size:1px;" colspan=50>&nbsp;</td></tr>
         <%}%>
      <%}%>

      <!-- ===================================================================== -->
         <!-- Game Totals -->
         <!-- ===================================================================== -->
         <%
              xgamed.getMonthlyGame();
              int iNumOfStr = xgamed.getNumOfStr();
              String [] sWeek = xgamed.getWeek();
              String [] sStr = xgamed.getStr();
              String [] sPlace = xgamed.getPlace();
              String [] sSales = xgamed.getSales();
              String [] sPlan = xgamed.getPlan();
              String [] sVar = xgamed.getVar();
          %>
           <tr><td style="background: darkred; font-size:1px;" colspan=50>&nbsp;</td></tr>
           <tr>
             <%String sClr="white";%>
             <td style="background: white; padding:3px;">Game Total<br>Sales<br>Plan<br>Var<td>

             <%for(int j=0; j < iNumOfStr; j++){%>
               <%
                 if(sPlace[j].equals("G")){ sClr="gold";}
                 else if(sPlace[j].equals("S")){sClr="silver";}
                 else if(sPlace[j].equals("B")){sClr="#B8860B;";}
               %>
               <td style="background: <%=sClr%>; padding:3px;"><%=sStr[j]%>
                  <br><%=sSales[j]%><br><%=sPlan[j]%><br><%=sVar[j]%>%
               <td>
             <%}%>
           </tr>

      </table>
      </td>

    </td>
  </tr>
</table>
<script>
//var html = document.all.tbGame.outerHTML;
//parent.dvWinterChall.innerHTML = html;
</script>

