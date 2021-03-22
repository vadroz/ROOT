<!DOCTYPE html>	
<%@ page import="com.test.api.*, java.util.*, java.text.*"%>  
<%
	try 
	{
		String [] sFiles = new String[]{"//192.168.20.24/Shared/IMG_2152.jpg"
				, "//192.168.20.24/Shared/IMG_2159.jpg"
				, "//192.168.20.24/Shared/IMG_2163.jpg"	};		     
		String sProd = "0006017855050";
		String [] sPicNms  = new String[]{"P0006017855050_0.jpg", "P0006017855050_1.jpg", "P0006017855050_2.jpg"};
		String [] sText  = new String[]{"Red Hat", "Blue Hat", "Green Hat"};
		System.out.println(sFiles[0]);	
		MozuUplPicture uplpic = new MozuUplPicture(sFiles, sProd, sPicNms, sText);
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
