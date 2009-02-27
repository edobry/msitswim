function showlogin(){
	if ($('loginbox') == null | $('login'))
	{
	    page = document.location;
		$('login').style.display = 'block';
		var loginbox = '<div id="loginbox">';
        loginbox += '<form action="validate.asp" method="post">';
		loginbox += '<input type="hidden" name="page" value="' + page + '" />'
		loginbox += 'Username:&nbsp; <input type="text" name="username" class="login" value="<%=Session("Username")%>" /><%If Session("gUser") = "false" Then%><img src="images/error.png" class="error"/><%End If%>';
		loginbox += '<br/>';
		loginbox += 'Password:&nbsp; <input type="password" name="password" class="login" style="margin-left:1px;" /><%If Session("gPass") = "false" Then%><img src="images/error.png" class="error"/><%End If%>';
		loginbox += '<br/>';
		loginbox += '<input type="submit" value="Login" <%If loggedin Then%>disabled<%End If%> style="margin-left:103px;" class="btn" />';
		loginbox += '<input type="button" value="Cancel" onclick="hidelogin()" style="margin-left:4px;" class="btn" />';
		loginbox += '</form>';
		loginbox += '</div>';
		$('login').innerHTML = loginbox;
	}
}