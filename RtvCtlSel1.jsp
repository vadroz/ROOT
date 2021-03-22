 <HTML>
 <HEAD>
	<title>E-Commerce</title>
	<META content="RCI, Inc." name="E-Commerce">
</HEAD>
 
<script>
//==============================================================================
// Global variables
//==============================================================================
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	sbmStrPickSendQty( )
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmStrPickSendQty( )
{
	 
    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='xxxxx.jsp'>"
        + "<input name='Action'>"
       
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Action.value="XXXXXXX";

   window.frame1.document.frmChgStrSts.submit();
}
</script>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>

TEST
</BODY>