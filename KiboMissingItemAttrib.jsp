<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*
, rciutility.CallAs400SrvPgmSup, rciutility.ConnToCounterPoint
, com.test.api.*"%>
<%
   String sDays = request.getParameter("days");
   String sOrd = request.getParameter("ord");

   if(sDays == null || sDays.trim().equals("")) { sDays="0"; }
   
   
   
//----------------------------------
//Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=KiboMissingItemAttrib.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	
	String sStmt = "select ILLTDU, ILLTDD, ILLTDT"
	 + ",digits(ilcls) as ilcls" 
	 + ", case when ILDWNDT <= sdStrDt then digits(dec(ilven,5,0))  else digits(ilven) end as ilven" 
	 + ", case when ILDWNDT <= sdStrDt then digits(dec(ilsty,4,0))  else digits(ilsty) end as ilsty"
	 + " from rci.MoPrtDtl" 
	 + " inner join rci.MOIP40C on 1=1"
	 + " where ILLTDD = current date - " + sDays + " days" 
	 + " order by ILLTDU, ILLTDd, ILLTDt"
	;				
						
	//System.out.println("\n" + sStmt);
						
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	int iParent = 0;
	
	Vector<String> vParent = new Vector<String>();
	Vector<String> vCls = new Vector<String>();
	Vector<String> vVen = new Vector<String>();
	Vector<String> vSty = new Vector<String>();
	Vector<String> vLastUs = new Vector<String>();
	Vector<String> vLastDt = new Vector<String>();
	Vector<String> vLastTm = new Vector<String>();
		
	while(runsql.readNextRecord())
	{
		String sCls =  runsql.getData("ilcls").trim();
		String sVen =  runsql.getData("ilven").trim();
		String sSty =  runsql.getData("ilsty").trim();
		
		vParent.add(sCls + sVen + sSty);		
		vCls.add(sCls);
		vVen.add(sVen);
		vSty.add(sSty);
		
		vLastUs.add(runsql.getData("ILLTDU").trim());
		vLastDt.add(runsql.getData("ILLTDD").trim());
		vLastTm.add(runsql.getData("ILLTDT").trim());
		
		iParent++;
	}
	String  sParentJsa = srvpgm.cvtToJavaScriptArray(vParent.toArray(new String[vParent.size()]));
	
	KiboValidProd mprod = new KiboValidProd();
	
%>
	
<HTML>
<HEAD>
<title>Missing Builds</title>
 </HEAD>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css"> 

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script src="XX_Set_Browser.js"></script>
<script src="XX_Get_Visible_Position.js"></script>

 
<script>
//==============================================================================
// Global variables
//==============================================================================
 var aParent = [<%=sParentJsa%>]; 
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{		
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
	 
	 
} 
//==============================================================================
// submit for different days back
//==============================================================================
function resbm(sel)
{
	var days = document.getElementById("selDays");
	var day = days.options[days.selectedIndex].value;
	
	url ="KiboMissingItemAttrib.jsp?";	
	url += "days=" + day; 	
	
	window.location.href=url;
}
 
 
 
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<BODY onload="bodyLoad();">

<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!----------------- beginning of table ------------------------>  
<table id="tbl01" class="tbl01">
   <tr id="trTopHdr" style="background:ivory; ">
          <th align=center colspan=2>
            <b>Retail Concepts, Inc
            <br>KIBO - Missing Parent/Child In Attribution 
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="KiboMissingItemAttrib.jsp"><font color="red" size="-1">Select</font></a>&#62; 
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;  
            <br> Select Days back: 
            <select name="selDays" id=="selDays">
            <%for(int i=0; i < 50; i++){%> 
              <option value="<%=i%>"><%=i%></option>
            <%}%>  
            </select>
            &nbsp; &nbsp;
            <button class="Small" onclick="resbm('1');">Go</button>
                                           
          </th>   
        </tr> 
        <tr id="trId" style="background:#FFE4C4;">
          <th align=center valign="top">   
      <!-- ======================================================================= -->
      
              	   
           	
           	<table id="tbl01" class="tbl02">
    	    	<tr>
           			<th class="th01" nowrap>Parent/Child</th>
           			<th class="th01" nowrap>User/Date/Time</th>
           		</tr>
           	
           	<%
           	  Vector<String> vChild = new Vector<String>();
           	
           	  for(int i=0; i < vParent.size(); i++){
           		boolean bParent_Found = mprod.getProductsByFilter("ProductCode eq " + vParent.get(i));
           		boolean bChild_Found = true;  
           		
           		
           		
           		if(bParent_Found)
           		{
           			sStmt = "select WLTDU,WLTDD, WLTDT" 
      				  + ", case when wddat <= sdStrDt then digits(dec(wclr,3,0))  else digits(wclr) end as wclr" 
      				  + ", case when wddat <= sdStrDt then digits(dec(wsiz,4,0))  else digits(wsiz) end as wsiz" 
      				  + " from rci.MoItWeb" 
      				  + " inner join rci.MOIP40C on 1=1"
      				  + " where wcls=" + vCls.get(i) 
      				  + " and wven=" + vVen.get(i)
      				  + " and wsty=" + vSty.get(i)
      				  + " order by WLTDU,WLTDD, WLTDT"
      				 ;
      				
      				//System.out.println("\n" + sStmt);
      				RunSQLStmt runsql_Dtl = new RunSQLStmt();
      				runsql_Dtl.setPrepStmt(sStmt);
      				ResultSet rs_Dtl = runsql_Dtl.runQuery();
      				
      				// retrieve children      				
      				mprod.getProdChild();
      				vChild = new Vector<String>();
      				while(runsql_Dtl.readNextRecord())
      				{
      					String sClr =  runsql_Dtl.getData("wclr").trim();
      					String sSiz =  runsql_Dtl.getData("wsiz").trim();
      					String sChild = vParent.get(i) + "-" + sClr + sSiz; 
      					
      					if(!mprod.checkProdChild(sChild))
      					{
      						vChild.add(sChild);
      						bChild_Found = false;
      						//System.out.println("Child: " + sChild + " is not found " + vChild.size());
      					}
      				}
      				rs_Dtl.close();
      				runsql_Dtl.disconnect();      				
           		}
           	%>
           		<%if(!bParent_Found || !bChild_Found){%>
           	 		<tr class="trDtl04">
           				<td class="td11" nowrap><%=vParent.get(i)%></th>
           				<td class="td11" nowrap><%=vLastUs.get(i)%> <%=vLastDt.get(i)%> <%=vLastTm.get(i)%></th>
           	 		</tr>
           	 		<%for(int j=0; j < vChild.size(); j++){%>
           	 			<tr class="trDtl04">
    	       				<td class="td11" nowrap><%=vChild.get(j)%></th>
    	       				<td class="td11" nowrap>&nbsp;</th>        	   				
	           	 		</tr>
           	 		<%}%>
           	 	<%}%>
           	<%}%>
           </table>    
       <!-- ======================================================================= -->
          
        
         </th>
       </tr> 
   </table>
   <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

       
    </body>
</html>
<%
}
%>