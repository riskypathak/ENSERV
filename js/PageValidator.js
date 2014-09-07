//Hiding all the callouts
function SetErrorMessageInvisible() {
    for (i = 0; i < Page_Validators.length; i++) {
        var det = Page_Validators[i].id;
        var popup = $find('AjaxCallouts_' + det);
        if (popup) {
            popup.hide();
        }
    }
}
//RadPanelBar Functions
function OnClicking(sender, eventArgs) {
    SetErrorMessageInvisible();
}

function SetFocusOnError(CurrentGroup) {
    for (i = 0; i < Page_Validators.length; i++) {
        var validator = Page_Validators[i];
        var groupName = validator.validationGroup;
        var callout = validator.ValidatorCalloutBehavior;

        if (groupName == CurrentGroup && callout._focusAttached != null && callout._focusAttached) {
            var controlToFocus = document.getElementById(validator.controltovalidate);
            controlToFocus.focus();
            popupCallout = callout;
            setTimeout("HideErrorCallout()", 2);
            setTimeout("ShowErrorCallout()", 600);
            break;
        }
    }
}
//Hide improperly focused callout
function HideErrorCallout() {
    if (popupCallout) {
        popupCallout.hide();
    }
}
//Show validator callout
function ShowErrorCallout() {
    if (popupCallout) {
        popupCallout.show();
    }
}
// Clear all the errors
function SetErrorClear() {
    for (i = 0; i < Page_Validators.length; i++) {
        Page_Validators[i].isValid = true;
        if (Page_Validators[i].ValidatorCalloutBehavior)
            Page_Validators[i].ValidatorCalloutBehavior._focusAttached = false;
    }
}
// Validation causes improper placements of validator callouts
function ValidatePage1(AccordionControlID) {
    SetErrorClear();
    var item;
    var accordianControl = $get(AccordionControlID).AccordionBehavior;

    if (accordianControl == null)
        return false;
    if (typeof (Page_ClientValidate) == 'function') {

        accordianControl.set_SelectedIndex(0);

        if (Page_ClientValidate('First') == false) {
            return false;
        }

        accordianControl.set_SelectedIndex(1);

        if (Page_ClientValidate('Second') == false) {
            return false;
        }

        accordianControl.set_SelectedIndex(2);

        if (Page_ClientValidate('Third') == false) {
            return false;
        }

    }

    return true;
}

// Solved Page validation by calling SetFocusOnError method
function ValidatePage2(AccordionControlID) {
    SetErrorClear();
    var item;
    var accordianControl = $get(AccordionControlID).AccordionBehavior;

    if (accordianControl == null)
        return false;
    if (typeof (Page_ClientValidate) == 'function') {

        accordianControl.set_SelectedIndex(0);

        if (Page_ClientValidate('First') == false) {
            SetFocusOnError('First');
            return false;
        }

        accordianControl.set_SelectedIndex(1);

        if (Page_ClientValidate('Second') == false) {
            SetFocusOnError('Second');
            return false;
        }

        accordianControl.set_SelectedIndex(2);

        if (Page_ClientValidate('Third') == false) {
            SetFocusOnError('Third');
            return false;
        }

    }

    return true;
}



function PanelScrolling() {
    SetErrorMessageInvisible();
}