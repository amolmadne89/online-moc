function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  // var str = '<li class="liThumbnail col-md-6">' + content.replace(regexp, new_id) + '</li>'
  $(link).before(content.replace(regexp, new_id));
}

function remove_must_do_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".hideDiv").hide();
}

$(document).ready(function(){
  $('li.dropdown.mega-dropdown a').on('click', function (event) {
      $(this).parent().toggleClass("open");
  });

  $('body').on('click', function (e) {
      if (!$('li.dropdown.mega-dropdown').is(e.target) && $('li.dropdown.mega-dropdown').has(e.target).length === 0 && $('.open').has(e.target).length === 0) {
          $('li.dropdown.mega-dropdown').removeClass('open');
      }
  });
  $('.rb1').removeAttr('checked');
  //$(".submitquestion").addClass("disableBtn");
  $('.rb1').click(function () {
    if($(this).is(':enabled')) {
      //$(".submitquestion").removeClass("disableBtn")
      $(".submitquestion").css({"pointer-events":"auto","background-color":"#1192ce"});
    }
  });

  var textBox = $('.questionTextBox').value;
  $(".questionTextBox").bind('keyup', function(event) {
    if ($(this).val() == '') {
      //$(".submitquestion").addClass("disableBtn");
      $(".submitquestion").css({"pointer-events":"none","background-color":"#ccc"});
    }else{
      //$(".submitquestion").removeClass("disableBtn")
      $(".submitquestion").css({"pointer-events":"auto","background-color":"#1192ce"});
    }
  })

});

$(document).ready(function(){
  $('.question_status').change(function() {
    update_attribute($(this).attr('url'), $(this).is(":checked"), $(this))
  });
});



$('document').ready(function(){
  $("input.time_txt").timepicki();
  $('.tabclick').click(function(){
  var el = $(this).attr('for');
  var DetailsEvent = $('.'+el).css('display');
    if(DetailsEvent == 'none'){
        $('.tabularlist').slideUp(500);
        $('.'+el).slideDown(500);
      }
      else{
        $('.'+el).slideUp(500);
        }
  });
  /*$('.closeclick').click(function() {
    $('.popup-overlay').hide();
    $('.ClientPopup-info').hide();

  })*/
$('.helpTag').click(function(){

var helpPop = $('.HelpPopup').css('display');
  if(helpPop == 'none'){
    $('.HelpPopup').slideDown(500);
    $('.help-popup-overlay').slideDown(500);

  }
  else{
  $('.HelpPopup').slideUp(500);
    $('.help-popup-overlay').slideUp(500);
  }

})


$('.closeclick').click(function(){
$('.HelpPopup').slideUp();
$('.help-popup-overlay').slideUp();

})


  $('.menuclick').click(function(){
    var menudsp =$('.collapseHide').css('display');
    if(menudsp =='none'){
      $('.collapseHide').slideDown(500);
    }
    else{

      $('.collapseHide').slideUp(500);
    }
  })
  $('.menuSubclick').click(function(){
    var menudsp =$('.SubMenucollapseHide').css('display');
    if(menudsp =='none'){
      $('.SubMenucollapseHide').slideDown(500);
    }
    else{

      $('.SubMenucollapseHide').slideUp(500);
    }
  })


  $('.tabclick').click(function(){
    var el = $(this).attr('for');
    var DetailsEvent = $('.'+el).css('display');
      if(DetailsEvent == 'none'){
          $('.tabularlist').slideUp(500);
          $('.'+el).slideDown(500);
        }
        else{
          $('.'+el).slideUp(500);
          }
  });
  $('.toggleDiv').css("display","none");
    $('.viewMoreLink').click(function(){
      $('.viewMoreLink').html("<span>view less</span>")
      var dsp = $(".toggleDiv").css('display');
      if(dsp == 'flex'){
        $('.toggleDiv').slideUp(500)
        $('.viewMoreLink').html("<span>view more</span>")
      }
      else{
        $('.toggleDiv').slideDown(500)
        $('.viewMoreLink').html("<span>view less</span>")
      }
    })

  /*$('.datePicker').each(function() {
    new Pikaday({
      field: $(this)[0]
    })
  })

  $('.datePicker').trigger('click')*/
  $('.nextcall').datepicker({
    format: 'yyyy-mm-dd',
    clearBtn: true,
    autoclose: true,
    todayBtn: 'linked',
    todayHighlight: true
  });

  $(".dropDownDiv").click(function(){
    $(this).children('.dropDownUl').slideToggle('fast');
    $('.dropDownDiv').not(this).children('.dropDownUl').slideUp("fast");
  });


  $(".dropDownUl li").click(function(){
       var selectedText = $(this).html();
        $(this).parent().prev().html(selectedText);
    })
  $('.headerdrop').click(function(){
    var droptxt = $(".dropDownUl").css('display');
    if(droptxt == 'none'){
      $('.dropDownUl').slideDown(500)
    }
    else{
      $('.dropDownUl').slideUp(500)
      }
  })

    $('.adminClick').click(function(){
       var selectedText = $('.HideSearchBlog').css('display');
       $('.HideTabularData').slideUp(500);
        if(selectedText == 'none'){
          $('.ml-card-holder.ml-card-holder-first').css('margin-top', '-45px');
          $('.ml-header').css('min-height', '90px');
          $('.HideTabularData').slideUp(500);
          $('.HideSearchBlog').slideDown(500);

        }
        else{

          $('.HideSearchBlog').slideUp(500);
          $('.HideTabularData').slideDown(500);
          $('.ml-card-holder.ml-card-holder-first').css('margin-top', '-84px');
          $('.ml-header').css('min-height', '140px');
        }
    });

    $('.collapseminus a').click(function(){
       var selectedText = $('.HideSearchBlog').css('display');
        if(selectedText == 'block'){
          $('.ml-card-holder.ml-card-holder-first').css('margin-top', '-84px');
          $('.ml-header').css('min-height', '140px');
          $('.HideTabularData').slideDown(500);
          $('.HideSearchBlog').slideUp(500);


        }
        else{

          $('.HideSearchBlog').slideUp(500);
          $('.HideTabularData').slideDown(500);
        }
    });



  $('#date').bootstrapMaterialDatePicker
      ({
        time: false
      });

      $('#time').bootstrapMaterialDatePicker
      ({
        date: false,

      });

      $('#date-format').bootstrapMaterialDatePicker
      ({
        format: 'dddd DD MMMM YYYY'
      });
      $('#date-fr').bootstrapMaterialDatePicker
      ({
        format: 'DD/MM/YYYY',
        lang: 'fr',
        weekStart: 1,
        cancelText : 'ANNULER'
      });

      $('#date-end').bootstrapMaterialDatePicker
      ({
        weekStart: 0, format: 'DD/MM/YYYY',time: false
      });
      $('#date-start').bootstrapMaterialDatePicker
      ({
        weekStart: 0, format: 'DD/MM/YYYY',time: false
      }).on('change', function(e, date)
      {
        $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
        time: false
      });

      $('#min-date').bootstrapMaterialDatePicker({ format : 'DD/MM/YYYY HH:mm',time: false, minDate : new Date() });



})


function flightTime() {
    var hours = [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'];
    $('.hours').autocomplete({
      source: hours,
      minLength: 0,
      scroll: true
      }).focus(function() {
        $(this).autocomplete("search", "");
      });
  }


  function minutes() {
    var minute = [
      '00',
      '05',
      '10',
      '15',
      '20',
      '25',
      '30',
      '35',
      '40',
      '45',
      '50',
      '55'];
    $('.minutes').autocomplete({
      source: minute,
      minLength: 0,
      scroll: true
      }).focus(function() {
        $(this).autocomplete("search", "");
      });
  }

  function times() {
    var time = [
      'AM',
      'PM'];
    $('.ampm').autocomplete({
      source: time,
      minLength: 0,
      scroll: true
      }).focus(function() {
        $(this).autocomplete("search", "");
      });
  }
  function showSuccessToast() {
            $().toastmessage('showSuccessToast', "Success Dialog which is fading away ...");
        }
        function showStickySuccessToast() {
            $().toastmessage('showToast', {
                text: 'Success Dialog which is sticky',
                sticky: true,
                position: 'top-right',
                type: 'success',
                closeText: '',
                close: function () {
                    console.log("toast is closed ...");
                }
            });

        }
        function showNoticeToast() {
            $().toastmessage('showNoticeToast', "Notice  Dialog which is fading away ...");
        }
        function showStickyNoticeToast() {
            $().toastmessage('showToast', {
                text: 'Notice Dialog which is sticky',
                sticky: true,
                position: 'top-left',
                type: 'notice',
                closeText: '',
                close: function () { console.log("toast is closed ..."); }
            });
        }
        function showWarningToast() {
            $().toastmessage('showWarningToast', "Warning Dialog which is fading away ...");
        }
        function showStickyWarningToast() {
            $().toastmessage('showToast', {
                text: 'Warning Dialog which is sticky',
                sticky: true,
                position: 'middle-right',
                type: 'warning',
                closeText: '',
                close: function () {
                    console.log("toast is closed ...");
                }
            });
        }
        function showErrorToast() {
            $().toastmessage('showErrorToast', "Error Dialog which is fading away ...");
        }
        function showStickyErrorToast() {
            $().toastmessage('showToast', {
                text: 'Error Dialog which is sticky',
                sticky: true,
                position: 'center',
                type: 'error',
                closeText: '',
                close: function () {
                    console.log("toast is closed ...");
                }
            });
        }








$('.tooltip').hide();

$('.form-input').focus(function() {
   $('.tooltip').fadeOut(250);
   $("."+$(this).attr('tooltip-class')).fadeIn(500);
});

$('.form-input').blur(function() {
   $('.tooltip').fadeOut(250);
});

$('.login-button').click(function (event) {
  event.preventDefault();
  // or use return false;
});

$( ".login-button" ).click(function() {
  if (  $( '.login-form' ).css( "transform" ) == 'none' ){
    $('.login-form').css("transform","rotateY(-180deg)");
    $('.loading').css("transform","rotateY(0deg)");
    var delay=600;
    setTimeout(function(){
      $('.loading-spinner-large').css("display","block");
      $('.loading-spinner-small').css("display","block");
    }, delay);
  } else {
      $('.login-form').css("transform","" );
  }
});




/*login popup*/

$(document).on('click', '.openLoginPopup', function(){
  show_popup('.loginPopup');
});

$(document).on('click', '.openSignupPopup', function(){
  show_popup('.signupPopup');
});

$(document).on('click', '.forgotPassword', function(){
  show_popup('.forgotPasswordPopup');
});

$(document).on('click', '.openresentConfirmationPopup', function(){
  show_popup('.resendConfirmationPopup');
});

$(document).on('click', '.openchangePasswordPopup', function(){
  show_popup('.changePassword');
});

$(document).on('click', '.closeThanks', function(){
  hide_all();
});

function show_popup(popup_name) {
  $('.thanksPopup, .bookingPopup, .loginOverLay, .loginPopup, .signupPopup, .forgotPasswordPopup, .resendConfirmationPopup, .changePassword').hide();
  $('.divPopUpBg').fadeIn();
  $('.divPopUpBigBlock').fadeIn();
  $('.loginOverLay').show();
  $(popup_name).show();
  var blockheight=parseInt($('.divPopUpBigBlock').outerHeight());
  var loginheight=parseInt($(popup_name).outerHeight());
  var blockwidth=parseInt($('.divPopUpBigBlock').outerWidth());
  var loginwidth=parseInt($(popup_name).outerWidth());
  $(popup_name).css('top', (blockheight-loginheight)/2);
  $(popup_name).css('left', (blockwidth-loginwidth)/2);
  $('span.message').remove();
  $(".error_msg").remove();
}

function hide_all() {
  $('.thanksPopup, .bookingPopup, .loginOverLay, .loginPopup, .signupPopup, .forgotPasswordPopup, .resendConfirmationPopup, .changePassword').hide();
  $('.divPopUpBigBlock').fadeOut();
  $('.divPopUpBg').fadeOut();
  $('body').css('overflow','auto');
}


