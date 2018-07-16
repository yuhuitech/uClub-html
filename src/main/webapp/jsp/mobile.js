var opened = false; //在手机模式中，默认菜单栏是关闭的，这是一个需要记住的全局状态
    $('#menu_toggle').mousedown(function() {
        var temp = $('#pageSize').width();
        if (opened === false) {
            if (temp - 70 <= 266) {
                $('#messageDropDown').css('display', 'none');
            } else {
                $('#messageDropDown').css('display', 'inline');
            }
            if (temp - 70 <= 234) {
                $('#miniMenu').css('display', 'none');
            } else {
                $('#miniMenu').css('display', 'inline');
            }
            opened = true;
        } else {
            if (temp + 70 <= 266) {
                $('#messageDropDown').css('display', 'none');
            } else {
                $('#messageDropDown').css('display', 'inline');
            }
            if (temp + 70 <= 234) {
                $('#miniMenu').css('display', 'none');
            } else {
                $('#miniMenu').css('display', 'inline');
            }
            opened = false;
        }
    });

$(window).ready(function() {
	var temp = $('#pageSize').width();

        if (temp <= 266) {
            $('#messageDropDown').css('display', 'none');
        } else {
            $('#messageDropDown').css('display', 'inline');
        }
        if (temp <= 234) {
            $('#miniMenu').css('display', 'none');
        } else {
            $('#miniMenu').css('display', 'inline');
        }
           temp = $('#pageSize').width();
          if (temp <= 342) {
              $('.fc-listMonth-button').click();
              $('.fc-agendaDay-button').css('display', 'none');
              $('.fc-agendaWeek-button').css('display', 'none');
              $('.fc-month-button').css('display', 'none');
              $('.fc-today-button').css('display', 'none');
              $('h2').css('font-size', '15px');
              $('h3').css('font-size', '20px');
              $('h1').css('font-size', '25px');
          } else {
              $('.fc-agendaDay-button').css('display', 'inline');
              $('.fc-agendaWeek-button').css('display', 'inline');
              $('.fc-month-button').css('display', 'inline');
              $('.fc-today-button').css('display', 'inline');
              $('#calendar').css('font-size', '1em');
              $('h2').css('font-size', '');
              $('h3').css('font-size', '');
              $('h1').css('font-size', '');
          }

      });

      $(window).resize(function() {
      	var temp = $('#pageSize').width();
        if (temp <= 266) {
            $('#messageDropDown').css('display', 'none');
        } else {
            $('#messageDropDown').css('display', 'inline');
        }
        if (temp <= 234) {
            $('#miniMenu').css('display', 'none');
        } else {
            $('#miniMenu').css('display', 'inline');
        }
           temp = $('#pageSize').width();
          if (temp <= 342) {
              $('.fc-listMonth-button').click();
              $('.fc-agendaDay-button').css('display', 'none');
              $('.fc-agendaWeek-button').css('display', 'none');
              $('.fc-month-button').css('display', 'none');
              $('.fc-today-button').css('display', 'none');
              $('#calendar').css('font-size', '9px');

              $('h5').css('font-size', '5px');
              $('h4').css('font-size', '15px');
              $('h2').css('font-size', '15px');
              $('h3').css('font-size', '20px');
              $('h1').css('font-size', '25px');

          } else {
              $('.fc-agendaDay-button').css('display', 'inline');
              $('.fc-agendaWeek-button').css('display', 'inline');
              $('.fc-month-button').css('display', 'inline');
              $('.fc-today-button').css('display', 'inline');
              $('#calendar').css('font-size', '1em');


              $('h5').css('font-size', '');
              $('h4').css('font-size', '');
              $('h2').css('font-size', '');
              $('h3').css('font-size', '');
              $('h1').css('font-size', '');
          }
      });