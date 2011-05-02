$(function() {
    font_size = 16;
    $('#bigger').click(function (){
        font_size += 4;
        $('p').css('font-size', font_size + "px");
    });
})