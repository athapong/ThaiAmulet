function checkThaiIdNumber(id) {
    if (id.length != 13) return false;
    for (i = 0, sum = 0; i < 12; i++)
        sum += parseFloat(id.charAt(i)) * (13 - i);
    if ((11 - sum % 11) % 10 != parseFloat(id.charAt(12))) return false;
    return true;
}

$(document).ready(function() {
    $('input[id=username]').blur(function() {
        defaultText = ""
        if ($(this).val() == '') {
            $(this).val(defaultText);
        } else {
            result = checkUserExist($(this).val());
            result.done(function(data){
                if (data == true) {
                    alert("มีสมาชิกนี้ในระบบแล้ว.");
                    $('input[id=username]').val(defaultText);
                    $('input[id=username]').focus();
                } else if(data == false) {
                }
            });
        }
    });
    $('input[id=usernameTxt]').blur(function() {
        defaultText = ""
        if ($(this).val() == '') {
            $(this).val(defaultText);
        } else {
            result = checkUserExist($(this).val());
            result.done(function(data){
                if (data == true) {
                    alert("มีสมาชิกนี้ในระบบแล้ว.");
                    $('input[id=usernameTxt]').val(defaultText);
                    $('input[id=usernameTxt]').focus();
                } else if(data == false) {
                }
            });
        }
    });
    $('input[id=email]').blur(function() {
        defaultText = ""
        if ($(this).val() == '') {
            $(this).val(defaultText);
        } else {
            result = isValidEmailAddress($(this).val());
            if (result == false) {
                alert("อีเมล์ไม่ถูกต้อง");
                $(this).val(defaultText);
                $(this).focus();
            } else {
                result = checkMailExist($(this).val());
                result.done(function(data){
                    if (data == true) {
                        alert("มีอีเมล์นี้ในระบบแล้ว.");
                        $('input[id=email]').val(defaultText);
                        $('input[id=email]').focus();
                    } else if(data == false) {
                    }
                });
                $('input[id=confirmEmail]').prop("disabled", false);
                $('input[id=confirmEmail]').focus();
            }
        }
    });
    $('input[id=idCardNo]').blur(function() {
        defaultText = ""
        if ($(this).val() == '') {
            $(this).val(defaultText);
        } else {
            result = checkThaiIdNumber($(this).val());
            if (result == false) {
                alert("เลขที่บัตรประชาชนไม่ถูกต้อง");
                $(this).val(defaultText);
                $(this).focus();
            }
        }
    });


    $('input[id=confirmEmail]').blur(function() {
        defaultText = ""
        if ($(this).val() == '') {
            $(this).val(defaultText);
        } else {
            result = isValidEmailAddress($(this).val());
            if (result == false) {
                alert("อีเมล์ไม่ถูกต้อง");
                $(this).val(defaultText);
                $(this).focus();
            } else {
                email = $('input[id=email]').val();
                confirmEmail = $('input[id=confirmEmail]').val();
                if (email != confirmEmail) {
                    alert("อีเมล์ไม่ตรงกัน");
                    $(this).focus();
                }
            }
        }
    });

    // password validation
    $('input[id=password]').blur(function() {
        defaultText = ""
        if ($(this).val() == '') {
            $(this).val(defaultText);
        } else {
            $('input[id=confirmPassword]').prop("disabled", false);
            $('input[id=confirmPassword]').focus();
        }
    });

    $('input[id=confirmPassword]').blur(function() {
        defaultText = ""
        if ($(this).val() == '') {
            $(this).val(defaultText);
        } else {
            password = $('input[id=password]').val();
            confirmPassword = $('input[id=confirmPassword]').val();
            if (password != confirmPassword) {
                alert("รหัสผ่านไม่ตรงกัน");
                $(this).focus();
            }
        }
    });

    var decimal_pattern = new RegExp(/^\d+(\.\d{2})?$/);
    var aSpecialKeysForFirefox = [8, 9, 13, 27, 37, 38, 39, 40, 46, 190];
    $("input#s_width").on({
        keydown: function(e) {
            var iKeyCode = e.which || e.keyCode;
            var sKey = String.fromCharCode(iKeyCode);
            if (sKey !== "" && $.inArray(iKeyCode, aSpecialKeysForFirefox ) < 0 && !sKey.match(decimal_pattern)) {
                e.preventDefault();
            }
        }
    });
    $("input#s_tall").on({
        keydown: function(e) {
            var iKeyCode = e.which || e.keyCode;
            var sKey = String.fromCharCode(iKeyCode);
            if (sKey !== "" && $.inArray(iKeyCode, aSpecialKeysForFirefox ) < 0 && !sKey.match(decimal_pattern)) {
                e.preventDefault();
            }
        }
    });
    $("input#s_long").on({
        keydown: function(e) {
            var iKeyCode = e.which || e.keyCode;
            var sKey = String.fromCharCode(iKeyCode);
            if (sKey !== "" && $.inArray(iKeyCode, aSpecialKeysForFirefox ) < 0 && !sKey.match(decimal_pattern)) {
                e.preventDefault();
            }
        }
    });
    $("input#meditation_l").on({
        keydown: function(e) {
            var iKeyCode = e.which || e.keyCode;
            var sKey = String.fromCharCode(iKeyCode);
            if (sKey !== "" && $.inArray(iKeyCode, aSpecialKeysForFirefox ) < 0 && !sKey.match(decimal_pattern)) {
                e.preventDefault();
            }
        }
    });
    $("input#meditaion_l").on({
        keydown: function(e) {
            var iKeyCode = e.which || e.keyCode;
            var sKey = String.fromCharCode(iKeyCode);
            if (sKey !== "" && $.inArray(iKeyCode, aSpecialKeysForFirefox ) < 0 && !sKey.match(decimal_pattern)) {
                e.preventDefault();
            }
        }
    });
});

function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    return pattern.test(emailAddress);
};


function registerMember() {
    if ($('input[id=firstname]').val() == "") {

    }
    if ($('input[id=lastname]').val() == "") {

    }
    $("input:radio[name=sex]").click(function() {
        var value = $(this).val();
    });
    if ($('input[id=idCardNo]').val() == "") {

    }
/*    $('input[name^="btnIdCardUpload"]').each(function () {
        $(this).rules('add', {
            required: true,
            accept: "image/jpeg, image/pjpeg"
        })
    });
    $('input[name^="btnHouseCertUpload"]').each(function () {
        $(this).rules('add', {
            required: true,
            accept: "image/jpeg, image/pjpeg"
        })
    });*/
    if ($('input[id=id4scan]').val() == "") {

    }
    if ($('input[id=mobileNo]').val() == "") {

    }
    if ($('input[id=email]').val() == "") {

    }
    if ($('input[id=confirmEmail]').val() == "") {

    }
    if ($('input[id=username]').val() == "") {

    }
    if ($('input[id=password]').val() == "") {

    }
    if ($('input[id=confirmPassword]').val() == "") {

    }
    if ($('input[id=question]').val() == "") {

    }
    if ($('#dropDownId :selected').text() == "") {

    }
    if ($('input[id=answer]').val() == "") {

    }

    $(function () {
        $('#registerMemberForm').on('click','#registerBtn', function(e){
            alert($('#registerMemberForm').serialize());
            e.preventDefault();
            $.ajax({
                type: "POST",
                url: "./registmembrservlet",
                data: new FormData( this ),
                processData: false,
                contentType: false
            });
            return false;
        });
    });
}

function checkUserExist(userName){
    return $.ajax({
        type: "GET",
        url: "./registmembrservlet",
        dataType: "json",
        cache: false,
        data: "do=CUE&userName="+userName,
        beforeSend: function() {
            // show spinner
            $('#spinner').fadeIn("fast");
        },
        complete: function() {
            // hide spinner
            $('#spinner').fadeOut("fast");
        }
    });
};

function checkMailExist(email){
    return $.ajax({
        type: "GET",
        url: "./registmembrservlet",
        dataType: "json",
        cache: false,
        data: "do=CUE&email="+email,
        beforeSend: function() {
            // show spinner
            $('#spinner').fadeIn("fast");
        },
        complete: function() {
            // hide spinner
            $('#spinner').fadeOut("fast");
        }
    });
};