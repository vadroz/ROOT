<%@ page import="rciutility.RunSQLStmt, rciutility.StoreSelect, java.sql.*, java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null )
{
     response.sendRedirect("SignOn1.jsp?TARGET=BchCustListSel.jsp&APPL=ALL");
}
else
{

      StoreSelect StrSelect = null;
      String sStrAllowed = session.getAttribute("STORE").toString();
      String sUser = session.getAttribute("USER").toString();

      StrSelect = new StoreSelect(10);
      String sStore = StrSelect.getStrNum();
      String sStrName = StrSelect.getStrName();

%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvRent { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}


  div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
  div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }

  tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; top: expression(this.offsetParent.scrollTop-3);}
  tr.TblRow { background:wite; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:middle; font-size:11px }


  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<script name="javascript">
var StrLst = [<%=sStore%>];
var StrName = [<%=sStrName%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
    setStrList();
}
//==============================================================================
// set Store List
//==============================================================================
function setStrList()
{
    for (var i = 0; i < StrLst.length; i++)
    {
      document.all.Str.options[i] = new Option(StrLst[i] + " - " + StrName[i], StrLst[i]);
    }
    document.all.Str.selectedIndex=0;
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(dwnl)
{
  var error = false;
  var msg = "";
  var str = document.all.Str.options[document.all.Str.selectedIndex].value;

  if (error) alert(msg);
  else{ sbmPlan( str ) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan( str )
{
  var url = "BchCustList.jsp?Str=" + str;

  //alert(url)
  window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle>
        <B>Rental Contract</B>

        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>

      <TABLE border=0>
        <TBODY>


       <!-- ======================= Store ============================ -->
       <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell1" colspan=4>Stores: &nbsp;
            <select class="Small" name="Str"></select>
         </TD>
       </TR>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">

               <br><br><a href="BchCustInfo.jsp" target="_blank">New Contract</a>&nbsp;
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