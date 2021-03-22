//-------------------------------------------------------------
// Move objects by cursor
//-------------------------------------------------------------
var leftX = 1;
var topY = 1;
var element = 0;
var rtnFld = null;
var dragapproved=false;
var z,x,y

var MovingBoxClassName = new Array();
var MovingBoxId = new Array();
//-------------------------------------------------------------
// save class name for object that must be allowed to move
//-------------------------------------------------------------
function setBoxclasses(boxClassName, boxId)
{
   MovingBoxClassName = boxClassName;
   MovingBoxId = boxId;
   document.onmousedown=drags;
   document.onmouseup=nodrags;
}

//-------------------------------------------------------------
// set dragging function for ipad
// example -- http://popdevelop.com/2010/08/touching-the-web/
//-------------------------------------------------------------
function setDraggable()
{
   $.fn.draggable = function() {
    var offset = null;
    var start = function(e) {
      var orig = e.originalEvent;
      var pos = $(this).position();
      offset = {
        x: orig.changedTouches[0].pageX - pos.left,
        y: orig.changedTouches[0].pageY - pos.top
      };
    };
    var moveMe = function(e) {
      e.preventDefault();
      var orig = e.originalEvent;
      $(this).css({
        top: orig.changedTouches[0].pageY - offset.y,
        left: orig.changedTouches[0].pageX - offset.x
      });
    };
    this.bind("touchstart", start);
    this.bind("touchmove", moveMe);
  };

  $(".draggable").draggable();
}  
//-------------------------------------------------------------
// Move
//-------------------------------------------------------------
function move()
{
  if((!isChrome && (event.button==1 || event.which==1) || isChrome && event.buttons==1) && dragapproved)
  {	  
     z.style.left=temp1+event.clientX-x
     z.style.top=temp2+event.clientY-y
     return false
   }
}
//-------------------------------------------------------------
// drag
//-------------------------------------------------------------
function drags(MovingBoxClassName)
{
  /*if (document.all == null) 
  { 
	  return; 
  }
  */
  var obj = event.srcElement

  if(isBoxClassMustbeMoved(event.srcElement.className))
  {
    while (obj.offsetParent)
    {
      if (isBoxIdMustbeMoved (obj.id))
      {
         z=obj;
         break;
      }
      obj = obj.offsetParent;
    }
  }

  if (z!=null)
  {
    dragapproved=true;
    temp1=z.style.left
    temp1 = parseInt(temp1, 10);
    temp2=z.style.top
    temp2 = parseInt(temp2, 10);
    x=event.clientX
    y=event.clientY
    document.onmousemove=move
  }
}
//-------------------------------------------------------------
// No drag
//-------------------------------------------------------------
function nodrags()
{
  dragapproved=false;
  z=null;
}
//-------------------------------------------------------------
// check if box name class name selected to be draged
//-------------------------------------------------------------
function isBoxClassMustbeMoved(boxClass)
{
   var allows = false;
   for(var i=0; i < MovingBoxClassName.length; i++)
   {
     if( MovingBoxClassName[i] == boxClass )
     {
       allows = true;
       break;
     }
   }
   return allows;
}
//-------------------------------------------------------------
// check if box selected to be moved
//-------------------------------------------------------------
function isBoxIdMustbeMoved(boxId)
{
   var allows = false;
   for(var i=0; i < MovingBoxId.length; i++)
   {
     if( MovingBoxId[i] == boxId )
     {
       allows = true;
       break;
     }
   }
   return allows;
}