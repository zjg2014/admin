<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#sysDictItemAddForm').form({
            url : '${path}/sysDictItem/add',
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
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#sysDictItemAddForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        
    });
    var selectRow = sysDictTypeDataGrid.datagrid('getSelected');
    $("#typeCode_add").val(selectRow.typeCode);
    
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="sysDictItemAddForm" method="post">
        <input name="typeCode" id="typeCode_add" type="hidden">
            <table class="grid">
                <tr>
                    <td>字典名称</td>
                    <td><input name="itemName" type="text" placeholder="请输入字典名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr> 
                <tr>
                    <td>字典值</td>
                    <td><input name="itemCode" type="text" placeholder="请输入字典值" class="easyui-validatebox span2"  value=""></td>
                </tr>
                <tr>
                    <td>排列顺序</td>
                    <td><input name="sortIndex" type="text" placeholder="排序" class="easyui-validatebox span2" data-options="required:true" value=""></td>
                </tr>  
            </table>
        </form>
    </div>
</div>