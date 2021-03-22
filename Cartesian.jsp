<%@ page import="payrollreports.IncPlan, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
%>

<html>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var t = "";
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
   //var a = ["8", "A", "B", "C"];
   //document.all.dvComb.innerHTML += "<br>before " + a + "  a.splice(1, 0, 10) = " + a.splice(1, 0, "10") + " after " + a;

   t = document.all.dvComb.innerHTML + "<br>";
   //var a = permute(["3","4","5", "8","10"]);

   var a = cartesian([3,4,5], [8,10,11], [86,92,93, 96]);
   t += "<br>";
   for(var i=0, j=0; i < a.length;i++, j++)
   {
      t += a[i] + " &nbsp; "
   }
   document.all.dvComb.innerHTML = t +  "<br>" + a.length
}

//==============================================================================
// premutaion
//==============================================================================
function cartesian()
{
    var r = [], arg = arguments, max = arg.length-1;
    var Deep = 0;

    t += "<br>0.  arg: " + arg + "  r: " + r + " max: " + max

    function helper(arr, i)
    {
        var deep = Deep;
        Deep++;

        t += "<br>1.  arr: " + arr + "  i: " + i + "   deep: " + deep
        for (var j=0, l=arg[i].length; j<l; j++)
        {
            var a = arr.slice(0); // clone arr
            t += "<br> &nbsp; 2.  arr: " + arr + "  j: " + j + "  a: " + a + "   deep: " + deep
            a.push(arg[i][j])
            t += "<br> &nbsp; 3.  arr: " + arr + "  j: " + j + "  a: " + a + "   deep: " + deep
            if (i==max) {
                r.push(a);
                t += "<br> &nbsp;  &nbsp; 4.  r: " + r + "  j: " + j + "  i: " + i   + "   deep: " + deep
            } else
                helper(a, i+1);
        }
    }
    helper([], 0);
    return r;
};
//==============================================================================
// premutaion
//==============================================================================
function permute(input) {
    var permArr = [],usedChars = [];
    var Deep = 0;

    t += "<br>input: " + input + "<br>"

    function main(input){
        var i, ch,  deep;
        deep = Deep;
        Deep++;

        for (i = 0; i < input.length; i++) {
            ch = input.splice(i, 1)[0];
            usedChars.push(ch);
            //t += "<br>1 i: " + i + " input: " + input + " ch " + ch + " usedChars: " + usedChars + "  deep: " +  deep
            document.all.dvComb.innerHTML = t;

            if (input.length == 0) {
                //t += "<br>2 i: " + i + " usedChars: " + usedChars + "  deep: " +  deep
                permArr.push(usedChars.slice());
            }

            main(input);
            //t += "<br>4 i: " + i + " input: " + input + " ch " + ch + " usedChars: " + usedChars + "  deep: " +  deep
            input.splice(i, 0, ch);
            //t += "<br>5 i: " + i + " input: " + input + " usedChars: " + usedChars + "  deep: " +  deep

            usedChars.pop();
            //t += "<br>6 i: " + i + " input: " + input  + " usedChars: " + usedChars + "  deep: " +  deep + "<br>"

        }
        return permArr;
    }
    return main(input);
}




</SCRIPT>
<body onload="bodyload()">
  <div id="dvComb">Test</div>
</body>
</html>
