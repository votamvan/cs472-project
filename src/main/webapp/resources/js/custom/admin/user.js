$(function(){
    "use strict";
    
    function isValid(){
        var fullname = $('input#fullname').val();
        var username = $('input#username').val();
        var password = $('input#password').val();

        var regex_fullname =/^[a-zA-Z0-9]{3,100}/;
        //var regex_password = /^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{6,}$/; <-- complex password

        if(fullname == null || fullname == ""){
            $('#errmsg').text("Fullname is required");
            return false;
        }
        if(!regex_fullname.test(fullname)){
            $('#errmsg').text("Fullname is invalid");
            return false;
        }
        if(username == null || username == ""){
            $('#errmsg').text("Username is required");
            return false;
        }
        if(username.length < 5 || username.length > 32){
            $('#errmsg').text("Username length is invalid");
            return false;
        }
        if(password.length < 6){
            $('#errmsg').text("Password is too short");
            return false;
        }
        // if(!regex_password.test(password)){
        //     $('#errmsg').text("Password is invalid");
        //     return false;
        // }
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
        if(isValid()){     
            ajax_submit("add", processData);
        }
    }
    function commit_edit(evt){
        if(isValid()){
            ajax_submit("edit", processEdit);
        }
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
        $("input#id").val("");
        $("input#fullname").val("");
        $("input#username").val("");
        $("input#password").val("");
        $('#errmsg').text("");
        toggleBtnAddEdit("on");
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
                    + "<td><button class=\"btn-info\" id=edit" + data.id + " value=" + data.id + ">Update</button></td>"
                    + "<td><button class=\"btn-warning\" id=del" + data.id + " value=" + data.id + ">Delete</button></td>"
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