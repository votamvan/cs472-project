<%@page isErrorPage="true" import="java.io.*" %>

<h3>There was an error happenned!!!</h3>
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