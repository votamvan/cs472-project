(function ($){
    "use strict";

    $(document).ready(function(){

        var formatter = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD',
            minimumFractionDigits: 2
        });

        /*-------------------
		Cart Info
        --------------------- */
        
        $.ajax({
            'url': 'cart?action=view',
            'type': 'POST',
            'success': function(obj){  
                $('.fa-shopping-bag + span').html(obj.total);          
                $('.header__cart__price > span').html(formatter.format(obj.cost));      
            },
            'error': function(xhr, status, exception) {
                console.log("Error: " + status.statusText);
            }
        });       
        
        /*-------------------
		Cart Item - Remove
        --------------------- */

        $('.shoping__cart__item__close .icon_close').on('click', function () {
            if(confirm('Are you sure?')){
                //remove item
                var tr = this.closest('tr');
                var td = $(tr).children('td')[0];
                console.log(td);
                var url = $(td).children('a')[0].href.replace("product?","cart?action=delete&");
                $.ajax({
                    'url': url,
                    'type': 'POST',
                    'success': function(obj){  
                        if(obj.result == 1){
                            $(tr).remove();
                            $('.header__cart__price > span').html(formatter.format(obj.cost));     
                            $($('.shoping__checkout li span')[0]).html(formatter.format(obj.cost));  
                            $($('.shoping__checkout li span')[1]).html(formatter.format(obj.cost));  
                        }else{
                            alert("Error: Couldn't remove item");
                        }
                    },
                    'error': function(xhr, status, exception) {
                        console.log("Error: " + status.statusText);
                    }
                });
            }else{
                //do nothing
            }            
        });

        /*-------------------
		Cart Item - Update
        --------------------- */

        $('.shoping__cart__item__update .fa-refresh').on('click', function () {
            //update item
            var tr = this.closest('tr');
            var td = $(tr).children('td')[0];
            var price = parseFloat($($(tr).children('td')[2]).html().replace("$",""));
            var quantity = parseInt($($(tr).children('td')[3]).children().find('input').val());
            
            $($(tr).children('td')[4]).html(formatter.format(price*quantity));            

            //remove row if quantity is zero
            if(quantity == 0){
                $(tr).remove();
            }
            //update cost total
            var url = $(td).children('a')[0].href.replace("product?","cart?action=update&");
            url = url + "&quantity="+quantity;            
            $.ajax({
                'url': url,
                'type': 'POST',
                'success': function(obj){  
                    if(obj.result == 1){
                        $('.header__cart__price > span').html(formatter.format(obj.cost));     
                        $($('.shoping__checkout li span')[0]).html(formatter.format(obj.cost));  
                        $($('.shoping__checkout li span')[1]).html(formatter.format(obj.cost));   
                    }else{
                        alert("Error: Couldn't update item");
                    }
                },
                'error': function(xhr, status, exception) {
                    console.log("Error: " + status.statusText);
                }
            });                       
        });
        
    });
})(jQuery);