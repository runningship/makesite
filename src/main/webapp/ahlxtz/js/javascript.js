/**
 * js all
 */

$(document).on({
      mouseenter: function(){
        $(this).siblings().find('.hvB').hide();
        $(this).find('.hvB').show();
      },
      mouseleave: function(){
        var Thi=$(this),
        st=setTimeout(function(){
            Thi.find('.hvB').hide();
            clearTimeout(st);
        },300);
      }
},'.hv');