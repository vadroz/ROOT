<html>
<head>
<title>
Charts01
</title>
</head>

<body>
<OBJECT ID="xlSheet"
        CLASSID="CLSID:0002E510-0000-0000-C000-000000000046"
        style="visibility:hidden">
</OBJECT>
<FORM NAME="form">
<TEXTAREA NAME="output" COLS="80" ROWS="10" WRAP="virtual"></TEXTAREA>
<INPUT TYPE="Button" VALUE="Show Properties" ONCLICK="showProperties()">
</FORM>

</body>
<SCRIPT>
function showProperties() {
  var objName = "xlSheet";
  obj = eval(objName);
  var msg = "";
  for (var i in obj) {
    try {
      // work around bug in IE
      if (i != "domain") msg += objName + "." + i + "=" + obj[i] + "\n";
    }
    catch(e) {}
  }
  form.output.value = msg;
}
</SCRIPT>

</html>
