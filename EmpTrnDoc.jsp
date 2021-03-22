<%@ page import="java.io.*, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EmpTrnDoc.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String sDocPath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Emp_Test";
   //String sDocPath = "/var/tomcat4/webapps/ROOT/Emp_Test";
   File dir = new File(sDocPath);
   //System.out.println(sDocPath);
   if (!dir.exists()) {  dir.mkdirs(); }
   File[] signs = dir.listFiles();
   //System.out.println(signs.length);

%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }
	td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2{ background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }

     div.Cal { position:absolute; background-attachment: scroll;
               border: black solid 2px; width:300; background-color:yellow; z-index:10;
               text-align:left; font-size:18px;
               animation-name: example;
               animation-duration: 1s;
               animation-iteration-count: infinite;
               padding: 10px;               
               }
               
     div.dvWarn { position: absolute;  top: expression(this.offsetParent.scrollTop+10); left:20px; background-attachment: scroll;
              border: red solid 3px; width:300px;  z-index:50; padding:3px;
              text-align:center; font-size:14px}
                        
	@keyframes example {
    from {background-color: red;}
    to {background-color: yellow;}
}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Dtl   {text-align:left; font-family:Arial; font-size:12px; }
        td.Dtl1  {background-color: blue; color:white; border-bottom: black solid 1px; text-align:center; font-family:Arial; font-size:11px; font-weight:bold}
        td.Dtl2  {background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Dtl3   {text-align:center; font-family:Arial; font-size:12px; }
        .Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:2px; font-family:Arial; font-size:10px }
</style>
<script language="JavaScript1.2">
</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<script>
function bodyload()
{
	var pos = getObjPosition(document.all.spnLoss);
	document.all.dvLoad.innerHTML = "Make Sure to print out your<br>completion certificate!!!";
	document.all.dvLoad.style.pixelLeft = pos[0] - 500;
	document.all.dvLoad.style.pixelTop = pos[1] - 20;	
}
</script>
<!-------------------------------------------------------------------->


<BODY onload="bodyload()">
<!-- ----------------------------------------------------------------------- -->
<div id="dvLoad" class="Cal"></div>
<!-- ----------------------------------------------------------------------- -->
<p align="center"> <b>RETAIL CONCEPTS, INC.
                   <br>Employee Training Documents</b><br>

  <br><a href="../"><font color="red" size="-1">Home</font></a>

  <table class="DataTable" align="center" >
     <tr>
       <th class="DataTable" >Document</th>
     </tr>
       <%for(int i=0; i<signs.length;i++){%>
          <tr>
            <td class="DataTable" >
                  <%if(signs[i].getName().indexOf(".url") < 0){%>
                     <a href="<%=sDocPath.substring(sDocPath.lastIndexOf("ROOT/") + 5) + "/" + signs[i].getName()%>"><%=signs[i].getName()%></a>
                  <%}
                  else {%>
                     <%
                       try{
                           FileInputStream fstream = new FileInputStream(signs[i]);
                           DataInputStream ins = new DataInputStream(fstream);
                           BufferedReader br = new BufferedReader(new InputStreamReader(ins));
                           String strLine;
                           String sUrl = "";
                           while ((strLine = br.readLine()) != null)
                           {
                              if(strLine.indexOf("URL=") >= 0)
                              {
                                 sUrl = strLine.substring(strLine.indexOf("URL=") + 4);
                              }
                           }

                     %>
                         <a href="<%=sUrl%>" target="_blank"><%=signs[i].getName()%>
                             <%if(signs[i].getName().indexOf("Loss") >= 0){%>
                                 <span id="spnLoss"></span>
                             <%}%>
                         </a>
                     <%
                           ins.close();
                      }
                      catch (Exception e)
                      {
                         System.err.println("Error: " + e.getMessage());
                      }
                     %>
                  <%}%>
            </td>
       <%}%>
      </td>
     </tr>
  </table><br>
  <div class="dvWarn">
      <span style="font-size:18px;"><b>ATTENTION!!!</b></span>
      <p style="text-align:left; ">You must notify Store Operations of all rehires by sending an ACTION 
          to the "Training(Training Tests,General)" Action Group.
          Failure to do so may result in inaccurate reporting.
    </div>
</BODY>
</HTML>
<%}%>