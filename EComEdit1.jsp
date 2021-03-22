<%@ page import="java.util.*"%>
<%
    String sCls = request.getParameter("Cls");
    String sVen = request.getParameter("Ven");
    String sSty = request.getParameter("Sty");
    String sClr = request.getParameter("Clr");
    String sSiz = request.getParameter("Siz");
    String sMnfName = request.getParameter("MnfName");
    String sModelName = request.getParameter("ModelName");
    String sModelYear = request.getParameter("ModelYear");
    String sGender = request.getParameter("Gender");
    String sMap = request.getParameter("Map");
    String sMapExpDate = request.getParameter("MapExpDate");
    String sIntro = request.getParameter("Intro");
    String sFeatures = request.getParameter("Features");


    if(sMnfName == null) sMnfName = " ";
    if(sModelName == null) sModelName = " ";
    if(sModelYear == null) sModelYear = " ";
    if(sGender == null) sGender = " ";
    if(sMap == null) sMap = " ";
    if(sMap == null) sMapExpDate = " ";
    if(sIntro == null) sIntro = " ";
    if(sFeatures == null) sFeatures = " ";
%>
<style>
  body {background:ivory;}
</style>
<script language="JavaScript1.2">
//==============================================================================
// initilize
//==============================================================================
function bodyload()
{
   <%if(sCls != null){%>
      document.all.Class.value = <%=sCls%>; document.all.Class.readOnly=true;
      document.all.Vendor.value = <%=sCls%>; document.all.Vendor.readOnly=true;
      document.all.Style.value = <%=sCls%>; document.all.Style.readOnly=true;
      document.all.Color.value = <%=sCls%>; document.all.Color.readOnly=true;
      document.all.Size.value = <%=sCls%>; document.all.Size.readOnly=true;

      var url = "Manufaturer Name: <%=sMnfName%><br>"
              + "Model Name: <%=sModelName%> Year: <%=sModelYear%><br>"
              + "Gender: <%=sGender%><br>"
              + "Map: <%=sMap%>  Experation Date: <%=sMapExpDate%><br>"
      document.all.dvItmProp.innerHTML=url;
      document.all.dvEdit.innerHTML = "<%=sIntro%>";
   <%}%>
}
//==============================================================================
// get Editable Component Context
//==============================================================================
function getEditContent()
{
   var html = document.all.dvEdit.innerHTML;
   alert(html)

}
//==============================================================================
// insert Image
//==============================================================================
function insertImage()
{
   dvEdit.focus();
   document.execCommand("InsertImage", "NewImage");
   dvEdit.focus();
   var html = document.all.dvEdit.innerHTML;
   var pos = html.indexOf("<IMG");
   html = html.substring(0, pos+4) + " width=100 heigth=100 " + html.substring(pos+5)
   document.all.dvEdit.innerHTML=html
}
</script>

<head></head>
<body onload="bodyload()">
<table unselectable="on" border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>E-Commerce Add Item Presentation</b>
       <br>
       </td>
     </tr>
     <!-- ------------------ item long Sku ------------------- -->
     <tr>
      <td ALIGN="center" VALIGN="TOP">
          Class: <input name="Class" size=4 maxlength=4>
          Vendor: <input name="Vendor" size=5 maxlength=5>
          Style: <input name="Style" size=4 maxlength=4>
          Color: <input name="Color" size=3 maxlength=3>
          Size: <input name="Size" size=4 maxlength=4><br><br>

          <div id="dvItmProp" style="border: darkred solid 1px;background:cornsilk; width:300;
             font-size=11px;text-align:left" unselectable="on"></div><br>

      </td>
     <tr>

      <td ALIGN="center" VALIGN="TOP">

        <div align=center>
          <div unselectable="on" align=center style="height:300; width:600; background-color:powderblue; border:outset powderblue">
           <br>
           <div id=dvEdit contenteditable align=left style="height:250; width:550;background-color:white; font-face:Arial; padding:3;
           border:inset powderblue; scrollbar-base-color:powderblue; overflow=auto;"></div>
           <br>
           <button unselectable="On" onclick='document.execCommand("Bold");dvEdit.focus();'
               style="width:80; background-color:powderblue; border-color:powderblue">
               <B>Bold</B></button>
           <button unselectable="On" onclick='document.execCommand("Italic");dvEdit.focus();'
              style="width:80; background-color:powderblue; border-color:powderblue">
              <B><I>Italic</I></B></button>
           <button unselectable="On" onclick='document.execCommand("Underline");dvEdit.focus();'
              style="width:80; background-color:powderblue; border-color:powderblue;">
              <B><U>Underline</U></B></button>
           <button unselectable="On" onclick='insertImage()'
                style="width:80; background-color:powderblue; border-color:powderblue;">
           <B>Image</B></button>
          </div>
        </div>
      </td>
     </tr>
     <tr >
       <td ALIGN="center" VALIGN="TOP">
         <button id=btnDesign onclick="getEditContent()">Save</button><br>
       </td>
     </tr>
</table><br>
</body>








