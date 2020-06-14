$(function() {
    $("#sameadr").click(function () {
        var checkBox = document.getElementById("sameadr");
        var ship_fname = document.getElementById("ship_fname");
        var ship_email = document.getElementById("ship_email");
        var ship_address = document.getElementById("ship_adr");
        var ship_city = document.getElementById("ship_city");
        var ship_state = document.getElementById("ship_state");
        var ship_zip = document.getElementById("ship_zip");
        if (checkBox.checked == true) {
        ship_fname.value = document.getElementById("bill_fname").value;
        ship_email.value = document.getElementById("bill_email").value;
        ship_address.value = document.getElementById("bill_adr").value;
        ship_city.value = document.getElementById("bill_city").value;
        ship_state.value = document.getElementById("bill_state").value;
        ship_zip.value = document.getElementById("bill_zip").value;
        } else {
        ship_fname.value = "";
        ship_email.value = "";
        ship_address.value = "";
        ship_city.value = "";
        ship_state.value = "";
        ship_zip.value = "";
        }
    });
});