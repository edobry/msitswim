
<!-- #include file="top_conn.inc"-->
<%
If Session("loggedin") Then
 oRecordset.Open "SELECT * FROM Suggestions",oConnection,0,3
%>

<h1>Suggestions</h1>

<br/>
<%
If Not oRecordset.EOF Then
		While Not oRecordset.EOF
%>

<div class="suggestion">
			<%=oRecordset("Suggestion")%>
</div>
<%
 		    oRecordset.MoveNext
	    Wend
    Else
	    Response.Write "There are no suggestions to display.<br/><br/>"
    End If
%>
<!-- #include file="bottom_conn.inc"-->
<%
Else
    Response.Redirect "default.asp"
End If
%>