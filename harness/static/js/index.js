$(document).ready(function() {


    // Add an encodeGrid function to jQuery so it can be used
    // with the table element
    (function ($){
        $.fn.encodeGrid = function(){
            var data = "";
            var isLiving = function(element) {           
                if ($(element).hasClass('live')) {
                    return "x";
                } else {
                    return " ";
                }
            }
            
            // Cycle through each row in the table
            $(this).find('tr').each(function() {
                // Map isLiving to the set of TD elements
                data += $.map($(this).find('td'), isLiving).join('') + '\n';
            });

            return data;
        }
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
            data: $('.life-table').encodeGrid(),
            dataType: 'text'
        }).done(function(data) {
            $('.life-table').empty().append(data);
        });
    });

    $('td').live('click', function() {
        $(this).toggleClass('live');
    });

// end document ready
});
