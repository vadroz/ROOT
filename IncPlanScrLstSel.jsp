<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=IncPlanScrLstSel.jsp&APPL=ALL");
   }
   else
   {
	   String sPrepStmt = "select pyr# from rci.fsyper"
	    + " where pyr# < 2099"
	    + " group by pyr#"
	    + " order by pyr# desc";
	   //System.out.println(sPrepStmt);
	   ResultSet rslset = null;
	   RunSQLStmt runsql = new RunSQLStmt();
	   runsql.setPrepStmt(sPrepStmt);		   
	   runsql.runQuery();
	   
	   Vector<String> vYear = new Vector<String>(); 
	   
	   while(runsql.readNextRecord())
	   {
	      vYear.add(runsql.getData("pyr#"));
	   }
	   runsql.disconnect();
	   runsql = null;
%>
<HTML>
<HEAD>
<title>Inc.Plan Scores Entries Selection</title>
<META content="RCI, Inc." name="E-Commerce">

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

</HEAD>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<script name="javascript">

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var yridx = document.all.Year.selectedIndex;
  var year = document.all.Year.options[document.all.Year.selectedIndex].value;
  
  var qtr = 1;
  for(var i=0; i < document.all.Qtr.length; i++)
  {
	  if(document.all.Qtr[i].checked){qtr = document.all.Qtr[i].value; break;}
  }
  
  var scridx = document.all.ScrNm.selectedIndex;
  var scrcd = document.all.ScrNm.options[scridx].value;
  var scrnm = document.all.ScrNm.options[scridx].text;
   
  if (error) alert(msg);
  else{ sbmPlan(year, qtr,scrcd, scrnm); }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(year, qtr, scrcd, scrnm)
{
  var url = null;
  url = "IncPlanScrLst.jsp?"

  url += "Year=" + year
    + "&Qtr=" + qtr
    + "&ScrCd=" + scrcd
    + "&ScrNm=" + scrnm
    ;
  
  //alert(url)
  window.location.href=url;
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Incentive Plan Manual Score Entries - Selection</B>
        <br>
          <a href="/"><font color="red" size="-1">Home</font></a>
      <TABLE>
        <TBODY>    
        
        <TR>
          <TD id="tdDate2">Fiscal Year: &nbsp;
              <select name="Year">
               <%for(int i=0; i < vYear.size(); i++){%>
                   <option value="<%=vYear.get(i)%>"><%=vYear.get(i)%></option>
               <%}%>
               </select>
               <br>
               <br><b>Quarter:</b>&nbsp;
               <input name="Qtr" type="radio" value="1" checked>1 &nbsp; &nbsp;
               <input name="Qtr" type="radio" value="2">2 &nbsp; &nbsp;
               <input name="Qtr" type="radio" value="3">3 &nbsp; &nbsp;
               <input name="Qtr" type="radio" value="4">4 &nbsp; &nbsp;              
          </TD>
        </TR>
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD id="tdDate2">Score Type: &nbsp;
              <select name="ScrNm">
              	<option value="Survey">Chatmeter Customer Survey</option>
              	<option value="Compliance">Compliance</option>
              	<option value="Training">Training</option>
              	<option value="FlrLeader">Sales Floor Leader Success</option>
              </select>
              <br>
          </TD>
        </TR>   
       
        <!-- ================================================================================================= -->

        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center >
               <button onClick="Validate()">Submit</button>
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>
