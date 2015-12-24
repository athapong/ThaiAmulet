function validateFields(field, label) {
    if ($("#"+field).val().trim() == "") {
        $("#"+field).addClass("input_required");
        $("#"+label).addClass("label_required");
        return false;
    } else return true;
}