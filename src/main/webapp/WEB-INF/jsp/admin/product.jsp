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
                        <label for="title">Title</label>
                        <input type="text" id="title" placeholder="Title" />
                    </div>
                    <div>
                        <label for="overview">Overview</label><br>
                        <textarea id="overview" rows="5" cols="80"></textarea>
                    </div>
                    <div>
                        <label for="genres">Genres</label>
                        <input type="text" id="genres" placeholder="Genres" />
                    </div>
                    <div>
                        <label for="release_date">Release Date</label>
                        <input type="text" id="release_date" placeholder="Release Date" />
                    </div>
                    <div>
                        <label for="poster_path">Poster</label>
                        <input type="text" id="poster_path" placeholder="Poster" />
                    </div>
                    <div>
                        <label for="price">Price</label>
                        <input type="text" id="price" placeholder="Price" />
                    </div>
                    <div>
                        <input id="btn_add" type="submit" value="Add Product"/>
                        <input id="btn_edit" type="submit" value="Edit Product"/>
                    </div>
                    <span id="errmsg"></span>
                </fieldset>
                <br>
                <table id="tbl">
                    <thead>
                        <tr>
                            <th>Poster</th>
                            <th>Id</th>
                            <th>Title</th>
                            <th>Overview</th>
                            <th>Genres</th>
                            <th>Release Date</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${products}" var="item">
                            <tr id="row${item.id}">
                                <td><img src="${item.poster_path}" width="100px" height="100px"></td>
                                <td><c:out value="${item.id}" /></td>
                                <td><c:out value="${item.title}" /></td>
                                <td><c:out value="${item.overview}" /></td>
                                <td><c:out value="${item.genres}" /></td>
                                <td><c:out value="${item.release_date}" /></td>
                                <td><c:out value="${item.price}" /></td>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
    "use strict";
    function toggleBtnAddEdit(condition){
        if (condition == "ON" || condition == "on") {
            $('#btn_add').attr('disabled', false);
            $('#btn_edit').attr('disabled', true);
        }else {
            $('#btn_add').attr('disabled', true);
            $('#btn_edit').attr('disabled', false);
        }
    }
    function ajax_submit(type, processFunc) {
        var id = $('input#id').val();
        if (id == null || id == "") id = "0";
        var title = $('#title').val();
        var overview = $('#overview').val();
        var genres = $('#genres').val();
        var release_date = $('#release_date').val();
		var poster_path = $('#poster_path').val();
		var price = $('#price').val();
		var item = {id: id, title:title, overview:overview, genres:genres, 
                    release_date:release_date, poster_path:poster_path, price:price};
        console.log(item);
        if (type == "add")
            $.post('/admin/product?action=add',{product: JSON.stringify(item)}, processFunc, "json");
        else
            $.post('/admin/product?action=edit',{product: JSON.stringify(item)}, processFunc, "json");
    }
    $('table#tbl button').each(function(index, btn) {
        var id = btn.id;
        if (id.substring(0,3) == "del"){
            $("button#" + id).click(del);
        }else if (id.substring(0,4) == "edit"){
            $("button#" + id).click(edit);
        }
    });
	$('#btn_add').click(insert);
    $('#btn_edit').click(update);
    toggleBtnAddEdit("on");
	function insert(){
        console.log("commit insert");
        ajax_submit("add", processData);
	}
    function update(evt){
        console.log("commit update");
        ajax_submit("edit", processEdit);
        function processEdit(data){
            console.log(data);
            if (data == null || data.id <= 0){
                alert("update error, try again!!!");
                return;
            }
            $('#row' + data.id + ">td>img").attr('src', data.poster_path);
            $('#row' + data.id).find('td').each(function(index, cell){
                if (index == 2) cell.innerHTML = data.title;
                if (index == 3) cell.innerHTML = data.overview;
                if (index == 4) cell.innerHTML = data.genres;
                if (index == 5) cell.innerHTML = data.release_date;
                if (index == 6) cell.innerHTML = data.price;
            });
            $("input#id").val("");
            $("input#title").val("");
            $("textarea#overview").val("");
            $("input#genres").val("");
            $("input#release_date").val("");
            $("input#poster_path").val("");
            $("input#price").val("");
            toggleBtnAddEdit("on");
        }
    }
	function processData(data){
        console.log(data);
        if (data == null || data.id <= 0){
            $("#errmsg").text("insert error, try again !!!");
            return;
        }
        $("#errmsg").text("");
        var id = data.id;
        var row_data = "<tr id=row" + id + ">"
                        + "<td><img src='" + data.poster_path + "' width='100px' height='100px'></td>"
                        + "<td>" + id + "</td>"
                        + "<td>" + data.title + "</td>"
                        + "<td>" + data.overview + "</td>"
                        + "<td>" + data.genres + "</td>"
                        + "<td>" + data.release_date + "</td>"
                        + "<td>" + data.price + "</td>"
                        + "<td><button id=edit" + data.id + " value=" + data.id + ">Edit</button></td>"
                        + "<td><button id=del" + data.id + " value=" + data.id + ">Delete</button></td>"
                        + "</tr>";
		$('#tbl>tbody').append(row_data);
        $("button#del" + id).click(del);
        $("button#edit" + data.id).click(edit);
	}
    function del(){
        var id = this.value;
        console.log(id);
        $('#row' + id).remove();
		$.ajax({type:'DELETE', url:'/admin/product?id=' + id, success:processDel});
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
        data[0] = $('#row' + id + ">td>img").attr("src");
        console.log(data);
        var start_index = 0;
        $("input#poster_path").val(data[start_index++]);
        $("input#id").val(data[start_index++]);
        $("input#title").val(data[start_index++]);
        $("textarea#overview").val(data[start_index++]);
        $("input#genres").val(data[start_index++]);
        $("input#release_date").val(data[start_index++]);
        $("input#price").val(data[start_index++]);
        toggleBtnAddEdit("off");
    }
});
</script>
<!-- Hero Section End -->
    </jsp:body>
</t:adminPage>