var tdate = new Date();
tdate.setHours(0,0,0,0);
tdate.setMonth(tdate.getMonth()-1);
var params = "date=" + formatdate(tdate.getTime());
var xmlHttp = newAjax();

xmlHttp.onreadystatechange = function() {
    var div = $("calendar");
    if (xmlHttp.readyState == 4) {
        if (div) {
            div.innerHTML = xmlHttp.responseText;
        }
    }
    else if(div){
        if (div.innerHTML != '<img alt="Loading..." src="images/loading.gif" class="ldgif" />') {
            div.innerHTML = '<img alt="Loading..." src="images/loading.gif" class="ldgif" />';
        }
    }
}

function changeMonth(mo) {
    tdate.setMonth(tdate.getMonth() + mo);
    //rdate = formatdate(tdate);
    params = "date=" + formatdate(tdate.getTime());
    xmlHttp.open("GET", "JScal/makecal.asp?" + params, true);
    xmlHttp.send(null)
}