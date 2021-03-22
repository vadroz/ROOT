<!DOCTYPE html>	
<%@ page import="com.test.api.*, java.util.*, java.text.*"%>  
<%
	MozuProducts mprod = new MozuProducts();   
	try 
	{
		System.out.println("Start Test Mozu");
		String sFilter = "ProductCode eq 4004059971500";
		mprod.getProductsByFilter(sFilter);
		System.out.println("End Test Mozu");
	} catch (Exception e)    
	{
		System.out.println("Error: " + e.getMessage());
		e.printStackTrace();
	}
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Test MOZU Maven Project</title>   

<SCRIPT>
</SCRIPT>

</head>
<body>
Test
 </body>
</html>
