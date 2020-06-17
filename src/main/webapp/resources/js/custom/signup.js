(function ($){
    "use strict";

    $(document).ready(function(){

        /*-------------------
		Error Message
        --------------------- */
        var button = $('button.site-btn');       
        var message = $(button).next(); 
        $(message).css('color','red').css('display','block').css('margin','20px');

        $('#password').keyup(function() {
            $('#pwd_info').css('display','block');
            $('#pwd_info').css('background-color','block');
            $('#pwd_info').html(checkStrength($('#password').val()));
        });

        $(button).on('click',function(event){     
            var fullname = $('input#fullname').val();
            var username = $('input#username').val();
            var password = $('input#password').val();
            var password2 = $('input#password2').val();

            var regex_fullname =/^[a-zA-Z0-9]{3,100}/;
            //var regex_password = /^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{6,}$/; <-- complex password

            if(fullname == null || fullname == ""){
                $(message).text("Fullname is required");
                return false;
            }
            if(!regex_fullname.test(fullname)){
                $(message).text("Fullname is invalid");
                return false;
            }
            if(username == null || username == ""){
                $(message).text("Username is required");
                return false;
            }
            if(username.length < 5 || username.length > 32){
                $(message).text("Username length is invalid");
                return false;
            }
            if(password.length < 6){
                $(message).text("Password is too short");
                return false;
            }            
            // if(!regex_password.test(password)){
            //     $(message).text("Password is invalid");
            //     return false;
            // }            
            if(password !== password2){
                $(message).html("Password is not matching");
                return false;
            }
        });

        function checkStrength(password) {
            var strength = 0;
            if (password.length < 6) {
                $('#pwd_info').removeClass();
                $('#pwd_info').addClass('short');
                return 'Too short';
            }
            if (password.length > 7) strength += 1;
            // If password contains both lower and uppercase characters, increase strength value.
            if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1;
            // If it has numbers and characters, increase strength value.
            if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1;
            // If it has one special character, increase strength value.
            if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1;
            // If it has two special characters, increase strength value.
            if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1;
            // Calculated strength value, we can return messages
            // If value is less than 2
            if (strength < 2) {
                $('#pwd_info').removeClass();
                $('#pwd_info').addClass('weak');
                return 'Weak';
            } else if (strength == 2) {
                $('#pwd_info').removeClass();
                $('#pwd_info').addClass('good');
                return 'Good';
            } else {
                $('#pwd_info').removeClass();
                $('#pwd_info').addClass('strong');
                return 'Strong';
            }
        }
        
    });
})(jQuery);