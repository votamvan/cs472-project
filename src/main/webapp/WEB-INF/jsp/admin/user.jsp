<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.*" %>
<fmt:setLocale value="en_US"/>
<t:adminPage>
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
                        <input type="text" id="password" placeholder="Password" />
                    </div>
                    <div>
                        <input id="btn_add" type="submit" value="Add user" />
                        <input id="btn_edit" type="submit" value="Edit user" />
                    </div>
                    <span id="errmsg"></span>
                </fieldset>
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
            </div>
        </div>
    </div>
</section>
<script>
$(function(){
    function toggleBtnAddEdit(condition){
        if (condition == "ON" || condition == "on") {
            $('#btn_add').attr('disabled', false);
            $('#btn_edit').attr('disabled', true);
        }else {
            $('#btn_add').attr('disabled', true);
            $('#btn_edit').attr('disabled', false);
        }
    }
    $('table#tbl button').each(function(index, btn) {
        var id = btn.id;
        if (id.substring(0,3) == "del"){
            $("button#" + id).click(del);
        }else if (id.substring(0,4) == "edit"){
            $("button#" + id).click(edit);
        }
    });
    $('#btn_add').click(add);
    $('#btn_edit').click(commit_edit);
    toggleBtnAddEdit("on");

    function add(evt) {
        ajax_submit("add", processData);
    }
    function commit_edit(evt){
        ajax_submit("edit", processEdit);
        function processEdit(data){
            console.log(data);
            if (data.id <= 0){
                var message = data.message;
                if (message == null) message = "username exist !!! Choose another username";
                $("#errmsg").text(message);
                return;
            }
            $('#row' + data.id).find('td').each(function(index, cell){
                if (index == 1) cell.innerHTML = data.fullname;
                if (index == 2) cell.innerHTML = data.username;
                if (index == 3) cell.innerHTML = data.password;
            });
            $("input#id").val("");
            $("input#fullname").val("");
            $("input#username").val("");
            $("input#password").val("");
            toggleBtnAddEdit("on");
        }
    }
    function ajax_submit(type, processFunc) {
        var id = $('input#id').val();
        if (id == null || id == "") id = "0";
        var fullname = $('input#fullname').val();
		var username = $('input#username').val();
		var password = $('input#password').val();
        var item = {id:id, fullname:fullname, username:username, password:password};
        console.log(item);
        if (type == "add")
            $.post('/admin/user?action=add',{user: JSON.stringify(item)}, processFunc, "json");
        else
            $.post('/admin/user?action=edit',{user: JSON.stringify(item)}, processFunc, "json");
    }
	function processData(data){
        console.log(data);
        if (data.id <= 0){
            var message = data.message;
            if (message == null) message = "User exist or insert error !!!";
            $("#errmsg").text(message);
            return;
        }
        $("#errmsg").text("");
        var row_data = "<tr id=row" + data.id + ">"
                       + "<td>" + data.id + "</td>"
                       + "<td>" + data.fullname + "</td>"
                       + "<td>" + data.username + "</td>"
                       + "<td>" + data.password + "</td>"
                       + "<td><button id=edit" + data.id + " value=" + data.id + ">Edit</button></td>"
                       + "<td><button id=del" + data.id + " value=" + data.id + ">Delete</button></td>"
                       + "</tr>";
		$('#tbl tr:last').after(row_data);
        $("button#del" + data.id).click(del);
        $("button#edit" + data.id).click(edit);
	}
    function del(){
        var id = this.value;
        console.log("DELETE", id);

        $('#row' + id).remove();
		$.ajax({type:'DELETE', url:'/admin/user?id=' + id, success:processDel});
        function processDel(data){
            console.log(data);
        }
    }
    function edit(){
        var id = this.value;
        console.log("EDIT", id);
        var data = [];
        $('#row' + id).find('td').each(function(index, cell){
            data[index] = cell.innerHTML;
        });
        console.log(data);
        $("input#id").val(data[0]);
        $("input#fullname").val(data[1]);
        $("input#username").val(data[2]);
        $("input#password").val(data[3]);
        toggleBtnAddEdit("off");
    }
});
</script>
<!-- Hero Section End -->
    </jsp:body>
</t:adminPage>