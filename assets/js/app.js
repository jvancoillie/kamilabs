/*
 * Welcome to your app's main JavaScript file!
 *
 * We recommend including the built version of this JavaScript file
 * (and its CSS file) in your base layout (base.html.twig).
 */

// Need jQuery? Install it with "yarn add jquery", then uncomment to import it.
import $ from 'jquery';
import 'bootstrap';
console.log('Hello Webpack Encore! Edit me in assets/js/app.js');

jQuery(document).ready(function ($) {

    /** ===========================================
     Hide / show the master navigation menu
     ============================================ */

        // console.log('Window Height is: ' + $(window).height());
        // console.log('Document Height is: ' + $(document).height());


    var previousScroll = 0;
    var nav = $("[data-nav-status='toggle']");
    var navHeight = nav.outerHeight();

    $(window).scroll(function () {

        var currentScroll = $(this).scrollTop();

        /*
          If the current scroll position is greater than 0 (the top) AND the current scroll position is less than the document height minus the window height (the bottom) run the navigation if/else statement.
        */
        if (currentScroll > navHeight && currentScroll < $(document).height() - $(window).height()) {
            /*
              If the current scroll is greater than the previous scroll (i.e we're scrolling down the page), hide the nav.
            */
            if (currentScroll > previousScroll) {
                window.setTimeout(hideNav, 300);
                /*
                  Else we are scrolling up (i.e the previous scroll is greater than the current scroll), so show the nav.
                */
            } else {
                window.setTimeout(showNav, 300);
            }
            /*
              Set the previous scroll value equal to the current scroll.
            */
            previousScroll = currentScroll;
        }

        if (currentScroll > navHeight){
            nav.addClass("is-scrolled");
        }else{
            nav.removeClass("is-scrolled");
        }

        console.log(currentScroll,navHeight )

    });

    function hideNav() {
        nav.addClass("hide");
    }

    function showNav() {
        nav.removeClass("hide");
    }

});
