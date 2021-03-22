<%@ page import="emptraining.TestQASave, java.util.*"%>
<%
   String sTest = request.getParameter("Test");
   String sQuest = request.getParameter("Quest");
   String sQstText = request.getParameter("QstText");
   String sAnswer = request.getParameter("Answer");
   String sAnswText = request.getParameter("AnswText");
   String sTrue = request.getParameter("True");
   String sAction = request.getParameter("Action");

   if(sQstText==null) { sQstText=" "; }
   if(sAnswer==null) { sAnswer="0"; }
   if(sAnswText==null) { sAnswText=" "; }
   if(sTrue==null) { sTrue=" "; }

   //System.out.println("|" + sTest + "|" + sQuest + "|" + sQstText + "|" + sAnswer
   //                 + "|" + sAnswText + "|" + sTrue + "|" + sAction + "|");
   TestQASave testqasv = new TestQASave(sTest, sQuest, sQstText, sAnswer, sAnswText, sTrue, sAction);
   testqasv.disconnect();
   testqasv = null;
%>






