<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
  String sPo = request.getParameter("PO");
  String sAsn = request.getParameter("ASN");
  String sAsnDt = request.getParameter("Date");
  String sCtn = request.getParameter("Ctn");
  String sAction = request.getParameter("Action");
  

//----------------------------------
// Application Authorization
//----------------------------------

if (session.getAttribute("USER")!=null)
{
   String sUser = session.getAttribute("USER").toString();

   // add leading zero to PO number
   int ipo = sPo.length();
   String sZero = "0000000000";
   String sZPo = sZero.substring(0, 10 - ipo) + sPo;   
   
   String sCtnNum = null;
   String sCtnShp = null;
   String sCtnRcv = null;
   String sCtnItm = null;
   String sSku = null;
   String sDesc = null;
   String sColor = null;
   String sSize = null;
   String sVenSty = null;
   String sUpc = null;
   String sRcvUser = null;
   String sSeq = null;
   String sManRcv = null;
   String sCtnSts = null;
   String sCtnInv = null;
   String sCtnDate = null;
   String sCtnTime = null;
      
   if(sAction.equals("Carton"))
   {
	    //System.out.println("\nCartons");
   	   	String sPrepStmt = "with itemf as(" 
    	 + "select  cono, casn, cctn, cqty"
    	 + ", (select  dec(sum(pqrs),9,0) from iptsfil.IpRLogI where pono = cono"
    	 + " and pcls=ccls and pven=cven and psty=csty and pclr=cclr and psiz=csiz) as man_rcv"
    	 + ", case when lsts is not null then lsts else ' ' end as lsts" 
    	 + ", case when lpas is not null then lpas else ' ' end as lpas"
    	 + ", case when lstd is not null then lstd else date('0001-01-01')  end as lstd" 
    	 + ", case when lstt is not null then lstt else  time('00.00.00') end as lstt"
    	 + " from iptsfil.ipanitm"
    	 + " left join Table (select lctn, lsts, lpas, LSTD, LSTT" 
    	 + " from iptsfil.IpCnLog where cctn=lctn" 
    	 + " and lsts='DROP SHIP' and lpas > ' '"
    	 + " group by  lctn, lsts, lpas, LSTD, LSTT fetch first 1 row only) cnlog on cctn=lctn"
    	 + " where cono = '" + sZPo + "' and casn='" + sAsn + "'"
    	 + ")"
    	 + ", ctnf as ("
    	 + " select cono, casn, cctn, sum(cqty) as cqty, sum(man_rcv ) as man_rcv"
    	 + ", lsts, lpas, lstd, lstt"
    	 + " from itemf"
    	 + " group by cono, casn, cctn, lsts, lpas, lstd, lstt) "    	 
    	 + " select cctn, cqty"
    	 + " , (select cqty from iptsmod.IpBrCtnD where BCTNONO = cono and BCtnCtn=cctn and BCTNASN=casn)  as rcvItm"
    	 + ", case when man_rcv is not null then man_rcv else 0 end as man_rcv"
    	 + ", lsts, lpas, char(lstd,usa) as lstd , char(lstt, usa) as lstt" 
    	 + " from ctnf a"
    	 + " order by cctn"
    	;

   		//System.out.println(sPrepStmt);
   		RunSQLStmt runsql = new RunSQLStmt();
   	    runsql.setPrepStmt(sPrepStmt);
   		runsql.runQuery();
   		Vector<String> vCtnNum = new Vector<String>();
   		Vector<String> vCtnShp = new Vector<String>();
   		Vector<String> vCtnRcv = new Vector<String>();
   		Vector<String> vCtnItm = new Vector<String>();
   		Vector<String> vManRcv = new Vector<String>();
   		Vector<String> vCtnSts = new Vector<String>();
   		Vector<String> vCtnInv = new Vector<String>();
   		Vector<String> vCtnDate = new Vector<String>();
   		Vector<String> vCtnTime = new Vector<String>();
   		
   		while(runsql.readNextRecord())
   		{
   			String ctn = runsql.getData("cctn");
   			vCtnNum.add(ctn);
   			vCtnShp.add(runsql.getData("cqty"));
   			String rcv = runsql.getData("rcvItm");
   			if(rcv == null){ rcv = "" ;}
   			vCtnRcv.add(rcv);
   			vManRcv.add(runsql.getData("man_rcv"));
   			vCtnSts.add(runsql.getData("lsts").trim());
   			vCtnInv.add(runsql.getData("lpas").trim());
   			vCtnDate.add(runsql.getData("lstd").trim());
   			vCtnTime.add(runsql.getData("lstt").trim());
   			
   			sPrepStmt = "with skuf as(" 
   		     + "select  cono, casn, cctn, csku"
   		     + " from iptsfil.ipanitm"
   		     + " where cono = '" + sZPo + "' and casn='" + sAsn + "' and cctn='" + ctn + "'" 
   		     + " group by cono, casn, cctn, csku)"
   		     + " select cctn, count(*) as numitm"
   		     + " from skuf a"
   		     + " group by cctn order by cctn"
   		    ;
   			RunSQLStmt sqlctn = new RunSQLStmt();
   			sqlctn.setPrepStmt(sPrepStmt);
   			sqlctn.runQuery();
   			if(sqlctn.readNextRecord())
   	   		{
   				vCtnItm.add(sqlctn.getData("numitm"));
   	   		}   			
   		}
   		
   		CallAs400SrvPgmSup srv = new CallAs400SrvPgmSup();
   		sCtnNum = srv.cvtToJavaScriptArray( vCtnNum.toArray(new String[]{}) );
   		sCtnShp = srv.cvtToJavaScriptArray( vCtnShp.toArray(new String[]{}) );
   		sCtnRcv = srv.cvtToJavaScriptArray( vCtnRcv.toArray(new String[]{}) );
   		sCtnItm = srv.cvtToJavaScriptArray( vCtnItm.toArray(new String[]{}) );
   		sManRcv = srv.cvtToJavaScriptArray( vManRcv.toArray(new String[]{}) );
   		sCtnSts = srv.cvtToJavaScriptArray( vCtnSts.toArray(new String[]{}) );
   		sCtnInv = srv.cvtToJavaScriptArray( vCtnInv.toArray(new String[]{}) );
   		sCtnDate = srv.cvtToJavaScriptArray( vCtnDate.toArray(new String[]{}) );
   		sCtnTime = srv.cvtToJavaScriptArray( vCtnTime.toArray(new String[]{}) );
   		
   	    runsql.disconnect();
   	    runsql = null;   		
   }
   else if(sAction.equals("Item"))
   {
	    sCtnNum = sCtn; 
   	   	String sPrepStmt = "with ctnf as(" 
    	 + " select cono, casn, cctn, csku, dec(sum(cqty),9,0) as cqty"
    	 + " from iptsfil.ipanitm"
    	 + " where cono = '" + sZPo + "' and casn='" + sAsn + "'"
    	 + " and cctn='" + sCtn + "'" 
    	 + " group by cono, casn, cctn, csku)"
    	 + ", skuf as ( "
    	 + " select cctn, csku, cqty"
    	 + " , case when (select cqty from iptsmod.IpBrCtnD where BCTNONO = cono and BCtnCtn=cctn and BCTNASN=casn) is not null" 
    	 + " then (select cqty from iptsmod.IpBrCtnD where BCTNONO = cono and BCtnCtn=cctn and BCTNASN=casn)"
         + " else 0 end as rcvItm "         
         + ", hdr.ides, clrn, snam, hdr.ivst"
         + ", case when (select max(ugtin) from iptsfil.IPUPCXF where hdr.iCls=uCls and hdr.iVen = uven" 
         + " and hdr.iSty = uSty and hdr.iClr = uClr and hdr.iSiz = uSiz and substr(ugtin,1,1) <> '4' )  is not null" 
         + " then (select max(ugtin) from iptsfil.IPUPCXF where hdr.iCls=uCls and hdr.iVen = uven "
         + " and hdr.iSty = uSty and hdr.iClr = uClr and hdr.iSiz = uSiz and substr(ugtin,1,1) <> '4' )" 
         + " else ' '  end as ugtin"         
		 + " , case when (select substr(BCTN###,35,4) from iptsmod.IpBrCtnD where BCTNONO = cono and BCtnCtn=cctn and BCTNASN=casn) is not null"
		 + " and (select substr(BCTN###,35,4) from iptsmod.IpBrCtnD where BCTNONO = cono and BCtnCtn=cctn and BCTNASN=casn) <>' '"
		 + " then (select dec(substr(BCTN###,35,4),4,0) from iptsmod.IpBrCtnD where BCTNONO = cono and BCtnCtn=cctn and BCTNASN=casn)"
		 + " else '0000' end as empnum "
		 + ", iseq"
		 + ", (select  dec(sum(pqrs),9,0) from iptsfil.IpRLogI where pono = cono and pseq=iseq ) as man_rcv"
         + " from ctnf a" 
         + " inner join iptsfil.IpItHDr hdr on hdr.isku=csku"
         + " inner join iptsfil.IpColor on hdr.iclr=cclr"
         + " inner join iptsfil.IpSizes on hdr.isiz=ssiz"
         + " left join iptsfil.IpPoItm ip on ip.iono=cono and ip.icls=hdr.icls and ip.iven=hdr.iven and ip.isty=hdr.isty and ip.iclr=hdr.iclr and ip.isiz=hdr.isiz"
         + ")"
    	 + " select cctn, csku, cqty,rcvItm, ides, clrn, snam, ivst,ugtin"
    	 + " , case when empnum > 0 then digits(empnum) else '0000' end as empnum"
    	 + " , case when empnum > 0 then (select ename from rci.rciemp where erci=empnum)"    	 
    	 + " else ' ' end as empname"
    	 + ", iseq"
    	 + ", case when man_rcv is not null then man_rcv else 0 end as man_rcv"
    	 + " from skuf" 
    	 + " order by csku"    	 
    	;

   		System.out.println(sPrepStmt);
   		
   		RunSQLStmt runsql = new RunSQLStmt();
   	    runsql.setPrepStmt(sPrepStmt);
   		runsql.runQuery();
   		Vector<String> vSku = new Vector<String>();
   		Vector<String> vCtnShp = new Vector<String>();
   		Vector<String> vCtnRcv = new Vector<String>();
   		Vector<String> vDesc = new Vector<String>();
   		Vector<String> vColor = new Vector<String>();
   		Vector<String> vSize = new Vector<String>();
   		Vector<String> vVenSty = new Vector<String>();
   		Vector<String> vUpc = new Vector<String>();
   		Vector<String> vRcvUser = new Vector<String>();
   		Vector<String> vSeq = new Vector<String>();
   		Vector<String> vManRcv = new Vector<String>();
   		
   		while(runsql.readNextRecord())
   		{
   			vSku.add(runsql.getData("csku"));
   			vCtnShp.add(runsql.getData("cqty"));
   			vCtnRcv.add(runsql.getData("rcvItm"));
   			String desc = runsql.getData("ides");
   			desc = desc.replace("'", "`");
   			vDesc.add(desc);
   			vColor.add(runsql.getData("clrn"));
   			vSize.add(runsql.getData("snam"));
   			vVenSty.add(runsql.getData("ivst"));
   			vUpc.add(runsql.getData("ugtin"));
   			String emp = runsql.getData("empnum");
   			String empnm = runsql.getData("empname");
   			vRcvUser.add(emp + " - " + empnm);
   			vSeq.add(runsql.getData("iseq"));
   			vManRcv.add(runsql.getData("man_rcv"));
   		}
   		
   		CallAs400SrvPgmSup srv = new CallAs400SrvPgmSup();
   		sSku = srv.cvtToJavaScriptArray( vSku.toArray(new String[]{}) );
   		sCtnShp = srv.cvtToJavaScriptArray( vCtnShp.toArray(new String[]{}) );
   		sCtnRcv = srv.cvtToJavaScriptArray( vCtnRcv.toArray(new String[]{}) );
   		sDesc = srv.cvtToJavaScriptArray( vDesc.toArray(new String[]{}) );
   		sColor = srv.cvtToJavaScriptArray( vColor.toArray(new String[]{}) );
   		sSize = srv.cvtToJavaScriptArray( vSize.toArray(new String[]{}) );
   		sVenSty = srv.cvtToJavaScriptArray( vVenSty.toArray(new String[]{}) );
   		sUpc = srv.cvtToJavaScriptArray( vUpc.toArray(new String[]{}) );
   		sRcvUser = srv.cvtToJavaScriptArray( vRcvUser.toArray(new String[]{}) );
   		sSeq = srv.cvtToJavaScriptArray( vSeq.toArray(new String[]{}) );
   		sManRcv = srv.cvtToJavaScriptArray( vManRcv.toArray(new String[]{}) );   		
   		
   	    runsql.disconnect();
   	    runsql = null;   		
   }
%>
sCtnNum = [<%=sCtnNum%>]
<br>sCtnShp = [<%=sCtnShp%>]
<br>sCtnRcv = [<%=sCtnRcv%>]
<br>sSku = [<%=sSku%>]
<br>sCtnItm = [<%=sCtnItm%>]
<br>Desc = [<%=sDesc%>]
<br>Color = [<%=sColor%>]
<br>Size = [<%=sSize%>]
<br>VenSty = [<%=sVenSty%>]
<br>Upc = [<%=sUpc%>]
<br>sCtnSts = [<%=sCtnSts%>]
<br>sCtnInv = [<%=sCtnInv%>]
<br>sCtnDate = [<%=sCtnDate%>]
<br>sCtnTime = [<%=sCtnTime%>]


<script name="javascript1.2">
var asn = "<%=sAsn%>";
var asndt = "<%=sAsnDt%>";
var po = "<%=sPo%>";
var ctn = [<%=sCtnNum%>];
var shp = [<%=sCtnShp%>];
var rcv = [<%=sCtnRcv%>];
var itm = [<%=sCtnItm%>];
var sku = [<%=sSku%>];
var selctn = "<%=sCtnNum%>";
var desc = [<%=sDesc%>];
var color = [<%=sColor%>];
var size = [<%=sSize%>];
var vensty = [<%=sVenSty%>];
var upc = [<%=sUpc%>];
var rcvuser = [<%=sRcvUser%>];
var seq = [<%=sSeq%>];
var manRcv = [<%=sManRcv%>];
var ctnSts = [<%=sCtnSts%>];
var ctnInv = [<%=sCtnInv%>];
var ctnDate = [<%=sCtnDate%>];
var ctnTime = [<%=sCtnTime%>];

var action = "<%=sAction%>";
if(action == "Carton"){ parent.showASNDtl(po, asn, asndt, ctn, shp, rcv, itm, manRcv
		, ctnSts, ctnInv, ctnDate, ctnTime) }
else if(action == "Item"){ parent.showASNItem(po, asn, asndt, selctn, sku, shp, rcv
		, desc, color, size, vensty, upc, rcvuser, seq, manRcv); }
</script>

<%}%>








