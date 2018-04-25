/**
 * activiti js
 */

$(function(){
	$("input[type='number']").each(function(){
		$(this).change(function(){
			if($(this).val() <=0){
				$(this).val(1);
			}
		})
	})
})