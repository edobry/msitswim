<!-- #include file="data.inc"-->
<%
	Dim user
	Dim pass
	user = Request.Form("username")
	pass = Request.Form("password")
	
	Dim oConnection
	Dim oCommand
	Dim oRecordset
	
	Set oCommand = Server.CreateObject ("ADODB.Command")
	Set oConnection = Server.CreateObject ("ADODB.Connection")
	Set oRecordset = Server.CreateObject ("ADODB.Recordset")
	oConnection.mode = 3 ' adModeReadWrite
	oConnection.Open strConnect
	
	oRecordset.Open "SELECT * FROM [People] WHERE Username = '" & user & "'",oConnection,0,3
	
	If Not oRecordset.EOF Then
		If oRecordset("Password") = pass Then
			Session("gUser") = "true"
			Session("gPass") = "true"
			Dim strName, value
			For Each sField In oRecordset.Fields
				strName = sField.Name
				value = sField.value
				Session(strName) = value
			Next
		Else
			Session("gPass") = "false"
		End If
	Else
		Session("gUser") = "false"
		Session("gPass") = "true"
	End If
	
	If Session("gUser") = "false" Then
		oRecordset.Close
		oConnection.Close
		Set oRecordset = Nothing
		Set oConnection = Nothing
		Response.Redirect Request.Form("page") + "?log=yes"
	End If
	
	If Session("gPass") = "false" Then
		Session("Username") = user
		oRecordset.Close
		oConnection.Close
		Set oRecordset = Nothing
		Set oConnection = Nothing
		Response.Redirect Request.Form("page") + "?log=yes"
	End If
	
	If Session ("gPass") AND Session("gUser") = "true" Then
		oRecordset.Close
		oConnection.Close
		Set oRecordset = Nothing
		Set oConnection = Nothing
		Session("loggedin") = true
		Response.Redirect Request.Form("page")
	End If
%>