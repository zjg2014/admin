<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    	debugger;
  		 $('#sysDictTypeEditForm').form({
            url : '${path}/sysDictType/edit',
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
                    var form = $('#sysDictTypeEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        
        var row = sysDictTypeDataGrid.datagrid('getSelected');
        $("#id_edit").val(row.id);
        $("#typeName_edit").val(row.typeName);
        $("#typeCode_edit").val(row.typeCode);
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="sysDictTypeEditForm" method="post">
            <table class="grid">
                <tr>
                    <td>字典名称</td>
                    <td><input name="id" id="id_edit" type="hidden" >
                    <input name="typeName" id="typeName_edit" type="text" placeholder="请输入名称" class="easyui-validatebox" data-options="required:true" ></td>
                </tr>
                <tr>
                    <td>字典编码</td>
                    <td>
                    <input name="typeCode" id="typeCode_edit" type="text" placeholder="请输入名称" class="easyui-validatebox" data-options="required:true">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>