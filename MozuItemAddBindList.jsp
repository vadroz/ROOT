<!DOCTYPE html>	
<%@ page import="rciutility.RunSQLStmt, java.sql.*, rciutility.CallAs400SrvPgmSup, java.util.*, java.text.*"%>
<%
String sSite = request.getParameter("Site");
String sCls = request.getParameter("Cls");
String sVen = request.getParameter("Ven");
String sSty = request.getParameter("Sty");
String sPrTyId = request.getParameter("PrTyId");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuItemAddBindList.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	String sStmt = "select TpId, TpName"
		+ " from rci.MOTNPRTY"		
		+ " where tpid=" + sPrTyId + " and tpsite='" + sSite + "'"		
	;
	//System.out.println("1." + sStmt);	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();	
	String sProdTypeNm = null; 
	
	if(runsql.readNextRecord())
	{
		sProdTypeNm = runsql.getData("TpName").trim();
	}	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	rs.close();
	rs = null;
	runsql.disconnect();
	runsql = null;
	
	sStmt = "select IDLINE "
		+ " from Rci.MOPRTDSC"
		+ " where idCls=" + sCls + " and IdVen = " + sVen
		+ " and IdSty = " + sSty
		+ " and IdType = 'WName'"
	;	
	//System.out.println("2." + sStmt);
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	rs = runsql.runQuery();	
	String sParentNm = null; 
	
	if(runsql.readNextRecord())
	{
		sParentNm = runsql.getData("IDLINE").trim();
	}
	
	if(sParentNm == null){ sParentNm = "Not Exists"; }
	
	runsql.disconnect();
	runsql = null;
	
	sStmt = "select case when ILDWNDT <= sdStrDt then 'Y' else 'N' end as oldPar"
	+ " from Rci.MOPRTDtl"
	+ " inner join rci.MOIP40C on 1=1"
	+ " where ilCls="+ sCls + " and ilVen="+ sVen + " and ilSty="+ sSty
	;
	
	//System.out.println(sStmt);
	
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	rs = runsql.runQuery();	
	String sOldPar = null;
	if(runsql.readNextRecord())
	{
		sOldPar = runsql.getData("oldPar").trim();
	}
	
	runsql.disconnect();
	runsql = null;
	if(sOldPar == null)
	{
		sOldPar = "N";
	}
	
	String sParent = sCls + sVen + sSty;
	if(sOldPar.equals("Y"))
	{
		sParent = sCls + sVen.substring(1) + sSty.substring(3);
	}
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
 
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>Bindings on Product</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Site = "<%=sSite%>";
var NewName = null;
var NumOfBnd = 0;
var Site = "<%=sSite%>";
var Parent = "<%=sParent%>";

var progressIntFunc = null;
var progressTime = 0;


//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{   
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{
		isSafari = true;
		setDraggable();
	}
	else
	{
	   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
	}
	
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmBind(bind, price, action)
{	
  	var nwelem = window.frame1.document.createElement("div");
  	nwelem.id = "dvAddBind"
		  	
  	var html = "<form name='frmItmProp'"
     + " METHOD=Post ACTION='MozuItemAddBindSv.jsp'>"
     + "<input name='Site'>"
     + "<input name='Prod'>"
     + "<input name='Bind'>"
     + "<input name='Price'>"
     + "<input name='Qty'>"
     + "<input name='Action'>"
     ;
  	html += "</form>"; 	
  		
    nwelem.innerHTML = html;
  	window.frame1.document.body.appendChild(nwelem);

  	window.frame1.document.all.Site.value = Site;
  	window.frame1.document.all.Prod.value = Parent;
  	window.frame1.document.all.Bind.value = bind;
  	window.frame1.document.all.Price.value = price;
  	window.frame1.document.all.Qty.value = "1";
  	window.frame1.document.all.Action.value=action;  
  	window.frame1.document.frmItmProp.submit();
  	
  	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000); 
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
//==============================================================================
//Hide selection screen
//==============================================================================
function showError(error)
{	
	clearInterval( progressIntFunc );
	document.all.dvWait.style.visibility = "hidden";
	
	document.all.divError.innerHTML = error; 
}  
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
}

</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<!----------------- beginning of table ------------------------>
     <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Mozu - Attach Extras to Product    
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
              <a class="Small" href="MozuBindProp.jsp?Site=<%=sSite%>&ProdTyId=<%=sPrTyId%>" target="_blank">Control Extra on PT</a>              
          </th>
        </tr>
        <tr>
          <td>           
<!-- ======================================================================= -->                        
      <table class="tbl02">	       
              <tr id="trId" class="trHdr01">
                <th class="th29" nowrap>Site: &nbsp;</th><th class="th28" nowrap><%=sSite%></th>
              </tr>  
              <tr id="trId" class="trHdr01">
                <th class="th29" nowrap>Product Type: &nbsp;</th><th class="th28" nowrap><%=sPrTyId%> - <%=sProdTypeNm%></th>
              </tr>
              <tr id="trId" class="trHdr01">
                <th class="th29" nowrap>Product: &nbsp;</th><th class="th28" nowrap><%=sCls%><%=sVen%><%=sSty%></th>
              </tr>
              <tr id="trId" class="trHdr01">
                <th class="th29" nowrap>Name: &nbsp;</th><th class="th28" nowrap><%=sParentNm%></th>
              </tr>
       </table> 
       
       <br>
       <br>
       
<!------------------------------- Detail --------------------------------->        
       <table class="tbl02">              
       		<tr id="trId" class="trHdr01">
              <th class="th01" nowrap>Extra Item Number</th>
              <th class="th01" nowrap>Description</th> 
              <th class="th01" nowrap>Color</th>
              <th class="th01" nowrap>Size</th>
              <th class="th01" nowrap>Retail</th>
              <th class="th01" nowrap>Attach<br>Extras</th>
              <th class="th01" nowrap>Remove<br>Extras</th>
            </tr> 
       <%
       String sTrCls = "trDtl04";
       sStmt = "with bindf as (" 
    	 + " select BPSITE, BPPTID, digits(BPCLS) as cls, digits(BPVEN) as ven, digits(BPSTY) as sty"  
    	 + ",digits(BPCLR) as clr, digits(BPSIZ) as siz, BPRECUS, char(BPRECDT,usa) as BPRECDT"
    	 + " , char(BPRECTM, usa) as BPRECTM"
    	 + ", TPNAME, ides, iret"
    	 + ", (select VXPRICE from rci.MoPrcInv where site = bpsite and parent='1'" 
    	 + " and prod=digits(bpcls) concat digits(bpven) concat digits(bpsty) " 
    	 + " order by recdt desc fetch first 1 row only) as ecom_ret"  
    	 + ", case when (select 1 from rci.MOITBIND where ibsite ='" + sSite + "'"
    	 + " and IbPCls = " + sCls + " and IbPVen = " + sVen  + " and IbPSty = " + sSty 
    	 + " and IbBcls = bpcls and IbBVen = bpven and IbBsty = bpsty and IbBclr = bpclr and IbBsiz = bpsiz"
    	 + ") is null  then 'N' else 'Y' end as attached "    	 
    	 + ",(select line from rci.MOPRTDSC" 
    	 + " where idcls=bpcls and idven=BpVen and idsty=BpSty and idtype='WName' fetch first 1 row only) as wname" 
    	 
    	 + ",(select case when ILDWNDT <= sdStrDt then 'Y' else 'N' end  from Rci.MOPRTDtl where ilCls=bpcls" 
    	 + " and ilVen=bpven and ilSty=bpsty) as oldpar"
    	 + ",(select case when wddat <= sdStrDt then 'Y' else 'N' end  from Rci.MOItWeb where wCls=bpcls" 
    	 + " and wVen=bpven and wSty=bpsty and wclr = bpclr and wsiz = bpsiz) as oldchi"
    	 + ", cival, sival"
    	 + " from rci.MoBindPr"
    	 + " inner join rci.MOTNPRTY on TPID=bpptid and TpSite=BpSite"
    	 + " inner join iptsfil.ipithdr on icls=BPCLS and iven=BPVen and iSty=BPSty"    	 
    	 + " and iclr=BPClr and isiz=BPSiz"
    	 + " inner join rci.MOIP40C on 1=1"
    	 + " inner join rci.MoItWeb on wcls=BPCLS and wven=BPVen and wSty=BPSty"    	 
    	 + " and wclr=BPClr and wsiz=BPSiz"
    	 + " left join rci.MoColor on cisite='" + sSite + "' and  char(ciOpt) = trim(wClrNm)"
    	 + " left join rci.MoSize  on sisite='" + sSite + "' and  char(siOpt) = trim(wSizNm)"
    	 + " where BpSite = '" + sSite + "' and TpId=" + sPrTyId 
		 + ") "
		 + " select cls, ven, sty, clr, siz, BPRECUS, BPRECDT, BPRECTM"
		 + ", TPNAME, ides, iret"
		 + ", case when ecom_ret is null then '0' else ecom_ret end as ecom_ret"
		 + ", case when wname is null then ' ' else wname end as wname"
		 + ", attached, oldpar, oldchi"
		 + ", case when cival is not null then cival else ' ' end as clrnm"
		 + ", case when sival is not null then sival else ' ' end as siznm"
		 + " from bindf "
    	 ;
    	
		System.out.println("\n3.\n" + sStmt);
      	
		runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		rs = runsql.runQuery();	
		int i=0;
			
		String sBindCls = "";
		String sBindVen = "";
		String sBindSty = "";
		String sBindClr = "";
		String sBindSiz = "";
		String sBindDesc = "";
		String sBindIpRet = "";
		String sBindEcomRet = "";
		String sAttached = "";
		String sBindOldPar = "";
		String sBindOldChi = "";
		String sBind = "";
		String sBindClrNm = "";
		String sBindSizNm = "";
				
		while(runsql.readNextRecord())
		{
			sBindCls = runsql.getData("cls");
			sBindVen =  runsql.getData("ven");
			sBindSty =  runsql.getData("sty");
			sBindClr =  runsql.getData("clr");
			sBindSiz =  runsql.getData("siz");
			
			sBindDesc =  runsql.getData("ides");
			String wname =  runsql.getData("wname").trim();
			if(!wname.equals("")){ sBindDesc = wname; }
			
			sBindIpRet =  runsql.getData("iret");
			sBindEcomRet =  runsql.getData("ecom_ret");	
			String sPrice = null;
			if(!sBindEcomRet.equals("0"))
			{ 
				sPrice = sBindEcomRet; 
			} 
			else { sPrice = sBindIpRet; }
			
			sAttached =  runsql.getData("attached").trim();
			sBindOldPar =  runsql.getData("oldpar").trim();
			sBindOldChi =  runsql.getData("oldchi").trim();
			
			if(sBindOldPar.equals("Y")){sBind = sBindCls + sBindVen.substring(1) + sBindSty.substring(3);}
			else {sBind = sBindCls + sBindVen + sBindSty; }
			
			if(sBindOldChi.equals("Y")){sBind += "-" + sBindClr.substring(1) + sBindSiz.substring(1);}
			else {sBind += "-" + sBindClr + sBindSiz; }
			
			sBindClrNm =  runsql.getData("clrnm").trim();
			sBindSizNm =  runsql.getData("siznm").trim();
        %>
            <tr class="<%=sTrCls%>">                         
                <td class="td12" id="tdBind<%=i%>" nowrap><%=sBindCls%><%=sBindVen%><%=sBindSty%>-<%=sBindClr%><%=sBindSiz%></td>
                <td class="td11" nowrap><%=sBindDesc%></td>
                <td class="td11" nowrap><%=sBindClrNm%></td>
                <td class="td11" nowrap><%=sBindSizNm%></td>
                <td class="td11"  id="tdPrice<%=i%>" nowrap><%=sPrice %></td>
                <td class="td18" nowrap>&nbsp;
                <%if(!sAttached.equals("Y")){%>
                	<a class="Small" href="javascript: sbmBind('<%=sBind%>', '<%=sPrice%>','ADD')">Add</a>
                <%}%> 
                </td>
                <td class="td18" nowrap>
                <%if(sAttached.equals("Y")){%>&nbsp;
                	<a class="Small" href="javascript: sbmBind('<%=sBind%>', '<%=sPrice%>','DLT')">Remove</a>
                <%}%> 
                </td>
            </tr>
                
        <% i++;
          }
        %>
        </table>
        <script>NumOfBnd = "<%=i%>";</script>
        <br><div id="divError" style="color: red;"></div>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
}
%>