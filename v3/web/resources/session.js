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
