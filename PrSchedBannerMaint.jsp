<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%  
	String sStmt = "Select sstr" 
      + ", case when BaText is null then ' ' else BaText end as BaText"
	  + ", case when BaFSiz is null then '24' else BaFSiz end as BaFSiz"
	  + ", case when BaFName is null then 'Arial' else BaFName end as BaFName"
	  + ", case when BaClr is null then 'Black' else BaClr end as BaClr"
	  + ", case when BaBack is null then 'White' else BaBack end as BaBack"
	  + ", case when BaBlink is null then 'N' else BaBlink end as BaBlink"	  
	  + " from Iptsfil.IpStore"
	  + " left join RCI.PRSTRBAN on bastr=sstr"
	  + " where ssts='S'"
	  + " order by sstr"
	;
	//System.out.println(sStmt);  
	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();

	Vector vStr = new Vector();
	Vector vText = new Vector();
	Vector vSize = new Vector();
	Vector vFont = new Vector();
	Vector vClr = new Vector();
	Vector vBackground = new Vector();
	Vector vBlink = new Vector();
	
	boolean bRecordFound = false;
		
	while(runsql.readNextRecord())
	{
		bRecordFound = true;
		vStr.add(runsql.getData("sStr").trim());
		vText.add(runsql.getData("BaText").trim());
	    vSize.add(runsql.getData("BaFSiz").trim());
	    vFont.add(runsql.getData("BaFName").trim());	    
	    vClr.add(runsql.getData("BaClr").trim());
	    vBackground.add(runsql.getData("BaBack").trim());
	    vBlink.add(runsql.getData("BaBlink").trim());	    
	}
	
	rs.close();
	runsql.disconnect();
		
%>
<HTML>
<HEAD>
<title>Banner Maint.</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:12px} a:visited.small { color:blue; font-size:12px}  a:hover.small { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:12px;}
        
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:9px }

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: white; font-size:12px }
        tr.DataTable2 { background: yellow; font-size:12px }
        tr.DataTable12 { background: yellow; font-size:12px }
        tr.DataTable3 { background: pink; font-size:12px }
        

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DTError{color:red; font-size:12px;}               

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

              
        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:350; height:450px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

               
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
               

        tr.Prompt { font-size:10px }
        tr.Prompt1 { font-size:10px }
        tr.Prompt2 { font-size:11px }

        th.Prompt { background:#FFCC99; text-align:ceneter; vertical-align:midle; font-family:Arial; font-size:11px; }
        td.Prompt { padding-left:3px; padding-right:3px; text-align:left; vertical-align:top; font-family:Arial;}
        td.Prompt1 { padding-left:3px; padding-right:3px; text-align:center; vertical-align:top; font-family:Arial;}
        td.Prompt2 { padding-left:3px; padding-right:3px; text-align:right; font-family:Arial; }
        td.Prompt3 { padding-left:3px; padding-right:3px; text-align:left; vertical-align:midle; font-family:Arial;}


</style>


<script language="javascript1.3">
//------------------------------------------------------------------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
    document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//validate banner 
//==============================================================================
function vldBanner(arg)
{
	var error = false;
	var msg = "";
	
	var cell = "tdStr" + arg;
	var str = document.all[cell].innerHTML.trim();
	
	cell = "Text" + arg;
	var text = document.all[cell].value.trim();
	
	cell = "Size" + arg;
	var size = document.all[cell].value.trim();
	
	cell = "Font" + arg;
	var font = document.all[cell].value.trim();
	
	cell = "Clr" + arg;
	var clr = document.all[cell].value.trim();
	
	cell = "Back" + arg;
	var back = document.all[cell].value.trim();
	
	cell = "Blink" + arg;
	var blinkobj = document.all[cell];
	var blink = "N";
	if(blinkobj[0].checked){ blink = "Y"; }
	
	if(error){ alert(msg); }
	else{ sbmBanner(str, text, size, font, clr, back, blink);}
}
//==============================================================================
// submit banner 
//==============================================================================
function sbmBanner(str, text, size, font, clr, back, blink)
{	
	SbmFunc = "sbmBanner";
    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmBanner"
    
     text = text.replace(/\n\r?/g, '<br />');
    

    var html = "<form name='frmBanner'"
     + " METHOD=Post ACTION='PrSchebBannerSave.jsp'>"
     + "<input name='str'>"
     + "<input name='text'>"
     + "<input name='size'>"
     + "<input name='font'>"
     + "<input name='clr'>"
     + "<input name='back'>"
     + "<input name='blink'>"
    html += "</form>"

    nwelem.innerHTML = html;
    window.frame1.document.appendChild(nwelem);

    window.frame1.document.all.str.value = str;
    window.frame1.document.all.text.value = text;
    window.frame1.document.all.size.value = size;
    window.frame1.document.all.font.value = font;
    window.frame1.document.all.clr.value = clr;
    window.frame1.document.all.back.value = back;
    window.frame1.document.all.blink.value = blink;
    
    window.frame1.document.frmBanner.submit();
}
//==============================================================================
//submit banner 
//==============================================================================
function restart()
{
	window.location.reload(); 
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="200" width="100%"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Setup Payroll Banner for Stores
        </B><br>
        

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable">Str</th>
             <th class="DataTable">Text</th>
             <th class="DataTable">Size</th>
             <th class="DataTable">Font</th>
             <th class="DataTable">Color</th>
             <th class="DataTable">Background</th>
             <th class="DataTable">Blink</th>
             <th class="DataTable">Save</th>
           </tr>
       <!-- ============================ Details =========================== -->
   <%if(bRecordFound){%>    
       <%for(int i=0; i < vStr.size(); i++ ){%> 
          <tr id="trProd" class="DataTable1">
            <td class="DataTable1" nowrap id="tdStr<%=i%>"><%=vStr.get(i)%></td>
            <td class="DataTable1" nowrap><textArea id="Text<%=i%>" cols="80" rows="4"><%=vText.get(i)%></textArea></td>
            <td class="DataTable1" nowrap><input id="Size<%=i%>" value="<%=vSize.get(i)%>" maxlength=3 size=3></td>
            <td class="DataTable1" nowrap><input id="Font<%=i%>" value="<%=vFont.get(i)%>" maxlength=50 size=10></td>
            <td class="DataTable1" nowrap><input id="Clr<%=i%>" value="<%=vClr.get(i)%>" maxlength=50 size=10></td>
            <td class="DataTable1" nowrap><input id="Back<%=i%>" value="<%=vBackground.get(i)%>" maxlength=50 size=10></td>
            <td class="DataTable1" nowrap>
               Yes<input id="Blink<%=i%>" type="radio" value="Y" <%if(vBlink.get(i).equals("Y")){%>checked<%}%>> &nbsp; &nbsp;
                No<input id="Blink<%=i%>" type="radio" value="N" <%if(!vBlink.get(i).equals("Y")){%>checked<%}%>>
            </td>
            <td class="DataTable1" nowrap><button class="Small" onclick="vldBanner('<%=i%>')">Save</button></td>
         </tr>         
       <%}%>
    <%}%>
       
    </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
