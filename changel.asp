<!-- #include file="top.inc"-->
<%If Session("loggedin") Then%>
<script type="text/javascript" language="javascript">
    function validate(){
        if ($('pass').value == $('cpass').value){
            if ($('pass').value != ""){
                return true;
            }
            else{
                alert("The password can't be blank!");
                return false;
            }
        }
        else{
            alert("The passwords you typed don't match!");
            return false;
        }
    }
</script>
<!-- #include file="data.inc"-->
<%
	Dim user
	user = Session("username")
	Dim pass
	
	Dim oConnection
	Dim oRecordset
	
	Set oConnection = Server.CreateObject ("ADODB.Connection")
	Set oRecordset = Server.CreateObject ("ADODB.Recordset")
	oConnection.mode = adModeReadWrite
	oConnection.Open strConnect
	
	oRecordset.Open "SELECT * FROM [People] WHERE ID = " & Session("ID"),oConnection,0,3
%>
<h1>Change Login</h1>
<br />
<form action="editl.asp" method="post" onsubmit="return validate()">
Username:&nbsp;<%=user%><br/>
New Username:&nbsp;<input type="text" name="user" size="30" class="makepost"/>
<br/>
New Password:&nbsp;<input type="password" id="pass" name="pass" size="30" class="makepost"/><br/>
Confirm Password:&nbsp;<input type="password" id="cpass" name="cpass" size="30" class="makepost"/>
<br/>
<input type="submit" value="Change" class="btn"/><input type="button" value="Cancel" onclick="window.location = 'members.asp'" class="btn"/>
</form>
<%Else%>
This page is for members only. You can sign in <a href="#" onclick="showlogin()">here</a>.
<%End If%>
<!-- #include file="bottom.inc"-->