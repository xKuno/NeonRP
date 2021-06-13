$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var data = event.data;
        $(".container").css("display",data.show? "none":"block");

        if (event.data.action == "updateStatus") {
            updateStatus(event.data.st);
        }

        if (event.data.action == "updateMumble") {
            updateMumble(event.data.status);
        }

        if (event.data.action == "updateTalking") {
            updateTalking(event.data.talking);
        }

        
        if (event.data.action == "toggleStreetlabel") {
            $('#streetLabel').css('display', event.data.status);
        }

        if (event.data.action == "updateStreetLabel") {
            $('#street').html(event.data.street);
            $('#street2').html(event.data.street2);
            $('#zone').html(event.data.zone);
            $('#heading').html(event.data.direction);
        }

        if (event.data.action == "toggle"){
			if (event.data.show){
			    $('#ui').show();
			} else {
			    $('#ui').hide();
            }
        }

        if (event.data.action == "update"){
           $('#ID').html(event.data.id);
        }

        if (event.data.action == "bodycam"){
            if ($('#top-right').css('display') == "none"){
                $('#top-right').fadeIn(500);
                $('#name').html(event.data.name);
                $('#callsign').html(event.data.badge);
                $('#agency').html(event.data.department);

                if(event.data.department == "Los Santos Police Department"){
                    $('#logoBodyCam').attr("src", "images/logo.png");
                } else if (event.data.department == "Sheriff Office") {
					$('#logoBodyCam').attr("src", "images/logoso.png");
				} else {
                    $('#logoBodyCam').attr("src", "images/logoems.png");
                }
                otwarty = true;
                zegar();          
            } else {
                $('#top-right').fadeOut(500);
                otwarty = false;
            }
        }
    })
})

function updateStatus(status){
    $('#boxHunger').css('width', status[0].percent+'%');
    $('#boxThirst').css('width', status[1].percent+'%');
}

function updateMumble(mode){
    if (mode == 1){
        $('#boxMumble').css('width', '33.3%');
    } else if (mode == 2) {
        $('#boxMumble').css('width', '66.6%');
    } else if (mode == 3) {
        $('#boxMumble').css('width', '100%');
    }
}

function updateTalking(talking){
    if (talking) {
        $('#boxMumble').css('background', '#ff00f4');
    } else {
        $('#boxMumble').css('background', '#81097b');
    }
}

function zegar(){
    var dzisiaj = new Date().toLocaleString("us-Us", {
        timeZone: "Europe/Warsaw",
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
    });

    if ($('#recording').css('display') == "none"){
        $('#recording').fadeIn(1000);        
    } else {
        $('#recording').fadeOut(1000);
    }
        
    dzisiaj = dzisiaj.replace(",", "");

   $("#date").html(dzisiaj);
    if (otwarty){
        setTimeout(function(){ 
            zegar();
        }, 1000);
    }
}