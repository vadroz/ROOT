<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
  <LINK href="style/Page_0001.css" rel="stylesheet" type="text/css"> 
  
  <style type="text/css">
    body { height: 1000px; }
    
    #header-fixed { position: fixed; top: 0px; display:none; background-color:white; }
    
     
}

  </style>

  <title>Floating header</title>

<script type='text/javascript'>//<![CDATA[
$(window).load(function(){
var tableOffset = $("#table-1").offset().top;
var $header = $("#table-1 > thead").clone();
var $fixedHeader = $("#header-fixed").append($header);

$(window).bind("scroll", function() {
    var offset = $(this).scrollTop();
    
    if (offset >= tableOffset && $fixedHeader.is(":hidden")) {
        $fixedHeader.show();
    }
    else if (offset < tableOffset) {
        $fixedHeader.hide();
    }
});
});//]]> 

</script>

  
</head>

<body>
  <table id="table-1" border=1> 
    <thead>
        <tr>
            <th width="20px">No.</th>
            <%for(int i=0; i < 15; i++){%>
            <th width="150px">Col <%=i%></th>
            <%}%>
        </tr>
    </thead>
    <tbody>
       <%for(int i=0; i < 50; i++){%>
        <tr>
            <td><%=i%></td>
            <%for(int j=0; j < 15; j++){%>
            	<td nowrap>Col=<%=j%>. info asdfasd </td>
            <%}%>
        </tr>
       <%}%> 
        
    </tbody>
</table>
<table id="header-fixed" border=1></table>

  
</body>

</html>
