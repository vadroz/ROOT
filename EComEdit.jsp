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
      document.all.Vendor.value = <%=sVen%>; document.all.Vendor.readOnly=true;
      document.all.Style.value = <%=sSty%>; document.all.Style.readOnly=true;
      document.all.Color.value = <%=sClr%>; document.all.Color.readOnly=true;
      document.all.Size.value = <%=sSiz%>; document.all.Size.readOnly=true;

      var url = "Manufaturer Name: <%=sMnfName%><br>"
              + "Model Name: <%=sModelName%> Year: <%=sModelYear%><br>"
              + "Gender: <%=sGender%><br>"
              + "Map: <%=sMap%>  Experation Date: <%=sMapExpDate%><br>"
      document.all.dvItmProp.innerHTML=url;
   <%}%>
}
//==============================================================================
// get Editable Component Context
//==============================================================================
function getEditContent()
{
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
             font-size=11px;text-align:left"></div><br>

      </td>
     <tr>

      <td ALIGN="center" VALIGN="TOP">

      </td>
     </tr>
     <tr >
       <td ALIGN="center" VALIGN="TOP">
         <button id=btnDesign onclick="getEditContent()">Save</button><br>
       </td>
     </tr>
</table><br>

</body>








