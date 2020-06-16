<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.*" %>
<fmt:setLocale value="en_US"/>
<t:masterPage>
    <jsp:attribute name="title">
        MIU-DVD SHOP - Admin Home Page
    </jsp:attribute>
    <jsp:body>
<!-- Hero Section Begin -->
<section class="hero">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="hero__categories">
                    <div class="hero__categories__all">
                        <i class="fa fa-bars"></i>
                        <span>Admin Menu</span>
                    </div>
                    <ul>
                        <li><a href="/admin/user">Users</a></li>
                        <li><a href="/admin/product">Products</a></li>
                        <li><a href="/admin/logout">Logout</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-9">
                <table id="tbl">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Fullname</th>
                            <th>Username</th>
                            <th>Password</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="item">
                            <tr id="row${item.id}">
                                <td><c:out value="${item.id}" /></td>
                                <td><c:out value="${item.fullname}" /></td>
                                <td><c:out value="${item.username}" /></td>
                                <td><c:out value="${item.password}" /></td>
                                <td><button id="edit${item.id}" value="${item.id}">Edit</button></td>
                                <td><button id="del${item.id}" value="${item.id}">Delete</button></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <fieldset>
                    <div>
                        <label for="id">Id</label>
                        <input type="text" id="id" readonly="readonly" placeholder="Id auto-generated"/>
                    </div>
                    <div>
                        <label for="fullname">Fullname</label>
                        <input type="text" id="fullname" placeholder="Fullname"/></div>
                    <div>
                        <label for="username">Username</label> 
                        <input type="text" id="username" placeholder="Username" />
                    </div>
                    <div>
                        <label for="password">Password</label> 
                        <input type="password" id="password" placeholder="Password" />
                    </div>
                    <div>
                        <input id="btn_add" type="submit" value="Add user" />
                    </div>
                    <span id="errmsg"></span>
                </fieldset>
            </div>
        </div>
    </div>
</section>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
    $('table#tbl button').each(function(index, btn) {
        var id = btn.id;
        if (id.substring(0,3) == "del"){
            $("#" + id).click(del);
        }else {
            console.log(id);
        }
    });
	$('#btn_add').click(add);
	function add(){
        var fullname = $('#fullname').val();
		var username = $('#username').val();
		var password = $('#password').val();
		var item = {fullname:fullname, username:username, password:password};
		$.post('/admin/user',{user: JSON.stringify(item)}, processData, "json")
	}
	function processData(data){
        console.log(data);
        if (data.id <= 0){
            $("#errmsg").text("User exist or insert error !!!");
            return;
        }
        $("#errmsg").text("");
        var id = data.id;
        var row_data = `<tr id=row"${id}"><td>${data.fullname}</td><td>${data.username}</td><td>${data.username}</td>`;
        row_data += `<button id="edit${id} rec_id="${id}">Edit</button></td>`;
        row_data += `<button id="del${id} rec_id="${id}">Delete</button></td></tr>`;
		$('#tbl>tbody').append(row_data);
        $("button#del" + id).click(del);
	}
    function del(){
        var id = this.value;
        console.log(id);
        $('#row' + id).remove();
		$.ajax({type:'DELETE', url:'/admin/user?id=' + id, success:processDel});
        function processDel(data){
            console.log(data);
        }
	}
});
</script>
<!-- Hero Section End -->
    </jsp:body>
</t:masterPage>