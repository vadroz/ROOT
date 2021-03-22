<%@ page import="payrollreports.PayEntryStrSum, java.util.*, java.text.*"%>
<%
   String sWeekend = request.getParameter("Week");   
   String sType = request.getParameter("Type");
   
   if(sType==null){ sType = "Labor";}
  
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=PayEntryStrSum.jsp&APPL=ALL");
}
else
{
   String sUser = session.getAttribute("USER").toString();


   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Date date = sdf.parse(sWeekend);
   date = new Date(date.getTime() - 86400000 * 7);
   String [] sDateOfWk = new String[7];

   for(int i=0; i < 7; i++)
   {
      date = new Date(date.getTime() + 86400000);
      sDateOfWk[i] = sdf.format(date);
   }

	PayEntryStrSum payent = new PayEntryStrSum(sWeekend, sType, sUser);

    // payment type headings
    int iNumOfPyTy = payent.getNumOfPyTy();
    String [] sPyTy = payent.getPyTy();
    String [] sPyTyNm = payent.getPyTyNm();
    
    // employee with entered labor payments
    int iNumOfStr = payent.getNumOfStr();

    String [] sDayOfWk = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
    
    String sSpan1 = "7";
    String sSpan2 = "1";
    if(sType.equals("Bike"))
    {
    	sSpan1 = "14";
        sSpan2 = "2";    	
    }
%>

<html>
<head>
<title>Store Labor Entry</title>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Type= "<%=sType%>"
//--------------- End of Global variables ----------------

//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
}
</SCRIPT>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script type='text/javascript'>//<![CDATA[
                                          
var TblWithFxd = "#tbl01";
var FixedHdrFtr = {hdr: ["#trTopHdr1", "#trTopHdr2", "#trTopHdr3", "#trTopHdr4", "#trTopHdr5"]
                 , footer: ["#trFoot"], bottom:["#trFoot1"]};
                 
var FootAdjustment = 200;
if(Type == "Bike"){ FootAdjustment = 220; }

$(window).load(function(){
	var tableOffset = $(TblWithFxd).offset().top;

	// made relative position for header and footer
	for(i in  FixedHdrFtr.hdr)	{ $(FixedHdrFtr.hdr[i]).css("position", "relative"); }	
	for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).css("position", "relative"); }
		
	var height = $(window).height();
	var footTop = $('body').scrollTop() + height-FootAdjustment;
	for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).css("top", footTop); }
		
	$(window).bind("scroll", function() 
	{
		var offset = $(this).scrollTop();
		var hdrPos = $('body').scrollTop();
		var tblHgt = $(TblWithFxd).height();
		
		if (offset >= tableOffset) 
		{
			for(i in  FixedHdrFtr.hdr)	{ $(FixedHdrFtr.hdr[i]).css("top", hdrPos-20); }					
		}
	    else if (offset < tableOffset) 
	    {
	    	for(i in  FixedHdrFtr.hdr)	{ $(FixedHdrFtr.hdr[i]).css("top", hdrPos-2); }	    	 	
	    }
		
		var footTop = $(FixedHdrFtr.bottom[0]).offset().top;
		var height = $(window.top).height();
		if (offset + height >= footTop)	
		{
			for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).hide(); }			
		}
		else 
		{ 
			for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).show(); }			
		}
						
		var height = $(window).height();
		footTop = $('body').scrollTop() + height-FootAdjustment;  
		for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).css("top", footTop); }
	});
		
});
//======================================================================
// on window resize get new position of window bottom and replace footer 
//======================================================================
$(window).resize(function() 
{
	var height = $(window).height();
	footTop = $('body').scrollTop() + height-FootAdjustment;
	for(i in  FixedHdrFtr.footer) {	$(FixedHdrFtr.footer[i]).css("top", footTop); }		 
});                                          

//]]> 

</script>


<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
  <div id="dvPrompt" class="Prompt"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

 <table id="tbl01" border="1" cellPadding="0" cellSpacing="0">
   <tr  id="trTopHdr1" class="trHdr04">
      <td ALIGN="center" VALIGN="TOP" nowrap colspan="22">
      <b>Retail Concepts, Inc
      <br><%if(sType.equals("Labor")){%>Store Weekly Labor Entry Summary<%}
           else {%>Store Weekly Bike Builds Entry Summary<%}%>
      </b>
     
      <br>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="PayEntrySel.jsp?Type=<%=sType%>"><font color="red" size="-1">Select Store/Week</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp<br><br>

      </td>
   </tr>

   
  <!----------------- beginning of table ------------------------>
  <tr id="trTopHdr2" class="trHdr01">
      <th class="th16">Store</th>
      <th class="th16">Pay Type</th>
      <th class="th16" colspan=<%=sSpan1%>>Days of Week</th>
      <th class="th16">&nbsp;</th>
      <th class="th16" colspan=<%=sSpan2%>>Total</th>
  </tr>

  <tr id="trTopHdr3" class="trHdr01">
    <th class="th16">&nbsp;</th>
    <th class="th16">&nbsp;</th>
    <%for(int i=0; i < 7; i++){%>
       <th class="th16" colspan=<%=sSpan2%>><%=sDayOfWk[i]%></th>
    <%}%>
    <th class="th16">&nbsp;</th>
    <th class="th16">&nbsp;</th>
    <th class="th16">&nbsp;</th>
  </tr>
  
  <tr id="trTopHdr4" class="trHdr01">
     <th class="th16">&nbsp;</th>
     <th class="th16">&nbsp;</th>
     <%for(int i=0; i < 7; i++){%>
        <th class="th16" colspan=<%=sSpan2%>><%=sDateOfWk[i]%></th>
     <%}%>
     <th class="th16">&nbsp;</th>
     <th class="th16">&nbsp;</th>
     <th class="th16">&nbsp;</th>
  </tr>
  
  <%if(sType.equals("Bike")){%>
  	<tr id="trTopHdr5" class="trHdr01">
    	<th class="th16">&nbsp;</th>
     	<th class="th16">&nbsp;</th>
     	<%for(int i=0; i < 7; i++){%>
        	<th class="th16">Bld</th>
        	<th class="th16">Sls</th>        	
     	<%}%>
     	<th class="th16">&nbsp;</th>
     	<th class="th16">Bld</th>
     	<th class="th16">Sls</th>
  </tr>
  <%}%>
  
  <!------------------------------Report Totals ----------------------------------->
	<tr class="Divider"><th colspan="22">&nbsp;<th></tr>
	<%
		payent.getRepPayInfo();
    	String sStr = payent.getStr();
		String [][] sStrAmt = payent.getStrAmt();
		String [] sStrDayAmt = payent.getStrDayAmt(); 
		String [] sSlsDayAmt = payent.getSlsDayAmt();
    %>    
    <tr id="trFoot" class="trDtl04">
       <td class="DataTable4" colspan=2>Company Weekly Total</td>
           
       <%for(int k=0; k < 8; k++){%>
          <%if(k==7){%><th class="DataTable">&nbsp;</th><%}%>
          <td class="td39"><%if(sType.equals("Labor")){%>$<%}%><%=sStrDayAmt[k]%></td>
          <%if(sType.equals("Bike")){%>
          	<td class="td39"><%=sSlsDayAmt[k]%></td>
          <%}%>
       <%}%>

    </tr>
  
<!------------------------------- Detail Data --------------------------------->
    <%
      for(int i=0; i<iNumOfStr; i++)
      {
    	payent.getEmpPayInfo();
      	sStr = payent.getStr();
      	sStrAmt = payent.getStrAmt();
      	sStrDayAmt = payent.getStrDayAmt();
      	sSlsDayAmt = payent.getSlsDayAmt();
    %>
         <tr class="trDtl12">
           <td class="DataTable" <%if(!sType.equals("Bike")){%>rowspan=<%=iNumOfPyTy + 1%><%} %>>
              <a href="PayEntry.jsp?Store=<%=sStr%>&StrName=<%=sStr%>&Week=<%=sWeekend%>&Type=<%=sType%>&Currwk=true"><%=sStr%></a>
           </td>

           <%for(int j=0; j < iNumOfPyTy; j++){%>
              <%if(j > 0){%><tr class="trDtl12"><%}%> 
              <td class="td08"><%=sPyTyNm[j]%></td>
              <%for(int k=0; k < 8; k++){%>
                  <%if(k==7){%><th class="DataTable">&nbsp;</th><%}%>
                  <td class="td39"><%if(sType.equals("Labor")){%>$<%}%><%=sStrAmt[j][k]%></td>
                  <%if(sType.equals("Bike")){%>
          			<td class="td39"><%=sSlsDayAmt[k]%></td>
          		  <%}%>                                     
              <%}%>              
           <%}%>
           
           <%if(!sType.equals("Bike")){%>
           <tr class="trDtl12">
           	 <td class="td08">Total</td>
           
           <%for(int k=0; k < 8; k++){%>
              <%if(k==7){%><th class="DataTable">&nbsp;</th><%}%>
              <td class="td49"><%if(sType.equals("Labor")){%>$<%}%><%=sStrDayAmt[k]%></td>
              <%if(sType.equals("Bike")){%>
          			<td class="td49"><%=sSlsDayAmt[k]%></td>
          	  <%}%>
           <%}%>

         </tr>
         <%}%>
         <tr class="Divider"><th colspan="22">&nbsp;<th></tr>
    <%}%>
<!------------------------------Report Totals ----------------------------------->
	<tr class="Divider"><th colspan="22">&nbsp;<th></tr>
	<%
		payent.getRepPayInfo();
    	sStr = payent.getStr();
		sStrAmt = payent.getStrAmt();
		sStrDayAmt = payent.getStrDayAmt(); 
		sSlsDayAmt = payent.getSlsDayAmt();
    %>    
    <tr id="trFoot1"  class="trDtl04">
       <td class="DataTable4" <%if(!sType.equals("Bike")){%>rowspan=<%=iNumOfPyTy + 1%><%}%>>Total</td>

       <%for(int j=0; j < iNumOfPyTy; j++){%>
          <%if(j > 0){%><tr class="trDtl04"><%}%> 
              <td class="td08"><%=sPyTyNm[j]%></td>
              <%for(int k=0; k < 8; k++){%>
                  <%if(k==7){%><th class="DataTable">&nbsp;</th><%}%>
                  <td class="td39"><%if(sType.equals("Labor")){%>$<%}%><%=sStrAmt[j][k]%></td>
                  <%if(sType.equals("Bike")){%>
          			<td class="td39"><%=sSlsDayAmt[k]%></td>
             	  <%}%>                                     
              <%}%>              
       <%}%>
       
       <%if(!sType.equals("Bike")){%>   
       <tr class="trDtl04">
          <td class="td08">Total</td>
           
          <%for(int k=0; k < 8; k++){%>
             <%if(k==7){%><th class="DataTable">&nbsp;</th><%}%>
             <td class="td49"><%if(sType.equals("Labor")){%>$<%}%><%=sStrDayAmt[k]%></td>
             <%if(sType.equals("Bike")){%>
          		<td class="td49"><%=sSlsDayAmt[k]%></td>
             <%}%>
          <%}%>

         </tr>
      <%}%>   
<!---------------------------- end of Report Totals ------------------------------>
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
payent.disconnect();
payent = null;
}%>