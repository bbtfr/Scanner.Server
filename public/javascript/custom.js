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

    if ($(window).scrollTop() > 100) {

      $('.header').addClass('header-solid');
    } else {

      $('.header').removeClass('header-solid');

    }

  }); 
  
  
  /* ----------------------------------------------------------- */
  /*  Flex slider
  /* ----------------------------------------------------------- */

  //Second item slider
  $(window).load(function() {
    $('.flexSlideshow').flexslider({
      animation: "fade",
      controlNav: false,
      directionNav: true,
      slideshowSpeed: 8000
    });
  });

  //Portfolio item slider
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

  //Testimonial

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
  
  //Clients

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
  
  
  //App gallery
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

  $("a[data-rel^='prettyPhoto']").prettyPhoto();

  
  /* ----------------------------------------------------------- */
  /*  Animation
  /* ----------------------------------------------------------- */
  //Wow
  new WOW().init();
  
  
  /* ----------------------------------------------------------- */
  /*  Contact map
  /* ----------------------------------------------------------- */
jQuery(function($) {
    
  $("#map").gmap3({
    map: {
      options: {
        center: [34.049676, -118.248372],
        zoom: 14,
        scrollwheel: false
      }
    },
    marker: {
      values: [{
        address: "200 N Main St, Los Angeles, CA 90012, United States",
        data: " Business Pro ! ! ",
        options: {
          icon: "https://res.cloudinary.com/quickthemes/image/upload/v1459381376/pu2tscdwmrfd3d27e4xs.png"
        }
      }],
      options: {
        draggable: false
      },
      events: {
        mouseover: function(marker, event, context) {
          var map = $(this).gmap3("get"),
            infowindow = $(this).gmap3({
              get: {
                name: "infowindow"
              }
            });
          if (infowindow) {
            infowindow.open(map, marker);
            infowindow.setContent(context.data);
          } else {
            $(this).gmap3({
              infowindow: {
                anchor: marker,
                options: {
                  content: context.data
                }
              }
            });
          }
        },
        mouseout: function() {
          var infowindow = $(this).gmap3({
            get: {
              name: "infowindow"
            }
          });
          if (infowindow) {
            infowindow.close();
          }
        }
      }
    }
  });
  
});   
