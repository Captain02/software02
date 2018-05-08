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
	//去重	
	$('#js-historyComment > tbody tr').remove();
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
$(function(){
	
	$('.js-editor-user').click(function(){
		
		if( $('#editor-myModal') ){
			var editorModal = $('#editor-myModal');
			
			editorModal.find('input[name="id"]').val($(this).attr('data-userid'));
			editorModal.find('input[name="password"]').val($(this).attr('data-userpassword'));
			editorModal.find('input[name="firstName"]').val($(this).attr('data-lastname'));
			editorModal.find('input[name="lastName"]').val($(this).attr('data-firstname'));
			editorModal.find('input[name="email"]').val($(this).attr('data-email'));
			editorModal.find('input[name="name"]').val($(this).attr('data-groupName'));
			
		}else{
			return false;
		}
		
	})
	
})


/**
 * @userManage.jsp 匹配用户所在的组
 */
function matchingGroup(result){
	var allGroups = [];
	var userHaveGroups = [];
	
	$('#group-myModal label').remove();
	
	$.each(result.extend.allGroup,function(index,value){
		var allGroupsHtml = $($.parseHTML(
				
				'<label class="checkbox-inline">'+
		      		'<input class="groupid" name="" value="'+result.extend.allGroup[index].id+'" type="checkbox">'+
					''+result.extend.allGroup[index].name+''+
		      	'</label>'
					
			));
		$('#group-myModal .modal-body').append(allGroupsHtml);
		
	})
	
	$.each(result.extend.groupByUserId,function(index,value){
		userHaveGroups.push(value.id);
	})
	
	$('#group-myModal input.groupid').each(function(){
		var groupid = $(this);
		
		if($.inArray(groupid.val(),userHaveGroups) >= 0){
			groupid.attr('checked','checked');
		}
		
	})
}

/**
 *  滑动菜单
 */

//弹出
function SlideDown(ele) {
    $(ele).children('ul.list-group').slideDown('fast')
    $(ele).addClass('open')
}

//收起
function SlideUp(ele) {
    $(ele).find('ul.list-group').slideUp('fast')
    $(ele).removeClass('open')
}

$(function () {
    $('li.item-name').click(function () {
    	$(this).hasClass('open') ? SlideUp($(this)) : SlideDown($(this))
    })
    
    $('ul.list-group li').click(function(event){
    	event.stopPropagation()
    })
})

/**
 *  高亮导航
 */
function highLightNav(ele){
	$(ele).addClass('active');
	$(ele).parents('li.item-name')?$(ele).parents('li.item-name').addClass('open'):false;
}

$(function () {
    var title = $('title').html();
    $('#menulist > .menulist-item li').each(function(){
    	$(this).attr('data-name')===title ? highLightNav($(this)) :false;
    })
})




