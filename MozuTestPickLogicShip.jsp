<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
    String sOrder = request.getParameter("ord");

	String sStmt = "Select "
	  + " AsSeq, AsNumItm, AsStrA, AsShip" 
	  + " from RCI.MoAlcWkS"
	  + " where AsOrd=" + sOrder
	  + " order by AsShip"
	  ;
	//System.out.println(sStmt);  
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();

	Vector vSeq = new Vector();
	Vector vNumItm = new Vector();
	Vector vStrArr = new Vector();
	Vector vShip = new Vector();
	
	boolean bRecordFound = false;
		
	while(runsql.readNextRecord())
	{
		bRecordFound = true;
		vSeq.add(runsql.getData("AsSeq").trim());
	    vNumItm.add(runsql.getData("AsNumItm").trim());
	    vStrArr.add(runsql.getData("AsStrA").trim());
	    vShip.add(runsql.getData("AsShip").trim());
	}
	rs.close();
	runsql.disconnect();
%>
<script>
var seq = new Array();
var numItm = new Array();
var str = new Array();
var ship = new Array();

<%for(int i=0; i < vSeq.size(); i++){%>
    seq[<%=i%>] = "<%=vSeq.get(i)%>";    
    numItm[<%=i%>] = "<%=vNumItm.get(i)%>";
    str[<%=i%>] = splitStr(numItm[<%=i%>], "<%=vStrArr.get(i)%>");
    ship[<%=i%>] = "<%=vShip.get(i)%>";
<%}%>

parent.setComb(seq, numItm, str, ship);
//=======================================================================
// split store and populate array
//=======================================================================
function splitStr(max, single)
{
	var stra = new Array();
	for(var i=0, j=0; i < max; i++)
	{
		stra[i] = single.substring(j, j+2);
		j += 2;
	}	
	return stra;
}
</script>
















