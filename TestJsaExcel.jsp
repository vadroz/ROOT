<%
%>

<html>
<head><Meta http-equiv="refresh"></head>

<SCRIPT language="JavaScript">
//==============================================================================
// start excel
//==============================================================================
function startExcel()
{
  var xls = new ActiveXObject ( "Excel.Application" );
 xls.visible = true;
 var newBook = xls.Workbooks.Add;
 newBook.Worksheets.Add;
 newBook.Worksheets(1).Activate;

 popExcelHdr(newBook);

 newBook.Worksheets(1).Name="Budget vs. Actual Average Rates";
}
//==============================================================================
// populate excel header
//==============================================================================
function popExcelHdr(newBook)
{
   var cells = newBook.Worksheets(1).Cells;

   cells(2,1).value="Str";
   newBook.Worksheets(1).Range(cells(1,1), cells(2,1)).Merge();

   cells(2,2).value="Group";
   newBook.Worksheets(1).Range(cells(1,2), cells(2,2)).Merge();

   cells(2,3).value="Hrs";
   newBook.Worksheets(1).Range(cells(1,3), cells(2,3)).Merge();


   cells(1,4).value="Actual";
   newBook.Worksheets(1).Range(cells(1,4), cells(1,9)).Merge();
   newBook.Worksheets(1).Range(cells(1,4), cells(1,9)).Interior.ColorIndex=36;

   cells(2,4).value="Reg Earn";
   cells(2,5).value="Sls Comm";
   cells(2,6).value="Labor Spiff";
   cells(2,7).value="Paid Spiff";
   cells(2,8).value="Other";
   cells(2,9).value="Total";

   newBook.Worksheets(1).Rows(1).Font.Bold = true;
   newBook.Worksheets(1).Rows(2).Font.Bold = true;
   newBook.Worksheets(1).Rows(2).WrapText = true;
   newBook.Worksheets(1).Rows(1).WrapText = true;
   newBook.Worksheets(1).Range(cells(1,1), cells(2,9)).Font.Bold = true;
   newBook.Worksheets(1).Range(cells(1,1), cells(2,9)).Font.ColorIndex = 5;
   cells(2,2).columnwidth=18;


   newBook.Worksheets(1).Range(cells(1,4), cells(1,9)).Borders(4).LineStyle=1;
   newBook.Worksheets(1).Range(cells(1,4), cells(1,9)).Borders(4).Weight=4;

   for(var i=1; i < 57; i++)
   {
      cells(i, 10).value=i;
      cells(i, 11).Interior.ColorIndex=i;
   }

}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<body>
<h3>Test Javascript and Excel</h3>
  <br><br><br><br>
  <input type="button" value="Avg Rates to Excel (IE only)" onclick="startExcel();">

 </body>

</html>







