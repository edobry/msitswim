<!-- #include file="data.inc"-->
<%
	Dim user
	user = Request("user")
	Dim pass
	pass = Request("pass")
	
	Dim oConnection
	Dim oRecordset
	
	Set oConnection = Server.CreateObject ("ADODB.Connection")
	Set oRecordset = Server.CreateObject ("ADODB.Recordset")
	oConnection.mode = adModeReadWrite
	oConnection.Open strConnect
	
	oRecordset.Open "SELECT * FROM [People] WHERE ID = " & Session("ID"),oConnection,0,3

	oRecordset("Username") = user
	oRecordset("Password") = pass
	oRecordset.Update
	
	oRecordset.Close
	oConnection.Close
	Set oRecordset = Nothing
	Set oConnection = Nothing
	Response.Redirect "members.asp"
%>