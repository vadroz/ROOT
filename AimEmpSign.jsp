<%@ page import="java.text.*"%>
<%
   int iSpace = 6;
%>

<html>
<head>

<style>
  body {background:white;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;text-align:center;}
  th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }

  tr.DataTable { font-size:10px;}
  tr.DataTable1 { font-size:14px;}

  td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left;}
  td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; }
  td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; }

  div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
  td.Grid  { background:darkblue; color:white; text-align:center;
             font-family:Arial; font-size:11px; font-weight:bolder}
  td.Grid2  { background:darkblue; color:white; text-align:right;
              font-family:Arial; font-size:11px; font-weight:bolder}
  .Small{ text-align:left; font-family:Arial; font-size:10px;}
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var CheckDtl = false;
//==============================================================================
// populate fields on page load
//==============================================================================
function bodyLoad()
{
   document.all.Emp.focus();
   for(var i=0; i < document.all.Jersey.length;i++)
   {
       document.all.Jersey[i].style.display="none"
   }
}

//==============================================================================
// Validate entry
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";
   var emp = document.all.Emp.value.trim();
   var email = null;
   var waiver = null;
   var init = document.all.Init.value.trim();
   var prodty= null;
   var size = null;

   if(emp == ""){ error=true; msg+= "Please enter employee number."; }
   else if(isNaN(emp)){ error=true; msg+= "Employee number is invalid - must be numeric.";}
   else if(eval(emp) <= 0){ error=true; msg+= "Employee number must be positive.";}

   if(CheckDtl)
   {
      email = document.all.Email.value.trim();
      if(email == ""){ error=true; msg="\nPlease enter your E-Mail address." }
      else if(email.indexOf("@") < 0 || email.indexOf(".") < 0){ error=true; msg="\nE-Mail address is invalid." }

      if(document.all.Waiver.checked) { waiver = "Y"; }
      else{ waiver = "N"; }

      if(waiver== "N" || init == "") { error=true; msg += "\nYou must read waiver, check box and put initials before submitting." }

      if(document.all.ProdTy[0].checked) { prodty = "T"; }
      else{ prodty = "B"; }

      for(var i=0; i < document.all.Size.length; i++)
      {
          if(document.all.Size[i].checked) { size = document.all.Size[i].value; }
      }
   }

   if(error){ alert(msg) }
   else if(!CheckDtl){ sbmRtvEmpInfo(emp) }
   else if( CheckDtl){ sbmSaveEmpInfo(emp, email, waiver, prodty, size, init) }
}
//==============================================================================
// change action on submit
//==============================================================================
function  sbmSaveEmpInfo(emp, email, waiver, prodty, size, init)
{
    email = email.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmEvt"

    var html = "<form name='frmAddUpdEmp'"
       + " METHOD=Post ACTION='AimEvtSv.jsp'>"
       + "<input name='emp'>"
       + "<input name='email'>"
       + "<input name='waiver'>"
       + "<input name='init'>"
       + "<input name='prodty'>"
       + "<input name='size'>"
       + "<input name='action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.emp.value = emp;
   window.frame1.document.all.email.value=email;
   window.frame1.document.all.waiver.value=waiver;
   window.frame1.document.all.init.value=init;
   window.frame1.document.all.prodty.value=prodty;
   window.frame1.document.all.size.value=size;

   window.frame1.document.all.action.value="CHGEMPPGM";

   window.frame1.document.frmAddUpdEmp.submit();
}
//==============================================================================
// change action on submit
//==============================================================================
function sbmRtvEmpInfo(emp){
   var url;

   url = "AimEmpInfo.jsp?emp=" + emp;

   //alert(url);
   window.frame1.location.href=url;
}

//==============================================================================
// change action on submit
//==============================================================================
function setEmployee(exist, name, str, sepr, email, waiver, prodty, size, init)
{
    if(!exist){ alert("Employee number is invalid.")}
    else if(sepr != ""){ alert("Employee is not active in the system.  Please contact HR.")}
    else
    {
       CheckDtl = true;
       document.all.Emp.readOnly = true;
       document.all.trEmpInfo.style.display = "block";
       document.all.tdName.innerHTML = name
       if(email.trim() != ""){ document.all.Email.value=email; }
       document.all.Waiver.checked=false;
       if(waiver == "Y")
       {
          document.all.tdWaiver.style.display="none";
          document.all.spnWvrCheck.style.display="inline";
          document.all.spnWvrInit.innerHTML = "Initials: " + init
          document.all.Waiver.style.display="none";
          document.all.Waiver.checked=true;
          document.all.Init.value=init;
          document.all.spnWaiver.style.display="none";
          document.all.spnWvrLnk.style.display="none";
       }
       else
       {
          document.all.tdWaiver.style.display="none";
          document.all.spnWvrCheck.style.display="none";
          document.all.spnWaiver.style.display="none";
          document.all.spnWvrLnk.style.display="block";
       }

       if(prodty == "T"){ document.all.ProdTy[0].checked=true; }
       if(prodty == "B"){ document.all.ProdTy[1].checked=true; }

       if(size == "T"){ document.all.Size[0].checked=true; }
       if(size == "S"){ document.all.Size[1].checked=true; }
       if(size == "M"){ document.all.Size[2].checked=true; }
       if(size == "L"){ document.all.Size[3].checked=true; }
       if(size == "X"){ document.all.Size[4].checked=true; }
       if(size == "Y"){ document.all.Size[5].checked=true; }
    }
}
//==============================================================================
// show waiver
//==============================================================================
function showWaiver(type)
{
   var show = false;
   if(type=="READ") { show = true; }

   if(show)
   {
      document.all.spnWaiver.style.display="block";
      document.all.spnWvrLnk.style.display="none";
      document.all.tdWaiver.style.display="inline";
   }
   //else
   //{
   //   document.all.spnWaiver.style.display="none";
   //   document.all.spnWvrLnk.style.display="none";
   //}
}
//==============================================================================
// restart
//==============================================================================
function restart()
{
   alert("Employee information have been saved")
   window.location.reload();
}
</SCRIPT>
</head>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

 <body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

  <table border="0" align=center width="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Associates in Motion(AIM) - Employee Sign for Program</b>
       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>
       &nbsp; &nbsp; &nbsp; &nbsp;
       <br><br><br>

      <table border=0>
      <!-- =============================================================================== -->
      <!-- Store list -->
      <!-- =============================================================================== -->
      <tr>
         <td align=right width="50%">Employee Number:</td>
         <td align=left><input name="Emp" size=4 maxlength=4
           onkeydown="if (event.keyCode == 13) document.all.btnSubmit.click()"></td>
      </tr>

      <tr id="trEmpInfo" style="display:none;">
         <td align=right colspan=2>

         <table border=0>
           <tr class="DataTable1">
             <td>Name:</td>
             <td id="tdName"></td>
           </tr>
           <tr class="DataTable1">
             <td>E-Mail Address:</td>
             <td align=left><input name="Email" size=50 maxlength=50></td>
           </tr>
           <tr class="DataTable1">
             <td>Waiver Signed:</td>
             <td>
                <span style="font-family: Wingdings;" id="spnWvrCheck">&#252; </span>
                <span id="spnWvrInit"></span>
                <span id="spnWvrLnk">Click <a href="javascript: showWaiver('READ');">here</a> to read the waiver.</span>
             </td>
           </tr>

           <tr class="DataTable1">
       <td class="DataTable" colspan=2>

       <span id="spnWaiver">
       <b>I agree that participating in the Associates in Motion (AIM) program may involve physical activity.
       <br>  I agree that I am in reasonably good health and have no conditions that would prevent or hinder
       <br> me from safely participating in the program.  Participation in all activities is strictly
       <br> voluntary and any injuries suffered in concurrence shall not be subject to reimbursement under
       <br> any workers/compensation law or any other applicable law.
       <br>I hereby agree to freely and expressly ASSUME and accept ANY AND ALL RISKS OF INJURY OR DEATH
       <br> while participating in the AIM program.
       <br><br>I, on  behalf of myself, heirs, next - of - kin and executors, hereby assume all risks which
       <br> may be associated with and/or result from my involvement in the AIM program and hereby agree to
       <br> hold harmless, release, indemnify and defend Retail Concepts, Inc., its affiliates, and their
       <br> officers and employees of and from any liability and claims arising out of or related to any loss,
       <br> damage or injury, including death that may be sustained by me or anyone else while participating
       <br> in the AIM program.
       <br><br>I also agree that all merchandise benefits earned through participation in the AIM program fall
       <br> within the guidelines of the Employee Purchase Discounts Policy (Policy No. 2.14) and will adhere
       <br> to those guidelines.
       <br>By accepting this waiver I also commit to participating in a minimum of 5 events in the first
       <br> year and commit to adhering to the rules of the program.
       <br><br>I have signed and understand the foregoing liability of release.  I am aware that this is
       <br> a release of liability and I sign it of my own free will.  I am not relying upon any oral or
       <br> written representation other than what is set forth in this agreement.
       </b>
       </span>
       </td>
     </tr>

     <tr class="DataTable1">
             <td align=left id="tdWaiver" colspan=2>
               <input name="Waiver" type="checkbox" class="Small" value="Y" onclick="showWaiver('BOX')"> &nbsp;
               Click in checkbox after you read the waiver. &nbsp;  &nbsp;
               Init: <input name="Init" size=2 maxlength=2>
               <br>&nbsp;
             </td>
           </tr>

           <tr>
             <td>T-Shirt<span id="Jersey"> or Bike Jersey</span>:</td>
             <td align=left>
                 <input name="ProdTy" type="radio" value="T" checked>T-Shirt &nbsp; &nbsp;
                 <span id="Jersey"><input name="ProdTy" type="radio" value="B">Bike Jersey</span>
             </td>
           </tr>
           <tr>
             <td>Size:</td>
             <td align=left>
                 <input name="Size" type="radio" value="T">X-Small &nbsp; &nbsp;
                 <input name="Size" type="radio" value="S">Small &nbsp; &nbsp;
                 <input name="Size" type="radio" value="M" checked>Medium &nbsp; &nbsp;
                 <input name="Size" type="radio" value="L">Large &nbsp; &nbsp;
                 <input name="Size" type="radio" value="X">X-Large &nbsp; &nbsp;
                 <input name="Size" type="radio" value="Y">XX-Large &nbsp; &nbsp;
             </td>
           </tr>
         </table>
         </td>
      </tr>

      <!-- =============================================================================== -->
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button id="btnSubmit" onClick="Validate()">Submit</button> &nbsp; &nbsp;
         <button onClick="window.location.reload();">Clear</button>
      </tr>

      </table>
         <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>&nbsp;
      </td>

     </tr>
   </table>
  </body>
</html>
