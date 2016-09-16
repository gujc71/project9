function chkInputValue(id, msg){
	if ( $.trim($(id).val()) == "") {
		alert(msg+"을(를) 입력해주세요.");
		$(id).focus();
		return false;
	}
	return true;
}

function fn_moveToURL(url, msg){
	if (msg) {
		if (!confirm( msg + " 하시겠습니까??")) return;
	}
	location.href=url;
}

function fn_moveToURLbyForm(formid, url, msg){
	if (msg) {
		if (!confirm( msg + " 하시겠습니까??")) return;
	}
	var form = document.getElementById(formid);
	form.action=url;
	form.submit();
}

function html2Text(str) {
    str = str.replace(/&nbsp;/gi, " ");
    return str.replace(/<br>/gi, "\n");
}

function text2Html(str) {
    str = str.replace(/ /g, "&nbsp;");
    return str.replace(/\n/g, "<br>");
} 