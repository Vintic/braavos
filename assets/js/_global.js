$(document).ready(function() {
  // TOGGEL MOBILE NAV
  $(".toggle-mobile-nav").click(function(){
    $(".toggle-mobile-nav, #mobile-menu").toggleClass("active");
    $("body").toggleClass("mobile-menu-active");
  });

  // SUBBANNER SEARCH
  // BOTTOM OPTIONS - HIDE SHOW BOTTOM OPTIONS - FOR MOBILE
  $("#search-banner .toggle-search-options").click(function(){
    if($(this).hasClass("active")){
      $("#search-banner .hidden-options").removeClass("active").stop().slideUp();;
    } else {
      $("#search-banner .hidden-options").addClass("active").stop().slideDown();;
    }
    $(this).toggleClass("active");
  });

  // BOTTOM OPTIONS - PRICE MIN-MAX DROPDOWN OPTION SHOW/HIDE - FOR MOBILE
  $("#search-banner .selected-option").click(function(){
    $(this).parent().toggleClass("active");
  });

  // BOTTOM OPTIONS - PRICE MIN-MAX DROPDOWN BUTTONS VALUE CHANGE ON SELECT - FOR MOBILE
  $("#search-banner .price-select label").click(function(){
    var parntContainer = $(this).parents("ol");
    var heading = $(this).parents().siblings(".selected-option");
    var selectedText = $(this).html();

    heading.html(selectedText);
    parntContainer.toggleClass("active");
  });

  // BOTTOM OPTIONS - CHANGE VALUE NEXT TO HEADING - MIKES MAGIC
  $("[data-select] input").on("click", function(e) {
    e.preventDefault();
  });

  $("[data-select] label").on("click", function(e) {
    e.preventDefault()
    checkHandler.call($(this).prev("input")[0]);
  });

  function checkHandler(e) {

    var $container = $(this).parents("[data-select]");

    var _target = $container.data("selectTarget");
    var $displayValues = $("[data-select-value="+_target+"]");

    var $all = $container
      .find("input[value=All]");

    var _value = this.value;

    /* ALL checked - uncheck everything else */
    if (_value == "All") {

      var checkState = $(this).prop("checked");
      var $inputs = $container
        .find("input").not("[input=All]");

      $inputs.prop("checked", false);
      $(this).prop("checked", true);
    }
    /* Other checked - uncheck All */
    else {

      var checkState = $(this).prop("checked");
      $(this).prop("checked", !checkState);

      if (!checkState) {
        $all.prop("checked", false)
      }
    }

    var $inputChecked = $container
      .find("input:checked");

    /* "Other" was unchecked, recheck ALL */
    if (!$inputChecked.length) {
      $all.prop("checked", true)
      $inputChecked = $all;
    }

    /* Update the target container values */
    var updatedValues = $inputChecked.toArray()
      .map(function(e) { return e.value });

    $displayValues.html(updatedValues.join(", "));
  };

  // END OF MIKES MAGIC

  
  // HOME PAGE BLOG SECTION
  $("#homepage-container #blogs .toggle-btn").click(function(){
    var $this = $(this);
    var newsType = $this.attr("data");

    console.log(newsType);

    $this.siblings().removeClass("active");
    $this.addClass("active");
    $(".news-items").stop().slideUp();
    $(".news-items[data=" + newsType + "]").stop().slideDown();
  });

  // HOME PAGE SEO LINK SECTION - FOR MOBILE
  $(".seo-links-toggle-btn").click(function(){
    if($(this).hasClass("active")){
      $(this).siblings("#collapsehomepageseo").removeClass("active").stop().slideUp();;
    } else {
      $(this).siblings("#collapsehomepageseo").addClass("active").stop().slideDown();;
    }
    $(this).toggleClass("active");
  });

  // SEARCH RESULTS SUBBANNER SEARCH
  // MOBILE TOGGEL HIDE/SHOW
  $(".toggle-mobile-search-banner").click(function(){
    $(".toggle-mobile-search-banner, #search-banner").toggleClass("active");
    $("body").toggleClass("mobile-menu-active");
  });

  // SEARCH RESULTS MOBILE RESET INPUT FIELDS
  $(".reset-search-banner").click(function() {
    $("#search-banner form").find("input[type=text], textarea").val("");
    $("#search-banner form").find("input[type=radio],input[type=checkbox]").prop('checked', false);
    $("#search-banner form .search-option li:first-child").find(" input[type=radio], input[type=checkbox]").prop('checked', true);

  });

  // SEARCH RESULTS PAGE - LISTING ITEM SLIDESHOW
  $("#search-results-page .listing-item .image-large").slick({
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    autoplay: false
  });

  // SEARCH RESULTS PAGE - sidebar property slider
  $("#search-results-page .side-otions .side-listings").slick({
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    dots: true,
    arrows: false,
    autoplay: false,
    //autoplaySpeed: 3000
  });


// JOESL REV DROPDOWN SOLUTION
  $(".rev__dropdown")
    .on('click', function() {

      var $button = $(this);
      var thisDropdown = $button.attr('target');
      var thisPosition = $button.attr('position');

      var $dropdown = $("#" + thisDropdown)
      var hAlign = $dropdown.attr('h-align')
      var vAlign = $dropdown.attr('v-align')

      var buttonOff = $button.offset();
      var buttonPos = $button.position();

      if(thisPosition == 'fixed' || thisPosition == 'absolute'){
          var buttonTop = buttonPos.top;
          var buttonBottom = buttonPos.top + $button.height();
      } else {
          var buttonTop = buttonOff.top;
          var buttonBottom = buttonOff.top + $button.height();
      }

      var buttonLeft = buttonOff.left;
      var buttonRight = buttonOff.left + $button.width();

      if( hAlign == 'left' ){
          $("#" + thisDropdown).css('left',buttonLeft);
      } else {
          $("#" + thisDropdown).css('left',buttonRight - $dropdown.width());
      }

      if( vAlign == 'top' ){
          $("#" + thisDropdown).css('top',buttonTop - $dropdown.height());
      } else {
          $("#" + thisDropdown).css('top',buttonBottom);
      }

      $("#" + thisDropdown).toggleClass("open");
    })

    .on('blur', function() {
      var thisTarget = $(this).attr('target');

      setTimeout(function(){
        $("#" + thisTarget).css('top',0).css('left',0).removeClass("open");
      },500);

    });

    
  // Modal Control
  $('.modal-overlay, .modal-close').on('click', function(){
    $('.modal-popup').fadeOut();
  });


  // Listing page  

  //  Recent Sales Property Image Slider
  $('.property-recent-sales .image-large').slick({
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    autoplay: false
  });

  //  Property Image Slider

    // Trigger Property Slider
  $('[data-hook=open-full-photo-viewer]').on('click', function(e){
    e.preventDefault();
    $('.modal-popup-photos').fadeIn();
    $('.photo-slider').get(0).slick.setPosition();
    $('.photo-slider-thumbnails').get(0).slick.setPosition();
  });

    // Main Image Slider
  $('.photo-slider').slick({
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
    fade: false,
    asNavFor: '.photo-slider-thumbnails',
    
  });

    // Thumbnails Image Slider
  $('.photo-slider-thumbnails').slick({
    infinite: true,
    speed: 300,
    slidesToShow: 5,
    slidesToScroll: 1,
    asNavFor: '.photo-slider',
    dots: true,
    focusOnSelect: true
  });

    // Pager Updates
  $('.photo-slider').on('init reInit afterChange', function (event, slick, currentSlide, nextSlide) {
    //currentSlide is undefined on init -- set it to 0 in this case (currentSlide is 0 based)
    var i = (currentSlide ? currentSlide : 0) + 1;
    $('#count').text(i);
  });

    //  Floorplan Image Slider

    // Trigger Floorplan Slider
    $('[data-hook=open-full-photo-viewer-to-floorplans]').on('click', function(e){
      e.preventDefault();
      $('.modal-popup-floorplan').fadeIn();
      $('.floorplan-slider').get(0).slick.setPosition();
      $('.floorplan-slider-thumbnails').get(0).slick.setPosition();
    });
  
      // Main Image Slider
    $('.floorplan-slider').slick({
      infinite: true,
      speed: 300,
      slidesToShow: 1,
      slidesToScroll: 1,
      arrows: true,
      fade: false,
      asNavFor: '.floorplan-slider-thumbnails',
      
    });
  
      // Thumbnails Image Slider
    $('.floorplan-slider-thumbnails').slick({
      infinite: true,
      speed: 300,
      slidesToShow: 5,
      slidesToScroll: 1,
      asNavFor: '.floorplan-slider',
      dots: true,
      focusOnSelect: true
    });
      // Pager Updates
    $('.floorplan-slider').on('init reInit afterChange', function (event, slick, currentSlide, nextSlide) {
      //currentSlide is undefined on init -- set it to 0 in this case (currentSlide is 0 based)
      var i = (currentSlide ? currentSlide : 0) + 1;
      $('#count-floorplan').text(i);
    });


  // Description Toggle
  $('a#description-toggle').on('click', function(e){
    e.preventDefault();
    $('.property-intro__description article').toggleClass('expended');
    $(this).toggleClass('less');
    if($(this).hasClass('less')){
      $(this).text('Show Less')
    }else{
      $(this).text('Read More');
    }
  });

  // School Type Tabs
  $('.toggle-school-type li a').on('click', function(e){
    e.preventDefault();
    thisLi = $(this).parent('li');
    thisLi.siblings().removeClass('active');
    thisLi.addClass('active');
    thisHref = $(this).attr('href');

    $('.tab-pane'+thisHref).siblings().removeClass('active')
    $('.tab-pane'+thisHref).addClass('active');

  });


});

$(window).resize(function() {
  $(".rev__dropdown-content").css('top',0).css('left',0).removeClass("open");
});