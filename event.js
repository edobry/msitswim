var xmlEvent = newAjax();

xmlEvent.onreadystatechange = function() {
    var ediv = $('ebox');
    if (xmlEvent.readyState == 4) {
        if (ediv) {
            ediv.innerHTML = xmlEvent.responseText;
        }
    }
    else {
        if(ediv){
            ediv.innerHTML = '<img alt="Loading..." src="images/loading.gif" class="eldgif" />';
        }
    }
}

function showevent(eventid){
    xmlEvent.open("GET", "event.asp?eventid=" + eventid, true);
    xmlEvent.send(null);

    $('eventbox').appear({ duration: 0.5 });
    
    var eventedit = $('eventedit');
    if (eventedit) {
        eventedit.innerHTML = '<a href="makeevent.asp?action=1&event=' + eventid +'">Edit</a> | <a href="editevents.asp?action=2&event=' + eventid + '">Delete</a>';
    }

}