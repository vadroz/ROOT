<%@ page import="java.util.*, eventcalendar.EvtCalOnFlashSls"%>
<%
    String sDate = request.getParameter("Date");
    //System.out.println(sDate);
    EvtCalOnFlashSls evtcal = new EvtCalOnFlashSls(sDate);

    String sYearJsa = evtcal.getYearJsa();
    String sColJsa = evtcal.getColJsa();
    String sEventJsa = evtcal.getEventJsa();
    String sFromJsa = evtcal.getFromJsa();
    String sToJsa = evtcal.getToJsa();
    String sEvtTextJsa = evtcal.getEvtTextJsa();

    String sEvtMemo = evtcal.getEvtMemoJsa();
    String sEvtSign = evtcal.getEvtSignJsa();
    String sEvtTrack = evtcal.getEvtTrackJsa();

    // Attached Advertising
    String sAdvMkt = evtcal.getAdvMktJsa();
    String sAdvOrgWk = evtcal.getAdvOrgWkJsa();
    String sAdvMedia = evtcal.getAdvMediaJsa();
    String sAdvMedDesc = evtcal.getAdvMedDescJsa();
    String sAdvPType = evtcal.getAdvPTypeJsa();
    String sAdvPDesc = evtcal.getAdvPDescJsa();
    String sAdvSeq = evtcal.getAdvSeqJsa();
    String sAdvPayee = evtcal.getAdvPayeeJsa();
    String sAdvMktName = evtcal.getAdvMktNameJsa();
    String sAdvDoc = evtcal.getAdvDocJsa();

    evtcal.disconnect();
%>


<SCRIPT language="JavaScript1.2">
var Year = [<%=sYearJsa%>];
var Column = [<%=sColJsa%>];
var Event  = [<%=sEventJsa%>];
var From = [<%=sFromJsa%>];
var To = [<%=sToJsa%>];
var EvtText = [<%=sEvtTextJsa%>];
var EvtMemo = [<%=sEvtMemo%>];
var EvtSign = [<%=sEvtSign%>];
var EvtTrack = [<%=sEvtTrack%>];

// Advertising
var AdvMkt = [<%=sAdvMkt%>];
var AdvOrgWk = [<%=sAdvOrgWk%>];
var AdvMedia = [<%=sAdvMedia%>];
var AdvMedDesc = [<%=sAdvMedDesc%>];
var AdvPType = [<%=sAdvPType%>];
var AdvPDesc = [<%=sAdvPDesc%>];
var AdvSeq = [<%=sAdvSeq%>];
var AdvPayee = [<%=sAdvPayee%>];
var AdvMktName = [<%=sAdvMktName%>];
var AdvDoc = [<%=sAdvDoc%>];

popParentPage()

//==============================================================================
// Load initial value on page
//==============================================================================
function popParentPage()
{
   parent.popEvtCalArr(Column, Event, From, To, EvtText, EvtMemo, EvtSign, EvtTrack
     ,AdvMkt, AdvOrgWk, AdvMedia, AdvMedDesc, AdvSeq, AdvPayee, AdvMktName, AdvDoc, Year);
}
</script>