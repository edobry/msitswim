<!-- #include file="data.inc" -->
<%If Request.Querystring("action") = 1 Then
	  Dim title
	  Dim text
	  
	  Dim action
	  Dim eventid
	  action = Request.Querystring("action")
	  eventid = Request.Querystring("event")
	  
	  Dim oConnection
	  Dim oRecordset
	  
	  Set oConnection = Server.CreateObject ("ADODB.Connection")
	  Set oRecordset = Server.CreateObject ("ADODB.Recordset")
	  oConnection.mode = adModeReadWrite
	  oConnection.Open strConnect
	  
	  oRecordset.Open "SELECT * FROM [Calendar] WHERE EventID = " & eventid,oConnection,0,3
	
  End If
%>
<!-- #include file="top.inc"-->
<script type="text/javascript">
    include('CalendarPopup.js');
    include('time.js');
    var head = document.getElementsByTagName('head')[0];
	style = document.createElement('style');
	style.innerHTML = getCalendarStyles();
	script.type = 'text/css';
	head.appendChild(style);
</script>
<form action="editevents.asp" method="post" name="makeevent">
<%If Session("loggedin") Then%>
<%If Request("action")= 1 Then%>
<h1>Edit Event</h1>
<%Else%>
<h1>Make A New Event</h1>
<%End If%>
<%If Request("action")= 1 Then%>
<input type="hidden" name="action" value="1"/>
<input type="hidden" name="event" value="<%=oRecordset("EventID")%>"/>
<%Else%>
<input type="hidden" name="action" value="0"/>
<%End If%>
<table class="style1">
    <tr style="margin-bottom:3px;">
        <td>
            Title:</td>
        <td>
            <input type="text" name="title" size="53" value="<%If Request("action")= 1 Then Response.Write oRecordset("Title")%>" class="makepost"/></td>
    </tr>
    <tr style="margin-bottom:3px;">
        <td>
            Type:
        </td>
        <td>
            <select name="type" style="height: 22px; margin-left: 4px;" class="makepost"><option>Test</option><option>Practice</option></select>
        </td>
    </tr>
    <tr style="margin-bottom:3px;">
        <td>
            When:
        </td>
        <td>
            <script type="text/javascript" id="js1x">
                var cal1x = new CalendarPopup('mydiv');
            </script>
            <input type="text" class="makepost" size="7" name="startdt" style="padding-right:18px;" value="<%If Request("action")= 1 Then Response.Write oRecordset("EDate")%>" /> <a id="anchor1x" style="float:none;" name="anchor1" onclick="cal1x.select(document.forms['makeevent'].startdt,'anchor1x','MM/dd/yyyy'); return false;" title="cal1x.select(document.forms['makeevent'].startdt,'anchor1x','MM/dd/yyyy'); return false;">
            <img src="images/cal.gif" alt="calendar" 
                style="vertical-align: middle; cursor: pointer; margin-left: -3px; margin-top: -3px;position:relative;left:-21px;top:-1px;" /></a><div id="mydiv" style="position:absolute;margin-left: 35px; margin-top: -4px;"></div>
            from <input type="text" id="stime" class="makepost" name="stime" onblur="magicTime(this)" value="<%If Request("action")= 1 Then Response.Write oRecordset("StartTime")%>" /> to <input id="etime" class="makepost" name="etime" type="text" onblur="magicTime(this)" value="<%If Request("action")= 1 Then Response.Write oRecordset("EndTime")%>" />
       </td>
    </tr>
    <tr style="margin-bottom:3px;">
        <td valign="top">
            <div>
            Description:</div>
        </td>
        <td>
            <textarea cols="40" rows="15" name="description" class="makepost"><%If Request("action")= 1 Then Response.Write oRecordset("EDescription")%></textarea></td>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td>
<input type="submit" value="Post" class="btn" style="margin-left:5px;"/><input type="button" value="Cancel" onclick="window.location = 'calendar.asp'" class="btn"/></td>
    </tr>
</table>
&nbsp;<br/>
&nbsp;<br />
<br/>
&nbsp;
</form>
<%Else%>
This page is for members only. You can sign in <a href="#" onclick="showlogin()">here</a>.
<%End If%>

<!-- #include file="bottom.inc"-->
