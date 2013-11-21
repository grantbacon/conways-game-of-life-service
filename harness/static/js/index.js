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

    function updateGrid() {

        var height = $('.height-box').val();
        var width = $('.width-box').val();
        var table = $('.life-table');

        table.empty();

        for (var i=0; i < height; i++)
        {
            table.append('<tr></tr>');
        }
        $('.life-table tr').each(function(rowNum) {
            for (var j=0; j < width; j++)
             {
            $(this).append('<td>x</td>');
             }});
        
    }

    $('.play').submit(function(){
        $.ajax({
            url: '/nextgen',
            type: 'POST',
            data: $('#form').serializeJSON(),
            dataType: 'text'
        });
        return false;
    });


    $('.height-box').change(updateGrid);
    $('.width-box').change(updateGrid);


});
