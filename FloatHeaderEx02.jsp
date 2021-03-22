<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<style type="text/css">
    table {
  position: relative;
  width: 700px;
  overflow: hidden;
  border-collapse: collapse;
}


/*thead*/
thead {
  position: relative;
  display: block; /*seperates the header from the body allowing it to be positioned*/
  width: 700px;
  overflow: visible;
}

thead th {
  min-width: 120px;
  height: 32px;
  border: 1px solid #222;
}

thead th:nth-child(1) {/*first cell in the header*/
  position: relative;
  display: block; /*seperates the first cell in the header from the header*/  
}


/*tbody*/
table {
  position: relative;
  width: 700px;
  background-color: #FFE4C4;
  overflow: hidden;
  border-collapse: collapse;
}


/*thead*/
thead {
  position: relative;
  display: block; /*seperates the header from the body allowing it to be positioned*/
  width: 700px;
  overflow: visible;
}

thead th {
  background-color: #FFE4C4;
  min-width: 120px;
  height: 32px;
  border: 1px solid #222;
}

thead th:nth-child(1) {/*first cell in the header*/
  position: relative;
  display: block; /*seperates the first cell in the header from the header*/
  background-color: #FFE4C4;
}


/*tbody*/
tbody {
  position: relative;
  display: block; /*seperates the tbody from the header*/
  width: 700px;
  height: 239px;
  overflow: scroll;
}

tbody td {
  background-color: #e7e7e7;
  min-width: 120px;
  border: 1px solid #222;
}

tbody tr td:nth-child(1) {  /*the first cell in each tr*/
  position: relative;
  display: block; /*seperates the first column from the tbody*/
  height: 40px;
  background-color: #e7e7e7;
}
</style>

<title>Floating header</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script>
$(document).ready(function() {
	  $('tbody').scroll(function(e) { //detect a scroll event on the tbody
	  	/*
	    Setting the thead left value to the negative valule of tbody.scrollLeft will make it track the movement
	    of the tbody element. Setting an elements left value to that of the tbody.scrollLeft left makes it maintain 			it's relative position at the left of the table.    
	    */
	    $('thead').css("left", -$("tbody").scrollLeft()); //fix the thead relative to the body scrolling
	    $('thead th:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first cell of the header
	    $('tbody td:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first column of tdbody
	  });
	});

</script>
</head>

<body>
test 
  <table>
    <thead>
      <tr>
        <th>Name</th>
        <th>Town</th>
        <th>County</th>
        <th>Age</th>
        <th>Profession</th>
        <th>Anual Income</th>
        <th>Matital Status</th>
        <th>Children</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>John Smith</td>
        <td>Macelsfield</td>
        <td>Cheshire</td>
        <td>52</td>
        <td>Brewer</td>
        <td>£47,000</td>
        <td>Married</td>
        <td>2</td>
      </tr>
      <tr>
        <td>Jenny Jones</td>
        <td>Threlkeld</td>
        <td>Cumbria</td>
        <td>34</td>
        <td>Shepherdess</td>
        <td>£28,000</td>
        <td>Single</td>
        <td>0</td>
      </tr>
      <tr>
        <td>Peter Frampton</td>
        <td>Avebury</td>
        <td>Wiltshire</td>
        <td>57</td>
        <td>Musician</td>
        <td>£124,000</td>
        <td>Married</td>
        <td>4</td>
      </tr>
      <tr>
        <td>Simon King</td>
        <td>Malvern</td>
        <td>Worchestershire</td>
        <td>48</td>
        <td>Naturalist</td>
        <td>£65,000</td>
        <td>Married</td>
        <td>2</td>
      </tr>
      <tr>
        <td>Lucy Diamond</td>
        <td>St Albans</td>
        <td>Hertfordshire</td>
        <td>67</td>
        <td>Pharmasist</td>
        <td>Retired</td>
        <td>Married</td>
        <td>3</td>
      </tr>
      <tr>
        <td>Austin Stevenson</td>
        <td>Edinburgh</td>
        <td>Lothian </td>
        <td>36</td>
        <td>Vigilante</td>
        <td>£86,000</td>
        <td>Single</td>
        <td>Unknown</td>
      </tr>
      <tr>
        <td>Wilma Rubble</td>
        <td>Bedford</td>
        <td>Bedfordshire</td>
        <td>43</td>
        <td>Housewife</td>
        <td>N/A</td>
        <td>Married</td>
        <td>1</td>
      </tr>
      <tr>
        <td>Kat Dibble</td>
        <td>Manhattan</td>
        <td>New York</td>
        <td>55</td>
        <td>Policewoman</td>
        <td>$36,000</td>
        <td>Single</td>
        <td>1</td>
      </tr>
      <tr>
        <td>Henry Bolingbroke</td>
        <td>Bolingbroke</td>
        <td>Lincolnshire</td>
        <td>45</td>
        <td>Landowner</td>
        <td>Lots</td>
        <td>Married</td>
        <td>6</td>
      </tr>
      <tr>
        <td>Alan Brisingamen</td>
        <td>Alderley</td>
        <td>Cheshire</td>
        <td>352</td>
        <td>Arcanist</td>
        <td>A pile of gems</td>
        <td>Single</td>
        <td>0</td>
      </tr>
    </tbody>
  </table>
</body>


</html>
