(function ($){
    "use strict";

    $(document).ready(function(){

        /*-------------------
		Check User Login
        --------------------- */
        $.ajax({
            'url': 'user',
            'type': 'POST',
            'success': function(obj){  
                var auth = $('.header__top__right__auth ');
                var welcome = $('.header__top__left > ul > li:nth-child(1)');
                if(obj.result == 1){
                    $(auth).html('<a href="logout"><i class="fa"></i> Log Out</a>');   
                    $(auth).next().remove();       
                    $(welcome).html('Welcome <strong>user</strong>!');
                }else{
                    $(auth).html('<a href="login"><i class="fa"></i> Login</a>');  
                    $(welcome).html('Welcome <strong>guest</strong>!');
                }                     
            },
            'error': function(xhr, status, exception) {
                console.log("Error: " + status.statusText);
            }
        }); 
        
    });
})(jQuery);