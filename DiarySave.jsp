<%@ page import="diary.*, java.text.*,java.util.*"%>
<%
   String sDate = request.getParameter("Date");
   String sUser = request.getParameter("User");
   String sAction = request.getParameter("Action");

   String [] sSec = request.getParameterValues("Sec");
   String [] sSecData = new String[sSec.length];
   String [] sScore = new String[sSec.length];

   DiarySave diasav = new DiarySave(sDate, sUser, sAction);

   if(sAction.equals("ADD"))
   {

      for(int i=0; i < sSec.length; i++)
      {
         String sParam = "txa" + sSec[i];
         sSecData[i] = request.getParameter(sParam);
         sParam = "selAnsw" + sSec[i];
         sScore[i] = request.getParameter(sParam);

         diasav.saveSection(sSec[i], sScore[i], sSecData[i]);
      }
   }

   diasav.disconnect();
   diasav = null;
%>

<%for(int i=0; i < sSec.length; i++){
      String sParam = "txa" + sSec[i];
%>
  Section = <%=sSec[i]%> &nbsp;  Data = <%=sSecData[i]%>; Score = <%=sScore[i]%><br>
<%}%>

<SCRIPT language="JavaScript">
  parent.window.location.reload();
</SCRIPT>

