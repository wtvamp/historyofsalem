<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistoryBook.aspx.cs" Inherits="Salem_Hospital_History_Book.WebForm1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>
    	Salem Hospital - A History of Service
    </title>
    <script type="text/javascript" src="http://use.typekit.com/lsj5ddz.js"></script>
    <script type="text/javascript">try { Typekit.load(); } catch (e) { }</script>
    <script type="text/javascript" src="http://use.typekit.com/wtn3zag.js"></script>
    <script type="text/javascript">    try { Typekit.load(); } catch (e) { }</script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.12/jquery-ui.min.js"></script>
    <script src="Scripts/jquery.easing.1.3.js" type="text/javascript"></script>
    <script src="Scripts/jquery.booklet.1.2.0.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.jqpuzzle.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.jplayer.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.spritely-0.4.js" type="text/javascript"></script>
    <script src="Scripts/xray.min.js" type="text/javascript"></script>
    <script src="Scripts/raphael-min.js" type="text/javascript"></script>
    <script src="Scripts/rain.js" type="text/javascript"></script>
    <script src="Scripts/Lightning.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            var showIntro = true;

            // This gets some dom object and stores them in variables
            var $mybook = $('#mybook');
            var $bttn_next = $('#next_page_button');
            var $bttn_prev = $('#prev_page_button');
            var $loading = $('#loading');

            // This finds all of the images in the book.  It assigns 
            // number of images in the book into cnt_images, and the
            // dom representation of the images into the array
            // $mybook_images.  The loaded variable starts as false
            // to represent that the images have not yet been loaded.  
            var $mybook_images = $mybook.find('img');
            var cnt_images = $mybook_images.length;
            var loaded = 0;

            // Get the page number from the URL
            var page = window.location.href.split('/page/');

            // If it's greater than one, add the book background.  This is
            // necessary because the front page does not have the book background.
            // If the page refreshes, it will not have a book background,
            // unless you add it manually here.
            if (page[1] > 1) {
                $(".book_wrapper").css('background', 'transparent url(./images/history_pages_bg2.png) no-repeat 9px 27px');
            };


            // These are the three jPlayer videos - they are initialized here.
            // The JQuery on the respective pages below starts/stops
            // and shows/hides them.
            $("#morsePlay").jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        m4v: "/Movies/morse.m4v",
                        poster: "/Images/page_images/WB-Morse.jpg"
                    }) // Attempts to Auto-Play the media
                },
                supplied: "m4v",
                swfPath: "Scripts"
            });

            $("#nursePlayer").jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        m4v: "/Movies/marketing.m4v",
                        poster: "/Images/page_images/Sister-Anna.jpg"
                    }) // Attempts to Auto-Play the media
                },
                supplied: "m4v",
                swfPath: "Scripts"
            });


            $("#pharmPlayer").jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        m4v: "/Movies/Pharmacy.m4v",
                        poster: "/Images/page_images/robot.png"
                    }) // Attempts to Auto-Play the media
                },
                supplied: "m4v",
                swfPath: "Scripts"
            });

            $("#narrationPlayer").jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        mp3: "/Movies/narration.mp3"
                    });
                },
                supplied: "mp3",
                swfPath: "Scripts"
            });

            $("#effectsPlayer").jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        mp3: "/Movies/edentsgate.mp3"
                    });
                },
                supplied: "mp3",
                swfPath: "Scripts"
            });



            // Count through each of the images in the book
            // from the array above
            $mybook_images.each(function () {

                // Get the src of the image from the current address
                // of the array of book images
                var $img = $(this);
                var source = $img.attr('src');

                // Once the image for this address is loaded
                $('<img/>').load(function () {
                    // Increase the number of loaded images
                    ++loaded;

                    // Once the number of actually loaded images
                    // equals the number of images counted in the book
                    // earlier, then hide the loading div, show the next
                    // and previous buttons, and show the book itself.  
                    if (loaded == cnt_images) {
                        $loading.hide();
                        $bttn_next.show();
                        $bttn_prev.show();
                        $mybook.show().booklet({
                            name: null,
                            // name of the booklet to display in the document title bar
                            width: 800,
                            // container width
                            height: 500,
                            // container height
                            speed: 600,
                            // speed of the transition between pages
                            direction: 'LTR',
                            // direction of the overall content
                            // organization, default LTR, left to right, can be
                            // RTL for languages which read right to left
                            startingPage: 0,
                            // index of the first page to be displayed
                            easing: 'easeInOutQuad',
                            // easing method for complete transition
                            easeIn: 'easeInQuad',
                            // easing method for first half of transition
                            easeOut: 'easeOutQuad',
                            // easing method for second half of transition

                            closed: true,
                            // start with the book "closed", will add empty
                            // pages to beginning and end of book
                            closedFrontTitle: null,
                            // used with "closed", "menu" and "pageSelector",
                            // determines title of blank starting page
                            closedFrontChapter: null,
                            // used with "closed", "menu" and "chapterSelector",
                            // determines chapter name of blank starting page
                            closedBackTitle: null,
                            // used with "closed", "menu" and "pageSelector",
                            // determines chapter name of blank ending page
                            closedBackChapter: null,
                            // used with "closed", "menu" and "chapterSelector",
                            // determines chapter name of blank ending page
                            covers: true,
                            // used with  "closed", makes first and last pages
                            //into covers, without page numbers (if enabled)

                            pagePadding: 10,
                            // padding for each page wrapper
                            pageNumbers: true,
                            // display page numbers on each page

                            manual: true,
                            hover: true,
                            overlay: false,
                            // enables preview pageturn hover animation,
                            // shows a small preview of previous or next page on hover

                            // enables navigation using a page sized overlay,
                            // when enabled links inside the content will
                            // not be clickable
                            tabs: false,
                            // adds tabs along the top of the pages
                            tabWidth: 60,
                            // set the width of the tabs
                            tabHeight: 20,
                            // set the height of the tabs
                            arrows: false,
                            // adds arrows overlayed over the book edges

                            hash: true,
                            // enables navigation using a hash string,
                            // ex: #/page/1 for page 1, will affect
                            // all booklets with 'hash' enabled
                            keyboard: true,
                            // enables navigation with arrow keys
                            // (left: previous, right: next)
                            next: $bttn_next,
                            // selector for element to use as click
                            // trigger for next page
                            prev: $bttn_prev,
                            // selector for element to use as click
                            // trigger for previous page

                            menu: null,
                            // selector for element to use as the menu area,
                            // required for 'pageSelector'
                            pageSelector: false,
                            // enables navigation with a dropdown menu of pages,
                            // requires 'menu'
                            chapterSelector: false,
                            // enables navigation with a dropdown menu of chapters,
                            // determined by the "rel" attribute, requires 'menu'

                            shadows: true,
                            // display shadows on page animations
                            shadowTopFwdWidth: 166,
                            // shadow width for top forward anim
                            shadowTopBackWidth: 166,
                            // shadow width for top back anim
                            shadowBtmWidth: 50,
                            // shadow width for bottom shadow


                            // If the page is the first or the last page, 
                            // make the background disappear.  The before
                            // function happens before a page is finished
                            // turning.
                            before: function (opts) {
                                if (opts.curr == 0) {
                                    $(".book_wrapper").css('background', 'none');
                                };
                                if (opts.curr == 32) {
                                    $(".book_wrapper").css('background', 'none');
                                };
                            },
                            // The after function happens after a page is
                            // completed turning.
                            after: function (opts) {


                                // If it is one of the pages in the middle of 
                                // the book, add the open book background.
                                if (opts.curr > 0 && opts.curr < 32) {
                                    $(".book_wrapper").css('background', 'transparent url(./images/history_pages_bg2.png) no-repeat 9px 27px');
                                };


                                // Each of the scripts below are designed to run on
                                // a particular page, after it is turned.  

                                // Page cover Scripts
                                if (opts.curr == 0) {
                                    // This stops, and hides the William Morse
                                    // animation, if the user turns back to this
                                    // page from page 2.
                                    $("#morsePlay").css('opacity', '0');
                                    $("#morsePlay").children().css('position', 'absolute');
                                    $("#morsePlay").children().css('left', '-200px');
                                    $("#morsePlay").jPlayer("stop");
                                    $("#morsePlay").css('z-index', '1');

                                    // This restarts the music if the person goes back to the first page:
                                    // Stop the narration
                                    $("#narrationPlayer").jPlayer("stop");
                                    // Load the music
                                    $("#effectsPlayer").jPlayer("setMedia", {
                                        mp3: "/Movies/edentsgate.mp3"
                                    });
                                    // Play the music
                                    $("#effectsPlayer").jPlayer("play", 0);
                                };


                                // These are things that need to be done on each 
                                // page.  
                                if (opts.curr >= 2) {
                                    narrationFadeOut();
                                    $("#narrationPlayer").unbind();
                                    $("#morsePlay").unbind();
                                }

                                if (opts.curr != 2) {
                                    // Hide the Morse div.
                                    $("#morsePlay").css('opacity', '0');
                                    $("#morsePlay").children().css('position', 'absolute');
                                    $("#morsePlay").children().css('left', '-200px');
                                    $("#morsePlay").jPlayer("stop");
                                    $("#morsePlay").css('z-index', '1');
                                }

                                if (opts.curr != 9) {
                                    // This hides the video on the next page - which seems to stick for some reason.
                                    $("#hideBackground").css('opacity', '0');
                                    $("#hideBackground").children().css('position', 'absolute');
                                    $("#hideBackground").children().css('left', '-400px');
                                    $("#hideBackground").css('z-index', '0');

                                }

                                // Page 1-2 Scripts
                                if (opts.curr == 2) {

                                    // Stop the previous narration
                                    $("#narrationPlayer").jPlayer("stop");
                                    // Load Doug's narration
                                    $("#narrationPlayer").jPlayer("setMedia", {
                                        mp3: "/Movies/narration.mp3"
                                    });

                                    // This shows William Morse's div, moving it left from
                                    // being hidden under the overflow div
                                    $("#morsePlay").css('opacity', '1');
                                    $("#morsePlay").css('z-index', '9999');
                                    $("#morsePlay").children().css('left', '0px');
                                    $("#morsePlay").jPlayer("play");
                                    $("#morsePlay").jPlayer("stop");

                                    // This starts Doug's narration.  It is bound
                                    // to the timeupdate jPlayer event, so we 
                                    // know when to stop it.
                                    $("#narrationPlayer").jPlayer("play", 0);
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {

                                        // At 20 seconds into the narration...
                                        if (event.jPlayer.status.currentTime > 20) {

                                            // Pause it and move the tapehead on 
                                            // Doug's narration to 27 seconds...
                                            $(this).jPlayer("pause", 27);

                                            // And start William Morse's animation
                                            $("#morsePlay").jPlayer("play");
                                            // Bind the timeupdate jPlayer event to 
                                            // William Morse's animation
                                            $("#morsePlay").bind($.jPlayer.event.timeupdate, function (event2) {
                                                // At 27 seconds into William Morse's animation....
                                                if (event2.jPlayer.status.currentTime > 27) {
                                                    // Pause it...
                                                    $(this).jPlayer("pause");
                                                    // And unbind the previous time event from doug's narration
                                                    // since we are starting the narration over from 27 seconds in.
                                                    $("#narrationPlayer").unbind();
                                                    // Start the narration again
                                                    $("#narrationPlayer").jPlayer("play");
                                                    // Rebind the jPlayer timeupdate event.  This is necessary
                                                    // because otherwise it keeps skipping/pausing based on the 
                                                    // first binding above.  By unbinding and rebinding the event,
                                                    // we can pause it in it's new ending event, at 43 seconds into
                                                    // Doug's narration. 
                                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                                        if (event.jPlayer.status.currentTime > 43) {
                                                            $(this).jPlayer("pause", 51);
                                                        }
                                                    });
                                                }
                                            });

                                        }



                                    });
                                };


                                // Page 3-4 Scripts
                                if (opts.curr == 4) {

                                    // Stop the narration, and move the tape head to 51 seconds
                                    $("#narrationPlayer").jPlayer("pause", 51);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind the time so we can stop it after narration for this page is done.
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 82) {
                                            $(this).jPlayer("pause", 88);
                                        };
                                    });

                                    var mySettings = {
                                        rows: 3,
                                        cols: 3,
                                        shuffle: true,
                                        language: 'en',
                                        // display additional gui controls 
                                        control: {
                                            shufflePieces: true,    // display 'Shuffle' button [true|false] 
                                            confirmShuffle: false,   // ask before shuffling [true|false] 
                                            toggleOriginal: true,   // display 'Original' button [true|false] 
                                            toggleNumbers: true,    // display 'Numbers' button [true|false] 
                                            counter: false,          // display moves counter [true|false] 
                                            timer: false,            // display timer (seconds) [true|false] 
                                            pauseTimer: false        // pause timer if 'Original' button is activated 
                                            // [true|false] 
                                        },
                                        success: {
                                            callback: function (results) {
                                                $("#deaconessCaption").html("Salem Deaconess Hospital, 1935");
                                                $("#deaconessStory").html("Mennonites from Dallas pitched in, salvaging bricks in 1920 from a burned McMinnville mill for use in" + "constructing a main building with 40 more beds.");
                                                $("#deaconessStory2").fadeIn();
                                                $(".jqp-wrapper div:nth-child(9)").fadeOut('slow', function () {
                                                    $(".jqp-wrapper div:nth-child(9)").css("background-image", "url(http://localhost:53508/Images/page_images/Salem-Deaconess-1935.png)");
                                                });
                                                $(".jqp-wrapper div:nth-child(9)").fadeIn('slow');

                                            }
                                        }
                                    };

                                    $('#oldDeaconess').jqPuzzle(mySettings);
                                };


                                // Page 5-6 Scripts
                                if (opts.curr == 6) {


                                    // Stop the narration, unbind all previous time events
                                    // move the tape head to 51 seconds
                                    $("#narrationPlayer").jPlayer("pause", 88);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind the time so we can stop it after narration for this page is done.
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 130) {
                                            $(this).jPlayer("pause", 136);
                                        };
                                    });

                                    $(".xray-block").xray({ x_width: 50, x_height: 25 });
                                    $("#hideBackground").css('opacity', '0');
                                    $("#hideBackground").children().css('position', 'absolute');
                                    $("#hideBackground").children().css('left', '-400px');
                                    $("#hideBackground").css('z-index', '0');
                                    $("#nursePlayer").jPlayer("stop");
                                    // This hides the video on the next page - which seems to stick for some reason.
                                };


                                // Page 7-8 Scripts
                                if (opts.curr == 8) {

                                    $("#hideBackground").css('opacity', '1');
                                    $("#hideBackground").children().css('position', 'absolute');
                                    $("#hideBackground").children().css('left', '-100px');
                                    $("#hideBackground").css('z-index', '9999');
                                    $("#nursePlayer").jPlayer("play");
                                    $("#nursePlayer").jPlayer("stop");


                                    // This starts Doug's narration.  It is bound
                                    // to the timeupdate jPlayer event, so we 
                                    // know when to stop it.
                                    $("#narrationPlayer").jPlayer("play", 137);
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {

                                        // At 20 seconds into the narration...
                                        if (event.jPlayer.status.currentTime > 191) {

                                            // Pause it and move the tapehead on 
                                            // Doug's narration to 27 seconds...
                                            $(this).jPlayer("pause", 198);

                                            // And start Sister Anna's animation
                                            $("#nursePlayer").jPlayer("play");
                                            // Bind the timeupdate jPlayer event to 
                                            // Sister Anna's animation
                                            $("#nursePlayer").bind($.jPlayer.event.timeupdate, function (event2) {
                                                // At 27 seconds into Sister Anna's animation....
                                                if (event2.jPlayer.status.currentTime > 27) {
                                                    // Pause it...
                                                    $(this).jPlayer("pause");
                                                }
                                            });

                                        }



                                    });

                                };

                                // Page 9-10 Scripts
                                if (opts.curr == 10) {

                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 198);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind the time so we can stop it after narration for this page is done.
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 204) {
                                            $(this).jPlayer("pause", 210);
                                            $("#narrationPlayer").unbind();
                                            $("#narrationPlayer").jPlayer("play");
                                            $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                                if (event.jPlayer.status.currentTime > 204) {
                                                    $(this).jPlayer("pause", 237);
                                                };
                                            });
                                        };
                                    });

                                    $("#pharmPlayer").css('opacity', '0');
                                    $("#pharmPlayer").css('z-index', '1');
                                    $("#pharmPlayer").children().css('position', 'absolute');
                                    $("#pharmPlayer").children().css('left', '-400px');
                                    $("#pharmPlayer").jPlayer("stop");
                                };

                                // Page 11-12 Scripts
                                if (opts.curr == 12) {
                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 237);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 289) {
                                            $(this).jPlayer("pause", 290);
                                        };
                                    });

                                    $("#pharmPlayer").css('opacity', '1');
                                    $("#pharmPlayer").css('z-index', '9999');
                                    $("#pharmPlayer").children().css('left', '0px');
                                    $("#pharmPlayer").jPlayer("play");
                                };

                                // Page 13-14 Scripts
                                if (opts.curr == 14) {
                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 290);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 365) {
                                            $(this).jPlayer("pause", 367);
                                        };
                                    });

                                    $("#pharmPlayer").css('opacity', '0');
                                    $("#pharmPlayer").css('z-index', '1');
                                    $("#pharmPlayer").children().css('position', 'absolute');
                                    $("#pharmPlayer").children().css('left', '-400px');
                                    $("#pharmPlayer").jPlayer("stop");
                                };

                                // Page 15-16 Scripts
                                if (opts.curr == 16) {
                                    $('#stormBack').fadeOut();
                                    $('#stormBack').remove();

                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 367);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 385) {
                                            $(this).jPlayer("pause", 386);
                                        };
                                    });
                                }

                                // Page 17-18 scripts
                                if (opts.curr == 18) {

                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 386);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 430) {
                                            $(this).jPlayer("pause", 430);
                                        };
                                    });


                                    $('#stormBack').remove();
                                    $('form').append('<div id="stormBack" style="position:absolute;display:none;top:0px;z-index:-50;left:0px;height:100%;width:100%;"></div>');
                                    $('#stormBack').css('background-image', 'url(images/page_images/stormclouds.png)');
                                    $('#stormBack').fadeIn();
                                    $('#stormBack').pan({ fps: 20, speed: 2, dir: 'left' });
                                    new Rain('stormBack', {
                                        speed: 0,
                                        angle: 0,
                                        intensity: 0,
                                        size: 0,
                                        color: '#fff'
                                    });
                                    stopEvent();
                                };

                                // Page 19-20 Scripts
                                if (opts.curr == 20) {

                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 430);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 470) {
                                            $(this).jPlayer("pause", 470);
                                        };
                                    });

                                    $('#stormBack').remove();
                                    $('form').append('<div id="stormBack" style="position:absolute;display:none;top:0px;z-index:-50;left:0px;height:100%;width:100%;font-family:ms sans serif;font-size:25;color:white;"></div>');
                                    $('#stormBack').css('background-image', 'url(images/page_images/stormclouds.png)');
                                    $('#stormBack').fadeIn();
                                    $('#stormBack').pan({ fps: 30, speed: 2, dir: 'left' });

                                    if (!($.browser.msie)) {
                                        new Rain('stormBack', {
                                            speed: 500,
                                            angle: 20,
                                            intensity: 5,
                                            size: 10,
                                            color: '#fff'
                                        });
                                        strike_area.style.top = 80;
                                        strike_area.style.left = (document.body.offsetWidth / 2) - (parseInt(strike_area.style.width) / 2);
                                        strike("run");
                                    }
                                }

                                // Page 21-22 Scripts
                                if (opts.curr == 22) {
                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 470);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 505) {
                                            $(this).jPlayer("pause", 505);
                                        };
                                    });

                                    $('#stormBack').fadeOut();
                                    $('#stormBack').remove();
                                    stopEvent();
                                    $('#oldVideo').show();
                                    $('.sticker').remove();
                                }

                                // Page 23-24 Scripts
                                if (opts.curr == 24) {

                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 505);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 566) {
                                            $(this).jPlayer("pause", 569);
                                        };
                                    });


                                    $('#oldVideo').hide();
                                    $('form').append('<img class="sticker" alt="First Sticker" src="Images/page_images/sticker1.png" style="z-index: 50000; position: absolute; top: 54px;">');
                                    $('form').append('<img class="sticker" alt="First Sticker" src="Images/page_images/sticker2.png" style="z-index: 50000; position: absolute; top: 204px;">');
                                    $('form').append('<img class="sticker" alt="First Sticker" src="Images/page_images/sticker3.png" style="z-index: 50000; position: absolute; top: 504px; left:400px;">');
                                    $('form').append('<img class="sticker" alt="First Sticker" src="Images/page_images/sticker4.png" style="z-index: 50000; position: absolute; top: 604px; left:500px;">');


                                    var imgNo = 1;
                                    $(".sticker").draggable({ snap: "#outline" });
                                    $(".sticker").bind("dragstop", function (event, ui) {
                                        var imageNo = new Array();
                                        imageNo[1] = $('#Piece1');
                                        imageNo[2] = $('#Piece2');
                                        imageNo[3] = $('#Piece3');
                                        imageNo[4] = $('#Piece4');
                                        var left = $(this).css("left");
                                        var leftInt = parseInt(left, 10);
                                        var top = $(this).css("top");
                                        var topInt = parseInt(top, 10);

                                        if ((leftInt > 741) && (topInt > 102) && (leftInt < 983) && (topInt < 276)) {
                                            $(this).hide();
                                            imageNo[imgNo].fadeIn();

                                            if (imgNo == 4) {
                                                $('#outline').hide();
                                                $('#instr1').fadeOut();
                                                $('#instr2').fadeIn();
                                            }
                                            imgNo++;
                                        }



                                    });

                                }

                                // Page 25-26 Scripts
                                if (opts.curr == 26) {

                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 569);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 635) {
                                            $(this).jPlayer("pause", 636);
                                        };
                                    });

                                    $('.sticker').remove();
                                }


                                // Page 27-28 Scripts
                                if (opts.curr == 28) {

                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 636);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 680) {
                                            $(this).jPlayer("pause", 680);
                                        };
                                    });
                                }


                                // Page 29-30 Scripts
                                if (opts.curr == 30) {
                                    // Stop the narration, 
                                    // move the tape head to 198 seconds
                                    $("#narrationPlayer").jPlayer("pause", 680);

                                    // Play the narration
                                    $("#narrationPlayer").jPlayer("play");

                                    // Bind an event to the narration that checks the current time
                                    // and if that time equals the stop time, stop 
                                    // the narration and move the tapehead to the next page start
                                    $("#narrationPlayer").bind($.jPlayer.event.timeupdate, function (event) {
                                        if (event.jPlayer.status.currentTime > 684) {
                                            $(this).jPlayer("pause", 724);
                                        };
                                    });
                                }

                            }
                            // callback invoked after each page turn animation
                        });
                    }
                }).attr('src', source);
            });



            // If the intro hasn't been shown and this is the first page.
            if ((showIntro == true) && (page[1] == 1 || (typeof page != 'undefined'))) {
                // hide the book and show the intro
                $('#historyBook').hide();
                $('#introduction').show();
            };


            // If the user chooses audio from the intro
            $('#introAudioOn').click(function () {
                showIntro = false;

                $('#introduction').fadeOut('slow', function () {
                    $('#historyBook').fadeIn('slow');
                });

                $("#effectsPlayer").jPlayer("play");
            });


            // This controls whether an event is shown on timeline, if it is hovered over
            $(".timeline-event").hover(
                function () {
                    $(this).children().show();
                },
                function () {
                    $(this).children().hide();
                }
            );


            // This makes the cursor on the timeline draggable
            //$("#timelineCursor").draggable({ axis: "x", containment: "#timeline", scroll: true, snap: ".timeline-event", snapMode: "inner", snapTolerance: "40" });
            $("#timelineCursor").draggable({ axis: "x", containment: "#timeline" });


            //This checks the position of the cursor when it stops on the timeline, and turns the page to that cursor when it stops.
            $("#timelineCursor").bind("dragstop", function (event, ui) {
                var turnPage = false;
                var left = $("#timelineCursor").css("left");
                var leftInt = parseInt(left, 10);
                var locationArray = [-1124, -1047, -870, -778, -693, -617, -541, -467, -382, -247, -72, 32, 129, 222, 299, 396, 508, 581, 667, 743, 817, 891, 1000, 1112, 1258, 1333, 1408, 1483, 1558, 1634, 1692];
                //$('#count').append(leftInt + ",");
                jQuery.each(locationArray, function (index, leftBound) {
                    rightBound = leftBound + 35;
                    if ((leftInt > leftBound) && (leftInt < rightBound)) {
                        pageNum = index;
                        turnPage = true;

                    }
                });
                if (turnPage == true) {
                    $('#mybook').booklet(pageNum + 2);
                };
            });



        });


        // This is the fadeOut function, which
        // makes narrationPlayer fade out instead of 
        // stopping abruptely.  
        var vol = 1;
        function narrationFadeOut() {
            if (vol > 0) {
                $("#effectsPlayer").jPlayer("volume", vol);
                t = setTimeout("narrationFadeOut()", 500);
                vol = vol - .1;
            } else {
                clearTimeout(t);
                $("#effectsPlayer").jPlayer("stop");
                vol = 1;
            }
        } 




    </script>

    <link href="jquery.booklet.1.1.0.css" rel="stylesheet" type="text/css" />
    <link href="jquery.jqpuzzle.css" rel="Stylesheet" type="text/css" />
    <link href="HistoryBookStyle.css" rel="stylesheet" type="text/css" />
    <link href="rain.css" rel="stylesheet" type="text/css" />
</head>

<body>
<span id="holder"></span>
    <form method="post" action="HistoryBook.aspx">

    

    <div class="aspNetHidden">
        <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTA1NDkzNTkwMmRkTXYEAuysTYdc27do6HDuJ8w16IKtdRoNG+OmOkrAsm0=" />
    </div>

    <div id="introduction" style="width:800px;height:500px;padding:30px;margin-left:auto;margin-right:auto;display:none;background-color:Gray;">
        <h1>Salem Hospital - A History of Service</h1>
        <p>Welcome to Salem Hospital - A History of Service.  This presentation is a visual and audio based
           multimedia experience, that tells the story of Salem Hospital since our inception in 1896.  </p>
        <p>As this presentation depends on some of the latest features and functions of new technology,
           we strongly suggest using an up to date browser.  While we have worked to insure a cross-compatible 
           experence across all browsers, certain special effects will only work in modern browsers.  We strongly
           suggest using the Google Chrome or Internet Explorer 9 while viewing this presentation.</p>
        <p>This presentation tells the story of the history of Salem Hospital using a number of audio effects
           to provide context.  We strongly suggest viewing this presentation with audio turned on.  Please note
           that audio can be turned off at any point during the presentation.</p>
        <div style="float:left;margin-left:200px;font-size:x-large;border:1px solid black;" id="introAudioOn">Start with Audio On</div>
        <div style="float:right;margin-right:200px;font-size:x-large;border:1px solid black;" id="introAudioOff">Start with Audio Off</div>
    </div>

    <div id="historyBook">
        <div class="book_wrapper">

        <!-- morsePlay, hideBackground, and pharmPlayer are 3 jplayer divs
        that have to be placed here.  This keeps them inside the book wrapper,
        but keeps them from sliding around when the user changes resolution or
        changes window size.  The flash divs cannot be hidden, because it crashes
        jPlayer.  Therefore, we give them opacity:0 and use overflow:hidden on the
        divs.  There is JQuery above that moves all the children of the divs to the
        left whenever they are supposed to be hidden, that way they are covered
        up by the overflow:hidden until they are supposed to show on the proper page.-->

        <!-- This counts the positions of the pages on the timeline.  It gets
             commented out when it is not needed - it's just to help me with development.  -->
        <!-- <div id="count">Count: </div> -->

        <div id="morsePlay" style="overflow:hidden;width:84px;opacity:0;filter: alpha(opacity=0);-ms-filter:'progid:DXImageTransform.Microsoft.Alpha(Opacity=0)';height:132px;position:absolute;z-index:0;top:210px;left:300px;"></div>

        <div id="hideBackground" style="position:absolute;left:480px;top:330px;z-index:0;width: 134px;opacity:0;filter: alpha(opacity=0);-ms-filter:'progid:DXImageTransform.Microsoft.Alpha(Opacity=0)'; overflow: hidden; height: 180px; float: left; margin-top: -7px;">
            <div style="position: relative; left: -100px; top: -18px;">
                <div style="display:block;width: 331px;height: 245px;" id="nursePlayer"></div>
            </div>
        </div>

        <div id="pharmPlayer" style="overflow:hidden;opacity:0;filter: alpha(opacity=0);-ms-filter:'progid:DXImageTransform.Microsoft.Alpha(Opacity=0)';position:absolute;left:495px;top:325px;z-index:0;display:block;width:300px;height:168px;"></div>

        <!-- This hidden div has the player for Doug's narration -->
        <div id="narrationPlayer" style="width:0px;height:0px;"></div>
        <div id="effectsPlayer" style="width:0px;height:0px;"></div>


        <a id="next_page_button"></a>
        <a id="prev_page_button"></a>

        <div id="loading" class="loading">Loading pages...</div>

            <div id="mybook">
                <div class="b-load">

                    <!-- The Cover -->
                    <div style="padding:30px;padding-left:45px;">


                        <div class="hoverDiv" style="margin-right:auto;margin-left:auto;">
                            <img src="Images/page_images/cover2.png" id="coverImageA" alt="Salem Hospital in 1899" />
                            <img src="Images/page_images/cover.png" id="coverImageB" alt="Salem Hospital in 2011" />
                        </div>

                        <h1 id="coverTitle" style="font-size:60px;margin:0px;height:80px;color:#a08341;text-align:center;">Salem Hospital</h1>
                        <h2 id="coverSubTitle" style="color:#a08341;text-align:center;">A History of Service</h2>

                        <script type="text/javascript">
                            $("#coverImageA").hover(
                            function () {
                                $(this).stop().animate({ "opacity": "0" }, "slow");
                            },
                            function () {
                                $(this).stop().animate({ "opacity": "1" }, "slow");
                            });
                        </script>

                    </div>

                    <!-- Page 1 - Each page will look like the one in this div -->
                    <div style="padding:30px;">
                        <p>It was 1896</p>
                        <p>Salem needed a hospital, and medical students at Willamette 
                           University needed a place to observe physicians at work.</p>
                        <div style="float:right;width:100px;margin-top:150px;">
                            <!-- The video of Dr. Morse is here -->
                            <p style="font-size:x-small">Dr. Willis B. Morse (above), was one of the founding physicians of Salem Hospital</p>
                        </div>
                        <p>An agreement was drawn up by leading citizens and four local citizens, establishing Salem Hospital.</p>                     
                        <p>Founded with a pioneering spirit, the hospital's resources included:</p>
                        <ul>
                            <li>5 beds</li>
                            <li>$752 in citizen donations</li>
                            <li>2 Nurses</li>
                            <li>1 Superintendant</li>
                            <li>1 Medical student (who served as house physician and janitor)</li>
                        </ul>                       
                    </div>

                    <!-- Page 2 -->
                    <div style="padding:30px;">
                        <p>However humble the first Salem Hospital's efforts were, the seeds were planted for future success caring for our communities sick...</p>
                        <img src="Images/page_images/cover2.png" alt="Picture of State School for the Blind" style="width:240px;height:180px;margin-left:40px;" />
                        <p>Salem's first hospital took over the former state school for the blind, which sat on the corner of 12th and Ferry Streets.  Later in 1899, 
                        the hospital moved to the Glen Oaks Orphan's Home (above), a 10 acre site on what is now Center Street.</p>
                    </div>

                    <!-- Page 3 -->
                    <div style="padding:30px;">
                        <p>In 1916, a second hospital came to Salem.</p>
                        <p>
                            Franz Wedel led a Mennonite mission to Salem and founded Salem Deaconess hospital with a pledge to
                            minister to the physically ill and spiritually needy.  
                        </p>
                        <div style="width:220px;margin:50px;height:120px;" class="hoverDiv">
                            <img id="franz1" src="Images/page_images/franz1.png" alt="An empty old photograph with no people" />
                            <img id="franz2" src="Images/page_images/franz2.png" alt="Sister Marie Wedel" />
                            <img id="franz3" src="Images/page_images/franz3.png" alt="Sister Martha Wedel" />
                            <img id="franz4" src="Images/page_images/franz4.png" alt="Sister Marie Deurksen" />
                            <img id="franz5" src="Images/page_images/franz5.png" alt="Sister Anna Deurksen" />
                            <img id="franz6" src="Images/page_images/franz6.png" alt="Franz Wedel" />
                            <script type="text/javascript">
                                $('#franz1').mouseover(function () {
                                    $(this).stop().animate({ "opacity": "0" }, 1300, function () {
                                        $('#franz2').stop().animate({ "opacity": "0" }, 1300, function () {
                                            $('#franz3').stop().animate({ "opacity": "0" }, 1300, function () {
                                                $('#franz4').stop().animate({ "opacity": "0" }, 1300, function () {
                                                    $('#franz5').stop().animate({ "opacity": "0" }, 1300);
                                                });
                                            });
                                        });
                                    });
                                });
                            </script>
                        </div>
                        <p style="font-size:x-small;width:220px;margin-left:auto;margin-right:auto;">Franz Wedel and four Mennonite daconesses - sister Marie Wedel, Sister Martha Wedel, Sister Marie Duerksen, and Sister Anna Duerksen</p>
                    </div>

                    <!-- Page 4 -->
                    <div style="padding:30px;">
                        <p id="deaconessCaption" style="font-size:x-small;width:300px;margin-left:auto;margin-right:auto;">The former Capitol Hotel became Salem Deaconess Hospital in 1916.</p>
                        <img id="oldDeaconess" class="jqPuzzle" alt="The former Capitol Hotel became Salem Deaconess Hospital in 1916" src="Images/page_images/salemdeaconess1918.jpg" style="width:320px;height:200px;" />
                        <p id="deaconessStory">
                            They purchased the former Capital Hotel at 665 Winter Street for $10,000. Expansion came quickly at the deaconess.  A frame addition increased capacity to 20 beds in 1918. 
                        </p>
                        <p id="deaconessStory2" style="display:none;">
                            That building stood for the next 48 years.
                        </p>
                    </div>

                    <!-- Page 5 -->
                    <div style="padding:30px;">
                            <div class="xray-block" style="float:left;width:189px;">
                                <img src="Images/page_images/X-ray.png" style="width:189px;height:325px;" alt="1950's XRay"/>
                                <img src="Images/page_images/X-ray2.png"  style="width:189px;height:325px;" alt="Secret XRay version of 1950s XRay Picture with hidden Nurse Standing besides it."/>
                            </div>
                            <div style="float:right;width:125px;margin-top:-15px;">
                            <p>Salem Hospital installed it's first X-ray machine in 1924.</p>
                            <p>Since then, we've invested in technology of all kinds that help us seen inside the body, including:</p>
                            <ul>
                                <li>Improved X-Ray</li>
                                <li>MRI</li>
                                <li>Ultrasound</li>
                                <li>Catheter Cameras</li>
                                <li>Endoscopes</li>
                                <li>and more!</li>
                            </ul>
                            </div>
                    </div>

                    <!-- Page 6 -->
                    <div style="padding:25px;">
                        <img src="Images/page_images/Old-lab.png" style="margin-left:30px;" alt="First Lab Technician in 1925" />
                        <p id="labCaption" style="font-size:x-small;width:220px;margin-left:auto;margin-right:auto;">We hired out first lab 
                        technician in 1925.  Today the lab employs 191 people and can conduct more than 700 tests using the 
                        latest technology.</p>
                        <!--[if IE 7]>
                        <script type="text/javascript">
                            $('#labCaption').css('margin-top','0px');
                        </script>
                        <![endif]-->
                        <p>In 1925, Salem Hospital hired its first laboratory technician, and its first anesthetist.</p>
                        <p>No longer could physicians and nurses be expected to do everything involved in patient care.</p>
                        <p>The age of specialized medicine had begun.</p>
                    </div>

                    <!-- Page 7 -->
                    <div style="padding:25px;"> 
                        <p>Salem Hospital struggled financially in the 1920's.  The hospital negotiated 
                        for permission to obtain a mortgage - and in 1923, the $120,000 facility was reopened.</p>
                        <p>Physicians still found the building to be too small to provide adequate care for patients.  </p>
                        <p>In 1926, Salem Hospital borrowed another $100,000, and with that was able to build a new facility with 59 
                        medical-surgical beds - and 16 maternity beds.</p>
                        <img src="Images/page_images/General-Hospital-18.png" style="margin-left:60px;width:215px;margin-top:-15px;" alt="Salem General Hospital - 1920" />
                        <p style="margin-top:5px;font-size:x-small;width:320px;margin-left:auto;margin-right:auto;">During the 1920s, Salem Hospital Expanded to 56 beds.  The Regional Rehabilitation Center still occupies the Center Street location.</p>
                    </div>

                    <!-- Page 8 -->
                    <div style="padding:25px;"> 
                        <img src="Images/page_images/2nd-grad-class.jpg" style="margin-left: 90px;width: 155px;" alt="Nurses from Salem Hospital's second graduating class, circa 1900" />
                        <p style="font-size:x-small;width:320px;margin-left:auto;margin-right:auto;margin-top:-2px;">Nurses from Salem Hospital's second graduating class, circa 1900</p>
                        <p>The 1926 addition was followed by a name change in 1927.  Salem Hospital declared itself to be Salem General Hospital to avoid confusion with Oregon State Hospital</p>
                        <!-- The video of Sister Ann Duerksen is here.  It's positioned absolutely, at the 
                             top of this html under the form tag -->
                        <p style="font-size:x-small;width:180px;float:right;margin-top:-10px;">One of the original founders, Sister Anna Duerksen (above) helped convert the Capitol Hotel in Salem Deaconess Hospital in 1916.  
                        She dedicated her life to caring for the needy, and recieved no salary until the advent of Social Security.  She worked and volunteered at the hospital until her death in 1972 at age 86.
                        </p>
                    </div>

                    <!-- Page 9 -->
                    <div style="padding:25px;"> 
                        <img id="auxillary" src="Images/page_images/IMG_1180.jpg" style="width:40%;border-style:solid;border-color:white;z-index:0;position:absolute;" alt="Auxillary staff member Mary Lou Hewitt, 76, is a retired nurse who worked the Auxiliary's TELE-CARE line." />
                        <p id="auxillarycaption" style="font-size:x-small;width:255px;margin-top:200px;margin-left:15px;position:absolute;z-index:0;margin-left:15px;display:none;">Since 1929, Auxiliary
                        members have volunteered their time to help patients, families, and staff.  Auxiliary staff member Mary Lou Hewitt, 76,
                        in this 2004 photo, is a retired nurse who worked the Auxiliary's TELE-CARE line, contacting people who live alone and
                        may need assistance.  The Auxiliary started the program in the mid-1980s.</p>
                        <p style="width:156px;float:right;">1929 - Auxiliary established as volunteer and fundraising group.</p>
                        <br />
                        <img id="highfeverfollies" src="Images/page_images/Follies-Group.jpg" style="width:160px;border-style:solid;border-color:white;height:111px;position: absolute;top: 150px;left: 205px;" alt="The High Fever Follies were major Auxiliary fundraisers and social events" />
                        <p id="highfeverfolliescaptions" style="font-size:x-small;width:240px;margin-top:300px;position:absolute;z-index:0;margin-left:32px;display:none;">Since 1929, Auxiliary
                        members have volunteered their time to help patients, families, and staff.  Auxiliary staff member Mary Lou Hewitt, 76,
                        in this 2004 photo, is a retired nurse who worked the Auxiliary's TELE-CARE line, contacting people who live alone and
                        may need assistance.  The Auxiliary started the program in the mid-1980s.</p>
                        <br />
                        <img id="rollinhaag" src="Images/page_images/Plaid-man-giving-checks.jpg" style="border-style:solid;border-color:white;width:132px;position:absolute;height:170px;margin-top:200px;" alt="In 1973 Rollin W. Haag gave $500 Foundation scholarships to these eager hospital staff members." />
                        <p id="rollinhaagcaption" style="font-size:x-small;width:250px;margin-top:280px;position:absolute;margin-left:15px;display:none;">It was 1973 when Rollin W. Haag (left), Trustee and major hospital supporter, 
                        gave $500 Foundation scholarships to these eager hospital staff members.  <br /><br /> Established in 1967, the Salem Hospital Foundation has raised money to help fund hospital projects
                        and the education of its workforce.</p>
                        <script type="text/javascript">

                            $("img#highfeverfollies").hover(
                                function () {
                                    
                                    // Make the picture appear on top of everything else
                                    $(this).css('z-index', '500');

                                    // This is necessary to fade in the caption in IE7
                                    if ($.browser.msie) {
                                        if (parseInt($.browser.version, 10) == 7) {
                                            $("p#highfeverfolliescaptions").show();
                                            $("p#highfeverfolliescaptions").css('z-index', '500');
                                        };
                                    }

                                    // Animate the picture to make grow
                                    $(this).animate({
                                        'width': '250px',
                                        'height': '174px',
                                        'z-index': '500',
                                        'left': '45px',
                                        borderLeftWidth: '15px',
                                        borderRightWidth: '15px',
                                        borderTopWidth: '15px',
                                        borderBottomWidth: '120px'
                                    }, {
                                        queue: false,
                                        duration: 500,
                                        complete: function () {
                                            // At the end of the animation, fade
                                            // in the caption and make it appear on top of
                                            // the picture.  NOTE: This only works in IE9
                                            // and Chrome browsers
                                            $("p#highfeverfolliescaptions").show();
                                            $("p#highfeverfolliescaptions").css('z-index', '500');
                                        }
                                    });
                                },
                                function () {
                                    // Put the picture behind everything else again
                                    $(this).css('z-index', '0');
                                    $("p#highfeverfolliescaptions").fadeOut(500, function () {
                                        // Animate the picture to shrink back to normal
                                        $("img#highfeverfollies").animate({
                                            'width': '170px',
                                            'height': '132px',
                                            'left': '205px',
                                            borderLeftWidth: '3px',
                                            borderRightWidth: '3px',
                                            borderTopWidth: '3px',
                                            borderBottomWidth: '3px'
                                        }, {
                                            queue: false,
                                            duration: 500,
                                            complete: function () {
                                                // When it's complete, fade out the caption
                                                $("p#highfeverfolliescaptions").fadeOut();
                                                $("p#highfeverfolliescaptions").css('z-index', '0');
                                            }
                                        });
                                    });
                                }
                            );

                            $("img#auxillary").hover(
                                function () {
                                    // Make the picture appear on top of everything else
                                    $(this).css('z-index', '500');

                                    // This is necessary to fade in the caption in IE7
                                    if ($.browser.msie) {
                                        if (parseInt($.browser.version, 10) == 7) {
                                            $("p#auxillarycaption").show();
                                            $("p#auxillarycaption").css('z-index', '500');
                                        };
                                    }

                                    // Animate the picture to make grow
                                    $(this).animate({
                                        'width': '250px',
                                        'height': '174px',
                                        'z-index': '500',
                                        borderLeftWidth: '15px',
                                        borderRightWidth: '15px',
                                        borderTopWidth: '15px',
                                        borderBottomWidth: '115px'
                                    }, {
                                        queue: false,
                                        duration: 500,
                                        complete: function () {
                                            // At the end of the animation, fade
                                            // in the caption and make it appear on top of
                                            // the picture.  NOTE: This only works in IE9
                                            // and Chrome browsers
                                            $("p#auxillarycaption").css('z-index', '500');
                                            $("p#auxillarycaption").fadeIn();
                                        }
                                    }
                                    );

                                },
                                function () {
                                    $(this).css('z-index', '0');
                                    $("p#auxillarycaption").fadeOut(500, function () {
                                        $("img#auxillary").animate({
                                            'width': '132px',
                                            'height': '91px',
                                            //'z-index': '0',
                                            borderLeftWidth: '3px',
                                            borderRightWidth: '3px',
                                            borderTopWidth: '3px',
                                            borderBottomWidth: '3px'
                                        }, {
                                            queue: false,
                                            duration: 500,
                                            complete: function () {
                                                $("p#auxillarycaption").css('z-index', '0');
                                                $("p#auxillarycaption").fadeOut();
                                            }
                                        });
                                    });
                                }
                            );


                            $("img#rollinhaag").hover(

                                function () {
                                    // Make the picture appear on top of everything else
                                    $(this).css('z-index', '500');

                                    // This is necessary to fade in the caption in IE7
                                    if ($.browser.msie) {
                                        if (parseInt($.browser.version, 10) == 7) {
                                            $("p#rollinhaagcaption").show();
                                            $("p#rollinhaagcaption").css('z-index', '500');
                                        };
                                    }
                                    // Animate the picture to make grow
                                    $(this).animate({
                                        'width': '260px',
                                        'height': '322px',
                                        'margin-top': '-65px',
                                        borderLeftWidth: '15px',
                                        borderRightWidth: '15px',
                                        borderTopWidth: '15px',
                                        borderBottomWidth: '110px'
                                    }, {
                                        queue: false,
                                        duration: 500,
                                        complete: function () {
                                            // At the end of the animation, fade
                                            // in the caption and make it appear on top of
                                            // the picture.  NOTE: This only works in IE9
                                            // and Chrome browsers
                                            $("p#rollinhaagcaption").css('z-index', '500');
                                            $("p#rollinhaagcaption").fadeIn();
                                        }
                                    }
                                    );

                                },
                                function () {
                                    $(this).css('z-index', '0');
                                    $("p#rollinhaagcaption").fadeOut(500, function () {
                                        $("img#rollinhaag").animate({
                                            'width': '132px',
                                            'height': '170px',
                                            'margin-top': '200px',
                                            //'z-index': '0',
                                            borderLeftWidth: '3px',
                                            borderRightWidth: '3px',
                                            borderTopWidth: '3px',
                                            borderBottomWidth: '3px'
                                        }, {
                                            queue: false,
                                            duration: 500,
                                            complete: function () {
                                                $("p#rollinhaagcaption").css('z-index', '0');
                                                $("p#rollinhaagcaption").fadeOut();
                                            }
                                        });
                                    });
                                }
                            );
                        </script>
                    </div>

                    <!-- Page 10 -->
                    <div style="padding:25px;"> 
                        <img src="Images/page_images/Salem-Deaconess-1935.png" style="margin-left:60px;width:215px;" alt="Salem Deaconess Hospital - 1931" />
                        <p style="font-size:x-small;width:320px;margin-left:auto;margin-right:auto;margin-top:-3px;">A 40 bed wing of built of bricks from the donated Newburg hotel increased the Salem Deaconess capacity to 100 beds</p>
                        <p style="width:350px;">Upon Franz Wedel's death in 1931, his son, Frank Wedel was elected manager.  The great depression weighed heavily on both hospitals over the next decade.  Despite this, both hospital's continued 
                        to grow - with the Salem Deaconess expanding to 100 beds in 1936.</p>
                        <div style="width:155px;height:115px;margin-top:-5px;z-index:50000;overflow:hidden;position:relative;">
                            <img id="wedelclan" src="Images/page_images/Wedel-clan.jpg" style="width:155px;height:115px;position:relative;" alt="The Wedel Clan" />
                        </div>
                        <p style="font-size:x-small;width:165px;float:right;margin-top:-115px;">This 1924 family photo shows three generations of the Wedel clan.  Franz (upper left), Frank (back row, third from right), and Irwin (first row, last child to the right).  From grandfather to father to son, these three led the hospital's growth from 1916 to 1979.</p>
                        <script type="text/javascript">
                            $("img#wedelclan").mouseover(function () {
                                $(this).animate({
                                    'width': '600px',
                                    'height': '461px'
                                }, {
                                    queue: true,
                                    duartion: 1500,
                                    complete: function () {
                                        $(this).animate({
                                            'right': '350px',
                                            'top': '-60px'
                                        }, {
                                            queue: true,
                                            duration: 1500,
                                            complete: function () {
                                                $(this).animate({
                                                    'right': '350px',
                                                    'top': '-230px'
                                                });
                                            }
                                        });
                                    }
                                });
                            });
                            $("img#wedelclan").mouseout(function () {
                                $(this).clearQueue();
                                $(this).stop();
                                wedelPos = $(this).position();
                                wedelLeft = wedelPos.left;
                                wedelTop = wedelPos.top;
                                $(this).animate({
                                    right: (wedelPos.left + -wedelLeft) + 'px',
                                    top: (wedelPos.top + -wedelTop) + 'px',
                                    'width': '155px', 'height': '115px'
                                }, 1500);
                                
                            });
                        </script>
                    </div>

                    <!-- Page 11 -->
                    <div style="padding:25px;"> 
                        <p>Finances became less of a problem as World War II approached.  The annual patient population at Deaconess increased from
                        963 in 1963, to 4,458 in 1940.</p>
                        <p>Staffing was more of a concern through World War II, because so many doctors and nurses went to way.  Those who stayed 
                        on the homefront worked double shifts.</p>
                        <img id="salemmemorial" src="Images/page_images/salemmemorial.jpg" style="border-style:solid;border-color:white;width:170px;position:absolute;top:325px;margin-left:75px;" alt="Salem Memorial Hospital - 1940" />
                        <p id="salemmemorialcaption" style="font-size:x-small;width:320px;top:375px;left:50px;margin-left:auto;margin-right:auto;display:none;position:absolute;">
                            In 1947, Mennonites relinquished control of the Deaconess to the City of Salem, and it was renamed Salem Memorial Hospital.
                        </p>
                        <p>
                            After the war, Deaconess struggled financially to continue it's mission of not only treating sick persons, but providing shelter for 
                            the elderly and ministering to deliquent youth and homeless as well. 
                        </p>
                        <script type="text/javascript">
                            $("img#salemmemorial").hover(
                                function () {
                                    $(this).css('z-index', '500');
                                    $(this).animate({
                                        'width': '323px',
                                        'height': '231px',
                                        'margin-left': '0px',
                                        'top': '125px',
                                        borderLeftWidth: '15px',
                                        borderRightWidth: '15px',
                                        borderTopWidth: '15px',
                                        borderBottomWidth: '50px'
                                    }, {
                                        queue: false,
                                        duration: 500,
                                        complete: function () {
                                            $("p#salemmemorialcaption").css('z-index', '500');
                                            $("p#salemmemorialcaption").fadeIn();
                                        }
                                    }
                                    );

                                },
                                function () {
                                    $(this).css('z-index', '0');
                                    $("p#salemmemorialcaption").fadeOut(500, function () {
                                        $("img#salemmemorial").animate({
                                            'width': '170px',
                                            'height': '121px',
                                            'top': '325px',
                                            'margin-left': '75px',
                                            //'z-index': '0',
                                            borderLeftWidth: '3px',
                                            borderRightWidth: '3px',
                                            borderTopWidth: '3px',
                                            borderBottomWidth: '3px'
                                        }, {
                                            queue: false,
                                            duration: 500,
                                            complete: function () {
                                                $("p#salemmemorialcaption").fadeOut();
                                            }
                                        });
                                    });
                                }
                            );
                            </script>
                    </div>

                    <!-- Page 12 -->
                    <div style="padding:25px;"> 
                        <img style="margin-left:auto;margin-right:auto;display:block;" src="Images/page_images/1920s-Drug-case-trans.png" alt="This image shows a drug case from the 1920's" />
                        <p id="P1" style="font-size:x-small;width:320px;margin-left:auto;margin-right:auto;">
                            This image shows a drug case from the 1920's
                        </p>
                        <p>In 1951 the first hospital-based pharmacist was hired.  Today our pharmacists's are assisted by robot technology to disperse medication.</p>


                    </div>

                    <!-- Page 13 -->
                    <div style="padding:25px;"> 
                        <p>Patient amenities were not introduced in either hospital until the 1950's.  Television was installed hospital rooms in 1954.
                        The first air conditioning appeared in 1955.  Population growth brought not only more potential patients, but more physicians.  Salem General staff grew from 47 to 77.</p>
                        
                        <div style="width:200px;height:126px;margin-left:auto;margin-right:auto;" class="hoverDiv">
                            <img id="wedel1" style="width:200px;height:126px;" src="Images/page_images/wedelkid.jpg" alt="A young Irwin Wedel" />
                            <img id="wedel2" style="width:200px;height:126px;" src="Images/page_images/wedeladult.jpg" alt="Irwin Wedel grows up to lead Salem Memorial Hospital" />
                            <script type="text/javascript">
                                $('#wedel1').hover(
                                    function () {
                                        $(this).stop().animate({ "opacity": "0" }, 1300, function () { });
                                    },
                                    function () {
                                        $(this).stop().animate({ "opacity": "1" }, 1300, function () { });
                                    }
                                );
                            </script>
                        </div>

                        <p id="P2" style="font-size:x-small;width:320px;margin-left:auto;margin-right:auto;position:relative;margin-top:2px;">
                            Irwin Wedel literally grew up at Salem Hospital, and spent his entire life creating his Salem Hospital family.  
                            He led a struggling Salem Memorial Hospital toward becoming a thriving community asset.
                        </p>
                        <p>
                            Meanwhile, Memorial also had embarked on a construction program in 1953, investing $323,135 in a 42-bed addition - bring their
                            capacity to 147 beds.
                        </p>
                    </div>

                    <!-- Page 14 -->
                    <div style="padding:25px;"> 
                        <p>At the same time, Salem General expanded by completing it's Morse building.  General broke ground in May, 1953, for the first building in its plan: a 68-bed, $384,566 
                           structure that was connect to the 1924 hospital by a temporary tunnel.</p>
                        <p>The building was named for Dr. Willis B. Morse, one of the founders of Salem General, who left behind the bulk of his estate, $130,000, to the hospital he helped create.</p>
                        <div style="width:290px;height:184px;margin-left:20px;" class="hoverDiv">    
                            <img id="morseGround1" style="width:290px;height:184px;" src="Images/page_images/ground1.png" alt="Ground is preparing to be broken on the Morse Building" />
                            <img id="morseGround2" style="width:290px;height:184px;" src="Images/page_images/ground2.png" alt="Ground is broken on the Morse Building" />
                            <script type="text/javascript">
                                $('#morseGround1').hover(
                                    function () {
                                        $(this).stop().animate({ "opacity": "0" }, 1300, function () { });
                                    },
                                    function () {
                                        $(this).stop().animate({ "opacity": "1" }, 1300, function () { });
                                    }
                                );
                            </script>
                        </div>
                    </div>

                    <!-- Page 15 -->
                    <div style="padding:25px;">
                        <p>
                            In 1955, the first televisions were installed in patient rooms.
                        </p>
                        
                        <div style="position:relative;height:222px;width:260px;margin-left:-50px;margin-top:-220px;">
                            <div id="nextChannel" style="width:25px;height:25px;background-image:url(Images/page_images/dot.png);position:absolute;cursor:pointer;left:283px;top:441px;z-index:30;"></div>
                            <div id="prevChannel" style="width:25px;height:25px;background-image:url(Images/page_images/dot.png);position:absolute;cursor:pointer;left:109px;top:441px;z-index:30;">&nbsp;&nbsp;&nbsp;</div>
                            
                        <img id="television" src="Images/page_images/television.png" style="width:425px;position: absolute;left: 0;top: 0;z-index: 20;" alt="Television" />    
                            <div id="nurseDesc" style="font-size:x-small;z-index:30;position:absolute;width:220px;height:50px;top:472px;left:100px;">
                                Both Salem General and Salem Memorial took responsibility for training nurses.<br />
                                By the end of 1896, Salem Hospital had established its own nursing school assume trained staff.
                            </div>
                            <div style="width:225px;height:175px;position: absolute;left: 112px;top: 270px;overflow:hidden;">
                                <img id="tvPic" style="width:1525px;position:absolute;" src="Images/page_images/Nurses-Channel.jpg" alt="Six Different Channels on the Television" />
                            </div>
                        </div>
                        
                        <script type="text/javascript">

                            // This array holds the various values for descriptions of the channels in the tv
                            // and is used below.  
                            var myNurseDesc = new Array();
                            myNurseDesc[-110] = "Both Salem General and Salem Memorial took responsibility for training nurses.<br />" +
                                                "By the end of 1896, Salem Hospital had established its own nursing school assume trained staff.";
                            myNurseDesc[-220] = "Here we can see a picture of nurses from Salem Hospital's second graduating class, circa 1900";
                            myNurseDesc[-440] = "In the early days, training called for rigid standards.  This included not wearing makeup not " +
                                                "visiting their boyfriends more than twice a month.  <br />" +
                                                "Nurses were required to wear proper attire - white and stiffly strached uniforms and hats.";
                            myNurseDesc[-660] = "Although formal nursing school ended with the Depression, cooperative education with community " +
                                                "continued through the 1950's";
                            myNurseDesc[-880] = "Today Salem Hospital offers practical training of nurses through its education services department.";
                            myNurseDesc[-1100] = "We also partner with area high schools through our Career Exploration Program and with Chemeketa " +
                                                 "Community College";
                            myNurseDesc[-1320] = "Styles may change, but nursing at Salem Hospital remains focused on helping patients, families, and communities attain " +
                                                 "a healthy quality of life.";


                            $('#nextChannel').live('click', function () {
                                // Get the pposition of the image under the tv
                                tvPosition = $('#tvPic').position();
                                // Add 110 to the position to get the new position (the next channel)
                                newLeft = tvPosition.left - 110;
                                // Get the description of the channel from the array above,
                                // using the position as the index of the array.
                                $('#nurseDesc').html((myNurseDesc[newLeft]));
                                // As long as the image isn't all the way to the end
                                // Add the new channel.
                                if (newLeft > -1321) {
                                    $('#tvPic').css('left', newLeft + "px");
                                };
                            });
                            $('#prevChannel').live('click', function () {
                                tvPosition = $('#tvPic').position();
                                newLeft = tvPosition.left + 110;
                                $('#nurseDesc').html((myNurseDesc[newLeft]));
                                if (newLeft < 1) {
                                    $('#tvPic').css('left', newLeft + "px");
                                };
                            });
                        </script>
                    </div>

                    <!-- Page 16 -->
                    <div style="padding:25px;">
                        <p>In 1958, Salem Hospital added five new surgical rooms.  Surgical became less invasive as the years passed, reducing
                           post-operative pain, complications, and recovery time.</p>
                        <div style="width:290px;height:184px;margin-left:21px;" class="hoverDiv">    
                            <img class="imageFade1" style="width:290px;height:184px;" src="Images/page_images/surgery2.jpg" alt="Surgery in the 1920's" />
                            <p id="surgeryCap1" style="font-size:x-small;width:320px;margin-left:auto;margin-right:auto;position:absolute;top:200px;">
                                This image show a patient being prepped for surgery during the 1920's
                            </p>
                            <img class="imageFade2" style="width:290px;height:184px;" src="Images/page_images/surgery1.jpg" alt="Surgery in modern times" />
                            <p id="surgeryCap2" style="font-size:x-small;width:320px;margin-left:auto;margin-right:auto;position:absolute;top:200px;display:none;">
                                Surgeon Beth Dayton, MD, performs a laparoscopic cholecystectomy, or gall bladder removal, in 2005.  <br />
                                The ability to see inside the body is key to such minimally invasive surgery, and is possible with an 
                                endoscopic camera that delivers video to monitors.  
                            </p>
                            <script type="text/javascript">
                                $('.imageFade1').hover(
                                    function () {
                                        $(this).stop().animate({ "opacity": "0" }, 1300, function () { });
                                        $('#surgeryCap1').fadeOut();
                                        $('#surgeryCap2').fadeIn();
                                    },
                                    function () {
                                        $(this).stop().animate({ "opacity": "1" }, 1300, function () { });
                                        $('#surgeryCap2').fadeOut();
                                        $('#surgeryCap1').fadeIn();
                                    }
                                );
                            </script>
                        </div>
                    </div> 

                    <!-- Page 17 -->
                    <div style="padding:25px;">
                        <p>In 1962, the Salem was hit by one of the most powerful natural disasters to face the city - the Columbus Day Storm.  
                           Salem Memorial doctors continued working tirelessly, even as the lights went out and parts of 
                           the roof were torn away.  Dr. Bob Cooper was among those who courageously stayed behind to
                           work under emergency conditions at the hospital.</p>
                            <img alt="Dr. Cooper" style="margin-left:15px;" src="Images/page_images/drcooper.png" />
                    </div>

                    <!-- Page 18 -->
                    <div style="padding:25px;">
                        <img alt="Arial shot of Salem Hospital flooded in 1964" style="margin-left:15px;" src="Images/page_images/flood3.png" />
                        <p>Salem Hospital has experienced a few natural disasters over the last 100 years: The Columbus Day storm, two floods in 
                           1992 and 1996, and an ice storm in January 2004.  Staff came in all occasions to serve those in need.  </p>
                    </div>

                    <!-- Page 19 -->
                    <div style="padding:25px;">

                        <img alt="Volunteers assist as the hospital is flooded" style="margin-left:15px;" src="Images/page_images/flood1.png" />
                        <p>On Dec 23, 1964, Salem Memorial Hospital's basement was flooded to a depth of 7 feet, 
                            knocking out heating, power, and communication systems.  The National Guard was called 
                            out to help evacuate patients...</p>

                    </div>

                    <!-- Page 20 -->
                    <div style="padding:25px;">
                        
                        <img style="float:left;" alt="National Guard Soldier Rescuing Baby" src="Images/page_images/rescue.png" />
                        <p style="width:160px;float:right;">All 121 patients, including a woman in labor and an 
                        infant in an incubator, were evacuated in 90 minutes.  Blood transfusions and intravenous feeding
                        continued even as patients were removed.  Gov. Mark Hatfield and other state 
                        officials participated in the ecacuation.  </p>
                        <div style="clear:both;"></div>
                        <p style="width:50px;margin-top:25px;float:left;">So did many Salem residents.</p>
                        <img alt="Second picture of the hospital flood" style="float:right;margin-top:5px;" src="Images/page_images/flood2.png" />
                        <span id="strike_area" style="position: absolute; height: 300px; width: 375px; font-family: 'ms sans serif'; font-size: 25px; color: white; z-index: 0; top: 80px; left: 444.5px; ">
                        </span>
                    </div>

                    <!-- Page 21 -->
                    <div style="padding:25px;">
                        
                         <div style="width:250px;height:151px;margin-left:auto;margin-right:auto;" class="hoverDiv">    
                            <img class="imageFade1" style="width:250px;height:151px;" src="Images/page_images/computers.png" alt="The first computers in 1964." />
                            <p id="computer1" style="font-size:x-small;width:250px;margin-left:auto;margin-right:auto;position:absolute;top:150px;">
                                In 1966, the first computers were introducted to business operations at both Salem 
                                General and Salem Memorial Hospital.  
                            </p>
                            <img class="imageFade2" style="width:250px;height:151px;" src="Images/page_images/HelpDesk1.png" alt="Members of the Salem Hospital IS Team" />
                            <p id="computer2" style="font-size:x-small;width:350px;margin-left:-40px;position:absolute;top:150px;display:none;">
                                Modern computers changed the way we work.  Today they required a knowledgeable 
                                team of technicians to keep them running smoothly.  In November 2006, Salem Hospital went 
                                live with our EPIC project, followed by our MUSE project in May of 2011.  This gives us
                                a truly electronic patient record that will benefit patient safety.
                            </p>
                            <script type="text/javascript">
                                $('.imageFade1').hover(
                                    function () {
                                        $(this).stop().animate({ "opacity": "0" }, 1300, function () { });
                                        $('#computer1').fadeOut();
                                        $('#computer2').fadeIn();
                                    },
                                    function () {
                                        $(this).stop().animate({ "opacity": "1" }, 1300, function () { });
                                        $('#computer2').fadeOut();
                                        $('#computer1').fadeIn();
                                    }
                                );
                            </script>
                        </div>

                       <div id="oldVideo" style="width: 250px; height: 187px; overflow: hidden; display:none; margin-top: 90px; margin-left: auto; margin-right: auto;">
                            <iframe width="250" height="217" src="http://www.youtube.com/embed/t-aiKlIc6uk?rel=0" frameborder="0" style="  margin-bottom: -50px; overflow: hidden;"></iframe>
                       </div>
                    </div>
                    
                    <!-- Page 22 -->
                    <div style="padding:25px;">
                        <p>In 1967, the board of Salem General made a public announcement that it would create an 
                        addition to the Morse building to include all the facilities 
                        of the original 1924 general building, including Medical and Surgical beds, operating 
                        rooms and the emergency room.</p>
                        <p>Salem Memorial hospital also continued to charge forward.  After establishing the Salem 
                        Memorial Hospital Foundation in 1967, Memorial combined that with other sources of funding 
                        to build the Center Tower, with a capacity of 275 beds.</p>
                        <img alt="North Wing" src="Images/page_images/northwing.jpg" style="margin-left:auto;margin-right:auto;display:block;" />
                    </div>
                    
                    <!-- Page 23 -->
                    <div style="padding:25px;">
                        
                        <p>
                            In 1967, Salem General's board began considering some sort of join operation
                            with Memorial.  Discussions of a merger began, with some opposition by physicians 
                            at both hospitals, who wished the marketplace to remain competitive.
                        </p>
                        <p>
                            Salem General continued to be confronted with financial problems, and the board
                            became very serious about a possible General-Memorial merger.  By April of 1968, 
                            the commitees of both hospitals had three joint meetings.  Talks failed after 
                            Salem General requested half the seats on the new board, even though they were
                            only license for 110 beds, to Memorial's 265.
                        </p>
                        <p>
                            On Jan. 29, 1969, Salem General Hospital bowed to the inevitable, proposing a merged
                            hospital with a board that contained 10 members from Memorial and 5 members from General.  
                        </p>

                    </div>

                    <!-- Page 24 -->
                    <div style="padding:25px;">
                        

                        <p id="instr1" style="font-size:x-small;width:350px;margin-left:auto;margin-right:auto;position:absolute;top:315px;">
                            Please drag the pieces into the outline above to help complete the merger between Salem General and Salem
                            Memorial Hospital.
                        </p>
                        <p id="instr2" style="font-size:x-small;width:350px;margin-left:auto;margin-right:auto;position:absolute;top:315px;display:none;">
                            The corporate merger was completed on Oct. 1, 1969.  Stan Hammer, new Vice President, led
                            a minority group of dissenters in rallying to honor history by retaining one of the 
                            hospital's existing name.  The newly merged hospital was named "Salem Hospital".
                        </p>
                        <img alt="Merger without building" src="Images/page_images/merger1.png" />
                        <img id="outline" alt="Outline of puzzle piece for merger" src="Images/page_images/merger2.png" style="position:absolute;top:92px;left:197px;" />
                        <img id="Piece1" alt="First merger piece" src="Images/page_images/merger3.png" style="position:absolute;top:188px;left:201px;display:none;" />
                        <img id="Piece2" alt="Second merger piece" src="Images/page_images/merger4.png" style="position:absolute;top:132px;left:201px;display:none;" />
                        <img id="Piece3" alt="Third merger piece" src="Images/page_images/merger5.png" style="position:absolute;top:127px;left:201px;display:none;" />
                        <img id="Piece4" alt="Final merger piece" src="Images/page_images/merger6.png" style="position:absolute;top:97px;left:201px;display:none;" />

                    </div>

                    <!-- Page 25 -->
                    <div style="padding:25px;">
                        
                        <p>
                            The 1970's began a period of construction and expansions for the new Salem Hospital,
                            that would last for the next two decades.  In 1973, the first Oncologist joined Salem
                            Hospital.  In 1978 the South Tower was built.  Construction continued into the 1980's, 
                            when, in 1986, the North Tower was built.  This increased inpatient capacity to 
                            406 beds.  
                        </p>
                        <div style="width:250px;margin:40px;" class="hoverDiv">
                            <img id="building1" src="Images/page_images/build1.png" alt="The Original Tower" />
                            <img id="building2" src="Images/page_images/build2.png" alt="The North Tower" />
                            <img id="building3" src="Images/page_images/build3.png" alt="The South Tower" />
                            <img id="building4" src="Images/page_images/build4.png" alt="All towers in Modern Times" />
                            <script type="text/javascript">
                                $('#building1').mouseover(function () {
                                    $(this).stop().animate({ "opacity": "0" }, 3800, function () {
                                        $('#building2').stop().animate({ "opacity": "0" }, 3800, function () {
                                            $('#building3').stop().animate({ "opacity": "0" }, 1800);
                                        });
                                    });


                                });
                            </script>
                        </div>

                    </div>

                    <!-- Page 26 -->
                    <div style="padding:25px;">
                        <p>
                            The late 80's and early 90's provided some major advances in mental health
                            care for Salem Hospital.  In 1988, Salem Hospital's Phsychiatric Center was
                            opened.  In 1989 the old General Hospital Center Street building was extensively
                            remodeled to house the Regional Rehabilation Center.
                        </p>
                        <img style="width:235px;margin-left:50px;" alt="Regional Rehabilitation Center" src="Images/page_images/rehab.png" />
                        <p>
                            At the same time, Salem Hospital made great strides in medical care.  The 
                            first open heart surgery was performed at Salem Hospital.  This was followed by
                            the first laparoscopic cholecystectomy performed in 1989.
                        </p>
                    </div>

                    <!-- Page 27 -->
                    <div style="padding:25px;">
                        <p>
                            A rough winter hit the Salem area in 1996, followed by a deep freeze and 
                            large rainstorm.  The 1996 flood was not as bad as the 1964 flood.  This was 
                            mainly because of several dams on Willamette tributaries, and construction in 
                            1986 that raised the ground level of both Winter Street and the hospital 4.5 
                            feet.
                        </p>
                        <img id="floodCrop" style="margin-left:45px;" alt="Newspaper of the 1996 Flood" src="Images/page_images/floodcrop.png" />
                        <script type="text/javascript">
                            $('#floodCrop').bind('click', function () {
                                $('form').append('<img class="floodCropLarge" style="position: absolute; top: 0px; z-index: 9999; left: 115px;" alt="Newspaper of the 1996 Flood" src="Images/page_images/floodcrop_large.png" />');
                                $('.floodCropLarge').click(function () {
                                    $('.floodCropLarge').hide();
                                });
                            });
                        </script>
                    </div>
                    
                    <!-- Page 28 -->
                    <div style="padding:25px;">
                        <p>
                            As Salem Hospital entered the new millenium in 2000, the Center for Outpatient 
                            Medicine was opened.  In 2002 Salem Hospital purchased Valley Community Hospital 
                            in Dallas, and the facility was renamed West Valley Hospital.  
                        </p>
                        <img alt="West Valley Hospital" style="margin-left:45px;" src="Images/page_images/westvalley.png" />
                    </div>

                    <!-- Page 29 -->
                    <div style="padding:25px;">
                        <p>
                            Salem Hospital has always provided special care for mothers and babies.  In 2003, our
                            Family Birth Center was built, offering seven antepartum rooms, 12 birthing suites, and 
                            36 mother/baby rooms.  In 2004, Salem Hospital opened our Special Care Nursery which can
                            now accomdiate newborns as early as 26 weeks gestation.  
                        </p>
                        <div style="width:300px;height:230px;margin-left:15px;" class="hoverDiv">    
                            <img class="imageFade1" style="width:300px;height:230px;" src="Images/page_images/fbc1.png" alt="The Family Birth Center as it was being constructed." />
                            <p id="fbc1" style="font-size:x-small;width:250px;margin-left:auto;margin-right:auto;position:absolute;top:150px;">
                                In 1966, the first computers were introducted to business operations at both Salem 
                                General and Salem Memorial Hospital.  
                            </p>
                            <img class="imageFade2" style="width:300px;height:230px;" src="Images/page_images/fbc2.png" alt="The Family Birth Center after construction was complete." />
                            <p id="fbc2" style="font-size:x-small;width:250px;margin-left:auto;margin-right:auto;position:absolute;top:150px;display:none;">
                                Modern computers changed the way we work.  Today they required a knowledgeable 
                                team of technicians to keep them running smoothly.  In November 2006, Salem Hospital went 
                                live with our EPIC project, followed by our MUSE project in May of 2011.  This gives us
                                a truly electronic patient record that will benefit patient safety.
                            </p>
                            <script type="text/javascript">
                                $('.fbcFade1').hover(
                                    function () {
                                        $(this).stop().animate({ "opacity": "0" }, 1300, function () { });
                                    },
                                    function () {
                                        $(this).stop().animate({ "opacity": "1" }, 1300, function () { });
                                    }
                                );
                            </script>
                        </div>
                    </div>

                    <!-- Page 30 -->
                    <div style="padding:25px;">
                        <p>
                            In 2005, our OB Hospitalist program established 24-hour physician coverage at the FBC.  
                            Also, our Family Birth Center opened, offering quality care to women who cannot afford or 
                            are unable to access a physician for prenatal care or delivery.  
                        </p>
                    </div>

                    <!-- Page 30 -->
                    <div style="padding:25px;">
                        <p>
                            In 2005, our OB Hospitalist program established 24-hour physician coverage at the FBC.  
                            Also, our Family Birth Center opened, offering quality care to women who cannot afford or 
                            are unable to access a physician for prenatal care or delivery.  
                        </p>
                    </div>

                    <!-- the back cover -->
                    <div style="padding:30px;">

                    </div>

                </div>
            </div>         
        </div>



        <div id="timeline" style="width:740px;overflow:hidden;overflow-x:scroll;margin-left:auto;margin-right:auto;position:relative;">
            <div class="timelineScroll" runat="server" id="timelineScroll">

                <!-- The timeline events and cursor go here -->

            </div>                 

        </div>


        <div id="timelineScrollCover" style="width:500px;height:22px; display:none;margin-left:auto;margin-right:auto;position:relative; top: -20px; left: 0px;background: #CCC url(./images/wood.jpg) repeat 634px 322px;">

        </div>
    </div>

    </form>



</body>

</html>
