<!-- #include file="data.inc"-->
<%
	Dim title
	Dim text
	title = Request.Form("title")
	text = Request.Form("text")

	Dim oConnection
	Dim oCommand
	Dim oRecordset
	
	Set oCommand = Server.CreateObject ("ADODB.Command")
	Set oConnection = Server.CreateObject ("ADODB.Connection")
	Set oRecordset = Server.CreateObject ("ADODB.Recordset")
	oConnection.mode = adModeReadWrite
	oConnection.Open strConnect
	
	oRecordset.Open "SELECT * FROM [Posts]",oConnection,0,3

	oRecordset.AddNew
	oRecordset("Title") = title
	oRecordset("Content") = text
	oRecordset("Poster") = Session("ID")
	oRecordset("TimePosted") = now()
	oRecordset.Update
	
	oRecordset.Close
	oConnection.Close
	Set oRecordset = Nothing
	Set oConnection = Nothing
	Response.Redirect "posts.asp"
%>