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
