<!-- 0=new 1=edit 2=delete-->
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
	
	If action <> 0 Then
		oRecordset.Open "SELECT * FROM [Posts] WHERE PostID = " & post,oConnection,0,3
	Else
		oRecordset.Open "SELECT * FROM [Posts]",oConnection,0,3

	End If
	
	Select Case action
		Case 1
			oRecordset("Title") = title
			oRecordset("Content") = text
			oRecordset.Update
		Case 2
			oRecordset.Delete
		Case 0
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