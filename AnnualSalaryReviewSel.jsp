<%@ page import="rciutility.RunSQLStmt, java.sql.*, rciutility.StoreSelect ,java.util.*, java.text.*"%>
<%
// check when user signon for this session
java.util.Date sessDate = null;
long lElapse = 99999;
if(session.getAttribute("DATE")!=null)
{
  sessDate = (java.util.Date)session.getAttribute("DATE");
  lElapse = (new java.util.Date()).getTime() -   sessDate.getTime();
}

if (session.getAttribute("USER")==null  || session.getAttribute("EMPSALARY")==null || lElapse > 3000)
{
   response.sendRedirect("SignOn1.jsp?TARGET=AnnualSalaryReviewSel.jsp&APPL=ALL");
}
else
{
   // Get allowed Store List
   StoreSelect strsel = null;
   Vector vStr = (Vector) session.getAttribute("STRLST");
   String [] sStrAlwLst = new String[ vStr.size()];
   Iterator iter = vStr.iterator();

   int iStrAlwLst = 0;
   while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }
   boolean bRegSel = false;

   String sStrAllowed = session.getAttribute("STORE").toString();
   if (sStrAllowed.startsWith("ALL"))
   {
       strsel = new StoreSelect();
       bRegSel = true;
   }
   else
   {
     if (vStr.size() > 1) { strsel = new StoreSelect(sStrAlwLst); }
     else strsel = new StoreSelect(new String[]{sStrAllowed});
   }

    int iNumOfStr = strsel.getNumOfStr();
    String [] sStr = strsel.getStrLst();
    String sReg = strsel.getStrReg();

    boolean bSalary = session.getAttribute("EMPSLRALW") != null;

    Vector vDept = new Vector();
    Vector vDeptNm = new Vector();
    String sStmt = "select estat"
        + ", case when uddes1 is null then 'Not Found' else uddes1 end as desc"
        + " from rci.RciEmp left join rci.FSYUDC on estat=udky"
        + " where esepr=' ' and estore > 1"
        + " group by estat, uddes1"
        + " order by estat, uddes1"
        ;
    //System.out.println(sStmt);
    RunSQLStmt runsql = new RunSQLStmt();
    runsql.setPrepStmt(sStmt);
    ResultSet rs = runsql.runQuery();
    while(runsql.readNextRecord())
    {
       vDept.add(runsql.getData("estat").trim());
       vDeptNm.add(runsql.getData("desc").trim());
    }

    Vector vTitle = new Vector();
    sStmt = "select etitl"
        + " from rci.RciEmp"
        + " where esepr=' ' and estore > 1"
        + " group by etitl"
        + " order by etitl"
        ;
    //System.out.println(sStmt);
    runsql = new RunSQLStmt();
    runsql.setPrepStmt(sStmt);
    rs = runsql.runQuery();
    while(runsql.readNextRecord())
    {
       vTitle.add(runsql.getData("etitl").trim());
    }


%>

<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var RegArr = [<%=sReg%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   popStoreSelect();
   popDept();
   popTitle();
}

//==============================================================================
// populate store checkbox
//==============================================================================
function popStoreSelect()
{
   var sel = document.all.Str[0].checked;
   var strbox = document.all.Str;
   <%if(bRegSel){%>
   var regbox = document.all.Reg;
   <%}%>

   for(var i=1; i < strbox.length; i++)
   {
      strbox[i].checked = sel;
   }

   <%if(bRegSel){%>
   for(var i=0; i < regbox.length; i++){ regbox[i].checked=sel;}
   document.all.Reset.checked=false;
   <%}%>
}
//==============================================================================
// populate store checkbox
//==============================================================================
function popReg(reg, selbox)
{
   var sel = selbox.checked;
   var strbox = document.all.Str;
   var regbox = document.all.Reg;
   document.all.Str[0].checked = false;

   for(var i=1; i < strbox.length; i++)
   {
      if(RegArr[i] == reg){ strbox[i].checked = sel; }
   }
}
//==============================================================================
// check/uncheck total store
//==============================================================================
function popDept()
{
   var sel = document.all.Dept[0].checked;
   var dptbox = document.all.Dept;

   for(var i=1; i < dptbox.length; i++)
   {
      dptbox[i].checked = sel;
   }
}
//==============================================================================
// check/uncheck total departments
//==============================================================================
function popTitle()
{
   var sel = document.all.Title[0].checked;
   var ttlbox = document.all.Title;

   for(var i=1; i < ttlbox.length; i++)
   {
      ttlbox[i].checked = sel;
   }
}
//==============================================================================
// check/uncheck total store
//==============================================================================
function chkStoreSelect()
{
   var strbox = document.all.Str;
   var ichecked = 0;
   <%if(bRegSel){%>
   var regbox = document.all.Reg;
   <%}%>

   for(var i=1; i < strbox.length; i++)
   {
      if (strbox[i].checked) { ichecked++;  }
      else { break; }
   }

   if(ichecked == strbox.length-1){ document.all.Str[0].checked = true; }
   else { document.all.Str[0].checked = false; }

   <%if(bRegSel){%>
     for(var i=0; i < regbox.length; i++){ regbox[i].checked=false;}
     document.all.Reset.checked=false;
   <%}%>
}
//==============================================================================
// check/uncheck total department
//==============================================================================
function chkDept()
{
   var dptbox = document.all.Dept;
   var ichecked = 0;

   for(var i=1; i < dptbox.length; i++)
   {
      if (dptbox[i].checked) { ichecked++;  }
      else { break; }
   }

   if(ichecked == dptbox.length-1){ document.all.Dept[0].checked = true; }
   else { document.all.Dept[0].checked = false; }
}
//==============================================================================
// check/uncheck total department
//==============================================================================
function chkTitle()
{
   var ttlbox = document.all.Title;
   var ichecked = 0;

   for(var i=1; i < ttlbox.length; i++)
   {
      if (ttlbox[i].checked) { ichecked++;  }
      else { break; }
   }

   if(ichecked == ttlbox.length-1){ document.all.Title[0].checked = true; }
   else { document.all.Title[0].checked = false; }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var form = document.forms[0];
  var error = false;
  var msg = " ";

  var str = new Array();
  var strbox = document.all.Str;
  var strchk = false;

  for(var i=1, j=0; i < strbox.length; i++)
  {
     if (strbox[i].checked) { str[j++] = strbox[i].value; strchk = true; }
  }
  if(!strchk){ error = true; msg += "Please, check at least 1 store."}

  var dept = new Array();
  var dptbox = document.all.Dept;
  var dptchk = false;

  for(var i=1, j=0; i < dptbox.length; i++)
  {
     if (dptbox[i].checked) { dept[j++] = dptbox[i].value; dptchk = true; }
  }
  if(!dptchk){ error = true; msg += "\nPlease, check at least 1 department."}


  var title = new Array();
  var ttlbox = document.all.Title;
  var ttlchk = false;

  for(var i=1, j=0; i < ttlbox.length; i++)
  {
     if (ttlbox[i].checked) { title[j++] = ttlbox[i].value.replaceSpecChar(); ttlchk = true; }
  }
  if(!ttlchk){ error = true; msg += "\nPlease, check at least 1 title."}

  var type = null;
  var typebox = document.all.Type;

  for(var i=0; i < typebox.length; i++)
  {
     if(typebox[i].checked){type = typebox[i].value; break;}
  }

  if (error) { alert(msg) }
  else{ sbmReport(str, type, dept, title) }
}
//==============================================================================
function sbmReport(str, type, dept, title)
{
   url= "AnnualSalaryReview.jsp?Type=" + type;

   for(var i=0; i < str.length; i++){ url += "&Str=" + str[i]; }
   for(var i=0; i < dept.length; i++){ url += "&Dept=" + dept[i]; }
   for(var i=0; i < title.length; i++){ url += "&Ttl=" + title[i]; }

   //alert(url);
   window.location.href = url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Annual Salary Review - Selection</B>

        <br><A class=blue href="/index.jsp">Home</A>

      <TABLE>
        <TBODY>
        <!-- ------------- Store  --------------------------------- -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell1">Store:
             <input name="Str" type="checkbox" value="ALL" onclick="popStoreSelect(this)" checked>Total Stores&nbsp;&nbsp;
             <%if(bRegSel){%>
               <input name="Reg" type="checkbox" value="ALL" onclick="popReg('1', this)">Dist 1&nbsp;&nbsp;
               <input name="Reg" type="checkbox" value="ALL" onclick="popReg('2', this)">Dist 2&nbsp;&nbsp;
               <input name="Reg" type="checkbox" value="ALL" onclick="popReg('3', this)">Dist 3&nbsp;&nbsp;
               <input name="Reg" type="checkbox" value="ALL" onclick="popReg('99', this)">Dist 99&nbsp;&nbsp;
               <input name="Reset" type="checkbox" value="ALL" onclick="document.all.Str[0].checked=false;popStoreSelect()">Reset&nbsp;&nbsp;
             <%}%>
             <br><br>


             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="Str" type="checkbox" onclick="chkStoreSelect()" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;&nbsp;
               <%if(i > 0 && i % 15 == 0) {%><br><%}%>
             <%}%>
          </TD>
        </TR>

        <!-- ------------- Department  --------------------------------- -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell1">Departments:
             <input name="Dept" type="checkbox" value="ALL" onclick="popDept()" checked>All Departments &nbsp;&nbsp;
             <br><br>

             <table border=0>
               <tr>
             <%for(int i=0, j=0; i < vDept.size(); i++, j++) {%>
               <td class="Cell1">
                  <input name="Dept" type="checkbox" onclick="chkDept()" value="<%=vDept.get(i)%>"><%=vDept.get(i)%> &nbsp; &nbsp;
               </td>
               <%if(j == 14 ) { j=-1;%></tr><tr><%}%>
             <%}%>
             </table>

          </TD>
        </TR>
        <!-- ------------- Title  --------------------------------- -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell1">Titles:
             <input name="Title" type="checkbox" value="ALL" onclick="popTitle()" checked>All Title &nbsp;&nbsp;
             <br><br>

             <table border=0>
               <tr>
             <%for(int i=0, j=0; i < vTitle.size(); i++, j++) {%>
               <td class="Cell1">
                  <input name="Title" type="checkbox" onclick="chkTitle()" value="<%=vTitle.get(i)%>"><%=vTitle.get(i)%> &nbsp; &nbsp;
               </td>
               <%if(j == 7) { j=-1;%></tr><tr><%}%>
             <%}%>
             </table>
          </TD>
        </TR>
        <!-- ------------- Hours or Salary  --------------------------------- -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell2">Select Hourly or Salary Employees: &nbsp;
             <INPUT type="radio"  name="Type" value="H" checked>Hourly
               - or -
             <INPUT type="radio" name="Type" value="B">Inactive

             <%if (bSalary) {%> - or - <%}%>
             <INPUT type="radio" <%if(!bSalary){%>style="display=none;"<%}%> name="Type" value="S">Salary

          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px">&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD align=center>
               <button onclick="Validate()">Submit</button>
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