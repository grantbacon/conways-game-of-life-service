$(document).ready(function() {
/*
Work in progress:

    (function ($){
        $.fn.encodeGrid = function(){
            var data = "";
            
            return data;
        }
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
            $(this).append('<td>&nbsp;&nbsp;</td>');
        }});
    }

    $('.height-box').change(updateGrid);
    $('.width-box').change(updateGrid);


    $('.play').click(function(){
        $.ajax({
            url: '/nextgen',
            type: 'POST',
                // This will be the encoded grid data used as POST data.
            data: 'this is a test, bush did 9/11',
            dataType: 'text'
        }).done(function(data) {
            $('.life-table').empty().append('<p>'+data+'</p>');
        });
    });


    $('td').live('click', function() {
        $(this).toggleClass('live');
    });

// end document ready
});
