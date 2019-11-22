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

    $('a#description-toggle').on('click', function(e){
      e.preventDefault();
      $('.property-description article').toggleClass('expended');
      $(this).toggleClass('less');
      if($(this).hasClass('less')){
        $(this).text('Show Less')
      }else{
        $(this).text('Read More');
      }
    });

});

$(window).resize(function() {
  $(".rev__dropdown-content").css('top',0).css('left',0).removeClass("open");
});