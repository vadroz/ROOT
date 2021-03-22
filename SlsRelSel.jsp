<%@ page import=" classreports.SlsRelSel, rciutility.ClassSelect, java.util.*"%>
<%
    ClassSelect select = new ClassSelect();
    String sDiv = select.getDivNum();
    String sDivName = select.getDivName();
    String sDpt = select.getDptNum();
    String sDptName = select.getDptName();
    String sDptGroup = select.getDptGroup();


    SlsRelSel slsRep = new SlsRelSel();
    int iNumOfRel = slsRep.getNumOfStr();

    String sCode = slsRep.getCode();
    String sFrCls = slsRep.getFrCls();
    String sFrClsName = slsRep.getFrClsName();
    String sToCls = slsRep.getToCls();
    String sToClsName = slsRep.getToClsName();

    slsRep.disconnect();
%>

<style>
        a:link { color:blue; font-size:12px } a:visited { color:blue; font-size:12px }  a:hover { color:blue; font-size:12px }
        a.blue:link { color:blue; font-size:10px } a:visited { color:blue; font-size:10px }  a:hover { color:red; font-size:10px }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:#EfEfEf; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Cornsilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:left;}

         td.DataTable1 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; text-decoration:underline}
         td.DataTable2 { display:none;}
         td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}


        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }


        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
                     background-color:LemonChiffon; border: black solid 2px; width:250; z-index:10;
                     text-align:center; font-size:10px}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1, startColorStr=MidnightBlue , endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:center;}

</style>

<script name="javascript">

var Code = [<%=sCode%>];
var FrCls = [<%=sFrCls%>];
var FrClsName = [<%=sFrClsName%>];
var ToCls = [<%=sToCls%>];
var ToClsName = [<%=sToClsName%>];

NewRow = 0;
var FromClass = new Array();
var ToClass = new Array();
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   popCodeSel();
   doDivSelect(null);
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
}
//==============================================================================
// popilate Code selection
//==============================================================================
function popCodeSel()
{
   for(var i=0; i < Code.length; i++)
   {
      document.all.Code.options[i] = new Option(Code[i], Code[i])
   }
}
//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id) {
    var df = document.all;
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];

    var allowed;

    if (id == null || id == 0) {
        //  populate the division list
        for (idx = 0; idx < divisions.length; idx++)
            df.Division.options[idx] = new Option(divisionNames[idx],divisions[idx]);
        id = 0;

    }
        allowed = dep_div[id].split(":");

        //  clear current depts
        for (idx = df.Department.length; idx >= 0; idx--)
            df.Department.options[idx] = null;

        //  if all are to be displayed
        if (allowed[0] == "all")
            for (idx = 0; idx < depts.length; idx++)
                df.Department.options[idx] = new Option(deptNames[idx],depts[idx]);

        //  else display the desired depts
        else
            for (idx = 0; idx < allowed.length; idx++)
                df.Department.options[idx] = new Option(deptNames[allowed[idx]],
                                                        depts[allowed[idx]]);
}

//==============================================================================
// retreive classes
//==============================================================================
function rtvClasses()
{
   var div = document.all.Division.options[document.all.Division.selectedIndex].value
   var dpt = document.all.Department.options[document.all.Department.selectedIndex].value

   var url = "RetreiveDivDptCls.jsp?"
           + "Division=" + div
           + "&Department=" + dpt;
   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// show selected classes
//==============================================================================
function showClasses(cls, clsName)
{
   // clear
   for(var i = document.all.Class.length; i >= 0; i--) {document.all.Class.options[i] = null;}

   //popilate
   for(var i=1; i < cls.length; i++)
   {
     document.all.Class.options[i-1] = new Option(clsName[i], cls[i]);
   }

   var size = 1;
   if(cls.length <= 10) size = cls.length;
   else size = 10;
   document.all.Class.size=size
}
//--------------------------------------------------------
// retreive Saved Relation classes selection
//--------------------------------------------------------
function rtvRelCls()
{
   var selId = document.all.Code.selectedIndex
   // add from relation code
   for(var i=0; i < FrCls[selId].length; i++)
   {
      addLine(FrCls[selId][i], FrCls[selId][i] + " - " + FrClsName[selId][i], "From");
   }
   // add to relation code
   for(var i=0; i < ToCls[selId].length; i++)
   {
      addLine(ToCls[selId][i], ToCls[selId][i] + " - " + ToClsName[selId][i], "To");
   }

   document.all.RepName.value=Code[selId]
   document.all.spSave.style.display="block";
}
//--------------------------------------------------------
// set selection
//--------------------------------------------------------
function setClasses(type)
{
   var selected = false;
   for(var i=0; i < document.all.Class.length; i++)
   {
      if(document.all.Class.options[i].selected)
      {
         addLine(document.all.Class.options[i].value, document.all.Class.options[i].text, type);
         selected=true;
         NewRow = eval(NewRow) + 1;
      }
   }
   if (selected) document.all.spSave.style.display="block";
}
//--------------------------------------------------------
// mark All classes as selected
//--------------------------------------------------------
function setAllCls()
{
   for(var i=0; i < document.all.Class.length; i++)
   {
      document.all.Class.options[i].selected = true;
   }
}
//------------------------------------------------------------------------
// add entry line in table
//------------------------------------------------------------------------
function addLine(cls, clsName, type)
{
   var tbody = document.getElementById("tbdSel");
   var row = document.createElement("TR")
   row.className="DataTable";
   row.id="trCls" + NewRow; //add ID

   var td = new Array();
   td[0] = addTDElem(clsName, "tdClsName" + NewRow, "DataTable") // class
   td[1] = addTDElem(type, "tdType" + NewRow, "DataTable3") // from / to


   td[2] = addTDElem("C", "tdClear" + NewRow, "DataTable1") // Delete
   var num = eval(NewRow);
   td[2].onclick= function(){ dltClass(num);};
   td[3] = addTDElem(cls, "tdCls" + NewRow, "DataTable2") // class

   // add cell to row
   for(var i=0; i < td.length; i++) { row.appendChild(td[i]); }

   // add row to table
   tbody.appendChild(row);
   NewRow = eval(NewRow) + 1;
}
//---------------------------------------------------------
// add new TD element
//---------------------------------------------------------
function addTDElem(value, id, classnm)
{
  var td = document.createElement("TD") // Reason
  td.appendChild (document.createTextNode(value))
  td.className=classnm;
  td.id = id;
  return td;
}
//---------------------------------------------------------
// delete selected class
//---------------------------------------------------------
function dltClass(rownum)
{
   var rowid = "trCls" + rownum;
   var tbody = document.getElementById("tbdSel");
   var row = document.getElementById(rowid);
   tbody.removeChild(row)
}

//---------------------------------------------------------
// delete all selected class from table
//---------------------------------------------------------
function ResetSelCls()
{
   var tbody = document.getElementById("tbdSel");
   var row = tbody.getElementsByTagName("TR");
   for(var i = row.length-1; i >= 0; i--)
   {
      tbody.removeChild(row[i])
   }
   document.all.spSave.style.display="none";
   document.all.RepName.value="";
}
//==============================================================================
// Validate form
//==============================================================================
  function Validate(repOrSave,  action){
  var form = document.all;
  var error = false;
  var msg = " ";

  var from = new Array();
  var fromNm = new Array();
  var to = new Array();
  var toNm = new Array();
  var row = null;
  var type = null;
  var cls = null;
  var clsnm = null;
  for(var i=0, j=0, k=0; i < NewRow; i++)
  {
     row = "trCls" + i;
     if(document.all[row] != null)
     {
        type = "tdType"+i
        cls = "tdCls"+i
        clsnm = "tdClsName"+i
        if(document.all[type].innerHTML == "From")
        {
           from[j] = document.all[cls].innerHTML;
           fromNm[j] = document.all[clsnm].innerHTML.trim();
           j++;
        }
        else
        {
           to[k] = document.all[cls].innerHTML;
           toNm[k] = document.all[clsnm].innerHTML.trim();
           k++;
        }
     }
  }

  if(from.length==0 || to.length==0)
  {
     msg += "Please, select at least 1 class for 'From' and 'To' comparison.\n"
     error = true;
  }

  // remove duplicates from arrays
  from = rmvDuplicates(from, true)
  fromNm = rmvDuplicates(fromNm, false)
  to = rmvDuplicates(to, true)
  toNm = rmvDuplicates(toNm, false)

  // check if report name is entered
  if(document.all.RepName.value.trim()=="")
  {
     msg += "Please, enter a report name.\n"
     error = true;
  }

  var tylyf = '0';
  if (document.all.TyLyF[1].checked) { tylyf='1' }
  if (document.all.TyLyF[2].checked) { tylyf='2' }

  if (error) alert(msg);
  else if(repOrSave) submitReport(from, to, tylyf);
  else if(!repOrSave) saveSelCls(from, fromNm, to, toNm, action);
  return error == false;
  }
//==============================================================================
// sort numbers
//==============================================================================
  function sortNumbers(a, b) { return a - b}
//==============================================================================
// remove duplicates
//==============================================================================
function rmvDuplicates(before, numeric)
{
  if (numeric) before.sort(sortNumbers);
  else before.sort();
  var after = new Array();
  after[0]=before[0];
  for(var i = 1, j=1; i < before.length; i++)
  {
     if(before[i] != before[i-1])
     {
        after[j] = before[i]
        j++;
     }
  }

  return after;
}
//==============================================================================
// submit report
//==============================================================================
function submitReport(from, to, tylyf)
{
   var url = "SlsRelRep.jsp?";
   var sel = "From=";
   for(var i = 0; i < from.length; i++)  {  url += sel + from[i]; sel="&From=";}
   var sel = "&To=";
   for(var i = 0; i < to.length; i++)  {  url += sel + to[i]; sel="&To=";}
   url += "&RepName=" + document.all.RepName.value.trim()
       + "&TyLyF=" + tylyf;

   //alert(url)
   window.location.href=url
}

//==============================================================================
// save selected classes report
//==============================================================================
function saveSelCls(from, fromNm, to, toNm, action)
{

   var url = "SlsRelSave.jsp?"
           + "RepName=" + document.all.RepName.value.trim();

   for(var i = 0; i < from.length; i++)
   {
      url += "&From=" + from[i]
          + "&FromNm=" + fromNm[i];
   }

   for(var i = 0; i < to.length; i++)
   {
      url += "&To=" + to[i]
          + "&ToNm=" + toNm[i]; ;
   }
   url += "&Action=" + action;

   //alert(url);
   //window.location=url;
   window.frame1.location=url;
}
//---------------------------------------------------------
// get result from saving report parameters
//---------------------------------------------------------
function getResult(Error)
{
   window.frame1.close();


   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Saving Selected Classes</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
   // display the error
   if(Error != "")
   {
      html += "<tr class='DataTable1'>"
            + "<td class='Prompt' nowrap colspan='2'>Error found!<br>" + Error
            + "<br>Press Update button, if you like replace existing set of classes."
            + "</td></tr>"
   }
   else
   {
      html += "<tr class='DataTable1'>"
            + "<td class='Prompt' nowrap colspan='2'>Selected classes have been saved successfully!</td></tr>"
   }

   html += "<tr class='DataTable1'>"
          + "<td class='Prompt' nowrap colspan='2'>";
   html += "<button id='Close' class='Small' onClick='hidePanel();'>Close</button>"
   if(Error != "")
   {
      html += "&nbsp;<button id='Update' class='Small' onClick='Validate(false, &#34UPD&#34)'>Update</button>"
   }

   html += "</td></tr></table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 120;
   document.all.Prompt.style.visibility = "visible";
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}
</script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>



<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
<div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0 cellPadding=0 cellSpacing=0>
  <TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=center><B>Retail Concepts Inc.
        <BR>Sales Relation Report - Selection</B>
    </td>
  </tr>
  <TR bgColor=moccasin>
     <TD vAlign=bottom align=center>
        <a href="/"><font color="red" size="-1">Home</font></a>&#62;
        <a href="rciWeeklyReports.html"><font color="red" size="-1">Weekly Sales Reports</font></a>&#62;
        <font size="-1">This Page.</font>
     </td>
  </tr>
  <TR bgColor=moccasin><TD style="border-top:darkred solid 1px; font-size:0px">&nbsp;</TD></TR>

  <TR bgColor=moccasin>
    <TD vAlign=top align=center>
      <TABLE border=0>
        <!-- --------------------------------------------------------------- -->
        <TR>
          <TD align=center rowspan=7  vAlign=top style="border-right:darkred solid 1px"> Pre-set Relation:
             <SELECT name="Code" class="Small"></SELECT>&nbsp;<br>
             <button onClick="rtvRelCls()" class="Small">Get Classes</button>
          </TD>
          <TD align=right>Division:</TD>
          <TD align=left>
             <SELECT class="Small" name="Division" onchange="doDivSelect(this.selectedIndex);">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>&nbsp;&nbsp;</td>
        </tr>
        <!-- --------------------------------------------------------------- -->
        <TR>
          <TD align=right vAlign=top>Department:</TD>
          <TD align=left>
             <SELECT class="Small" name="Department" >
                <OPTION value="ALL">All Department</OPTION>
             </SELECT>&nbsp;
          </td>
        </tr>
           <TD align=center colspan=2>
             <button onClick="rtvClasses()" class="Small">Get Classes</button>
           </td>
          </TD>
        </TR>
        <!-- --------------------------------------------------------------- -->
        <TR><TD style="border-bottom:darkred solid 1px; font-size:0px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD align=right >Class:</TD>
          <TD align=left>
             <SELECT class="Small" name="Class" size="1" multiple>
                <OPTION value="0">-- No Classes --</OPTION>
             </SELECT>
          </TD>
        </TR>
        <!-- --------------------------------------------------------------- -->
        <TR>
           <TD align=center colSpan=2>
               <button onClick="setAllCls()" class="Small">Mark All</button>&nbsp;
           </TD>
        </TR>
        <!-- --------------------------------------------------------------- -->
        <TR>
           <TD align=center colSpan=2>
               <button onClick="setClasses('From')" class="Small">Save as 'FROM' Classes</button>&nbsp;
               <button onClick="setClasses('To')" class="Small">Save as 'TO' Classes</button>
           </TD>
        </TR>
        <!-- --------------------------------------------------------------- -->
        <TR><TD style="border-top:darkred solid 1px; font-size:0px" colspan="3" >&nbsp;</TD></TR>
        <TR>
          <TD align=center colspan=3>Report Name: <input name="RepName" class="Small" type="text" size="50">
          </td>
        </tr>
        <TR>
          <TD align=center colspan=5>
             <table class="DataTable" id="tbClass" cellPadding="0" cellSpacing="0">
             <tr>
                 <th class="DataTable" colspan="3">Classes selected for report</th>
               <tr>
               <tr>
                 <th class="DataTable">Class</th>
                 <th class="DataTable">From/To</th>
                 <th class="DataTable">Clear</th>
               <tr>
               <TBODY id="tbdSel">
               </TBODY>
             </table>
             <span id="spSave" onClick="javascript: Validate(false, 'ADD')" style="display:none;font-size:10px;">
                Click <font style="cursor:hand;color:blue; text-decoration:underline;">here to save</font> selected Classes
             </span>
          </TD>
        </TR>
        <!-- --------------------------------------------------------------- -->
        <TR><TD style="border-top:darkred solid 1px; font-size:0px" colspan="3" >&nbsp;</TD></TR>
        <TR>
          <TD align=center colspan=3>
              <input name="TyLyF" type="radio" value="0" checked>This Year &nbsp; &nbsp; &nbsp; &nbsp;
              <input name="TyLyF" type="radio" value="1">Last Year "Year-To-Date"
              <input name="TyLyF" type="radio" value="2">Entire Last Year
          </td>
        </tr>
        <!-- --------------------------------------------------------------- -->

        <TR><TD style="border-bottom:darkred solid 1px; font-size:0px" colspan="3" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD align=center colSpan=3>
               <button name=SUBMIT onClick="Validate(true, 'REPORT')" class="Small">Submit</button>&nbsp;
               <button name=Reset onClick="ResetSelCls()" class="Small">Reset</button>
           </TD>
        </TR>
        <!-- --------------------------------------------------------------- -->
        </TABLE>
      </TD>
     </TR>
   </TABLE>
</BODY></HTML>
