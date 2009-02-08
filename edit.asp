<!-- #include file="data.inc"-->
<%
	Dim action
	Dim post
	
	If Request.Querystring("action") = "" Then
		Dim title
		Dim text
		title = Request.Form("title")
		text = Request.Form("text")
		action = Request.Form("action")
		post = Request.Form("post")
	Else
		action = Request.Querystring("action")
		post = Request.Querystring("post")
	End If

	Dim oConnection
	Dim oRecordset
	
	Set oConnection = Server.CreateObject ("ADODB.Connection")
	Set oRecordset = Server.CreateObject ("ADODB.Recordset")
	oConnection.mode = adModeReadWrite
	oConnection.Open strConnect
	
	If action <> "new" Then
		oRecordset.Open "SELECT * FROM [Posts] WHERE PostID = " & post,oConnection,0,3
	Else
		oRecordset.Open "SELECT * FROM [Posts]",oConnection,0,3
	End If
	
	Select Case action
		Case "edit"
			oRecordset("Title") = title
			oRecordset("Content") = text
			oRecordset.Update
		Case "delete"
			oRecordset.Delete
		Case "new"
			oRecordset.AddNew
			oRecordset("Title") = title
			oRecordset("Content") = text
			oRecordset("Poster") = Session("ID")
			oRecordset("TimePosted") = now()
			oRecordset.Update
	End Select
	
	oRecordset.Close
	oConnection.Close
	Set oRecordset = Nothing
	Set oConnection = Nothing
	Response.Redirect "posts.asp"
%>