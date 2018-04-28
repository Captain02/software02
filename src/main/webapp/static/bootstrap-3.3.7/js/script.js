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









