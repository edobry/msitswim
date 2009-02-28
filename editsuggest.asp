<!-- #include file="data.inc"-->
<%
    Dim suggestion
    suggestion  = Request("suggest")
    
	Dim oConnection
	Dim oRecordset
	
	Set oConnection = Server.CreateObject ("ADODB.Connection")
	Set oRecordset = Server.CreateObject ("ADODB.Recordset")
	oConnection.mode = adModeReadWrite
	oConnection.Open strConnect
	
	oRecordset.Open "SELECT * FROM [Suggestions]",oConnection,0,3
	
	oRecordset.AddNew
	oRecordset("Suggestion") = suggestion
	oRecordset.Update
	
	oRecordset.Close
	oConnection.Close
	Set oRecordset = Nothing
	Set oConnection = Nothing
	
	Response.Write "<div id='srecieve'>Thank you. Your suggestion has been recieved.</div>"
%>