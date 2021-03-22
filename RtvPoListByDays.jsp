<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup, java.text.*, java.sql.*, java.util.*"%>
<%
   String sSelVen = request.getParameter("Ven");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   
   java.util.Date dCurDate = new java.util.Date();
   SimpleDateFormat sdfISO = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat sdfMDY = new SimpleDateFormat("MM/dd/yyyy");

   String sPrepStmt = "with prtf as ("
	+ " select  iono, i.idiv, i.icls, i.iven, i.isty, iadi, sum(iqty - itqr) as qty" 
	+ ", sum((iqty - itqr) *  h.iret) as ret" 
	+ ", rci.POPRTCNT(i.icls, i.iven, i.isty," + sFrom + "," + sTo + ") as po_num_prnt"
   	+ " from iptsfil.IpPoItm i" 
	+ " inner join iptsfil.IpItHdr h on h.icls = i.icls and h.iven = i.iven"
   	+ " and h.isty = i.isty and h.iclr = i.iclr and h.isiz = i.isiz"
   	+ " where  i.iven  = " + sSelVen +" and  ierr <> 'C'" 
   	+ " and iadi > current date + " + sFrom + " days and iadi <= current date + " + sTo + " days"
   	+ " and iatt01 in (2, 3)"
   	+ " and not exists(select 1 from rci.MoChild where mcsite ='11961   ' and mccls=h.icls and mcven=h.iven and mcsty=h.isty and mcclr=h.iclr and mcsiz=h.isiz)"
   	+ " and (ilri >= (current date - 365 days) or ilri = '0001-01-01')" 
	+ " group by iono, i.idiv, i.icls, i.iven, i.isty, iadi"
   	+ ")"
   	+ "select iono, idiv, dnam, iadi, dec(sum(qty),9,0) as qty, dec(sum(ret),11,2) as ret"
   	+ ", dec(sum(po_num_prnt),9,0) as po_num_prnt" 
   	+ " from prtf"   	
   	+ " left join iptsfil.IpDivsn on idiv=ddiv"   	
   	+ " group by iono, idiv, iadi, dnam "
   	+ " order by iadi, idiv, iono";
   
   sPrepStmt += "";
   
   System.out.println(sPrepStmt);

   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);

   ResultSet rs = runsql.runQuery();

   int iNumOfRec = 0;
    
   Vector<String> vPoNum = new Vector<String>();
   Vector<String> vDiv = new Vector<String>();
   Vector<String> vDivNm = new Vector<String>();
   Vector<String> vAntDt = new Vector<String>();
   Vector<String> vQty = new Vector<String>();
   Vector<String> vRet = new Vector<String>();
   Vector<String> vNumPrt = new Vector<String>();
   
   while(runsql.readNextRecord())
   {
	   vPoNum.add(runsql.getData("IONO").trim());
	   vDiv.add(runsql.getData("IDIV").trim());
	   vDivNm.add(runsql.getData("DNAM").trim());
	   vAntDt.add(runsql.getData("IADI").trim());
	   vQty.add(runsql.getData("QTY").trim());
	   vRet.add(runsql.getData("RET").trim());
	   vNumPrt.add(runsql.getData("po_num_prnt").trim());
       iNumOfRec++;
   }

   CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
      
   String [] sPoNum = vPoNum.toArray(new String[0]);
   String [] sDiv = vDiv.toArray(new String[0]);
   String [] sDivNm = vDivNm.toArray(new String[0]);
   String [] sAntDt = vAntDt.toArray(new String[0]);
   String [] sQty = vQty.toArray(new String[0]);
   String [] sRet = vRet.toArray(new String[0]);
   String [] sNumPrt = vNumPrt.toArray(new String[0]);
      
   runsql.disconnect();
   runsql = null;

%>

<script name="javascript1.2">
var poNum = [<%=srvpgm.cvtToJavaScriptArray(sPoNum)%>];
var div = [<%=srvpgm.cvtToJavaScriptArray(sDiv)%>];
var divNm = [<%=srvpgm.cvtToJavaScriptArray(sDivNm)%>];
var antDt = [<%=srvpgm.cvtToJavaScriptArray(sAntDt)%>];
var qty = [<%=srvpgm.cvtToJavaScriptArray(sQty)%>];
var ret = [<%=srvpgm.cvtToJavaScriptArray(sRet)%>];
var num_prt = [<%=srvpgm.cvtToJavaScriptArray(sNumPrt)%>];

parent.showPoNum(poNum, div, divNm, antDt, qty, ret, num_prt);
</script>


