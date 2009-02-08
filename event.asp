<!-- #include file="data.inc"-->
<%
 Dim oConnection
 Dim oCommand
 Dim oRecordset

 Set oCommand = Server.CreateObject ("ADODB.Command")
 Set oConnection = Server.CreateObject ("ADODB.Connection")
 Set oRecordset = Server.CreateObject ("ADODB.Recordset")
 oConnection.mode = 3 ' adModeReadWrite
 oConnection.Open strConnect

 oRecordset.Open "SELECT * FROM Calendar WHERE EventID = " + Request("eventid"),oConnection,0,3
 %>
<h2 id='etitle'><%=oRecordset("Title")%></h2>
<div id="edate">On 
<script language="javascript" type="text/javascript">SetDate('<%=oRecordset("EDate")%>')</script>
<%=oRecordset("EDate")%> <%If oRecordset("StartTime") <> oRecordset("EndTime") And oRecordset("StartTime") <> "" Then Response.Write " from " & oRecordset("StartTime") & " to " & oRecordset("EndTime") Else If oRecordset("StartTime") <> "" Then Response.Write " at " & oRecordset("StartTime")%> </div>
<div id='evdesc'><%=oRecordset("EDescription")%></div>