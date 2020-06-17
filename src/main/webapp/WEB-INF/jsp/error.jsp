<%@page isErrorPage="true" import="java.io.*" %>

<h1>OOP!!!!</h1>
<h3>There was an error happenned</h3>
<hr/>
<p>Please contact to our web master to get more information. Thank you!</p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<p></p>
<hr/>
Message: 
<%=exception.getMessage()%>
<br/><br/>
StackTrace:
<br/>
<%
	StringWriter stringWriter = new StringWriter();
	PrintWriter printWriter = new PrintWriter(stringWriter);
	exception.printStackTrace(printWriter);
	out.println(stringWriter);
	printWriter.close();
	stringWriter.close();
%>