$(document).ready(function () {
    $("#admin_logout").click(function() {
        alert("ท่านได้ออกจากระบบเรียบร้อยแล้ว");
        $("#admin_logout_form").submit();
    });
});

function logout(F) {
    alert("ท่านได้ออกจากระบบเรียบร้อยแล้ว");
    document.forms[0].action = "logoutservlet";
    document.forms[0].method = "post";
    document.forms[0].submit();

}

var speed = 'fast';

$('html, body').hide();

$(document).ready(function() {
    $('html, body').fadeIn(speed, function() {
        $('a[href], button[href]').click(function(event) {
            var url = $(this).attr('href');
            if (url.indexOf('#') == 0 || url.indexOf('javascript:') == 0) return;
            event.preventDefault();
            $('html, body').fadeOut(speed, function() {
                window.location = url;
            });
        });
    });
});