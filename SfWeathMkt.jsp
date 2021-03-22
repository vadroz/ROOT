<%@ page import="strforce.SfWeathLst, rciutility.StoreSelect, java.util.*, java.text.*
,java.text.SimpleDateFormat"%>
<%
   String sMkt = request.getParameter("mkt");
   String [] sWk = request.getParameterValues("wk");
   String sMktNm = request.getParameter("nm");
     
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
		 
	SfWeathLst sfwth = new SfWeathLst();
	sfwth.setWeathMkt(sMkt, sWk);
	
	String [][] sAvg = new String[3][8];
	String [][] sSls = new String[3][8];
	String [][] sTrf = new String[3][8];

	sfwth.setWeathMkt(sMkt, sWk);
	for(int i=0; i < 3; i++)
	{		 
		sfwth.setSngMktAvg();
		sAvg[i] = sfwth.getAvg();
		sSls[i] = sfwth.getSls();
		sTrf[i] = sfwth.getTrf();
	}
	
	String sAvgJsa = sfwth.cvtTo2DimensionJSA(sAvg);
	String sSlsJsa = sfwth.cvtTo2DimensionJSA(sSls);
	String sTrfJsa = sfwth.cvtTo2DimensionJSA(sTrf);
	String sWkJsa = sfwth.cvtToJavaScriptArray(sWk);
	
	sfwth.disconnect();
	sfwth = null;

%>
<SCRIPT>
var wk =  [<%=sWkJsa%>];
var avg = [<%=sAvgJsa%>];
var sls = [<%=sSlsJsa%>];
var trf = [<%=sTrfJsa%>];
var mktnm = "<%=sMktNm%>"

parent.showHistTemp(mktnm, wk, avg, sls, trf);

</SCRIPT>
<%} else { %>alert("Your session is expired. Please login again.");<%}%>