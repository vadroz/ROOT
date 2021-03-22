<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect, rciutility.RunSQLStmt
 , rciutility.CallAs400SrvPgmSup, java.text.SimpleDateFormat, java.sql.*, java.util.*"
%>
<%
      StoreSelect select = new  StoreSelect();

      int iNumOfStr = select.getNumOfStr();
      String sStr = select.getStrNum();
      String sStrName = select.getStrName();
      
      ClassSelect clssel = new ClassSelect();
      String sDiv = clssel.getDivNum();
      String sDivName = clssel.getDivName();
      String [] sDivArr = clssel.getDivArr();
      
   // get division groups
      String sPrepStmt = "select grpn, div from rci.DIVGRPS"
    	   + " order by GRPC, DIV";
   	  //System.out.println(sPrepStmt);
      ResultSet rslset = null;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      runsql.runQuery();
      
      Vector<String> vGrpNm = new Vector<String>();
      Vector<String> vDiv = new Vector<String>();
      
      while(runsql.readNextRecord())
      {
    	  vGrpNm.add(runsql.getData("grpn").trim());
    	  vDiv.add(runsql.getData("div").trim());
      }
      
      String [] sGrpNm = (String []) vGrpNm.toArray(new String[vGrpNm.size()]);
      String [] sGrpDiv = (String []) vDiv.toArray(new String[vDiv.size()]);
      
      CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
      String sGrpNmJva = srvpgm.cvtToJavaScriptArray(sGrpNm);
      String sGrpDivJva = srvpgm.cvtToJavaScriptArray(sGrpDiv);
      srvpgm = null;
      
      vDiv.toArray();
      runsql.disconnect();
      runsql = null;
%>
<header>
<title>Inventory Summary</title>
</header>
<style>
	#trMultDiv { display:none}
  	#trSingleDiv { display:block}
</style>
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var Store = [<%=sStr%>];
var StrName = [<%=sStrName%>];

var Div = [<%=sDiv%>];
var DivNm = [<%=sDivName%>];
var MultView = false;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   popStoreSelect();
   popDivSelect();
}

//==============================================================================
// populate store selection
//==============================================================================
function popStoreSelect() 
{
    
   	//  clear current classes
    for (var i = document.all.Store.length; i >= 0; i--) { document.all.Store.options[i] = null; }
   	//  populate the class list
    for (var i=0; i < Store.length; i++)
    {
    	document.all.Store.options[i] = new Option(Store[i] + " - " + StrName[i], Store[i]);
    }
    document.all.Store.focus();
}
//==============================================================================
//populate division selection
//==============================================================================
function popDivSelect() 
{
	//  clear current classes
    for (var i = document.all.Div.length; i >= 0; i--) { document.all.Div.options[i] = null; }
	//  populate the class list
    for (var i=0; i < Div.length; i++)
    {
    	document.all.Div.options[i] = new Option(DivNm[i], Div[i]);
    }
    document.all.Div.selectedIndex = 1;
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(){

  var error = false;
  var msg = " ";
  
  var str = document.all.Store.options[document.all.Store.selectedIndex].value;  
  var strnm = StrName[document.all.Store.selectedIndex].text;
  
  var divMult = document.all.DivM;
  var divarr = new Array();
  divarr[0] = document.all.Div.value.trim();
  
  name = DivNm[document.all.Div.selectedIndex];
  var a = name.indexOf("-");
  var divnm = name.substring(a+1);
  
  //get selected divisions  
  var divsel = false;
  for(var i=0, j=0; i < divMult.length; i++ )
  {
     if(divMult[i].checked)
     {
        divsel=true;
        divarr[j] = divMult[i].value;
        j++;
     }
     if(!MultView){ divMult[i].checked = false; }
  }  

  if (error) alert(msg);
  else{sbmReport(str, strnm, divarr, divnm); } 
}
//==============================================================================
//SUBMIT report
//==============================================================================
function sbmReport(str, strnm, div, divnm)
{
	var url = "InventorySum.jsp?Store=" + str
	 + "&StrName=" + strnm
	;
	
	for(var i=0; i < div.length; i++) { url += "&Div=" + div[i]; }
	
	if(!MultView){ url += "&DivName=" + divnm; }
	
	window.location.href = url;
}
//==============================================================================
//check division by selected group
//==============================================================================
function setAllDiv(chk)
{
	var divfld = document.all.DivM;
	for(var i=0; i < divfld.length; i++)
	{
		divfld[i].checked = chk;
	}
}
//==============================================================================
//check division by selected group
//==============================================================================
function checkDivGrp(grp)
{
	var divfld = document.all.DivM;
	for(var i=0; i < divfld.length; i++)
	{
		divfld[i].checked = false;
		for(var j=0; j < ArrGrp.length; j++)
		{
			var a = ArrGrp[j], b = ArrDiv[j], c = divfld[i].value;
			var t = a==grp, v = b == c;
			if(ArrGrp[j]==grp && ArrDiv[j] == divfld[i].value)
			{
				divfld[i].checked = true;
			}
		}
	}
}
//==============================================================================
//switch between single and multiple divisions selections
//==============================================================================
function switchDiv(group)
{
	var single = document.all.trSingleDiv;
	var mult = document.all.trMultDiv;
	var sdisp = "none";
	var mdisp = "block";

	if(group == "SINGLE"){ sdisp = "block"; mdisp = "none"; MultView = false;}
	else { MultView = true; }

	for(var i=0; i < single.length; i++){ single[i].style.display = sdisp; }
	for(var i=0; i < mult.length; i++){ mult[i].style.display = mdisp; }
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  
  <TR bgColor=moccasin>    
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Inventory Summary - Selection</B>

      <TABLE border=0>
        <TBODY>
        <!-- ------------- Stores  --------------------------------- -->
        <TR>
          <TD align=right>Store:</TD>
          <TD align=left colspan="3">
             <SELECT name="Store"></SELECT>             
          </TD>
        </TR>
        <!-- ------------- Division  --------------------------------- -->
        <TR id="trSingleDiv">
          <TD align=right>Division:</TD>
          <TD align=left colspan="3">
             <SELECT name="Div"></SELECT>             
          </TD>
        </TR>
        
        <TR id="trSingleDiv">
            <TD class="Cell1" align=center colspan=4>
              <button class="Small" onClick="switchDiv('MULTIPLE')">Multiple Divisions</button>
           </td>
        </TR>
        
        
        <!-- ===================== Multiple Division Selection ============= -->
        <TR id="trMultDiv">
          <TD class="Cell" >Division:</TD>   
          <TD class="Small" colspan=4 nowrap>
            <%for(int i=0; i < sDivArr.length; i++){%>
               <input class="Small" name="DivM" type="checkbox" value="<%=sDivArr[i]%>"> <%=sDivArr[i]%>
               <%if(i > 0 && i % 14 == 0){%><br><%}%>
            <%}%>
            <br>
            <%if(iNumOfStr > 1) {%>
              <br><button class="Small" onClick="setAllDiv(true)">All Divisions</button> &nbsp;
              
              <button onclick='checkDivGrp(&#34;SKI&#34;)' class='Small'>Ski</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;OUTDOOR&#34;)' class='Small'>Outdoor</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;CYCLING&#34;)' class='Small'>Cycling</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;WATER&#34;)' class='Small'>Water</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;SKATE&#34;)' class='Small'>Skate</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;ACTIVE APPAREL&#34;)' class='Small'>Active Apparel</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;FOOTWEAR&#34;)' class='Small'>Footwear</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;OTHER&#34;)' class='Small'>Other</button> &nbsp; &nbsp;
                          
              <button class="Small" onClick="setAllDiv(false)">Reset</button><br><br>
              <%}%>
          </TD>
        </TR>
        <TR id="trMultDiv">
           <TD class="Cell1" align=center colspan=5>
              <button class="Small"  onClick="switchDiv('SINGLE')">Single Divisions</button>
           </td>
        </TR>
        
        
        
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD align=center colSpan=5>
               <button onclick="Validate()">Submit</button>
               &nbsp;&nbsp;&nbsp;&nbsp;
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
