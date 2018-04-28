/**
 * 实现多个复选框的全选
 */
$(function(){
	if(document.getElementById('selectAll') == null){
		return false;
	}
	var selectAll = document.getElementById('selectAll');
    var selectItems = document.getElementsByName('selectItem');

    selectAll.onclick = function () {
        for (var i = 0; i < selectItems.length; i++) {
            selectItems[i].checked = selectAll.checked;
        }
    }

    for (var i = 0; i < selectItems.length; i++) {
        selectItems[i].onclick = function () {
            selectAll.checked = true;
            for (var j = 0; j < selectItems.length; j++) {
                if (!selectItems[j].checked) {
                    selectAll.checked = false;
                }
            }
        }
    }
})


/**
 * @login_new.jsp  请求ajax,生成组别
 */
function addGroup(result){
	for(var i = 0; i<result.extend.groups.length; i++){
		var html = $($.parseHTML(" '<option value="+result.extend.groups[i].id+">"+result.extend.groups[i].name+"</option>' "));
		
		if($('#js-group')){
			$('#js-group').append(html);
		}else{
			return false;
		}
		
	}

}

/**
 * @yibanManage.jsp  请求ajax,生成历史批注
 */
function addComment(result){
	for(var i = 0; i<result.extend.commens.length; i++){
		var date = new Date(result.extend.commens[i].time);
		var html = $($.parseHTML(
				
				'<tr>'+
				'<td>'+date.getFullYear() + '-' + parseInt(date.getMonth()+1) + '-' + date.getDate() + ' ' + date.getHours()+ ':' + date.getMinutes()+ ':' +date.getSeconds()+'</td>'+
				'<td>'+result.extend.commens[i].userId+'</td>'+
				'<td>'+result.extend.commens[i].message+'</td>'+
				'</tr>'
				
			));
		
		if($('#js-historyComment')){
			$('#js-historyComment > tbody').append(html);
		}else{
			return false;
		}
		
	}
}

/**
 * @userManage.jsp 编辑按钮填充用户信息
 */
function showUserInfo(ele){
//	var userName = $(ele)
//	var passWord
//	var name
//	var userEmail
	
	var userInfo = $(ele).parent.siblings('td.userInfo')
	var showUserInfo = $('#editor-myModal > ')
}








