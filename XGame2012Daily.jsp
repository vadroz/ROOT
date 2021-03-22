  <%@ page import="menu.XGame2012Daily, java.util.*"%>
<%
    String sDate = request.getParameter("Date");
    String sSort = request.getParameter("Sort");
    if (sSort == null) sSort = "GAME";
    if (sDate == null) sDate = "LASTDATE";

    // Charts and table for div 1 challenage
    XGame2012Daily xgamed = new XGame2012Daily(sDate, sSort);

%>
<SCRIPT language="JavaScript1.2">

</SCRIPT>

<table id="tbGame">
  <tr>
    <td align="center">
       <span>
          <a href="XGame2012Weekly.jsp" style="font-size:20px; font-weight:bold;">2012 X Games</a>
       </span>
    </td>
  </tr>
  <tr>
    <td align="center">
    <table border=0 id="tbPodium" style="font-size:10px;" cellPadding="0" cellSpacing="0">
         <tr>
           <td align="center">
<!-- ===================================================================== -->
       <span style="color: brown; font-size:12px; font-weight:bold;">Podium - Week to Date</span>
<!-- ===================================================================== -->

       <%
          xgamed.getDailyPlace("0");
          int iNumOfPlace = xgamed.getNumOfPlace();
          String [] sStr = xgamed.getStr();
          String [] sReg = xgamed.getReg();
          String [] sPlace = xgamed.getPlace();
       %>

       <table border=1 id="tbWTDPodium" style="font-size:10px;" cellPadding="0" cellSpacing="0">
         <tr >
           <%String sClr="white";%>
           <%for(int i=0; i < iNumOfPlace; i++){%>
             <%
               if(sPlace[i].equals("G")){ sClr="gold";}
               else if(sPlace[i].equals("S")){sClr="silver";}
               else if(sPlace[i].equals("B")){sClr="#B8860B;";}
             %>

             <td style="background: <%=sClr%>; padding:3px;"><%=sStr[i]%><td>
           <%}%>
         </tr>
       </table>
      </td>
      <td> &nbsp;  &nbsp;  &nbsp; </td>
      <td align="center">
<!-- ===================================================================== -->
       <span style="color: brown; font-size:12px; font-weight:bold;">Podium - Last Week</span>
<!-- ===================================================================== -->

       <%
          xgamed.getDailyPlace("1");
          iNumOfPlace = xgamed.getNumOfPlace();
          sStr = xgamed.getStr();
          sReg = xgamed.getReg();
          sPlace = xgamed.getPlace();
       %>

       <table border=1 id="tbWTDPodium" style="font-size:10px;" cellPadding="0" cellSpacing="0">
         <tr >
           <%sClr="white";%>
           <%for(int i=0; i < iNumOfPlace; i++){%>
             <%
               if(sPlace[i].equals("G")){ sClr="gold";}
               else if(sPlace[i].equals("S")){sClr="silver";}
               else if(sPlace[i].equals("B")){sClr="#B8860B;";}
             %>

             <td style="background: <%=sClr%>; padding:3px;"><%=sStr[i]%><td>
           <%}%>
         </tr>
       </table>
      </td>
     </tr>
   </table>
<!-- ===================================================================== -->
       <span style="color: brown; font-size:12px; font-weight:bold;">Comp Stores Game Results</span>
<!-- ===================================================================== -->
       <%
         xgamed.getDailyGame("1");

         int iNumOfGame = xgamed.getNumOfGame();
         String [] sGame = xgamed.getGame();
         String [] sStr1 = xgamed.getStr1();
         String [] sStr2 = xgamed.getStr2();
         String [] sVar1 = xgamed.getVar1();
         String [] sVar2 = xgamed.getVar2();
         String [] sWin1 = xgamed.getWin1();
         String [] sWin2 = xgamed.getWin2();
       %>

       <table border=1 id="tbCompStr" style="font-size:10px;" cellPadding="0" cellSpacing="0">
         <tr >
           <%boolean bClr=true;%>
           <%sClr=null;%>
           <%String sBgImage=null;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>

             <th style="background: <%=sClr%>; background-image:url('<%=sBgImage%>'); padding:3px;">Store<th>
             <th style="background: <%=sClr%>; padding:3px;">Var<th>
             <th style="background: blue;">&nbsp;</th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>

         <tr style="background: white">
           <%bClr=true;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <%if(sWin1[i].equals("1")){ sBgImage = "/MainMenu/Flag.jpg"; } else { sBgImage = "none";}%>

             <td style="background: <%=sClr%>; background-image:url('<%=sBgImage%>'); background-repeat:no-repeat; padding:3px;"><%=sStr1[i]%><td>
             <td style="background: <%=sClr%>; padding:3px;"><%=sVar1[i]%>%<td>
             <th style="background: blue;">&nbsp;</td>
             <%bClr=!bClr;%>
           <%}%>
         </tr>

         <tr style="background: white">
           <%bClr=true;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <td style="background: <%=sClr%>; text-align:center;" colspan=3>vs.<th>
             <th style="background: blue;">&nbsp;</th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>


         <tr style="background: white">
           <%bClr=true;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <%if(sWin2[i].equals("1")){ sBgImage = "/MainMenu/Flag.jpg"; } else { sBgImage = "none";}%>

             <td style="background: <%=sClr%>; background-image:url('<%=sBgImage%>'); background-repeat:no-repeat; padding:3px;"><%=sStr2[i]%><th>
             <td style="background: <%=sClr%>; padding:3px;"><%=sVar2[i]%>%<th>
             <th style="background: blue;">&nbsp;</th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>
       </table>


  <!-- ===================================================================== -->
       <span style="color: brown; font-size:12px; font-weight:bold;">New Stores Game Results</span>
  <!-- ===================================================================== -->
       <%
         xgamed.getDailyGame("2");

         iNumOfGame = xgamed.getNumOfGame();
         sGame = xgamed.getGame();
         sStr1 = xgamed.getStr1();
         sStr2 = xgamed.getStr2();
         sVar1 = xgamed.getVar1();
         sVar2 = xgamed.getVar2();
         sWin1 = xgamed.getWin1();
         sWin2 = xgamed.getWin2();
       %>

       <table border=1 id="tbNewStr" style="font-size:10px;" cellPadding="0" cellSpacing="0">
         <tr >
           <%bClr=true;%>
           <%sClr=null;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <th style="background: <%=sClr%>; padding:3px;">Store<th>
             <th style="background: <%=sClr%>; padding:3px;">Var<td>
             <th style="background: blue;">&nbsp;</th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>

         <tr style="background: white">
           <%bClr=true;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <%if(sWin1[i].equals("1")){ sBgImage = "/MainMenu/Flag.jpg"; } else { sBgImage = "none";}%>

             <td style="background: <%=sClr%>; background-image:url('<%=sBgImage%>'); background-repeat:no-repeat; padding:3px;"><%=sStr1[i]%><th>
             <td style="background: <%=sClr%>; padding:3px;"><%=sVar1[i]%>%<th>
             <th style="background: blue;">&nbsp;</th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>

         <tr style="background: white">
           <%bClr=true;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <td style="background: <%=sClr%>; text-align:center;" colspan=3>vs.<th>
             <th style="background: blue;">&nbsp;</th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>

         <tr style="background: white">
           <%bClr=true;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <%if(sWin2[i].equals("1")){ sBgImage = "/MainMenu/Flag.jpg"; } else { sBgImage = "none";}%>

             <td style="background: <%=sClr%>; background-image:url('<%=sBgImage%>'); background-repeat:no-repeat; padding:3px;"><%=sStr2[i]%><th>
             <td style="background: <%=sClr%>; padding:3px;"><%=sVar2[i]%>%<th>
             <th style="background: blue;">&nbsp;</th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>
       </table>
<!-- ===================================================================== -->
       <span style="color: brown; font-size:12px; font-weight:bold;">ECom Store Game Result</span>
<!-- ===================================================================== -->
       <%
         xgamed.getDailyGame("3");

         iNumOfGame = xgamed.getNumOfGame();
         sGame = xgamed.getGame();
         sStr1 = xgamed.getStr1();
         sStr2 = xgamed.getStr2();
         sVar1 = xgamed.getVar1();
         sVar2 = xgamed.getVar2();
         sWin1 = xgamed.getWin1();
         sWin2 = xgamed.getWin2();
       %>

       <table border=1 id="tbStr70" style="font-size:10px;" cellPadding="0" cellSpacing="0">
         <tr >
           <%bClr=true;%>
           <%sClr=null;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <th style="background: <%=sClr%>; padding:3px;">Store<th>
             <th style="background: <%=sClr%>; padding:3px;">Var<th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>

         <tr style="background: white">
           <%bClr=true;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <%if(sWin1[i].equals("1")){ sBgImage = "/MainMenu/Flag.jpg"; } else { sBgImage = "none";}%>

             <td style="background: <%=sClr%>; background-image:url('<%=sBgImage%>'); background-repeat:no-repeat; padding:3px;"><%=sStr1[i]%><td>
             <td style="background: <%=sClr%>; padding:3px;"><%=sVar1[i]%>%<th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>

         <tr style="background: white">
           <%bClr=true;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <td style="text-align:center;" colspan=3>vs.<th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>

         <tr style="background: white">
           <%bClr=true;%>
           <%for(int i=0; i < iNumOfGame; i++){%>
             <%if(bClr){ sClr = "white"; } else { sClr = "#ccffcc;"; }%>
             <td style="background: <%=sClr%>; padding:3px;">Company<th>
             <td style="background: <%=sClr%>; padding:3px;"><%=sVar2[i]%>%<th>
             <%bClr=!bClr;%>
           <%}%>
         </tr>
       </table>
    </td>
  </tr>
</table>
<script>
var html = document.all.tbGame.outerHTML;
parent.dvWinterChall.innerHTML = html;
</script>

