// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery-1.8.3.min
//= require jquery.themepunch.tools.min
//= require jquery.themepunch.revolution.min
//= require jquery.sidr
//= require jquery.fancybox
//= require cleantabs.jquery
//= require fitvids.min
//= require jquery.scrollUp.min
//= require mediaelement-and-player.min
//= require owl.carousel
//= require selectivizr-min
//= require placeholder
//= require jquery.stellar.min
//= require mosaic.1.0.1
//= require jquery.isotope
//= require toggle
//= require jquery.tooltipster
//= require jquery.countdown
//= require jquery.sticky
//= require html5media
//= require slider-1
//= require main
//= require pickaday
//= require s3_direct_upload
//= require selectize


$(document).ready(function() {

  $(".owl-carousel").owlCarousel({

      navigation : true, // Show next and prev buttons
      slideSpeed : 300,
      paginationSpeed : 400,
      items: 2,
      itemsDesktop: false

      // "singleItem:true" is a shortcut for:
      // items : 1,
      // itemsDesktop : false,
      // itemsDesktopSmall : false,
      // itemsTablet: false,
      // itemsMobile : false

  });

  recalculate();
  $('[data-price]').change(function() {
    recalculate();
  });


  var i = document.createElement('input');
  i.setAttribute('type', 'date');

  if (i.type === 'text') {

    var i18nOptions = {
      previousMonth : 'Tidigare månad',
      nextMonth     : 'Nästa månad',
      months        : ['Januari','Februari','Mars','April','Maj','Juni','Juli','Augusti','September','Oktober','November','December'],
      weekdays      : ['Söndag','Måndag','Tisdag','Onsdag','Torsdag','Fredag','Lördag'],
      weekdaysShort : ['Sön','Mån','Tis','Ons','Tor','Fre','Lör']
    }

    $('.datepicker').forEach(function(element) {
      new Pikaday({
        field: element,
        firstDay: 1,
        i18n: i18nOptions
      });
    });
  }


  $('[data-confirm]').click(function() {
    if (!confirm($(this).data('confirm'))) {
      return false;
    }
  });

  $('.fancybox').click(function(ev) {
    ev.preventDefault();
    url = $(this).attr('href');
    title = $(this).attr('title')
    $.fancybox.open({
      href : url,
      title: title,
      type : 'image'
    });
    return false;
  });



});

var recalculate = function() {
  var sum = 0;
  $('[data-price]').each(function(idx, attr) {
    $attr = $(attr);

    if ($attr.is(':checked') || $attr.is(':selected')) {
      sum += $attr.data('price');
    }
    $('#total-cost').text(sum + 200);
    $('#total-year-cost').text(sum);
  });
}

$('.multiple').selectize();

