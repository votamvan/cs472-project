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
                if(obj.result == 1){
                    $(auth).html('<a href="logout"><i class="fa"></i> Log Out</a>');   
                    $(auth).next().remove();       
                }else{
                    $(auth).html('<a href="login"><i class="fa"></i> Login</a>');  
                }                     
            },
            'error': function(xhr, status, exception) {
                console.log("Error: " + status.statusText);
            }
        }); 
        
    });
})(jQuery);