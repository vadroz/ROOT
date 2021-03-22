<%@ page import="menu.AlertClient, java.text.*, java.util.*"%>
<%
     AlertClient alClient = new AlertClient();

     int iNumOfMsg = alClient.getNumOfMsg();
     String [] sDate = alClient.getDate();
     String [] sTime = alClient.getTime();
     String [] sText = alClient.getText();
     String [] sFont = alClient.getFont();
     String [] sColor = alClient.getColor();
     String [] sBgClr = alClient.getBgClr();
     alClient = null;
%>
<%if(iNumOfMsg == 0) {%>[[@!#NONE#!@]]<%}%>
<%for(int i=0; i < iNumOfMsg; i++){%>
        <div style="font-size:<%=sFont[i]%>px;color:<%=sColor[i]%>; background:<%=sBgClr[i]%>">
             <blink><%=sText[i]%></blink> &nbsp; &nbsp;
             <span style="font-size:12px">Started: <%=sDate[i] + " " + sTime[i]%></span>
          </div>
<%}%>