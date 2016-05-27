<script>
// Convert touch to mouse event for mobile devices
function touchHandler(event) {
  var touches = event.changedTouches,
       first = touches[0], type = "";
  switch(event.type) {
    case "touchstart": type="mousedown"; break;
    case "touchmove":  type="mousemove"; break;        
    case "touchend":   type="mouseup"; break;
    default: return;
  }
  var simulatedEvent = document.createEvent("MouseEvent");
  simulatedEvent.initMouseEvent(type, true, true, window, 1, 
                            first.screenX, first.screenY, 
                            first.clientX, first.clientY, false, 
                            false, false, false, 0/*left*/, null);
  first.target.dispatchEvent(simulatedEvent);
  event.preventDefault();
}
document.addEventListener("touchstart", touchHandler, true);
document.addEventListener("touchmove", touchHandler, true);
document.addEventListener("touchend", touchHandler, true);
document.addEventListener("touchcancel", touchHandler, true); 

// rotate needle to correct position
var pos = 50;
function setPos(p) {
  if (p<0) p=0;
  if (p>100) p=100;
  pos = p;
  // change the label's text
  document.getElementById("label").textContent = pos;    
  // rotate the 'needle' around the middle of the SVG
  var a = (pos-50)*2.8;
  document.getElementById("needle").setAttribute("transform","rotate("+a+" 250 250)");    
}
setPos(pos);

// handle events
var dragging = false;
function dragStart() {
  dragging = true;
  document.getElementById("ring").style.fill = "#ff0000";
}
document.addEventListener("mousemove", function(e) {
  if (dragging) {
    e.preventDefault();
    var svg = document.getElementById("svg");
    // work out the angle from coordinates - note that the coordinates are in window pixels, not SVG pixels
    var ang = Math.atan2(e.clientX-(svg.clientWidth/2),(svg.clientHeight/2)-e.clientY)*180/Math.PI;
    // move to new location
    setPos(Math.round((ang/2.8)+50));
  }
});
document.addEventListener("mouseup", function(e) {
  dragging = false;
  document.getElementById("ring").style.fill = "#80e5ff";
  document.getElementById("up").style.fill = "#d5f6ff";
  document.getElementById("dn").style.fill = "#d5f6ff";
    // POST data to Espruino
  var req=new XMLHttpRequest();
  req.open("POST","?pos="+pos, true);
  req.send();
});
document.getElementById("ring").onmousedown = dragStart;
document.getElementById("needle").onmousedown = dragStart;
document.getElementById("up").onmousedown = function(e) { e.preventDefault(); this.style.fill = "#ff0000"; };
document.getElementById("dn").onmousedown = function(e) { e.preventDefault(); this.style.fill = "#00ff00"; };
document.getElementById("up").onmouseup = function(e) { setPos(pos+10); };
document.getElementById("dn").onmouseup = function(e) { setPos(pos-10); };
</script>