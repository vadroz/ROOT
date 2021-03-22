<%@ page import=" java.text.*, java.util.*"%>

<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}
</script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<div style="background: khaki; width: 250px; ">
    test div <br>
	<div style="background: cornSilk; width: auto; height: 240px; overflow: auto;">
	Test Table<br>
	
	<table cellPadding=0 cellSpacing=0 style="background:#e9e9e9; font-size:14px;" border=1>
	<tr>
   	<th>Col1</th>
   	<th>Col2</th>
   	<th>Col3</th>
   	</tr>
   		<%for(int i=0; i < 200; i++){%>
   			<tr>
    			<td>a <%=i+1%></td>
    			<td>b <%=i+1%></td>
    			<td>c <%=i+1%></td>
   			</tr> 
   		<%}%>
	</TABLE>
	</div>
</div>
</BODY></HTML>
