//= require jquery
//= require bootstrap
//= require owl.carousel.min
//= require jquery.prettyPhoto
//= require jquery.flexslider-min
//= require isotope.pkgd.min
//= require wow.min
//= require jquery.counterup.min
//= require jquery.waypoints.min

$('.my-navbar a[href^="#"]').on('click', function(event) {
  var target = $($(this).attr('href'));
  if (target.length) {
    event.preventDefault();
    $('html, body').animate({
      scrollTop: target.offset().top - 40
    }, 1000);
  }
});


/* ----------------------------------------------------------- */
/*  Fixed header
/* ----------------------------------------------------------- */

$(window).on('scroll', function() {
  if ($(window).scrollTop() > $(window).height()) {
    $('.header').addClass('header-solid');
  } else {
    $('.header').removeClass('header-solid');
  }
});


/* ----------------------------------------------------------- */
/*  Flex slider
/* ----------------------------------------------------------- */

// Second item slider
$(window).load(function() {
  $('.flexSlideshow').flexslider({
    animation: "fade",
    controlNav: false,
    directionNav: true,
    slideshowSpeed: 8000
  });
});

// Portfolio item slider
$(window).load(function() {
  $('.flexportfolio').flexslider({
    animation: "fade",
    controlNav: false,
    directionNav: true,
    slideshowSpeed: 8000
  });
});


/* ----------------------------------------------------------- */
/*  Counter
/* ----------------------------------------------------------- */

$('.counter').counterUp({
  delay: 10,
  time: 1000
});

/* ----------------------------------------------------------- */
/*  Owl Carousel
/* ----------------------------------------------------------- */

// Testimonial

$("#testimonial-carousel").owlCarousel({
  navigation: false, // Show next and prev buttons
  slideSpeed: 600,
  pagination: true,
  singleItem: true
});

// Custom Navigation Events
var owl = $("#testimonial-carousel");


// Custom Navigation Events
$(".next").click(function() {
  owl.trigger('owl.next');
})
$(".prev").click(function() {
  owl.trigger('owl.prev');
})
$(".play").click(function() {
  owl.trigger('owl.play', 1000); //owl.play event accept autoPlay speed as second parameter
})
$(".stop").click(function() {
  owl.trigger('owl.stop');
})

// Clients

$("#client-carousel").owlCarousel({
  navigation: false, // Show next and prev buttons
  slideSpeed: 400,
  pagination: false,
  items: 5,
  rewindNav: true,
  itemsDesktop: [1199, 3],
  itemsDesktopSmall: [979, 3],
  stopOnHover: true,
  autoPlay: true
});


// App gallery
$("#app-gallery-carousel").owlCarousel({
  navigation: false, // Show next and prev buttons
  slideSpeed: 400,
  pagination: true,
  items: 4,
  rewindNav: true,
  itemsDesktop: [1199, 3],
  itemsDesktopSmall: [979, 3],
  stopOnHover: true
});

/* ----------------------------------------------------------- */
/*  Prettyphoto
/* ----------------------------------------------------------- */

$("a[data-rel^='prettyPhoto']").prettyPhoto({
  social_tools: ""
});


/* ----------------------------------------------------------- */
/*  Animation
/* ----------------------------------------------------------- */
// Wow
new WOW().init();


/* ----------------------------------------------------------- */
/*  Contact map
/* ----------------------------------------------------------- */
jQuery(function($) {

  // 百度地图API功能
  var map = new BMap.Map("map");
  var point = new BMap.Point(116.473809, 40.00338);
  var marker = new BMap.Marker(point);  // 创建标注
  map.addOverlay(marker);              // 将标注添加到地图中
  map.centerAndZoom(point, 15);

});


/* ----------------------------------------------------------- */
/*  Isotope
/* ----------------------------------------------------------- */
jQuery(function($){

  if($.fn.isotope) {
    var $w = $(window);

    $w.load(function () {
      var $isotops = $('.isotope');

      $isotops.each(function () {
        var $el = $(this),
          id = $el.attr('id'),
          mode = $el.data('isotopeMode') || 'fitRows',
          tmt;


        $el.isotope({
          itemSelector: '.isotope-item',
          layoutMode: mode,
          animationOptions: {
            duration: 400,
            queue: false
          }
        });


        $w.resize(function(){
          clearTimeout(tmt);
          tmt = setTimeout(function(){
            $el.isotope('layout');
          }, 150);
        });

        var $menu = $('[data-isotope-nav="' + id + '"]');

        if ($menu.length) {
          $menu.find('a').click(function (e) {
            var $link = $(this);
            if(!$link.hasClass('active')){
              var selector = $link.attr('data-filter');
              $link.parents('ul').eq(0).find('.active').removeClass('active');
              $link.addClass('active');
              $el.isotope({ filter: selector });
            }
            e.preventDefault();
          });
        }

        $w.resize();

      });
    });
  }
});
