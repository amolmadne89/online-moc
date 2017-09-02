//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require bootstrap-multiselect
//= require bootstrap-datepicker
//= require moment
//= require cocoon
//= require daterangepicker
//= require data-confirm-modal
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require jquery-tablesorter
//= require app
//= require widget-cssStickyHeaders
//= require jquery.slimscroll.min

$(function() {
  // General Functionalities
  $("#full-screen-map").click(function(e){
    e.preventDefault();
    $("#map").css("position", 'fixed').
    css('top', 0).
    css('left', 0).
    css("width", '100%').
    css("height", '100%');
    google.maps.event.trigger(map, 'resize');
    $('body').addClass("sidebar-collapse")
  });

  $(".export-table").on('click', function (event) {
    // $('p.showmore').readmore('destroy');
    exportTableToCSV.apply(this, [$('table.export'), 'export.csv']);
  });

  function exportTableToCSV($table, filename) {
    var $rows = $table.find('tr:has(td)'),
      tmpColDelim = String.fromCharCode(11), // vertical tab character
      tmpRowDelim = String.fromCharCode(0), // null character

      // actual delimiter characters for CSV format
      colDelim = '","',
      rowDelim = '"\r\n"',
      // Grab text from table into CSV formatted string
      csv = '"' + $rows.map(function (i, row) {
          var $row = $(row),
              $cols = $row.find('td');

          return $cols.map(function (j, col) {
              var $col = $(col),
                  text = $col.text();

              return text.replace(/"/g, '""'); // escape double quotes

          }).get().join(tmpColDelim);

      }).get().join(tmpRowDelim).split(tmpRowDelim).join(rowDelim)
        .split(tmpColDelim).join(colDelim) + '"',

      // Data URI
      csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

    $(this)
      .attr({
      'download': filename,
        'href': csvData,
        'target': '_blank'
    });
  }

  $(document).on('keydown', function(e) {
    var googleMapWidth = $("#map").css('width');
    var googleMapHeight = $("#map").css('height');
    if (e.keyCode == 27) {
      $("#map").css("position", 'relative').
        css('top', 0).
        css("width", googleMapWidth).
        css("height", googleMapHeight);
      google.maps.event.trigger(map, 'resize');
    }
  });

  $('.multiselect').multiselect({
    enableFiltering: true,
    enableCaseInsensitiveFiltering: true,
    nonSelectedText: 'Please Select',
    includeSelectAllOption: true
  });

  $('.diffmultiselect').multiselect({
    enableFiltering: true,
    nonSelectedText: 'Please Select',
    enableCaseInsensitiveFiltering: true
  });

  ERP.dataConfirmModal();
  ERP.showMoreLess();
  ERP.handleAdvanceSearch();
  ERP.initializeBootstrapTooltip();
  ERP.initializeBootstrapDatePicker();
  ERP.initializeDataTable();
  ERP.initializeTableSorter();
  $('div.bulk-process').hide();
  $("#project_city").on("change", function(e){
    e.preventDefault()
    var project_id = $(this).find('option:selected').val();
    getProjects(project_id);
  });
  $("#lead_transaction_type_id").on("change", function(e){
    e.preventDefault()
    var transaction_type = $(this).find('option:selected').text();
    getRangeForSaleAndRent(transaction_type);
  });

  $("#user_role").on("change", function(e){
    e.preventDefault()
    var role = $(this).find('option:selected').text();
    getUsers(role);
  });

  $('.lead-collapse').on('click',function() {
    $('.collapse').collapse('hide');
  });
  // $('.datetimepicker').datetimepicker();

  var a = ['','one ','two ','three ','four ', 'five ','six ','seven ','eight ','nine ','ten ','eleven ','twelve ','thirteen ','fourteen ','fifteen ','sixteen ','seventeen ','eighteen ','nineteen '];
  var b = ['', '', 'twenty','thirty','forty','fifty', 'sixty','seventy','eighty','ninety'];

  function inWords (num) {
      if ((num = num.toString()).length > 9) return 'overflow';
      n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
      if (!n) return; var str = '';
      str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'crore ' : '';
      str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'lakh ' : '';
      str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'thousand ' : '';
      str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'hundred ' : '';
      str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + '' : '';
      return str;
  }

  $(".currency_input").on("keyup", function(e){
    var x=$(this).val();
    var to_fill_span = $(this).parent().find(".currency_text");
    to_fill_span.html(inWords(x));
  });
  $('.currency_input').bind('focusout', function() {
    var x=$(this).val();
    var to_fill_span = $(this).parent().find(".currency_text");
    to_fill_span.hide();
  });
  $('.currency_input').bind('focusin', function() {
    var x=$(this).val();
    var to_fill_span = $(this).parent().find(".currency_text");
    to_fill_span.show();
  });

  $('.alert').fadeTo(2000, 600).slideUp(1000, function() {
    $('.alert').alert('close');
  });
  // Update associated property.
  function setId(id) {
    $("#user_property_id").val(id);
  }
  // Bootstrap Multiselects
  $('.select-location').multiselect({
    buttonWidth: '120px',
    nonSelectedText: 'Select Location'
  });
  $('.select-builder').multiselect({
    buttonWidth: '120px',
    nonSelectedText: 'Select Builder'
  });
  $('.property-type').multiselect({
    buttonWidth: '120px',
    nonSelectedText: 'Property Type'
  });
  $('.select-user').multiselect({
    buttonWidth: '120px',
    nonSelectedText: 'Assigned To'
  });
  // Datepickers
  $('.nextcall').datepicker({
    format: 'yyyy-mm-dd',
    clearBtn: true,
    autoclose: true,
    todayBtn: 'linked',
    todayHighlight: true
  });
  // Min budget Range
  var $range = $("#min_budget"),
    $inputmn = $("#min_budget_val"),
    instance,
    min = 3000000,
    max = 100000000;
  $range.ionRangeSlider({
    type: "single",
    grid: false,
    min: min,
    max: max,
    from: 3000000,
    step: 100000,
    prefix: "Rs ",
    prettify_enabled: true,
    onStart: function(data) {
      $inputmn.prop("", data.from);
    },
    onChange: function(data) {
      $("#min_budget_val").val(data.from)
    }
  });
  instance = $range.data("ionRangeSlider");

  // Max budget Range
  var $range = $("#max_budget"),
    $inputmax = $("#max_budget_val"),
    instance,
    min = 3000000,
    max = 100000000;
  $range.ionRangeSlider({
    type: "single",
    grid: false,
    min: min,
    max: max,
    from: 3000000,
    step: 100000,
    prefix: "Rs ",
    prettify_enabled: true,
    onStart: function(data) {
      $inputmax.prop("", data.from);
    },
    onChange: function(data) {
      $inputmax.prop("value", data.from);
    }
  });
  instance = $range.data("ionRangeSlider");
  //  Area Range From
  var $range = $("#arearange_from"),
    $inputr = $("#arearange_from_val"),
    instance,
    min = 100,
    max = 10000;
  $range.ionRangeSlider({
    type: "single",
    grid: false,
    min: min,
    max: max,
    from: 100,
    step: 50,
    postfix: " Sq.ft ",
    prettify_enabled: true,
    onStart: function(data) {
      $inputr.prop("", data.from);
    },
    onChange: function(data) {
      $inputr.prop("value", data.from);
    }
  });

  instance = $range.data("ionRangeSlider");
  //  Area Range to
  var $range = $("#arearange_to"),
    $inputrto = $("#arearange_to_val"),
    instance,
    min = 100,
    max = 10000;
  $range.ionRangeSlider({
    type: "single",
    grid: false,
    min: min,
    max: max,
    from: 100,
    step: 50,
    postfix: " Sq.ft ",
    prettify_enabled: true,
    onStart: function(data) {
      $inputrto.prop("", data.from);
    },
    onChange: function(data) {
      $inputrto.prop("value", data.from);
    }
  });

  instance = $range.data("ionRangeSlider");

  // Destroy Popup Configuration.

  // Date Range Pickers
  $('#daterange').daterangepicker({
    timePicker: false,
    locale: {
      format: 'YYYY-MM-DD'
    },
    alwaysShowCalendars: true,
    autoUpdateInput: true
  });
  singleSelectOperations();
  bulkSelectOperations();
});
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  // var str = '<li class="liThumbnail col-md-6">' + content.replace(regexp, new_id) + '</li>'
  $(link).before(content.replace(regexp, new_id));
}

function getProjects(project_id) {
  $.ajax({
    type: 'GET',
    url: '/projects/projects_with_city',
    dataType: 'json',
    data: { project_id : project_id },
    success: function(response) {
      var options = "";
      $.each(response, function(index, d) {
        options = options + "<option value=" + d.id + ">" + d.name + "</option>"
      });
      $("#project_id").html(options);
    }
  });
}

function getUsers(role) {
  $.ajax({
    type: 'GET',
    url: '/users/users_with_role',
    dataType: 'json',
    data: { role : role },
    success: function(response) {
      var options = "";
      $.each(response, function(index, d) {
        options = options + "<option value=" + d.id + ">" + d.full_name + "</option>"
      });
      $("#user_user_managers_attributes_new__association__manager_id").html(options);
    }
  });
}

function getRangeForSaleAndRent(transaction_type){
  if (transaction_type == "Rent") {
    $("#rent-range-picker").html("<div class='form-group dropdown'><div aria-expanded='false' aria-haspopup='true' class='styled-select dropop-range' data-toggle='dropdown'><input class='form-control' id='rent_min_budget_val' name='lead[min_budget]' placeholder='Min Budget (Rs)' type='text' /></div><div aria-labelledby='dLabel' class='range-holder dropdown-menu'><input id='rent_min_budget' name='' type='text' value=''></div></div>");
    $("#sale-range-picker").children().remove();
    ERP.initializeMinRentSlider();
  } else {
    $("#sale-range-picker").html("<div class='form-group dropdown'><div aria-expanded='false' aria-haspopup='true' class='styled-select dropop-range' data-toggle='dropdown'><input class='form-control' id='sale_min_budget_val' name='lead[min_budget]' placeholder='Min Budget (Rs)' type='text' /></div><div aria-labelledby='dLabel' class='range-holder dropdown-menu'><input id='sale_min_budget' name='' type='text' value=''></div></div>")
    $("#rent-range-picker").children().remove();
    ERP.initializeMinSaleSlider();
  }
}

var ERP = function() {

  /*************************************/
  /** Private Functions and Variables **/
  /*************************************/

  /**********************************/
  /** Public Methods and Functions **/
  /**********************************/
  return {
    init: function() {

    },
    dataConfirmModal: function() {
      dataConfirmModal.setDefaults({
        title: 'Are you sure?',
        commit: 'Yes',
        cancel: 'No',
      });
    },
    showMoreLess: function() {
      var showChar = 200;
      var ellipsestext = "...";
      var moretext = "Show more >";
      var lesstext = "Show less <";
      $('.more').each(function() {
        var content = $(this).html();
        if(content.length > showChar) {
          var c = content.substr(0, showChar);
          var h = content.substr(showChar, content.length - showChar);
          var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
          $(this).html(html);
        }
      });

      $(".morelink").click(function(){
        if($(this).hasClass("less")) {
          $(this).removeClass("less");
          $(this).html(moretext);
        } else {
          $(this).addClass("less");
          $(this).html(lesstext);
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
      });
    },
    handleAdvanceSearch: function() {
      $('#adv-search').click(function() {
        $('#adv-searchbox').toggle(300);
        icon = $('#adv-search').children('i');
        if (icon.hasClass('fa-angle-down')) {
          icon.removeClass('fa-angle-down').addClass('fa-angle-up')
        } else {
          icon.removeClass('fa-angle-up').addClass('fa-angle-down')
        }
      });
    },
    initializeBootstrapTooltip: function() {
      $('[data-toggle="tooltip"]').tooltip();
    },
    initializeBootstrapDatePicker: function() {
      $('.datepicker').datepicker({
        format: 'yyyy-mm-dd',
        clearBtn: true,
        autoclose: true,
        todayBtn: 'linked',
        todayHighlight: true
      });
    },
    initializeMinRentSlider: function () {
      var $range = $("#rent_min_budget"),
        $inputmn = $("#rent_min_budget_val"),
        instance,
        min = 5000,
        max = 500000;
      $range.ionRangeSlider({
        type: "single",
        grid: false,
        min: min,
        max: max,
        from: 5000,
        step: 1000,
        prefix: "Rs ",
        prettify_enabled: true,
        onStart: function(data) {
          $inputmn.prop("", data.from);
        },
        onChange: function(data) {
          $("#rent_min_budget_val").val(data.from)
        }
      });
      instance = $range.data("ionRangeSlider");
    },
    initializeMinSaleSlider: function () {
      var $range = $("#sale_min_budget"),
        $inputmn = $("#sale_min_budget_val"),
        instance,
        min = 3000000,
        max = 100000000;
      $range.ionRangeSlider({
        type: "single",
        grid: false,
        min: min,
        max: max,
        from: 3000000,
        step: 100000,
        prefix: "Rs ",
        prettify_enabled: true,
        onStart: function(data) {
          $inputmn.prop("", data.from);
        },
        onChange: function(data) {
          $("#sale_min_budget_val").val(data.from)
        }
      });
      instance = $range.data("ionRangeSlider");
    },
    initializeTableSorter: function() {
      $('.tablesorter').tablesorter({
        showProcessing: true,
        // initialize zebra and filter widgets
        widgets: ["zebra", "filter", "cssStickyHeaders"],
        headers: {
        },
        widgetOptions: {
          cssStickyHeaders_offset: 63,
          cssStickyHeaders_addCaption: false
        }

      });
    },
    initializeDataTable: function() {
      $("#data-table, #data-table2").DataTable({
        "bPaginate": true,
        'aLengthMenu' : [
          [10, 25, 50, 100, 200, -1],
          [10, 25, 50, 100, 200, 'All']
        ],
        // 'pageLength': 25,
        'iDisplayLength' : -1,
        'language' : {
          'lengthMenu' : 'Showing _MENU_ records per page',
        },
        "fixedHeader" : {
          "header": true,
          "headerOffset": 50
        },
        "bInfo": false,
        "bSort": false
      });
    }
  }
}();
function singleSelectOperations() {
  $('input.bulk-select').on('change', function() {
    if($('input.bulk-select:checked').length) {
      $('div.bulk-process').show();
    } else {
      $('div.bulk-process').hide();
    }
  });
}

function bulkSelectOperations() {
  $('.select-all').on('change', function() {
    if(this.checked) {
      $('.bulk-select').each(function() {
        this.checked = true;
      });
      $('div.bulk-process').show();
    } else {
      $('.bulk-select').each(function() {
        this.checked = false;
      });
      $('div.bulk-process').hide();
    }
  });
}



