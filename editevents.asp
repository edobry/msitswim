<!-- 0=new 1=edit 2=delete-->
<!-- #include file="data.inc"-->
<%
	Dim action
	Dim eventid
	
	If Request.Querystring("action") = "" Then
		Dim title
		Dim text
		Dim etype
		Dim startdt
		title = Request.Form("title")
		etype = Request.Form("type")
		startdt = Request.Form("startdt")
		stime = Request.Form("stime")
		etime = Request.Form("etime")
		description = Request.Form("description")
		action = Request.Form("action")
		eventid = Request.Form("event")
	Else
		action = Request("action")
		eventid = Request("event")
	End If
        
	Dim oConnection
	Dim oRecordset
	
	Set oConnection = Server.CreateObject ("ADODB.Connection")
	Set oRecordset = Server.CreateObject ("ADODB.Recordset")
	oConnection.mode = adModeReadWrite
	oConnection.Open strConnect
	
	If action <> 0 Then
		oRecordset.Open "SELECT * FROM [Calendar] WHERE EventID = " & eventid,oConnection,0,3
	Else
		oRecordset.Open "SELECT * FROM [Calendar]",oConnection,1,3

	End If
	
	Select Case action
		Case 1
			oRecordset("Title") = title
			oRecordset("EType") = etype
			oRecordset("EDate") = startdt
			oRecordset("StartTime") = stime
			oRecordset("EndTime") = etime
			oRecordset("EDescription") = description
			oRecordset.Update
		Case 2
			oRecordset.Delete
		Case 0
			oRecordset.AddNew
			oRecordset("Poster") = Session("ID")
			oRecordset("Title") = title
			oRecordset("EDate") = startdt
			oRecordset("StartTime") = stime
			oRecordset("EndTime") = etime
			oRecordset("EDescription") = description
			oRecordset("EType") = etype			
			oRecordset.Update
	End Select
	
	oRecordset.Close
	oConnection.Close
	Set oRecordset = Nothing
	Set oConnection = Nothing
	Response.Redirect "calendar.asp"
%>