(function ($){
    "use strict";

    $(document).ready(function(){

        /*-------------------
		Poster Click
        --------------------- */
        $('div.featured__item__pic').on('click',function(event){   
            var next = $(this).next();
            var a = $($(next).children()[0]).children()[0];
            document.location=a.href;
        });
        
    });
})(jQuery);