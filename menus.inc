<div id="mcon">
  <div class="menu rc">
    <a href="default.asp" class="menut">Home</a>
    <br/>
    <a href="posts.asp" class="menut">Posts</a>
    <br/>
    <a href="calendar.asp" class="menut">Calendar</a>
    <br/>
    <%If loggedin Then%>
      <a href="members.asp" class="menut">Members Page</a>
      <br/>
      <a href="logout.asp" class="menut">Logout</a>
    <%Else%>
      <a onclick="showlogin()" class="menut">Login</a>
    <%End If%>
    <br/>
    <a href="contact.asp" class="menut">Contact</a>
  </div>
  <div class="suggestbox rc" id="suggestbox">
    <h1>Suggestion Box</h1>
    Write your suggestion here:<br/>
    <textarea id="suggest" name="suggest" rows="5" cols="15" wrap="soft"></textarea>
    <input type="submit" class="btn" id="sbtn" value="Suggest" onclick="suggest()" />
  </div>
</div>