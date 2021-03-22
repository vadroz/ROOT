<%@ page import="rciutility.RunSQLStmt, java.sql.*
	, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%   
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuClsDim.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
      String sStrAllowed = session.getAttribute("STORE").toString();    
              	  
  	  String sPrepStmt = "select SCSTR,ScIncl"
  		   	 + " from rci.MOSTRCON"  		   	 
  	       	 + " order by ScStr";       	
  	      	
  	  System.out.println(sPrepStmt);
  	       	
  	  ResultSet rslset = null;
  	  RunSQLStmt runsql = new RunSQLStmt();
  	  runsql.setPrepStmt(sPrepStmt);		   
  	  runsql.runQuery();
  	    		   		   
  	  Vector<String> vStr = new Vector<String>();
  	  Vector<String> vIncl = new Vector<String>();
  	    		   		   
  	  while(runsql.readNextRecord())
  	  {
  		  vStr.add(runsql.getData("SCSTR").trim());
  		  vIncl.add(runsql.getData("ScIncl").trim());  		
  	  }  
  	  
  	  CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
  	  String [] sStr = vStr.toArray(new String[]{});
  	  String [] sIncl = vIncl.toArray(new String[]{});  	 
%>

<html>
<head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<style type="text/css" media="print">
  @page { transform: rotate(90deg); }
  .NonPrt  { display:none; }
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
 

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
}
//==============================================================================
// add Ctl comments
//==============================================================================
function chgStrIncl(str, incl)
{
   if(incl == "Y"){ incl = "X"; }
   else{ incl = "Y"; }
   
   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmCommt"

   var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='MozuStrConsolidateSv.jsp'>"
       + "<input class='Small' name='Str'>"
       + "<input class='Small' name='Incl'>"   
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Str.value = str;
   window.frame1.document.all.Incl.value = incl;
    
   //alert(html)
   window.frame1.document.frmAddComment.submit();
   hidePanel();
}
 
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
 
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<title>Mozu Consolidate</title>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
   <table  class="tbl01" id="tblClaim">
     <tr>       
      <td ALIGN="center" VALIGN="TOP"nowrap>      
      <span id="spnHdrImg"><img src="Sun_ski_logo4.png" height="50px" alt="Sun and Ski Patio"></span>
      <br>Mozu - Consolidate Stock On-Hand Inclusion Tool 
      <br>
       </b>
       </td>       
      </tr>

    <tr class="NonPrt">
      <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        &nbsp;&nbsp;&nbsp;
      </td>
    </tr>
     
    <tr>
      <td colspan=3 align=center>
         <table class="tbl02">
           <tr class="trHdr01">
              <th class="th02" nowrap>Store</th>
              <%for(int i=0; i < sStr.length; i++){%>
              	<th class="th02" nowrap><%=sStr[i]%></th>  
              <%}%>                          
           </tr>
            
           <%String sCss1="trDtl04";%>           
              <tr class="<%=sCss1%>">
                 <td class="td12" nowrap>Include</td>
                 <%for(int i=0; i < sStr.length; i++){%>
                 	<td class="td12" <%if(!sIncl[i].equals("Y")){%>style="background: pink;"<%}%>  nowrap>
                    	<a href="javascript: chgStrIncl('<%=sStr[i]%>', '<%=sIncl[i]%>' )"><%=sIncl[i]%></a>                  
                 	</td>  
                 <%}%>                               
              </tr>
           
           <!----------------------- end of table ------------------------>                 
         </table>
      </td>
    </tr>
    
    
   </table>
 </body>
</html>
<%}%>






