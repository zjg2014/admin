<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#roleEditForm').form({
            url : '${path }/role/edit',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#roleEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        var row = roleDataGrid.datagrid('getSelected');
        $("#id_edit").val(row.id);
        $("#name_edit").val(row.name);
        $("#seq_edit").val(row.seq);
        $("#description_edit").val(row.description);
        $('#status_edit').combobox({    
			data:window.parent.dictCache.getDictItems("user_status"),
		    valueField:'itemCode',    
		    textField:'itemName',
		    value:row.status,
		    editable:false,  //不可编辑，只能选择
		});
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="roleEditForm" method="post">
            <table class="grid">
                <tr>
                    <td>角色名称</td>
                    <td><input id="id_edit" name="id" type="hidden" >
                    <input id="name_edit" name="name" type="text" placeholder="请输入角色名称" class="easyui-validatebox" data-options="required:true" ></td>
                </tr>
                <tr>
                    <td>排序</td>
                    <td><input id="seq_edit" name="seq"  class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required" data-options="editable:false" ></td>
                </tr>
                <tr>
                    <td>状态</td>
                    <td >
                      <input class="easyui-combobox" id="status_edit" name="status"  required="required" data-options="width:140,height:29,editable:false,panelHeight:'auto'"></input>
                    </td>
                </tr>
                <tr>
                    <td>备注</td>
                    <td colspan="3"><textarea id="description_edit" name="description"></textarea></td>
                </tr>
            </table>
        </form>
    </div>
</div>