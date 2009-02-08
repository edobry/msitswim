function formatdate(date){
// ***********************************************
// AUTHOR: WWW.CGISCRIPT.NET, LLC
// URL: http://www.cgiscript.net
// Use the script, just leave this message intact.
// Download your FREE CGI/Perl Scripts toaceDay!
// ( http://www.cgiscript.net/scripts.htm )
// ***********************************************

var aceDate=new Date()
aceDate.setDate(date);
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
fullDate = aceMonth + "/" + aceDayMonth + "/" + aceYear;
return fullDate;
}