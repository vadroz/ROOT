<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*
,com.test.api.*"%>
<%
    String sParent = request.getParameter("Parent");
    String sCls = request.getParameter("Cls");
    String sVen = request.getParameter("Ven");
    String sSty = request.getParameter("Sty");
  
    
	boolean bParent_Found = false;
    
	KiboValidProd mprod = new KiboValidProd();
	
	bParent_Found = mprod.getProductsByFilter("ProductCode eq " + sParent);
	mprod.getProdChild();
	
	Vector<String> vChild = new Vector<String>();
	Vector<Boolean> vChild_Found = new Vector<Boolean>();
	
	if(bParent_Found)
	{
		String sStmt = "select WLTDU,WLTDD, WLTDT" 
   	 	+ ", case when wddat <= sdStrDt then digits(dec(wclr,3,0))  else digits(wclr) end as wclr" 
	 	+ ", case when wddat <= sdStrDt then digits(dec(wsiz,4,0))  else digits(wsiz) end as wsiz" 
   		+ " from rci.MoItWeb" 
  	 	+ " inner join rci.MOIP40C on 1=1"
   	 	+ " where wcls=" + sCls 
 	  	+ " and wven=" + sVen
   		+ " and wsty=" + sSty
   		+ " and exists(select 1 from IpTsFil.IpItHdr where wcls=icls and wven=iven and wsty=isty " 
   		+ " and wclr=iclr and wsiz=isiz and iatt01=2)"
   	 	+ " order by WLTDU,WLTDD, WLTDT"
    	; 
	
   		//System.out.println(sStmt);
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);  
		ResultSet rs = runsql.runQuery();

	
		
		while(runsql.readNextRecord())
		{
			String sClr =  runsql.getData("wclr").trim();
			String sSiz =  runsql.getData("wsiz").trim();
			String sChild = sParent + "-" + sClr + sSiz; 
			
			
			if(!mprod.checkProdChild(sChild))
			{	
				System.out.println(sChild + " - not found" );
				vChild.add(sChild);
				vChild_Found.add(false);			
			}			
		}
		rs.close();
		runsql.disconnect();
 	}  
%>
<script>
var child = null;
var child_found = null;

<%if(vChild != null &&  vChild.size() > 0){%>
	child = new Array();
	child_found = new Array();
<%}%>


<%for(int i = 0; i < vChild.size(); i++){%>
   child[<%=i%>] = "<%=vChild.get(i)%>";
   child_found[<%=i%>] = <%=vChild_Found.get(i)%>;
<%}%>

parent.setProd(<%=bParent_Found%>, "<%=sParent%>", child, child_found);
</script>













