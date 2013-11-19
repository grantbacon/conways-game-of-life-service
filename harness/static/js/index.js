$(document).ready(function() {
    (function ($){
        $.fn.serializeJSON=function(){
            var json = {};
            jQuery.map($(this).serializeArray(), function(n, i) {
                if (n['value'] !== '') {
                    json[n['name']] = n['value']
                }
            });
            return JSON.stringify(json);
        };
    })(jQuery);


    $('#form').submit(function(){
        $.ajax({
            url: '/nextgen',
            type: 'POST',
            data: $('#form').serializeJSON(),
            dataType: 'text'
        });
        return false;
    });
});
