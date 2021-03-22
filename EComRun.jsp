<html>
<head>
<script language="javascript1.3" type="text/javascript">
function runApp(which)
{

  WshShell = new ActiveXObject("WScript.Shell");
  WshShell.Run (which,1,false);

}
</script>
</head>
<body>
<!-- Two ways to create a link to run the app. -->
<font onClick="runApp('file://c:/WINDOWS/notepad.exe');" style="cursor: hand;"><u>Notepad</u></font>
<br>
<!-- Or use <a> descriptor -->
<a href="javascript: runApp('file://c:/ECommerce/CpyOrder.bat');">Batch File</a>
</body>
</html>
