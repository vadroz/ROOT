<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekDay = request.getParameter("WKDATE");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sFrom = request.getParameter("FROM");
%>

<html>
<head>
<title>
SchDayOpr
</title>
<frameset rows="60%,40%">
<frame name="list" src="SchedbyDay.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWeekDay%>&FROM=<%=sFrom%>">
<frame name="entry" src="HoursEntry.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWeekDay%>&GRP=MNGR&FROM=<%=sFrom%>">
</frameset>
</head>
</html>
