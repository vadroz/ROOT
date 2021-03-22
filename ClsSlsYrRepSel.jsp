<%
   // ClsSlsYrRepSel.jsp
   // Get year weeks
   int iNumOfYr = 8;
%>
<!-- ---------------------------- Style -------------------------------- -->
<style>
  body {background:ivory;}
  table.FormTb { background:#FFE4C4;}
  td.FormTb { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }

  table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
  th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
  td.DataTable { background:cornsilk; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px;
                 padding-left:3px; padding-right:3px; cursor: hand;
                 text-align:center; font-family:Arial; font-size:10px }
   td.DataTable1 { color:grey; background:cornsilk; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px;
                 padding-left:3px; padding-right:3px;
                 text-align:center; font-family:Arial; font-size:10px }
   a.Date:link { color:blue; text-decoration:none }
   a.Date:visited { color:blue; text-decoration:none }
   a.Date:hover { color:red; text-decoration:none }
   .Small {font-size:10px}
</style>
<!-- ------------------------- End Style ------------------------------ -->


<script name="javascript">
var NumOfYr = <%=iNumOfYr%>

//==============================================================================
// Initialization process
//==============================================================================
function bodyLoad()
{

   for(var i=0, year=(new Date().getFullYear()) - NumOfYr + 1; i < NumOfYr; i++, year++)
   {
      document.all.Year.options[i] = new Option(year, year);
   }
}
</script>


<HTML><HEAD>


<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-- saved from url=(0088)http://192.168.20.64:8080/servlet/formgenerator.FormGenerator?FormGrp=TICKETS&Form=BBT01 -->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>GM Data Download</B>

      <FORM  method="GET" action="ClsSlsFor1Year.jsp">

      <TABLE border=0>
        <TBODY>
        <TR>
          <TD class=FormTb align=center colSpan=10>Select Year:
             <SELECT name="Year">
             </SELECT>
        </TR>

        <TR>
           <TD class=FormTb align=center colSpan=10>
               <INPUT type=submit value=Submit name=SUBMIT>&nbsp;&nbsp;
           </TD>
        </TR>
<!-- --------------- Select Report Data ---------------------------------- -->
        <TR>
           <TD class=FormTb align=center colSpan=10><BR><b><u>Select Report data</u></b></TD>
        </TR>
         <tr>
           <td class=FormTb align=right >Retail</td>
           <td class=FormTb align=left ><input type="radio" name="RepFld" value="SLSRET" checked></td>
           <td class=FormTb align=right >GM Dollars</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="GMRAMT"  ></td>
           <td class=FormTb align=right >Retail</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="ENDRET"  ></td>
           <td class=FormTb align=right >Retail</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="AGERET"  ></td>
           <td class=FormTb align=right > - %</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="AGPRET"  ></td>

        </tr>
        <tr>
           <td class=FormTb align=right>Cost</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="SLSCST"  ></td>
           <td class=FormTb align=right >GM %:</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="GMRPRC"  ></td>
           <td class=FormTb align=right>Cost</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="ENDCST"  ></td>
           <td class=FormTb align=right>Cost</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="AGECST"  ></td>
           <td class=FormTb align=right> - %</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="AGPCST"  ></td>
        </tr>
        <tr>
           <td class=FormTb align=right>Units</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="SLSUNT"  ></td>
           <td class=FormTb colspan=2>&nbsp;</td>
           <td class=FormTb align=right>Units</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="ENDUNT"  ></td>
           <td class=FormTb align=right>Units</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="AGEUNT"  ></td>
           <td class=FormTb align=right> - %</td>
           <td class=FormTb align=left><input type="radio" name="RepFld" value="AGPUNT"  ></td>
        </tr>

         </TBODY>
        </TABLE>
       </FORM>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
