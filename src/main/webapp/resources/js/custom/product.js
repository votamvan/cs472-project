(function ($){
    "use strict";

    $(document).ready(function(){

        /*-------------------
		Poster Click
        --------------------- */
        $('div.product__item__pic').on('click',function(event){  
            var next = $(this).next();
            var a = $($(next).children()[0]).children()[0];
            document.location=a.href;
        });

        /*-------------------
		Cart Item - Add
        --------------------- */
        $('a.primary-btn').on('click',function(event){          

            event.preventDefault(); 
            var div = this.closest('div');    
            var quantity = parseInt($($(div).children('div')).children().find('input').val());           
            var url = this.href + "&quantity="+quantity;  
            
            //add to cart
            $.ajax({
                'url': url,
                'type': 'POST',
                'success': function(obj){  
                    if(obj.result == 1){
                        document.location="cart";  
                    }else{
                        alert("Error: Couldn't add item");
                    }
                },
                'error': function(xhr, status, exception) {
                    console.log("Error: " + status.statusText);
                }
            });
                 
        });
        
    });
})(jQuery);