include('date.js');

var url = '';
var params = '';
var etitle = '';

var xmlHttp = new XMLHttpRequest();
xmlHttp.onreadystatechange = function() {
    if (xmlHttp.readyState == 4) {
        etitle = xmlHttp.responseText;
        /*var element = document.getElementById(datepart);
        if(element) 
        {
        element.innerHTML = xmlHttp.responseText;
        }
        */
    }
}

/*
var xmlHttp = new XMLHttpRequest();
xmlHttp.onreadystatechange = function() { 
	if (xmlHttp.readyState==4)
		{
			var today = new Date();
			var element = document.getElementById(today.getDate());
			if(element) 
			{
				element.innerHTML = xmlHttp.responseText;
			}
		}
	}
*/


//Constructor
function calendar(id,d,p){
	this.id = id;
	this.dateObject = d;
	this.write = writeCalendar;
	this.length = getLength;
	this.month = d.getMonth();
	this.date = d.getDate();
	this.day = d.getDay();
	this.year = d.getFullYear();
	this.getFormattedDate = getFormattedDate;
	//get the first day of the month's day
	d.setDate(1);
	this.firstDay = d.getDay();
	//then reset the date object to the correct date
	d.setDate(this.date);
}

var days = new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
var months = new Array('January','February','March','April','May','June','July','August','September','October','November','December');

function getFormattedDate(){
	return days[this.day] + ', ' + months[this.month] + ' ' + this.date + ', ' + this.year;
	//return this.month + '/' + this.date + '/' + this.year;
}

function writeCalendar(){
	var calString = '<div id="calContainer">';
	//write navigation
	calString += '<table id="cal' + this.id + '" cellspacing="2">\n';
	calString += '<tr><td id="nav" colspan="7"><input id="todayButton" style="display:none;" value="Today" type="button" onclick="d.setDate(this.date)" class="navbtn">\n<input id="prevMonth" value="&lt;" type="button" class="navbtn" onclick="changeMonth(-1,\'' + this.id + '\')">\n';
	calString += '<span class="month">' + months[this.month] + '</span><input id="nextMonth" value="&gt;" type="button" class="navbtn" onclick="changeMonth(+1,\'' + this.id + '\')">\n';
	calString += '<input id="prevYear" value="&lt;&lt;" type="button" class="navbtn" onclick="changeMonth(-12,\'' + this.id + '\')"><span id="yearHolder">' + this.year + '</span><input id="nextYear" value="&gt;&gt;" type="button" class="navbtn" onclick="changeMonth(+12,\'' + this.id + '\')"></td></tr>\n';
	//write a row containing days of the week
	calString += '<tr>';	
	for(var i=0;i<days.length;i++){
		calString += '<th class="dayHeader">' + days[i].substring(0,3) + '</th>\n';
	}
	//write the body of the calendar
	calString += '<tr>';
	//create 6 rows so that the calendar doesn't resize
	for(var j=0;j<42;j++){
		var displayNum = (j-this.firstDay+1);
		if(j<this.firstDay){
			//write the leading empty cells
			calString += '<td class="empty">&nbsp;</td>';
		}else if(displayNum==this.date){
			calString += '<td id="' + this.id +'selected" class="date" onclick="changeDate(this,\'' + this.id + '\')">' + displayNum + '<div id="' + this.date + '" class="eventtitle">';
			var popdate = (this.month + 1) + '/' + displayNum + '/' + this.year;
			popdate = dateFormat(popdate, "mm/dd/yyyy");
			populate(popdate);
			calString += xmlHttp.responseText;
			calString += '</div></td>\n';
			/*
			url = 'getcal.asp';
			params = 'sid=' + Math.random() + '&q=' + (this.month + 1) + '/' + displayNum + '/' + this.year;
			xmlHttp.open("POST",url,true);
			xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xmlHttp.setRequestHeader("Content-length", params.length);
			xmlHttp.setRequestHeader("Connection", "close");
			xmlHttp.send(params);
			*/
			calString += '</td>';
		}else if(displayNum > this.length()){
			//Empty cells at bottom of calendar
			calString += '<td>&nbsp;</td>';
		}else{
			//the rest of the numbered cells
			calString += '<td id="" class="days" onclick="changeDate(this,\'' + this.id + '\')">' + displayNum + '<div id="' + displayNum + '" class="eventtitle">';
			var popdate = (this.month + 1) + '/' + displayNum + '/' + this.year;
			popdate = dateFormat(popdate, "mm/dd/yyyy");
			populate(popdate);
			calString += xmlHttp.responseText;
			calString += '</div></td>\n';
			/*
			url = 'getcal.asp';
			params = 'sid=' + Math.random() + '&q=' + (this.month + 1) + '/' + displayNum + '/' + this.year;
			xmlHttp.open("POST",url,true);
			xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xmlHttp.setRequestHeader("Content-length", params.length);
			xmlHttp.setRequestHeader("Connection", "close");
			xmlHttp.send(params);
			*/
		}
		if(j%7==6){
			calString += '</tr><tr>';
		}
	}
	//close the last number row
	calString += '</tr>';
	calString += '</table>';
	calString += '</div>\n';
	return calString;
}

function getLength(){
	//thirty days has September...
	switch(this.month){
		case 1:
			if((this.dateObject.getFullYear()%4===0&&this.dateObject.getFullYear()%100!==0)||this.dateObject.getFullYear()%400===0)
				return 29; //leap year
			else
				return 28;
		case 3:
			return 30;
		case 5:
			return 30;
		case 8:
			return 30;
		case 10:
			return 30
		default:
			return 31;
	}
}
function changeDate(td,cal){
	//Some JavaScript trickery
	//Change the cal argument to the existing calendar object
	//This is why the first argument in the constructor must match the variable name
	//The cal reference also allows for multiple calendars on a page
	cal = eval(cal);
	document.getElementById(cal.id + "selected").className = "days";
	document.getElementById(cal.id + "selected").id = "";
	td.className = "date";
	td.id = cal.id + "selected";
	//set the calendar object to the new date
	cal.dateObject.setDate(td.firstChild.nodeValue);
	cal = new calendar(cal.id,cal.dateObject);
	//here is where you could react to a date change - I'll just display the formatted date
	window.status = cal.getFormattedDate();
}

function changeMonth(mo,cal){
	//more trickery!
	cal = eval(cal);
	//The Date object is smart enough to know that it should roll over in December
	//when going forward and in January when going back
	cal.dateObject.setMonth(cal.dateObject.getMonth() + mo);
	cal = new calendar(cal.id,cal.dateObject);
	cal.formattedDate = cal.getFormattedDate();
	document.getElementById('calContainer').innerHTML = cal.write();
}

function changeYear(yr,cal){
	var yrdiff = yr - cal.dateObject.getFullYear;
	cal = eval(cal);
	cal.dateObject.setMonth(cal.dateObject.getMonth() + yrdiff);
	cal = new calendar(cal.id,cal.dateObject);
	cal.formattedDate = cal.getFormattedDate();
	document.getElementById('calContainer').innerHTML = cal.write();
}

function populate(date){
	var datepart = date.slice(3,5);
	url = 'getcal.asp' + '?sid=' + Math.random();
	params = '&date=' + date;
	xmlHttp.open("GET",url + params,false);
	//xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	//xmlHttp.setRequestHeader("Content-length", params.length);
	//xmlHttp.setRequestHeader("Connection", "close");
	xmlHttp.send(null);
}