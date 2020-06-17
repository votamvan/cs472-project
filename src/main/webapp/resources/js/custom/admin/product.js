$(function(){
    "use strict";
    function isValid(){
        var title = $('#title').val();
        var overview = $('#overview').val();
        var genres = $('#genres').val();
        var release_date = $('#release_date').val();
		var poster_path = $('#poster_path').val();
        var price = $('#price').val();

        var regex_date = /^[0-9]{1,2}[\/][0-9]{1,2}[\/][0-9]{2}$/;

        if(title == null || title == ""){
            $('#errmsg').text("Title is required");
            return false;
        }
        if(!regex_date.test(release_date)){
            $('#errmsg').text("Release date is invalid");
            return false;
        }
        if(price == null || price == "" || isNaN(price)){
            $('#errmsg').text("Price is invalid");
            return false;
        }
        if(title.length>255 || overview.length>4000 || genres.length>50 || poster_path.length >255){
            $('#errmsg').text("Input data is exceed");
            return false;
        }
        return true;
    }
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
        $("input#id").val("");
        $("input#title").val("");
        $("textarea#overview").val("");
        $("input#genres").val("");
        $("input#release_date").val("");
        $("input#poster_path").val("");
        $("input#price").val("");
        $('#errmsg').text("");
        toggleBtnAddEdit("on");
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
        if(isValid()){
            ajax_submit("add", processData);
        }
	}
    function update(evt){
        console.log("commit update");
        if(isValid()){
            ajax_submit("edit", processEdit);
        }
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
                        + "<td><button class=\"btn-info\" id=edit" + data.id + " value=" + data.id + ">Update</button></td>"
                        + "<td><button class=\"btn-warning\" id=del" + data.id + " value=" + data.id + ">Delete</button></td>"
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