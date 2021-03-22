//---------------------------------------------------------
// Script: Format Numeric value
//---------------------------------------------------------
var Precision = 1;
//---------------------------------------------------------
// format numeric
//---------------------------------------------------------
function setPrecision(prec)
{
   if(prec==1) Precision = 1;
   else if(prec==2) Precision = 100;
   else if(prec==3) Precision = 1000;
   else if(prec==4) Precision = 10000;
}

//---------------------------------------------------------
// format numeric
//---------------------------------------------------------
function format(num)
{
    // change number by presision
    num = (num / Precision).toFixed(1);

    var neg = num < 0;
    if (neg) { num = num * -1; }
    num += ""; //convert to string
    if(num.indexOf('.') > -1)
    {
        num = num.split('.');
        num[0] = num[0].toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g,'$1,').split('').reverse().join('').replace(/^[\,]/,'');
        num = num[0]+'.'+num[1];
    }
    else{ num = num.toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g,'$1,').split('').reverse().join('').replace(/^[\,]/,'') };

   if(neg) num = "-" + num;

   return num;
 }


 //---------------------------------------------------------
// format numeric (without conversion) as is
//---------------------------------------------------------
function format_as_is(num, fix)
{
    // change number by presision
    num = eval(num).toFixed(fix);

    var neg = num < 0;
    if (neg) { num = num * -1; }
    num += ""; //convert to string
    if(num.indexOf('.') > -1)
    {
        num = num.split('.');
        num[0] = num[0].toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g,'$1,').split('').reverse().join('').replace(/^[\,]/,'');
        num = num[0]+'.'+num[1];
    }
    else{ num = num.toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g,'$1,').split('').reverse().join('').replace(/^[\,]/,'') };

   if(neg) num = "-" + num;

   return num;
 }
