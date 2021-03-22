<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*, java.text.*"%>
<%
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MenuUserLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	int iNumOfItm = 0;   
	   
	boolean bKiosk = session.getAttribute("USER") == null;
	String sUser = "KIOSK";
	if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }

	ResultSet rslset = null;
	RunSQLStmt runsql = new RunSQLStmt();


    String sPrepStmt = "select uaappl, count(*) as count"
      + " from rci.PrUserAp"
      + " group by uaappl"
      + " order by uaappl";

    //System.out.println(sPrepStmt);

    SimpleDateFormat sdfISO = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfUSA = new SimpleDateFormat("MM/dd/yyyy");

    
    runsql.setPrepStmt(sPrepStmt);
    runsql.runQuery();
    
    Vector<String> vAuth = new Vector<String>();
    Vector<String> vNumUsr = new Vector<String>();
    
    while(runsql.readNextRecord())
    {       
       vAuth.add(runsql.getData("uaappl").trim());
       vNumUsr.add(runsql.getData("count").trim());
    }
	    
	runsql.disconnect();
	runsql = null;
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<title>Menu/User List</title>
<script src="String_Trim_function.js"></script>
<SCRIPT>

//--------------- Global variables -----------------------
 
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);    
}

//==============================================================================
//retreive vendors
//==============================================================================
function getUserByAuth(code)
{
	var url = "UserAuthList.jsp?Code=" + code
	 + "&Action=UserByCode"
	 ;
	
	if(isIE || isSafari){ window.frame1.location.href = url; }
	else if(isChrome || isEdge) { window.frame1.src = url; }    
}
//==============================================================================
//popilate division selection
//==============================================================================
function showUserLst(code, user,str,name,term,dept,title,lastdt,commt)
{	
	var hdr = "Authorization Code: " + code;
    var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popUserLst(code, user,str,name,term,dept,title,lastdt,commt)
	       + "</td></tr>"
	     + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "700";}
	  else { document.all.dvItem.style.width = "auto";}
	      
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.left=getLeftScreenPos() + 30;
	  document.all.dvItem.style.top=getTopScreenPos() + 70;
	  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate panel
//==============================================================================
function popUserLst(code, user,str,name,term,dept,title,lastdt,commt)
{	
   var panel = "<div style='height: 450; overflow-y: scroll;'>" 
	+ "<table class='tbl02' id='tblMenu'>"
    + "<tr class='trHdr01'>"   
       + "<th class='th02'>User</th>"
       + "<th class='th02'>Str</th>"
       + "<th class='th02'>Name</th>"
       + "<th class='th02'>Term<br>Code</th>"
       + "<th class='th02'>Dept</th>"
       + "<th class='th02'>Title</th>"
       + "<th class='th02'>Last<br>Date</th>"
      // + "<th class='th02'>Comment</th>"
    + "</tr>"
    ;
    
    for(var i=0; i < user.length; i++)
    {
       panel += "<tr class='trDtl04'>"
          + "<td class='td11'><a href='javascript: getUserAuthLst(&#34;" + user[i] + "&#34;)'>" + user[i] + "</a></td>"
          + "<td class='td11'>" + str[i] + "</td>"
          + "<td class='td11' nowrap>" + name[i] + "</td>"
          + "<td class='td11'>" + term[i] + "</td>"
          + "<td class='td11'>" + dept[i] + "</td>"
          + "<td class='td11'>" + title[i] + "</td>"
          + "<td class='td11' nowrap>" + lastdt[i] + "</td>"
          //+ "<td class='td11' nowrap>" + commt[i] + "</td>"
       + "</tr>";
    }
   
    panel += "</table></div>"
        + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button>&nbsp;";
	        
	return panel;
}

//==============================================================================
//retreive vendors
//==============================================================================
function getUserAuthLst(user)
{
	var url = "UserAuthList.jsp?User=" + user
	 + "&Action=CodebyUser"
	 ;
	
	if(isIE || isSafari){ window.frame1.location.href = url; }
	else if(isChrome || isEdge) { window.frame1.src = url; }    
}
//==============================================================================
//popilate division selection
//==============================================================================
function showAuthLst(user, auth)
{	
	var hdr = "User: " + user;
  var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel(&#34;dvUser&#34;);' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popAuthLst(user, auth)
	       + "</td></tr>"
	     + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvUser.style.width = "900";}
	  else { document.all.dvUser.style.width = "auto";}
	     
	  document.all.dvUser.innerHTML = html;
	  document.all.dvUser.style.left=getLeftScreenPos() + 60;
	  document.all.dvUser.style.top=getTopScreenPos() + 80;
	  document.all.dvUser.style.visibility = "visible";
	}
//==============================================================================
//populate panel
//==============================================================================
function popAuthLst(user, auth)
{		   
 	var panel = "<table class='tbl02' id='tblMenu'>"
  	 + "<tr class='trHdr01'>"   
     + "<th class='th02' colspan='10'>Authorization List</th>"     
  	+ "</tr>"
  	;
  	
  	panel += "<tr class='trDtl04'>";
  	for(var i=0; i < auth.length; i++)
  	{
  		if(i % 10 == 0)
  		{
  			panel += "</tr><tr class='trDtl04'>";  			
  		}
    	panel += "<td class='td11'><a href='javascript: getMenuLst(&#34;" + auth[i] + "&#34;)'>" + auth[i] + "</a></td>" 
        
  	}
 	
 
  	panel += "</table>"
      + "<button onClick='hidePanel(&#34;dvUser&#34;);' class='Small'>Close</button>&nbsp;";
	        
	return panel;
}

//==============================================================================
// get menu list
//==============================================================================
function getMenuLst(auth)
{
	var url = "UserAuthList.jsp?Code=" + auth
	 + "&Action=MenubyCode"
	 ;
	
	if(isIE || isSafari){ window.frame1.location.href = url; }
	else if(isChrome || isEdge) { window.frame1.src = url; }    
}
//==============================================================================
//popilate division selection
//==============================================================================
function showMenuLst(code, menu, parent, sort, type, url )
{	
	var hdr = "Authorization Code: " + code;
  var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel(&#34;dvAuth&#34;);' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popMenuLst(code, menu, parent, sort, type, url )
	       + "</td></tr>"
	     + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvAuth.style.width = "700";}
	  else { document.all.dvAuth.style.width = "auto";}
	     
	  document.all.dvAuth.innerHTML = html;
	  document.all.dvAuth.style.left=getLeftScreenPos() + 90;
	  document.all.dvAuth.style.top=getTopScreenPos() + 90;
	  document.all.dvAuth.style.visibility = "visible";
}
//==============================================================================
//populate panel
//==============================================================================
function popMenuLst(code, menu, parent, sort, type, url )
{		   
 var panel = "<div style='height: 450; overflow-y: scroll;'>"  
  + "<table class='tbl02' id='tblMenu'>"
   + "<tr class='trHdr01'>"   
  	 + "<th class='th02'>Sort</th>"
     + "<th class='th02'>Menu</th>"
     + "<th class='th02'>Parent</th>"
     + "<th class='th02'>Type</th>"
     + "<th class='th02' nowrap>URL</th>" 
  + "</tr>"
  ;
  
  for(var i=0; i < menu.length; i++)
  {
     panel += "<tr class='trDtl04'>"
    	+ "<td class='td11'>" + sort[i] + "</td>"
        + "<td class='td11' nowrap>"  + menu[i] + "</td>"
        + "<td class='td11' nowrap>" + parent[i] + "</td>"        
        + "<td class='td11'>" + type[i] + "</td>"
        + "<td class='td11' nowrap><a href='" + url[i] + "' taget='_blank'>" + url[i] + "</a></td>"
     + "</tr>";
  }
 
  panel += "</table></div>"
      + "<button onClick='hidePanel(&#34;dvAuth&#34;);' class='Small'>Close</button>&nbsp;";
	        
	return panel;
}

//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel(objnm)
{
    document.getElementById(objnm).innerHTML = " ";
    document.getElementById(objnm).style.visibility = "hidden";
}
//==============================================================================
//reload page
//==============================================================================
function restart(){ window.location.reload(); }
</SCRIPT>

<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>

<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-- ================================================================ -->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-- ================================================================ -->
<div id="dvItem" class="dvItem"></div>
<div id="dvUser" class="dvItem"></div>
<div id="dvAuth" class="dvItem"></div>
<!-- ================================================================ -->

      <!--  beginning of table  -->
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Authorization / User List
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62; 
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;                          
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02">Authorization</th>
          <th class="th02">User</th>        
        </tr>
       
       <!-- ======================== Details =============================== -->
           <%
             String sSvAuth = vAuth.get(0);
           	 String sRowCls = "trDtl04";
           	 boolean bShow = true;
           %>            
           <%for(int i=0; i < vAuth.size(); i++){
        	   String sAuth = vAuth.get(i);
        	   
        	   if(!sSvAuth.equals(vAuth.get(i)) && sRowCls.equals("trDtl06")){ sRowCls = "trDtl04"; }
        	   else if(!sSvAuth.equals(vAuth.get(i)) && sRowCls.equals("trDtl04")){ sRowCls = "trDtl06"; }
        	   
        	   if(!sSvAuth.equals(vAuth.get(i))){bShow = true;}
        	   
        	   sSvAuth = vAuth.get(i);
           %>
              <tr id="trId" class="<%=sRowCls%>">
                <td class="td11" nowrap><%if(bShow){%><%=vAuth.get(i)%> (<%=vNumUsr.get(i)%>)<%}%></td>
                <td class="td11">
                   <table border=0>
                     <tr">
                <%
                sPrepStmt = "select uauser"
               		+ " from rci.PrUserAp"
                	+ " where uaappl = '" + vAuth.get(i) + "'"
                	+ " order by uauser";
                //System.out.println(sPrepStmt);
                
                ResultSet rslset1 = null;
            	RunSQLStmt runsql1 = new RunSQLStmt();
                runsql1.setPrepStmt(sPrepStmt);
                runsql1.runQuery();
                
                int iLine = 0;
                while(runsql1.readNextRecord())
                {       
                   String sUserApp = runsql1.getData("uauser").trim();
                %>                  
                  <%if(iLine > 0 && iLine % 13 == 0){%></tr><tr><%}%>
                  <td ><%=sUserApp%></td>
                <%
                   	
                	iLine++;
                }
            	    
            	runsql1.disconnect();
            	runsql1 = null;            
                %>
                  </tr>
                  </table>
                </td>
              </tr>              
           <% bShow = false;
           }%>
         </table>
      <!-- ======================== end Table =============================== -->
      </tr>
   </table>
 </body>
</html>
<%
}
%>