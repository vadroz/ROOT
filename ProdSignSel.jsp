<%@ page import="java.sql.*, java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null )
{
     response.sendRedirect("SignOn1.jsp?TARGET=ProdSignSel.jsp&APPL=ALL");
}
else
{
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
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(dwnl)
{
  var error = false;
  var msg = "";

  var cls = document.all.Class.value.trim();
  var ven = document.all.Vendor.value.trim();
  var sty = document.all.Style.value.trim();

  if(cls==""){ error=true; msg="Please enter class." }

  if (error) alert(msg);
  else{ sbmSign(cls, ven, sty); }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSign(cls, ven, sty)
{
  var url = "ProdSign.jsp?"
   + "Cls=" + cls
   + "&Ven=" + ven
   + "&Sty=" + sty

  //alert(url)
  window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();" bgColor=moccasin>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<TABLE width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle colspan=4>
        <B>Retail Concepts Inc.
        <br>Product Information Signs</B>

        <br>
        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>

        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" >&nbsp;</TD></TR>
        <TR><TD colspan="4" >&nbsp;</TD></TR>
        <TR>
            <td align=right colspan=2 width="50%">Class &nbsp; </td>
            <td align=left colspan=2><input class="Small" name="Class" maxlength=4 size=4></td>
         </TR>
         <TR>
            <td align=right colspan=2 width="50%">Vendor &nbsp; </td>
            <td align=left colspan=2><input class="Small" name="Vendor" maxlength=5 size=5></td>
         </TR>
         <TR>
            <td align=right colspan=2 width="50%">Style &nbsp; </td>
            <td align=left colspan=2><input class="Small" name="Style" maxlength=4 size=4></td>
         </TR>
         <tr>
           <td align=center colspan=4><br><br>
             <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
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