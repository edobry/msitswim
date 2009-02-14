<%@language = "JavaScript"%>
<%
function SetDate(indate){
    var date = new Date();
    var part = new String(indate);
    date.setFullYear(part.substr(6,4),part.substr(0,2),part.substr(3,2));
    return date;
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
var aceYear=aceDate.getYear()
if (aceYear < 1000)
aceYear+=1900
var aceDay=aceDate.getDay()
var aceMonth=aceDate.getMonth()+1
if (aceMonth<10)
aceMonth="0"+aceMonth
var aceDayMonth=aceDate.getDate()
if (aceDayMonth<10)
aceDayMonth="0"+aceDayMonth
var fullDate = aceMonth + "/" + aceDayMonth + "/" + aceYear;
return fullDate;
}

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

var strConnect =  'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\\sites\\content\\W\\h\\i\\WhiteNdNrdy\\db\\data.mdb;Persist Security Info=False';
var oCommand = Server.CreateObject("ADODB.Command");
var oConnection = Server.CreateObject("ADODB.Connection");
var oRecordset = Server.CreateObject("ADODB.Recordset");
oConnection.Open(strConnect);

oRecordset.Open("SELECT * FROM [Calendar]",oConnection,1,3);

var caldate = SetDate(Request.QueryString("date"));

var thisMonth = new calendar('thisMonth',caldate);
Response.Write(thisMonth.write());

var days = new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
var months = new Array('January','February','March','April','May','June','July','August','September','October','November','December');

function getFormattedDate(){
	return days[this.day] + ', ' + months[this.month] + ' ' + this.date + ', ' + this.year;
	//return this.month + '/' + this.date + '/' + this.year;
}

function writeCalendar(){
    var days = new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
    var months = new Array('January','February','March','April','May','June','July','August','September','October','November','December');

    var calString = '';
    var popdate = '';
    %>
    <div id="calContainer">
    <table id="cal<%=this.id%>" cellspacing="2">
    <tr>
    <td id="nav" colspan="7">
    <input id="prevMonth" value="&lt;" type="button" class="navbtn" onclick="changeMonth(-1)">
    <span class="month"><%=months[this.month]%></span><input id="nextMonth" value="&gt;" type="button" class="navbtn" onclick="changeMonth(+1)">
    <input id="prevYear" value="&lt;&lt;" type="button" class="navbtn" onclick="changeMonth(-12)"><span id="yearHolder"><%=this.year%></span>
    <input id="nextYear" value="&gt;&gt;" type="button" class="navbtn" onclick="changeMonth(+12)">
    
	  <a href="makeevent.asp">+New Event</a>
    </tr>
    <tr>
    <%
    for(var i=0;i<days.length;i++){
	    calString += '<th class="dayHeader">' + days[i].substring(0,3) + '</th>\n';
    }
    //write the body of the calendar
    calString += '<tr>';
    var tmpdate = this.dateObject;
    var tmpsdate = this.dateObject;
    //create 6 rows so that the calendar doesn't resize
    for(var j=0;j<42;j++){
    	var displayNum = (j-this.firstDay+1);
    	if(j<this.firstDay){
		    //write the leading empty cells
		    calString += '<td class="empty">&nbsp;</td>';
	    }else if(displayNum > this.length()){
    		//Empty cells at bottom of calendar
		    calString += '<td>&nbsp;</td>';
	    }else{
    		//the rest of the numbered cells
		    calString += '<td class="days" id="' + displayNum + '">' + displayNum + '<div id="' + displayNum + 'event" class="eventtitle">';
		    tmpdate.setDate(displayNum);
		    oRecordset.Filter = "[EDate] = " + formatdate(tmpdate.getTime());
		    if (!oRecordset.EOF || !oRecordset.BOF) {
    		    calString += "<span class='event' onclick='showevent(" + oRecordset('EventID') + ")'>" + oRecordset('Title') + "</span>";
		    }
		    calString += '</div></td>\n';
		    calString += '</td>';
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
    %>