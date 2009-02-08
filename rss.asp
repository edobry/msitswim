<?xml version="1.0" encoding="ISO-8859-1"?>
<%
Response.Buffer = true
Response.ContentType = "text/xml"
   
Function ApplyXMLFormatting(strInput)
  strInput = Replace(strInput,"&", "&amp;")
  strInput = Replace(strInput,"'", "'")
  strInput = Replace(strInput,"""", "&quot;")
  strInput = Replace(strInput, ">", "&gt;")
  strInput = Replace(strInput,"<","&lt;")
  
  ApplyXMLFormatting = strInput
End Function   
%>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
     <channel>
    	<atom:link href="http://localhost/eugenesite/rss.asp" rel="self" type="application/rss+xml" />
	<title>MSIT Swim Team</title>
	<link>http://localhost/eugenesite</link>
	<description>News about the MSIT Swim Team.</description>
	<language>en-us</language>
	<lastBuildDate><%=WeekDayName(Weekday(Now()),True) & ", " & DatePart("D",Now()) & " " & MonthName (DatePart("M",Now()),True) & " " & DatePart("YYYY",Now()) & " " & FormatDateTime(todaysDate,4) & ":00 EST"%></lastBuildDate>  
	<category>Sports</category>
	<generator>RSS 2.0 generation class</generator>  
	<docs>http://blogs.law.harvard.edu/tech/rss</docs>
	<copyright>Copyright 2008 Eugene Dobry All Rights Reserved.</copyright>
	<!-- #include file="data.inc"-->
	<%
	  Dim oConnection
	  Dim oRecordset
	  Dim counter
	  
	  counter = 0

 	  Set oConnection = Server.CreateObject ("ADODB.Connection")
 	  Set oRecordset = Server.CreateObject ("ADODB.Recordset")
 	  oConnection.mode = 3 ' adModeReadWrite
 	  oConnection.Open strConnect
 	  
 	  oRecordset.Open "SELECT * FROM [Posts] ORDER BY PostID DESC",oConnection,0,3
 	  
 	  While Not oRecordset.EOF AND counter < 11
 	  %>
 	  	<item>
 	  		<title><%=ApplyXMLFormatting(oRecordset("Title").Value)%></title>
 	  		<link>http://localhost/eugenesite/posts.asp#<%=ApplyXMLFormatting(oRecordset("PostID").Value)%></link>
 	  		<guid>http://localhost/eugenesite/posts.asp#<%=ApplyXMLFormatting(oRecordset("PostID").Value)%></guid>
 	  		<description><%=ApplyXMLFormatting(oRecordset("Content").Value)%></description>
 	  	</item>
 	  <%
 	  	oRecordset.MoveNext
 	  	counter = counter + 1
 	  Wend
 	  
 	  oRecordset.Close
	  oConnection.Close
	  Set oRecordset = Nothing
	  Set oConnection = Nothing
	%>
     </channel>
</rss>