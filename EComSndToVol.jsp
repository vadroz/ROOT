<%
%>
<HTML>
<HEAD>
<title>E-Commerce_Send_Customer_Orders</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>
<style>
  body {background:ivory;}
</style>

<script name="javascript1.2">
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad(){}
//==============================================================================
// submit product updates
//==============================================================================
function submit()
{
/*    var data = "Update<xmldata>"
           + "<Products>"
             + "<ProductCode>0003050526081</ProductCode>"
             + "<listprice>30</listprice>"
             + "<productprice>24.99</productprice>"
             + "<saleprice></saleprice>"
             + "<stockstatus>1</stockstatus>"
             + "<customfield2>sales</customfield2>"
             + "<customfield3>10/22/2007</customfield3>"
             + "<customfield4>Fall 07</customfield4>"
             + "<FreeShippingItem>N</FreeShippingItem>"
             + "<metatag_title>Thermotech Performance Men's Thermal Underwear Top @ Sun and Ski Sports</metatag_title>"
             + "<hideproduct>N</hideproduct>"
             + "<customfield5></customfield5>"
             + "<OrderFinished_Note></OrderFinished_Note>"
             + "<TaxableProduct>Y</TaxableProduct>"
             + "<Vendor_Price>5.5017</Vendor_Price>"
             + "<Yahoo_Category>PERFORMANCE MENS THERMOTC</Yahoo_Category>"
             + "<ShoppingDotCom_Category>SKI ACCESSORIES</ShoppingDotCom_Category>"
             + "<Yahoo_Medium>Men's</Yahoo_Medium>"
           + "</Products>"
         + "</xmldata>";
 */
   var url = "http://www.sunandski.com/net/WebService.aspx?Login=rsmith@retailconcepts.cc&EncryptedPassword=4B89AE74CE7907DCB38CBBFF7712AE3BD3488D0D8BBDBE6340AD247EF64BD0B6"
           + "&Import=Update"
           + '<?xml version="1.0" encoding="utf-8" ?>'
           + "<xmldata>"
           + "<Products>"
             + "<ProductCode>0003050526081</ProductCode>"
             + "<StockStatus>1</StockStatus>"
           + "</Products>"
         + "</xmldata>";
   alert(url)
   window.location.href = url;
}

</script>
<body onload="bodyLoad()">

 <button onclick="submit()">Submit</button>
</body>



