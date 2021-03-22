<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*
, rciutility.CallAs400SrvPgmSup, rciutility.ConnToCounterPoint,com.test.api.*"%>
<%
   String sDays = request.getParameter("days");
   String sOrd = request.getParameter("ord");

   if(sDays == null || sDays.trim().equals("")) { sDays="0"; }
      
//----------------------------------
//Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=KiboMissingItemAttrib01.jsp&APPL=ALL&" + request.getQueryString());
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
	 + " and exists(select 1 from IpTsFil.IpItHdr where ilcls=icls and ilven=iven and ilsty=isty and iatt01=2)" 
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
	String  sClsJsa = srvpgm.cvtToJavaScriptArray(vCls.toArray(new String[vCls.size()]));
	String  sVenJsa = srvpgm.cvtToJavaScriptArray(vVen.toArray(new String[vVen.size()]));
	String  sStyJsa = srvpgm.cvtToJavaScriptArray(vSty.toArray(new String[vSty.size()]));
	
	String  sLastUsJsa = srvpgm.cvtToJavaScriptArray(vLastUs.toArray(new String[vLastUs.size()]));
	String  sLastDtJsa = srvpgm.cvtToJavaScriptArray(vLastDt.toArray(new String[vLastDt.size()]));
	String  sLastTmJsa = srvpgm.cvtToJavaScriptArray(vLastTm.toArray(new String[vLastTm.size()]));	
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
 var Days = "<%=sDays%>";
 var aParent = [<%=sParentJsa%>];
 var aCls = [<%=sClsJsa%>];
 var aVen = [<%=sVenJsa%>];
 var aSty = [<%=sStyJsa%>];
 var aLastUs = [<%=sLastUsJsa%>];
 var aLastDt = [<%=sLastDtJsa%>];
 var aLastTm = [<%=sLastTmJsa%>];
 
 var ParArg = -1;
 

 var progressIntFunc = null;
 var progressTime = 0;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{		
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
	
	getReport(); 
} 
//==============================================================================
// check if Item exists
//==============================================================================
function getReport()
{
	ParArg++;
	if(ParArg < aParent.length)
	{
		document.getElementById("tdChkArg").innerHTML = ParArg + 1;
		document.getElementById("tdChkPar").innerHTML = aParent[ParArg];
		
		var url = "KiboRtvAttribItem.jsp?Parent=" + aParent[ParArg]
		  + "&Cls=" + aCls[ParArg]
		  + "&Ven=" + aVen[ParArg]
		  + "&Sty=" + aSty[ParArg]
		;
		window.frame1.location = url;
	}
	else
	{
		//document.getElementById("trCheck").style.display = "none";		
		document.getElementById("tdChkArg").innerHTML = ParArg;
		document.getElementById("tdChkPar").innerHTML = " Item(s) Found";
		document.getElementById("tdChkMsg").innerHTML = "All Checked";
	}
}
//==============================================================================
// show result
//==============================================================================
function setProd(parFound, parent, child, child_found)
{
	if(!parFound || child != null)
	{
		var tbody = document.getElementById("tbl02").getElementsByTagName("TBODY")[1];
	
		var row = document.createElement("TR");
		var td1 = document.createElement("td")
		var td2 = document.createElement("td")
		var td3 = document.createElement("td")
	   
		row.className="trDtl04";
		td1.className="td12";
		td2.className="td11";
		td3.className="td11";
	   
		td1.innerHTML= eval(ParArg) + 1;
		td2.innerHTML=parent;
	
		if(parFound){ td3.innerHTML = "<td>" + aLastUs[ParArg] + " " + aLastDt[ParArg] + " " + aLastTm[ParArg] + "</td>"}
		else{ td3.innerHTML = "<td>" + aLastUs[ParArg] + " " + aLastDt[ParArg] + " " + aLastTm[ParArg]  + " - is not found</td>" }
	    	    
		row.appendChild(td1);
		row.appendChild(td2);
		row.appendChild(td3);
	    
		tbody.appendChild(row); 
			
		if(child != null)
		{
			for(var i = 0; i < child.length; i++)
			{
				tbody = document.getElementById("tbl02").getElementsByTagName("TBODY")[1];
			
				row = document.createElement("TR");
				td1 = document.createElement("td")
				td2 = document.createElement("td")
				td3 = document.createElement("td")
			   
				row.className="trDtl04";
				td1.className="td12";
				td2.className="td11";
				td3.className="td11";
			
				td1.innerHTML="&nbsp";
				td2.innerHTML=child[i];
			
				if(child_found[i]){ td3.innerHTML = "<td>Good</td>"}
				else{ td3.innerHTML = "<td>is not found</td>" }
			    	    
				row.appendChild(td1);
				row.appendChild(td2);
				row.appendChild(td3);
			    
				tbody.appendChild(row); 
			}
		}
	}
	getReport(); 
}
//==============================================================================
// submit for different days back
//==============================================================================
function resbm(sel)
{
	var days = document.getElementById("selDays");
	var day = days.options[days.selectedIndex].value;
	
	url ="KiboMissingItemAttrib01.jsp?";	
	url += "days=" + day; 	
	
	window.location.href=url;
}
 
//==============================================================================
//show exist options for selection
//==============================================================================
function showWaitBanner()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:12px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvWait.innerHTML = html;
	document.all.dvWait.style.height = "20px";
	document.all.dvWait.style.pixelLeft= document.documentElement.scrollLeft + 340;
	document.all.dvWait.style.pixelTop= document.documentElement.scrollTop + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
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
              <a href="KiboMissingItemAttrib01.jsp"><font color="red" size="-1">Select</font></a>&#62; 
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;  
            <br> Select Days back: 
            <select name="selDays" id=="selDays">
            <%for(int i=0; i < 50; i++){
               String sArg = String.valueOf(i);
               String sSelect = "";
               if(sArg.equals(sDays)){ sSelect = "selected"; }
            %> 
              <option value="<%=i%>" <%=sSelect%>><%=i%></option>
            <%}%>  
            </select>
            &nbsp; &nbsp;
            <button class="Small" onclick="resbm('1');">Go</button>
                                           
          </th>   
        </tr> 
        <tr id="trId" style="background:#FFE4C4;">
          <th align=center valign="top">   
      <!-- ======================================================================= -->
           	
           	<table id="tbl02" class="tbl02">
    	    	<tr>
    	    	  <th class="th01" nowrap>No.</th>
           		  <th class="th01" nowrap>Parent/Child</th>
           		  <th class="th01" nowrap>User/Date/Time</th>
           		</tr> 
           		<tbody id="tbdGrp">
           		  <tr class="trDtl06" id="trCheck">
           		    <td class="td12" id="tdChkArg"></td>
           		    <td class="td11" id="tdChkPar"></td>
           		    <td class="td11" id="tdChkMsg">Checking now in KIBO</td>
           		  </tr>
           		</tbody>
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