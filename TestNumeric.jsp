<%
// color code for transfer items
   String [] sColor = new String[]{"255 255 0", "0 255 0",
                                   "255 105 180", "180 150 255",
                                   "255 69 0", "0 191 255"
                                   };
%>
<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}

        <!------------------------------------------------->
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        <!------------------------------------------------->

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------

function check()
{
  if(isNaN(document.all.amount.value)) alert("Wrong");
  else alert("Good")
}

</SCRIPT>
</head>
<body >
       <!-- ------------ Legend -------------- -->
      <table class="DataTable" cellPadding="0" cellSpacing="0">
       <tr><th class="DataTable">Status</th><th class="DataTable">From</th><th class="DataTable">To</th></tr>
        <tr class="DataTable">
          <td style="border-top: darkred solid 1px; border-right: darkred solid 1px">Pending</td>
          <td style="background: rgb(<%=sColor[0]%>); border-top: darkred solid 1px; border-right: darkred solid 1px" >&nbsp;</td>
          <td style="background: rgb(<%=sColor[1]%>); border-top: darkred solid 1px">&nbsp;</td>
       </tr>
        <tr class="DataTable">
          <td style="border-top: darkred solid 1px; border-right: darkred solid 1px">Approved</td>
          <td style="background: rgb(<%=sColor[2]%>); border-top: darkred solid 1px; border-right: darkred solid 1px" >5</td>
          <td style="background: rgb(<%=sColor[3]%>); border-top: darkred solid 1px">125</td>
        </tr>
        <tr class="DataTable">
          <td style="border-top: darkred solid 1px; border-right: darkred solid 1px">In Progress</td>
          <td style="background: rgb(<%=sColor[4]%>); border-top: darkred solid 1px; border-right: darkred solid 1px" >&nbsp;</td>
          <td style="background: rgb(<%=sColor[5]%>); border-top: darkred solid 1px">&nbsp;</td>
        </tr>

      </table >
      <!-- ----Aquamarine-------- End Legend -------------- -->


<input type="text" name="amount"><br>
<button onclick="check()">Check</button>
</body>
</html>
