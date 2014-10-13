//****************************//

var stream_width        = 5;

var max_segments        = 40;

var max_segment_length  = 20;

var glow_color          = "#3399FF"

var fork_top            = 0;

//***************************//





var striker       = ""

var angle_holder  = new Array();

var length_holder = new Array();

length_holder[0]  = fork_top;

var temp          = length_holder[0];

var last_pos_x    = 0;

var last_pos_y    = 0;

var last_img      = "";

var mx;

var my;

dot = new Image();dot.src = "Images/page_images/dot.gif";



function strike(opt) {

    if (opt == "run") {

        with (Math) {

            disp = round((random() * 200))

            timer = round((random() * 1000))

            x = round((floor(random() * document.body.offsetWidth) - 30))

            seglen = round((random() * max_segment_length))

            length_holder[1] = round(((random() * 2) * seglen))

            for (a = 0; a < max_segments + 1; a++) { angle_holder[a] = round((random() * 4) - ((random() * 2) * 2)) }

            for (a = 1; a < max_segments + 1; a++) { length_holder[a] = round(length_holder[a - 1] + ((random() * 2) * seglen)) }

        }

        for (count = 0; count < max_segments + 1; count++) {

            for (y = temp; y < length_holder[count]; y += 3) {

                x += angle_holder[count]

                striker += '<img id="img_' + y + '" src="' + dot.src + '" style="position:absolute;z-index:9999;top:' + y + 'px;left:' + x + 'px;height:' + stream_width + 'px;width:' + stream_width + 'px;filter:GLOW(color=' + glow_color + ')">'

                last_img = 'img_' + y

            }

            temp = length_holder[count]

            last_pos_x = x; // x axis position of end of fork

            last_pos_y = y; // y axis position of end of fork

        }

        window.status = last_img

        holder.innerHTML = striker

        strike_event(opt)

        striker = ""

        setTimeout("holder.innerHTML = striker", disp)

        foo = setTimeout("strike('run')", timer)

    }
    else if (opt == "stop") {
        return false;
    }
}



function strike_event(opt)

 {

     if (opt == "run") {
         if (last_pos_y > parseInt(strike_area.style.top) && last_pos_y < (parseInt(strike_area.style.top) + parseInt(strike_area.style.height)) && last_pos_x > parseInt(strike_area.style.left) && last_pos_x < (parseInt(strike_area.style.left) + parseInt(strike_area.style.width))) {

             document.all[last_img].style.width = 10

             document.all[last_img].style.height = 10

             //document.all[last_img].src = "down.gif"

             //strike_area.filters.glow.enabled = true

             setTimeout('strike_area.filters.glow.enabled = false', 500)

         }
     }
     else if (opt == "stop") {
         return false;
     }
 }

 function stopEvent() {
     if (typeof(foo) != "undefined") {
         clearTimeout(foo);
     }
 }