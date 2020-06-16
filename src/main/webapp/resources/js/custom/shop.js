(function ($){
    "use strict";

    $(document).ready(function(){

        /*-------------------
		Poster Click
        --------------------- */
        $('div.product__discount__item__pic').on('click',function(event){   
            var next = $(this).next();
            var a = $($(next).children()[1]).children()[0];
            document.location=a.href;
        });

        $('div.product__item__pic').on('click',function(event){  
            var next = $(this).next();
            var a = $($(next).children()[0]).children()[0];
            document.location=a.href;
        });
        
    });
})(jQuery);