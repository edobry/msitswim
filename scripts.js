
var xmlSuggest = newAjax();

xmlSuggest.onreadystatechange = function() {
    var div = $("suggestbox");
    if (xmlSuggest.readyState == 4) {
        if (div) {
            div.innerHTML = xmlSuggest.responseText;
        }
    }
    else if(div){
        if (div.innerHTML != '<img alt="Loading..." src="images/loading.gif" />') {
            div.innerHTML = '<img alt="Loading..." src="images/loading.gif" />';
        }
    }
}

function div(wdiv,visibility) { 
	if (document.getElementById) { // DOM3 = IE5, NS6 
		$(wdiv).style.visibility = visibility; 
	} 
	else { 
		if (document.layers) { // Netscape 4 
			document.hideshow.visibility = visibility; 
		} 
		else { // IE 4 
			document.all.hideshow.style.visibility = visibility; 
		} 
	} 
}

//Get all the elements of the given classname of the given tag.
function getElementsByClassName(classname,tag) {
 if(!tag) tag = "*";
 var anchs =  document.getElementsByTagName(tag);
 var total_anchs = anchs.length;
 var regexp = new RegExp('\\b' + classname + '\\b');
 var class_items = new Array()
 
 for(var i=0;i<total_anchs;i++) { //Go thru all the links seaching for the class name
  var this_item = anchs[i];
  if(regexp.test(this_item.className)) {
   class_items.push(this_item);
  }
 }
 return class_items;
}

function hidelogin(){
	$('login').innerHTML = "";
}

function include(filename)
{
	var head = document.getElementsByTagName('head')[0];
	
	script = document.createElement('script');
	script.src = filename;
	script.type = 'text/javascript';
	
	head.appendChild(script)
}

function formatdate(date){
// ***********************************************
// AUTHOR: WWW.CGISCRIPT.NET, LLC
// URL: http://www.cgiscript.net
// Use the script, just leave this message intact.
// Download your FREE CGI/Perl Scripts toaceDay!
// ( http://www.cgiscript.net/scripts.htm )
// ***********************************************

var aceDate=new Date()
aceDate.setTime(date);
var aceYear=aceDate.getFullYear()
if (aceYear < 1000)
aceYear+=1900
var aceDay=aceDate.getDay()
var aceMonth=aceDate.getMonth()+1
if (aceMonth<10)
aceMonth="0"+aceMonth
var aceDayMonth=aceDate.getDate()
if (aceDayMonth<10)
aceDayMonth="0"+aceDayMonth
fullDate = aceMonth + "/" + aceDayMonth + "/" + aceYear;
return fullDate;
}

function $() {
	var elements = new Array();
	for (var i = 0; i < arguments.length; i++) {
		var element = arguments[i];
		if (typeof element == 'string')
			element = $(element);
		if (arguments.length == 1)
			return element;
		elements.push(element);
	}
	return elements;
}

function newAjax(){
    var xmlHttp;
    try {
        // Firefox, Opera 8.0+, Safari
        xmlHttp = new XMLHttpRequest();
    }
    catch (e) {
        // Internet Explorer
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
    }
    return xmlHttp;
}

function getCalendarStyles() { var result = ""; var p = ""; if (this != null && typeof (this.cssPrefix) != "undefined" && this.cssPrefix != null && this.cssPrefix != "") { p = this.cssPrefix; } result += ""; result += "." + p + "cpYearNavigation,." + p + "cpMonthNavigation{background-color:#C0C0C0;text-align:center;vertical-align:middle;text-decoration:none;color:#000000;font-weight:bold;}\n"; result += "." + p + "cpDayColumnHeader, ." + p + "cpYearNavigation,." + p + "cpMonthNavigation,." + p + "cpCurrentMonthDate,." + p + "cpCurrentMonthDateDisabled,." + p + "cpOtherMonthDate,." + p + "cpOtherMonthDateDisabled,." + p + "cpCurrentDate,." + p + "cpCurrentDateDisabled,." + p + "cpTodayText,." + p + "cpTodayTextDisabled,." + p + "cpText{font-family:arial;font-size:8pt;}\n"; result += "TD." + p + "cpDayColumnHeader{text-align:right;border:solid thin #C0C0C0;border-width:0px 0px 1px 0px;}\n"; result += "." + p + "cpCurrentMonthDate, ." + p + "cpOtherMonthDate, ." + p + "cpCurrentDate{text-align:right;text-decoration:none;}\n"; result += "." + p + "cpCurrentMonthDateDisabled, ." + p + "cpOtherMonthDateDisabled, ." + p + "cpCurrentDateDisabled{color:#D0D0D0;text-align:right;text-decoration:line-through;}\n"; result += "." + p + "cpCurrentMonthDate, .cpCurrentDate{color:#000000;}\n"; result += "." + p + "cpOtherMonthDate{color:#808080;}\n"; result += "TD." + p + "cpCurrentDate{color:white;background-color: #C0C0C0;border-width:1px;border:solid thin #800000;}\n"; result += "TD." + p + "cpCurrentDateDisabled{border-width:1px;border:solid thin #FFAAAA;}\n"; result += "TD." + p + "cpTodayText, TD." + p + "cpTodayTextDisabled{border:solid thin #C0C0C0;border-width:1px 0px 0px 0px;}\n"; result += "A." + p + "cpTodayText, SPAN." + p + "cpTodayTextDisabled{height:20px;}\n"; result += "A." + p + "cpTodayText{color:black;}\n"; result += "." + p + "cpTodayTextDisabled{color:#D0D0D0;}\n"; result += "." + p + "cpBorder{border:none;background-color:white;}\n"; result += ""; return result; }

function SetDate(indate){
    var date = new Date();
    var part = new String(indate);
    date.setFullYear(part.substr(6,4),part.substr(0,2),part.substr(3,2));
    return date;
}

function suggest(){
    var suggestion = $('suggest').value;
    $('sbtn').disabled = true;
    xmlSuggest.open("GET", "editsuggest.asp?suggest=" + suggestion, true);
    xmlSuggest.send(null)
}