<%@ page import="fileutility.FileUtility, java.util.*"%>
<%
String sFile = request.getParameter("File");
String sLib = request.getParameter("Lib");

   int iNumOfFmt = 0;
   String [] sRcdFmt = null;

   int [] iNumOfFld = null;
   String [][] sFld = null;
   String [][] sLng = null;
   String [][] sPos = null;
   String [][] sType = null;
   String [][] sName = null;
   String [][] sUse = null;
   String [][] sDecPos = null;
   String [][] sEdit = null;

   // file description
   String sLogFile = null;
   String sSrcDta = null;
   String sAccess = null;
   String sLvlChk = null;
   String sSelOmit = null;
   String sNumMbr = null;
   String sNumKey = null;
   String sPubAuth = null;
   String sMaxMbr = null;
   String sMaxWait = null;
   String sFrcWrt = null;
   String sSrcFile = null;
   String sSrcMbr = null;
   String sSrcLib = null;
   String sNumFld = null;
   String sRcdLng = null;
   String sActFile = null;
   String sActLib = null;

   int iNumOfKey = 0;
   String [] sKey = null;
   String [] sKeyTyp = null;
   String [] sKeyLng = null;
   String [] sKeyDgt = null;
   String [] sKeyDec = null;
   String [] sKeySeq = null;

if (sFile !=null )
{
    FileUtility filutil = new FileUtility(sFile, sLib);

    iNumOfFmt = filutil.getNumOfFmt();
    sRcdFmt = filutil.getRcdFmt();

    iNumOfFld = filutil.getNumOfFld();
    sFld = filutil.getFld();
    sLng = filutil.getLng();
    sPos = filutil.getPos();
    sType = filutil.getType();
    sName = filutil.getName();
    sUse = filutil.getUse();
    sDecPos = filutil.getDecPos();
    sEdit = filutil.getEdit();

   // file description
    sLogFile = filutil.getLogFile();
    sSrcDta = filutil.getSrcDta();
    sAccess = filutil.getAccess();
    sLvlChk = filutil.getLvlChk();
    sSelOmit = filutil.getSelOmit();
    sNumMbr = filutil.getNumMbr();
    sNumKey = filutil.getNumKey();
    sPubAuth = filutil.getPubAuth();
    sMaxMbr = filutil.getMaxMbr();
    sMaxWait = filutil.getMaxWait();
    sFrcWrt = filutil.getFrcWrt();
    sSrcFile = filutil.getSrcFile();
    sSrcMbr = filutil.getSrcMbr();
    sSrcLib = filutil.getSrcLib();
    sNumFld = filutil.getNumFld();
    sRcdLng = filutil.getRcdLng();
    sActFile = filutil.getActFile();
    sActLib = filutil.getActLib();

    iNumOfKey = filutil.getNumOfKey();
    sKey = filutil.getKey();
    sKeyTyp = filutil.getKeyTyp();
    sKeyLng = filutil.getKeyLng();
    sKeyDgt = filutil.getKeyDgt();
    sKeyDec = filutil.getKeyDec();
    sKeySeq = filutil.getKeySeq();

    filutil.disconnect();
}
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;
                       padding-left:3px; padding-right:3px;padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        td.FileDsc  { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px;
                      padding-right:3px; border-bottom: darkred solid 1px; text-align:left;
                      font-family:Verdanda; font-size:12px;}
        td.FileDsc1 { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px;
                      padding-right:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                      text-align:center; font-family:Verdanda; font-size:12px; font-weight:bold}


        tr.Row { background:lightgrey; font-family:Arial; font-size:10px }
        tr.Row1 { background:Cornsilk; font-family:Arial; font-size:10px }

        td.Cell { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:left;}
        td.Cell1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:right;}

        td.Cell2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:Center;}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Div1 { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        tr.Grid { background:darkblue; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        tr.Grid1 { background:LightBlue; text-align:center; font-family:Arial; font-size:11px;}
        tr.Grid2 { background:LightBlue; text-align:center; font-family:Arial; font-size:10px;}
        tr.Grid3 { background:LightBlue; text-align:left; font-family:Arial; font-size:10px;}

        td.Grid  { color:white; text-align:center; padding-left:3px; padding-right:3px;}
        td.Grid1  { color:white; text-align:right;}
        td.Grid2  { padding-left:3px; padding-right:3px;}
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------

var NumOfAllFld = "<%=sNumFld%>";
var aSelFld = new Array();
var aSelType = new Array();
var aSelSeq = new Array();
var aSelFunc = new Array();
var SelRecWhere = null;
var SortRecOrderBy = null;
//--------------- End of Global variables ----------------
function bodyLoad()
{
  var inp = document.getElementsByTagName("input");
  for(var i=0; i < inp.length; i++)
  {
     if (inp[i].type=="checkbox")
     inp[i].checked=false;
  }
}
//---------------------------------------------------------------------
// save/remove selected/unselected filed
//---------------------------------------------------------------------
function selFld(fld, type, fldSeq)
{
  //unselect
  var aSort = new Array();
    // copy all selection in sorting array (temporary), exclude current field
    for(var i=0, j=0; i < aSelFld.length; i++)
    {
      if (aSelFld[i] != fld.value)
      {
        aSort[j] = new Field(aSelFld[i], aSelType[i], aSelSeq[i], aSelFunc[i]);
        j++
      }
    }

    if(fld.checked==true)
    {
      aSort[aSort.length] = new Field(fld.value, type, fldSeq, " ");
    }

    // Sort array by field sequence
    aSort.sort(sortBySequence);

    // clear arrays
    aSelFld = new Array();
    aSelType = new Array();
    aSelSeq = new Array();
    aSelFunc = new Array();

    // populate arrays with sorted
    for(var i=0; i < aSort.length; i++)
    {
      aSelFld[i] = aSort[i].fld;
      aSelType[i] = aSort[i].type;
      aSelSeq[i] = aSort[i].seq;
      aSelFunc[i] = aSort[i].func;
    }
}
//---------------------------------------------------------------------
//  Sorting function for fields by their sequence in a file
//---------------------------------------------------------------------
function sortBySequence(fld1, fld2)
{
  return fld1.seq - fld2.seq;
}
//---------------------------------------------------------------------
//  Define Field Object constructor
//---------------------------------------------------------------------
function Field(fld, type, seq, func)
{
  this.fld=fld;
  this.type=type;
  this.seq=seq;
  this.func=func
}
//---------------------------------------------------------------------
// Field.toString() method
//---------------------------------------------------------------------
function Field.prototype.toString()
{
  return this.fld + "/" + this.type + "/"  + this.seq + "/" + this.func;
}

//---------------------------------------------------------------------
// submit query
//---------------------------------------------------------------------
function submitQuery()
{
  var url = "FileQuery.jsp?File=<%=sActFile%>&Lib=<%=sActLib%>"
  var type = null;
  for(var i=0; i < aSelFld.length; i++)
  {
      if(aSelType[i] == "A"){ type=0; }
      else if(aSelType[i] == "S"){ type=1; }
      else if(aSelType[i] == "P"){ type=1; }
      else if(aSelType[i] == "L"){ type=2; }
      else if(aSelType[i] == "T"){ type=3; }
      else if(aSelType[i] == "Z"){ type=4; }

      url += "&Fld=" + aSelFld[i];

      if(aSelFunc[i] != null && aSelFunc[i].trim() != "") { url += "&Func=" + aSelFunc[i]; }

      url += "&Type=" + type;
  }

  if (SelRecWhere != null && SelRecWhere !="") url += "&Where=" + SelRecWhere;
  if (SortRecOrderBy != null && SortRecOrderBy !="") url += "&OrderBy=" + SortRecOrderBy;


  //alert(url);
  window.location.href=url;
}
//------------------------------------------------------------------
// show Fields Function panel
//-----------------------------------------------------------------
function setFieldFunc()
{
  if(aSelFld.length > 0)
  {
    opener.popFldLst(aSelFld);
    window.close()
  }
}
//------------------------------------------------------------------
// populate field function area
//-----------------------------------------------------------------
function populateFldFunc(seq)
{
  if(aSelFunc[seq] != null && aSelFunc.length > seq) document.all.txaNewFunc.value = aSelFunc[seq];
}
//------------------------------------------------------------------
// save new function in array
//-----------------------------------------------------------------
function addNewFunc(seq)
{
  aSelFunc[seq] = document.all.txaNewFunc.value.trim();
  hidedivFunc();
}
//------------------------------------------------------------------
// reset field function
//-----------------------------------------------------------------
function resetFldFunc(seq)
{
  if(seq < 0)  aSelFunc = new Array();
  else aSelFunc[seq] = null;
}


//------------------------------------------------------------------
// create the prototype on the String object
//-----------------------------------------------------------------
String.prototype.trim = function()
{
 // skip leading and trailing whitespace
 // and return everything in between
  var x=this;
  x=x.replace(/^\s*(.*)/, "$1");
  x=x.replace(/(.*?)\s*$/, "$1");
  return x;
}
</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------------------->
<div id="Clause" class="Div1"></div>
<div id="divFunc" class="Div1"></div>
<!-------------------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
<!-------------------------------------------------------------------------------->
     <tr bgColor="moccasin">
      <td ALIGN="Center" VALIGN="TOP" colspan="2" nowrap>
           <b><u>Display File Fields</u></b><br><br>
      </td>
    </tr>
    <form  method="GET" action="FileUtility.jsp">
      <tr bgColor="moccasin">
        <td ALIGN="right" width="45%">File:&nbsp; </td>
        <td ALIGN="left" ><input name="File" type="text" maxlength="10" size="10">&nbsp;
                          <INPUT type=submit value=Submit name=SUBMIT></td>
      </tr>
      <tr bgColor="moccasin">
        <td ALIGN="right">Library:&nbsp;</td>
        <td ALIGN="left"><input name="Lib" type="text" maxlength="10" size="10" value="*LIBL"></td>
      </tr>
    </form>

<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan="2">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="FileUtilitySel.jsp"><font color="red" size="-1">File Selection</font></a>&#62;
          <font size="-1">This Page.</font>&#62;
          <a href="javascript:window.close()"><font color="red" size="-1">Close</font></a>

<%if (sFile !=null ){%>
<!-------------------------------------------------------------------->
<!----------------- File Description table ------------------------>
<!-------------------------------------------------------------------->
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	    <td class="FileDsc">File Name:</td>
            <td class="FileDsc1"><%=sActLib + " / " + sFile.toUpperCase()%></td>
            <td class="FileDsc">Type of file:</td>
            <td class="FileDsc1"><%=sLogFile%></td>
            <td class="FileDsc">File type:</td>
            <td class="FileDsc1"><%=sSrcDta%></td>
            <td class="FileDsc">Access path:</td>
            <td class="FileDsc1"><%=sAccess%></td>
            <td class="FileDsc">Level Check:</td>
            <td class="FileDsc1"><%=sLvlChk%></td>
        </tr>
        <tr>
            <td class="FileDsc">Select/Omit:</td>
            <td class="FileDsc1"><%=sSelOmit%></td>
            <td class="FileDsc">Number of members:</td>
            <td class="FileDsc1"><%=sNumMbr%></td>
            <td class="FileDsc">Number of keys:</td>
            <td class="FileDsc1"><%=sNumKey%></td>
            <td class="FileDsc">Publick authority:</td>
            <td class="FileDsc1"><%=sPubAuth%></td>
            <td class="FileDsc">Maximum Member:</td>
            <td class="FileDsc1"><%=sMaxMbr%></td>
        </tr>
        <tr>
            <td class="FileDsc">Maximum wait time (sec):</td>
            <td class="FileDsc1"><%=sMaxWait%></td>
            <td class="FileDsc">Force to write:</td>
            <td class="FileDsc1"><%=sFrcWrt%></td>
            <td class="FileDsc">Source File:</td>
            <td class="FileDsc1">
               <%if(!sSrcFile.equals("unknown")){%><%=sSrcLib + " / " + sSrcFile + " (" + sSrcMbr + ")"%></td>
               <%} else {%><%=sSrcFile%><%}%>
            <td class="FileDsc">Number of fields:</td>
            <td class="FileDsc1"><%=sNumFld%></td>
            <td class="FileDsc">Record Length:</td>
            <td class="FileDsc1"><%=sRcdLng%></td>
        </tr>
      </table>
<br>
<!-------------------------------------------------------------------->
<!----------------- File Keys Table ---------------------------------->
<!-------------------------------------------------------------------->
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	    <th class="DataTable">Key Field<br>Name</td>
            <th class="DataTable">Field<br>Length</td>
            <th class="DataTable">Number of<br>Digits</td>
            <th class="DataTable">Number of<br>Decimal<Points></td>
            <th class="DataTable">Sorting<br>Sequence</td>
        </tr>


        <%for(int i=0; i < iNumOfKey; i++) {%>
          <tr class="Row1">
             <td class="Cell" nowrap><%=sKey[i]%></td>
             <td class="Cell1" nowrap><%=sKeyLng[i]%></td>
             <td class="Cell1" nowrap><%=sKeyDgt[i]%></td>
             <td class="Cell1" nowrap><%=sKeyDec[i]%></td>
             <td class="Cell1" nowrap><%=sKeySeq[i]%></td>
          </tr>
        <%}%>
      </table>
<br>

<button class="Small" name="FieldFun" value="func" onclick="setFieldFunc()">Select Fields</button>&nbsp; &nbsp;

<br><br>
<!-------------------------------------------------------------------->
<!----------------- Field Description of table ------------------------>
<!-------------------------------------------------------------------->
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
            <th class="DataTable">Select</th>
	    <th class="DataTable">Field Name</th>
            <th class="DataTable">Name</th>
            <th class="DataTable">Length</th>
            <th class="DataTable">Type</th>
            <th class="DataTable">Dec<br>Pos</th>
            <th class="DataTable">Use</th>
            <th class="DataTable">Pos</th>
            <th class="DataTable">Editing</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
        <%for(int i=0, recNum=0; i < iNumOfFmt; i++) {%>
           <tr class="Row1">
             <td class="Cell2" colspan="9">Record Format: <%=sRcdFmt[i]%>
              <%if(iNumOfFld[i]==0){%>&nbsp;(No Fields)<%}%>
             </td>
           </tr class="Cell">
           <%for(int j=0; j < iNumOfFld[i]; j++, recNum++) {%>
             <tr class="Row">
<!--=======-->
<!--==A01==--> <td class="Cell" nowrap id="<%=sFld[i][j]%>">
<!--=======-->   <input onclick="selFld(this, '<%=sType[i][j]%>', <%=recNum%>)" name="<%=sFld[i][j]%>" type="checkbox"
                      value="<%=sFld[i][j]%>" ></td>

               <td class="Cell" nowrap><%=sFld[i][j]%></td>
               <td class="Cell1" nowrap><%=sName[i][j]%></td>
               <td class="Cell1" nowrap><%=sLng[i][j]%></td>
               <td class="Cell2" nowrap><%=sType[i][j]%></td>
               <td class="Cell2" nowrap><%=sDecPos[i][j]%></td>
               <td class="Cell2" nowrap><%=sUse[i][j]%></td>
               <td class="Cell1" nowrap><%=sPos[i][j]%></td>
               <td class="Cell2" nowrap><%=sEdit[i][j]%></td>
            </tr>
           <%}%>
        <%}%>
     </table>
<%}
else {%><%for(int i=0; i < 17; i++){%><br><%}%><%}%>
<!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
