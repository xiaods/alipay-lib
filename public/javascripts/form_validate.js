function validate(inputs) {
    var i;
    var error = false;
    for (i = 0; i < inputs.length; i++) {
        var temp = inputs[i];
        if (temp.allowBlank == false && $F(temp.id).blank()) {
            error = true;
            break;
        }
        if (temp.maxLength && $F(temp.id).length > temp.maxLength) {
            error = true;
            break;
        }
        if (temp.minLength && $F(temp.id).length < temp.minLength) {
            error = true;
            break;
        }
        if (temp.pattern && !temp.pattern.test($F(temp.id))) {
            error = true;
            break;
        }
    }
    if (error) {
        showError(temp.id);
        return false
    }
    else {
        return true;
    }
}

function showError(id) {
    $$(".error").each(function (i) {
        i.hide();
    });
    if ($(id + "_error")) {
        $(id + "_error").show();
        $(id).focus();
    }
}

mailPattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
qqPattern = /^\d{5,15}$/
cellPattern = /^\d{5,15}$/
phonePattern = /^(\d{2,4}\-){0,1}\d{6,9}$/

function onSubmitOrder(form) {
    var inputs = [{
        id: "order_pay_type_id",
        allowBlank: false
    }];
    if (validate(inputs)) {
        if ($F("order_pay_type_id") == "") ) {
            showError("order_pay_type_id");
        }
        else if(!cellPattern.test($F("order_cell_phone"))) {
            showError("order_phone");
        }
        else {
            form.submit();
        }
    }
}

