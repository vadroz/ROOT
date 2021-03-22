<%@ page import="java.util.*, tagging.SnsTagStd"%>
<%
    String sSort = request.getParameter("Sort");
    if(sSort==null) sSort = "HIER";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=SnsTagStd.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sUsrStr = session.getAttribute("STORE").toString();
    boolean bAppl = false;
    if(session.getAttribute("TAG")!=null) bAppl = true;
    String sUser = session.getAttribute("USER").toString();

    SnsTagStd snstag = new SnsTagStd(sSort);

    int iNumOfTag = snstag.getNumOfTag();
    String [] sHier = snstag.getHier();
    String [] sHType = snstag.getHType();
    String [] sHierNm = snstag.getHierNm();
    String [] sShrAmt = snstag.getShrAmt();
    String [] sShrPrc = snstag.getShrPrc();
    String [] sPrcTresh = snstag.getPrcTrash();
    String [] sComment = snstag.getComment();
    String [] sSnsType = snstag.getSnsType();
    String [] sLoc = snstag.getLoc();
    String [] sApply = snstag.getApply();
    String [] sPicture = snstag.getPicture();
    String [] sMall = snstag.getMall();

    String sHierJsa = snstag.getHierJsa();
    String sHTypeJsa = snstag.getHTypeJsa();
    String sHierNmJsa = snstag.getHierNmJsa();
    String sShrAmtJsa = snstag.getShrAmtJsa();
    String sShrPrcJsa = snstag.getShrPrcJsa();
    String sPrcTreshJsa = snstag.getPrcTrashJsa();
    String sCommentJsa = snstag.getCommentJsa();
    String sSnsTypeJsa = snstag.getSnsTypeJsa();
    String sLocJsa = snstag.getLocJsa();
    String sApplyJsa = snstag.getApplyJsa();
    String sPictureJsa = snstag.getPictureJsa();
    String sMallJsa = snstag.getMallJsa();

    snstag.disconnect();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:10px;} a:visited { color:blue; font-size:10px;}  a:hover { color:blue; font-size:10px;}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

  tr.DataTable1 { background:#e7e7e7; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable2 { background:white; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable21 { background:#e7e7e7; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable3 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}

  td.DataTable { border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-bottom: darkred solid 1px;text-align:center;
                  padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: darkred solid 1px;}
  td.DataTable3 { border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 font-size:11px; font-weight:bold}

  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:300; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px }
  div.dvSelect { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:300; height:450;background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px }

  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}
</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Hier = [<%=sHierJsa%>];
var HType = [<%=sHTypeJsa%>];
var HierNm = [<%=sHierNmJsa%>];
var ShrAmt = [<%=sShrAmtJsa%>];
var ShrPrc = [<%=sShrPrcJsa%>];
var PrcTresh = [<%=sPrcTreshJsa%>];
var Comment = [<%=sCommentJsa%>];
var SnsType = [<%=sSnsTypeJsa%>];
var Loc = [<%=sLocJsa%>];
var Apply = [<%=sApplyJsa%>];
var Mall = [<%=sMallJsa%>];
var Picture = [<%=sPictureJsa%>];
var UsrStr = "<%=sUsrStr%>";
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt", "dvSelect"]);

  // show line selectively by Sensor Tags applyed columns
  selSnsTag(0, 0);
  document.all.selTagApply.selectedIndex=0

  window.document.focus();
}

//==============================================================================
// Load initial value on page
//==============================================================================
function chgTag(arg, action)
{
   var hdr = "Create Sensor Tag";
   if(action =='UPD') { hdr = "Update: " + Hier[arg] + " - " + HierNm[arg]}
   else if(action =='DLT') { hdr = "Delete: " + Hier[arg] + " - " + HierNm[arg]}

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
    + "<form name='Upload'  method='post'  enctype='multipart/form-data' action='SnsTagEnt.jsp'>"
         + popPanel(action)
    + "</form></td>"
    + "</tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 130;
   document.all.dvPrompt.style.visibility = "visible";

   if(action!="ADD") popPanelValue(arg, action);
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popPanel(action)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr><td class='Prompt2' nowrap id='tdDpt1'>Department/Class: &nbsp;</td>"
          + "<td class='Prompt'  id='tdDpt2'><input class='Small' name='Hier' size=4 maxlength=4>"
          + "<input name='HType' type='radio' value='P' checked>Dpt or &nbsp;"
          + "<input name='HType' type='radio' value='C'>Class &nbsp;"
          + "<input type='hidden' name='ShrAmt' value='0'>"
          + "<input type='hidden' name='ShrPrc' value='0'>"
          + "</td>"
      + "</tr>"
      + "<tr><td class='Prompt2' nowrap>Price Threshold: &nbsp;</td>"
          + "<td class='Prompt'><input name='PrcTresh' class='Small' size=30 maxlength=100></td>"
      + "</tr>"
      + "<tr><td class='Prompt2' nowrap>Sensor Type: &nbsp;</td>"
          + "<td class='Prompt'><input name='SnsType' class='Small' size=50 maxlength=50></td>"
      + "</tr>"
      + "<tr><td class='Prompt2' nowrap>Location: &nbsp;</td>"
          + "<td class='Prompt'><input name='Loc' class='Small' size=50 maxlength=50></td>"
      + "</tr>"
      + "<tr><td class='Prompt2' nowrap>Applied By: &nbsp;</td>"
          + "<td class='Prompt'><input name='Apply' class='Small' size=15 maxlength=15>"
            + "<input type='hidden' name='Action' class='Small' value='" + action + "'>"
            + "<input type='hidden' name='User' class='Small' value='<%=sUser%>'>"
          + "</td>"
      + "</tr>"
      + "<tr><td class='Prompt2' id='tdMall' nowrap>Mall: &nbsp;</td>"
          + "<td class='Prompt'  id='tdMall'><input name='Mall' type=radio class='Small' value='Y'>Yes &nbsp;  &nbsp;  &nbsp; "
          + "<input name='Mall'  id='tdMall' type=radio class='Small' value='N' checked>No</td>"
      + "</tr>"
      + "<tr><td class='Prompt2' nowrap>Comments: &nbsp;</td>"
          + "<td class='Prompt'><input name='Comment' class='Small' size=30 maxlength=50></td>"
      + "</tr>"
      + "<tr><td class='Prompt2'>Picture: &nbsp;</td>"
          + "<td class='Prompt'><input type='File' name='Doc' class='Small' size=50></td>"
      + "</tr>"

      if(action!='DLT') panel += "<tr><td class='Prompt1' colspan=4><button onClick='Validate(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
      else panel += "<tr><td class='Prompt1' colspan=4><button onClick='Validate(&#34;" + action + "&#34;)' class='Small'>Delete</button>&nbsp;"

     panel += "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
     panel += "</table>";
  return panel;
}

//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popPanelValue(arg, action)
{
  document.all.Hier.value = Hier[arg];
  // class or Dpt
  if(HType[arg]=="P")
  {
    document.all.HType[0].checked = true;
    document.all.HType[1].checked = false;
  }
  else
  {
    document.all.HType[0].checked = false;
    document.all.HType[1].checked = true;
  }


  document.all.ShrAmt.value = ShrAmt[arg];
  document.all.ShrPrc.value = ShrPrc[arg];
  document.all.PrcTresh.value = PrcTresh[arg].showSpecChar();
  document.all.SnsType.value = SnsType[arg].showSpecChar();
  document.all.Loc.value = Loc[arg];
  document.all.Apply.value = Apply[arg];
  document.all.Loc.value = Loc[arg];
  document.all.Comment.value = Comment[arg];

  if(Mall[arg] == 'Y'){document.all.Mall[0].checked = true; document.all.Mall[1].checked = false;}
  else {document.all.Mall[0].checked = false; document.all.Mall[1].checked = true;}

  // hide department and mall for update and delete
  document.all.tdDpt1.style.display = "none";
  document.all.tdDpt2.style.display = "none";
  document.all.tdMall[0].style.display = "none";
  document.all.tdMall[1].style.display = "none";
  document.all.tdMall[2].style.display = "none";

  // read only for deleted records
  if(action=="DLT")
  {
     document.all.ShrAmt.readOnly = true;
     document.all.ShrPrc.readOnly = true;
     document.all.PrcTresh.readOnly = true;
     document.all.Comment.readOnly = true;
     document.all.SnsType.readOnly = true;
  }
}
//--------------------------------------------------------
// Validate entry values
//--------------------------------------------------------
function Validate(action)
{
   var msg="";
   var error=false

   var hier = document.all.Hier.value.trim();
   var htype = "D";
   if(document.all.HType[1].checked) htype = "C";
   var prctrash =  document.all.PrcTresh.value.trim();
   var snstype = document.all.SnsType.value.trim();
   var loc = document.all.Loc.value.trim();
   var apply = document.all.Apply.value.trim();
   var comment =  document.all.Comment.value.trim();

   if(hier=="") { msg +="\nPlease Enter Department or Class"; error=true; }
   //if(prctrash!="" && isNaN(prctrash)) {msg +="\nPrice Threshold is not a numeric value"; error=true;}

   if(error) alert(msg)
   else
   {
      //alert(hier + "\n" + htype + "\n" + shramt + "\n" + shrprc + "\n" + prctrash + "\n" + snstype + "\n" + loc + "\n" + apply + "\n" + action)
      document.Upload.submit();
   }
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.innerHTML = " ";
   document.all.dvPrompt.style.visibility = "hidden";
   hidePanelSel();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanelSel()
{
   document.all.dvSelect.innerHTML = " ";
   document.all.dvSelect.style.visibility = "hidden";
}
//==============================================================================
// select Sensor Tag
//==============================================================================
function selSnsTag(tag, mall)
{
  var type =  tag;
  var row = ["trDC", "trNA", "trStore", "trMisc"]
  var rowobj = null;
  for(var i=0; i < row.length; i++)
  {
     {
        if (document.all[row[i]] != null)
        {
           for(var j=0; j < document.all[row[i]].length; j++)
           {
              rowobj = document.all[row[i]][j];
              var colMall = selColMall(rowobj, mall);

              if((type==0 || type==1 && i==0 || type==2 && i==1 || type==3 && (i==2 || i==4)
                || type==4 && i==3 || type==5 && i==4) && colMall)
              {
                 document.all[row[i]][j].style.display = "block";
              }
              else document.all[row[i]][j].style.display = "none";
           }
        }
     }
  }
  document.all.linkHome.focus();
}
//==============================================================================
// select Sensor Tag
//==============================================================================
function selColMall(row, mall)
{
  var tdMall = false;
  if(row.all.colMall != null)
  {
     if(mall == 0) { tdMall = true;}
     else if(mall == 1) { tdMall = (row.all.colMall.innerHTML == "Y");}
     else if(mall == 2) { tdMall = (row.all.colMall.innerHTML == "N"); }
  }
  return tdMall;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Sensor Tagging Standards
       <br>
       </b>

        <a id="linkHome" href="../"><font color="red" size="-1">Home</font></a>;
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead>
             <tr class="DataTable" style="position: relative; top: expression(this.offsetParent.scrollTop);">
               <th class="DataTable">Dept/<br>*Class</th>
               <th class="DataTable">Department (Class)<br>Name
               <%if(bAppl){%><br><a href="javascript:chgTag(0, 'ADD')">Add</a><%}%>
               </th>

               <%if(bAppl){%><th class="DataTable">C<br>h<br>g</th><%}%>

               <th class="DataTable">Price Point Threshold<br>
                  Only sensor tag<br> merchandise with a<br>retail price greater than:
               </th>
               <th class="DataTable">Sensor Tag<br>Type</th>
               <th class="DataTable">Sensor Tag<br>Location</th>
               <th class="DataTable">Tags<br>Applied By<br>
                  <span style="color:darkblue;font-size:10px">Show by Group:<br>
                     <select id="selTagApply" class="Small" onChange="selSnsTag(selTagApply.selectedIndex, selMall.selectedIndex)">
                      <option value="0">All</option>
                      <option value="1">DC</option>
                      <option value="2">N/A</option>
                      <option value="3">Store</option>
                      <option value="4">Other</option>
                  </select></span>
               </th>
               <th id="thComments" class="DataTable">Mall<br>
                   <select id="selMall" class="Small" onChange="selSnsTag(selTagApply.selectedIndex, selMall.selectedIndex)">
                      <option value="0">All</option>
                      <option value="1">Mall</option>
                      <option value="2">Non-Mall</option>
                   </select>
               </th>
               <th id="thComments" class="DataTable">Comments</th>
               <%if(bAppl){%><th class="DataTable">D<br>l<br>t</th><%}%>
             </tr>
           </thead>

        <!--------------------- Event Detail ----------------------------->
        <tbody style="overflow: auto">
        <%for(int i=0; i < iNumOfTag; i++){%>
           <%if(sHType[i].equals("D")) {%>
              <!-- ------------ Division line ------------------------- -->
              <tr class="DataTable3"><td class="DataTable1" colspan="17">
                    <%=sHier[i] + " - " + sHierNm[i]%></td>
           <%} else {%>
              <!-- ----------- Department class ----------------------- -->
              <%
                 String sTrName = "trMisc";
                 if(sApply[i].equals("N/A")) sTrName = "trNA";
                 else if(sApply[i].equals("Stores")) sTrName = "trStore";
                 else if(sApply[i].equals("DC")) sTrName = "trDC";
              %>
              <tr id="<%=sTrName%>" class="DataTable2<%if(sHType[i].equals("C")){%>1<%}%>">
                <%if(sHType[i].equals("C")){%>
                   <td class="DataTable" nowrap>*<%=sHier[i]%></td>
                <%}
                  else {%>
                    <td class="DataTable3" nowrap><%=sHier[i]%></td>
                <%}%>
                <td class="DataTable" nowrap>
                   <%if(!sPicture[i].equals("")){%>
                      <a target="_blank" href="SnsTagStd/<%=sPicture[i]%>">
                        <%if(i < iNumOfTag-1){ for(int j=0;j<5;j++){%>&nbsp;<%}%><%=sHierNm[i]%><%}%>
                      </a>
                   <%} else {%>
                      <%if(i < iNumOfTag-1 && sHType[i].equals("P") && sHType[i+1].equals("C")){ for(int j=0;j<5;j++){%>
                           &nbsp;<%}%><b><%=sHierNm[i]%></b>
                      <%} else {%><%=sHierNm[i]%><%}%>
                   <%}%>
                </td>

                <%if(bAppl){%><td class="DataTable">
                     <a href="javascript:chgTag(<%=i%>, 'UPD')">C</a></td>
                <%}%>
                <td class="DataTable" width="15%"><%=sPrcTresh[i]%>&nbsp;</td>
                <td class="DataTable"><%=sSnsType[i]%>&nbsp;</td>
                <td class="DataTable" width="10%"><%=sLoc[i]%>&nbsp;</td>
                <td class="DataTable1"><%=sApply[i]%></td>
                <td class="DataTable1" id="colMall"><%=sMall[i]%></td>
                <td class="DataTable"><%=sComment[i]%>&nbsp;</td>
                <%if(bAppl){%><td class="DataTable">
                     <a href="javascript:chgTag(<%=i%>, 'DLT')">D</a></td>
                <%}%>
              </tr>
            <%}%>
          <%}%>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>