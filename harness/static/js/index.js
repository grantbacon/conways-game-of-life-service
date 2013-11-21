$(document).ready(function() {
/*
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
*/
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

    $('.height-box').change(updateGrid);
    $('.width-box').change(updateGrid);


    $('.play').click(function(){
        $.ajax({
            url: '/nextgen',
            type: 'GET'
//            data: null,
//            dataType: 'text'
        }).done(function(data) {
            $('.life-table').empty().append('<p>'+data+'</p>');
        });
    });

});
