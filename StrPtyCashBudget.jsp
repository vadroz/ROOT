<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*
	, java.util.*, rciutility.CallAs400SrvPgmSup
	, rciutility.StoreSelect "
%>
<%
String sSelStr = request.getParameter("Str");
String sSelAmt = request.getParameter("Amt");
String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
String sAppl = "PTYCSH";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !(session.getAttribute(sAppl) == null))
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrPtyCashBudget.jsp");
}
else
{
	   	String sStrAllowed = session.getAttribute("STORE").toString();
	   	String sUser = session.getAttribute("USER").toString();
	   	
	   	StoreSelect strlst = null;
    	if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
        {
          strlst = new StoreSelect(23);
        }
        else if (sStrAllowed != null && sStrAllowed.trim().equals("70"))
        {
          strlst = new StoreSelect(21);
        }
        else
        {
          Vector vStr = (Vector) session.getAttribute("STRLST");
          String [] sStrAlwLst = new String[ vStr.size()];
          Iterator iter = vStr.iterator();

          int iStrAlwLst = 0;
          while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

          if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
          else strlst = new StoreSelect(new String[]{sStrAllowed});
        }    	
       
       	String sStrJsa = strlst.getStrNum();
       	String sStrNameJsa = strlst.getStrName();
       	String [] sArrStr = strlst.getStrLst();
       	int iNumOfStr = strlst.getNumOfStr();
	   	
       	if(sSelStr != null)
       	{
       		String sPrepStmt = "";
    	   	if(sAction.equals("ADD"))
    	   	{ 
    	   		sPrepStmt = "insert into rci.SPBUDGT values(" + sSelStr + ", " + sSelAmt
    	   		 + ", '" + sUser + "', current date, current time"		
    	   		 + ")"; 
    	   	}
    	   	else if(sAction.equals("UPD"))
    	   	{ 
    	   		sPrepStmt = "update rci.SPBUDGT set sbamt=" + sSelAmt
    	   		 + ", SBRECUS='" + sUser + "'"
    	   		 + ", SBRECDT=current date"
    	   		 + ", SBRECTM=current time"
    	   		 + " where sbstr=" + sSelStr; 
    	   	}    	      	
    	   	System.out.println(sPrepStmt);
    	   	ResultSet rslset = null;
           	RunSQLStmt runsql = new RunSQLStmt();
           	runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
           	runsql.disconnect();
       	}
	   	
	   	String sPrepStmt = "select sSTR,snam, SBAMT,SbRECUS, char(SbRECDT,usa) as SbRECDT" 
	   	 + ", char(SbRECTM, usa) as SbRECTM"
	   	 + " from IpTsFil.IpStore "
	   	 + " left join rci.SPBUDGT on sbstr=sstr"
	   	 + " where sstr in (";
	   	 
	   	String coma = "";
	   	for(int i=0; i < iNumOfStr; i++)
	   	{	
	   		sPrepStmt += coma + " '" + sArrStr[i] + "'";
	   		coma = ",";
	   	}	   	
	   	sPrepStmt += ")";	   	
	   	sPrepStmt += " order by sstr";       	
      	
       	//System.out.println(sPrepStmt);
       	
      	ResultSet rslset = null;
      	RunSQLStmt runsql = new RunSQLStmt();
    	runsql.setPrepStmt(sPrepStmt);		   
    	runsql.runQuery();
    		   		   
    	Vector<String> vStr = new Vector<String>();
    	Vector<String> vStrNm = new Vector<String>();
    	Vector<String> vAmt = new Vector<String>();
    	Vector<String> vRecUsr = new Vector<String>();
    	Vector<String> vRecDt = new Vector<String>();
    	Vector<String> vRecTm = new Vector<String>();
    	Vector<String> vExists = new Vector<String>();
    		   		   
    	while(runsql.readNextRecord())
    	{
    		vStr.add(runsql.getData("sstr"));
    		vStrNm.add(runsql.getData("snam"));
    		
    		String amt = runsql.getData("sbAmt"); 
    		System.out.println("amt=" + amt);
    		if( amt != null)
    		{
    			vAmt.add(runsql.getData("SbAmt"));
    			vRecUsr.add(runsql.getData("SbRECUs"));
    			vRecDt.add(runsql.getData("SbRECDT"));
        		vRecTm.add(runsql.getData("SbRECTM"));
        		vExists.add("true");
    		}
    		else
    		{
    			vAmt.add("0");
    			vRecUsr.add("None");
    			vRecDt.add("");
        		vRecTm.add("");
        		vExists.add("false");
    		}
    		
        }
    	runsql.disconnect();
    	runsql = null;
    	
    	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();	
    	
    	String [] sStr = vStr.toArray(new String[]{});
    	String [] sStrNm = vStrNm.toArray(new String[]{});
    	String [] sAmt = vAmt.toArray(new String[]{});
    	String [] sRecUsr = vRecUsr.toArray(new String[]{});
    	String [] sRecDt = vRecDt.toArray(new String[]{});
    	String [] sRecTm = vRecTm.toArray(new String[]{});
    	String [] sExists = vExists.toArray(new String[]{});    	
    	       
       
   	    boolean bAllowChg = sUser.equals("vrozen") || sUser.equals("psnyder") || sUser.equals("srutherfor")
   	    	|| sUser.equals("jlegaspi") || sUser.equals("gorozco");		
   			   
%>
<html>
<head>		 
	<title>Petty Cash Budget</title>
</head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">


<script name="javascript">
var User = "<%=sUser%>";
//var EmpReq = <!-- %=bEmpReq% -->;

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
//var UserAuth = "<!-- %=sUserAuth% -->";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{    
	setBoxclasses(["BoxName",  "BoxClose"], ["dvVendor"]);
}
//==============================================================================
//set store budget
//==============================================================================
function setStrBdg(str, exists, amt)
{
var hdr = "Store " + str + " Petty Cash Budget";

var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  + "<tr>"
    + "<td class='BoxName' nowrap>" + hdr + "</td>"
    + "<td class='BoxClose' valign=top>"
      +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    + "</td></tr>"
 + "<tr><td class='Prompt' colspan=2>" + popStrBdg(str, exists)
  + "</td></tr>"
+ "</table>"

	document.all.dvVendor.innerHTML = html;
    document.all.dvVendor.style.width= 200;
    document.all.dvVendor.style.height= 50;
	document.all.dvVendor.style.pixelLeft= document.documentElement.scrollLeft + 440;
	document.all.dvVendor.style.pixelTop= document.documentElement.scrollTop + 95;
	document.all.dvVendor.style.visibility = "visible";
	
	if(exists){ document.all.Amt.value=amt; }
	document.all.Amt.focus();
}
//==============================================================================
//populate Entry Panel
//==============================================================================
function popStrBdg(str, exists)
{
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
	panel += "<td class='td48' nowrap>Amount:<input name='Amt' size=10 maxlength=10>" 
	         +"<input name='Str' type='hidden' value='" + str + "'>"
      + "</td>"
    + "</tr>"

	panel += "<tr>";
	if(!exists){panel += "<td class='Prompt1'><br><br><button onClick='Validate(&#34;ADD&#34;)' class='Small'>Submit</button>" }
	else{panel += "<td class='Prompt1'><br><br><button onClick='Validate(&#34;UPD&#34;)' class='Small'>Submit</button>" }
	panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
	panel += "</table>";
	return panel;
}

//==============================================================================
// Validate form
//==============================================================================
function Validate(action)
{
  var error = false;
  var msg = "";

  var str = document.all.Str.value;
  
  var amt = document.all.Amt.value.trim();
  if(amt==""){error=true; msg += "\nPlease type budget amount.";}
  else if(isNaN(amt)){error=true; msg += "\nThe Amount is not numeric.";}
  else if(eval(amt) <= 0){error=true; msg += "\nThe Amount must be positive number.";}
    
  if (error) alert(msg);
  else { sbmCtl(str, amt, action); }
  return error == false;
}
//==============================================================================
// Submit list
//==============================================================================
function sbmCtl(str, amt, action)
{
	var url = "StrPtyCashBudget.jsp?Str=" + str
   	  	+ "&Amt=" + amt
   		+ "&Action=" + action
   	;
	window.location.href=url;	
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvVendor.innerHTML = " ";
   document.all.dvVendor.style.visibility = "hidden";
}
</script>


<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="Get_Object_Position.js"></script>



<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <!--  TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo4.png"></TD>
  </TR -->
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Store Petty Cash Budget</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE border=0>
        <TBODY>
        
        <!-- ========================== Control ============================== -->            
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr style="text-align:center">
        	<td colspan=4 style="text-align:center">                		   	
        	
        		<table border=1 cellPadding="0" cellSpacing="0" width=100%>
        			  <thead>
        			  <tr class="trHdr05" >
        				<th class="th08">Store</th>
        				<th class="th08">Budget Ammount</th>
        				<th class="th08">Last Updated<br>By User</th>
        				<th class="th08">Last Updated<br>Date/Time</th>        				        				
        				<%if(bAllowChg){%><th class="th08">Chg</th><%}%>
        		      </tr>
        		      </thead>
        		       		 
        			  <%for(int i=0; i < sStr.length; i++){%>
        				<tr class="trDtl06">
        				  <td id="tdSts<%=i%>" class="td48" nowrap><%=sStr[i]%> - <%=sStrNm[i]%></td>
        				  <td id="tdSts<%=i%>" class="td48" nowrap><%=sAmt[i]%></td>
        				  <td id="tdSts<%=i%>" class="td48" nowrap><%=sRecUsr[i]%></td>
        				  <td id="tdSts<%=i%>" class="td48" nowrap><%=sRecDt[i]%> <%=sRecTm[i]%></td>
        				  <%if(bAllowChg){%>       	
        				  	<td class="td49">        				  	    
        				  		<a href="javascript: setStrBdg('<%=sStr[i]%>',<%=sExists[i]%>, '<%=sAmt[i]%>')">Chg</a>        				  		
        				  	</td>
        				  <%}%>			  
        				</tr>  
        			  <%}%>
        			</table>
        			  
        	</td>
        </tr>
        <TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%} %>




