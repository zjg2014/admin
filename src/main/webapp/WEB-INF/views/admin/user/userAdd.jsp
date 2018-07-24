<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#userAddOrganizationId').combotree({
            url : '${path }/organization/tree',
            parentField : 'pid',
            panelHeight : 'auto'
        });

        $('#userAddRoleIds').combotree({
            url: '${path }/role/tree',
            multiple: true,
            required: true,
            panelHeight : 'auto'
        });

        $('#userAddForm').form({
            url : '${path }/user/add',
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
                    var form = $('#userAddForm');
                    parent.$.messager.alert('提示', result.msg, 'warning');
                }
            }
        });
        
        $("#sex_add").combobox({
	    	data:window.parent.dictCache.getDictItems("sex"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
	    });
        
        $("#userType_add").combobox({
	    	data:window.parent.dictCache.getDictItems("user_type"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
	    });
        $("#status_add").combobox({
	    	data:window.parent.dictCache.getDictItems("user_status"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
	    });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="userAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>登录名</td>
                    <td><input name="loginName" type="text" placeholder="请输入登录名称" class="easyui-validatebox" data-options="required:true" value=""></td>
                    <td>姓名</td>
                    <td><input name="name" type="text" placeholder="请输入姓名" class="easyui-validatebox" data-options="required:true" value=""></td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td><input name="password" type="password" placeholder="请输入密码" class="easyui-validatebox" data-options="required:true"></td>
                    <td>性别</td>
                    <td>
                        <input id="sex_add" name="sex" class="easyui-combobox" data-options="width:140,height:29,editable:false,required:true,panelHeight:'auto'">
                    </td>
                </tr>
                <tr>
                    <td>年龄</td>
                    <td><input type="text" name="age" class="easyui-numberbox"/></td>
                    <td>用户类型</td>
                    <td>
                        <input id="userType_add" name="userType" class="easyui-combobox" data-options="width:140,height:29,editable:false,required:true,panelHeight:'auto'">
                    </td>
                </tr>
                <tr>
                    <td>部门</td>
                    <td><select id="userAddOrganizationId" name="organizationId" style="width: 140px; height: 29px;" class="easyui-validatebox" data-options="required:true"></select></td>
                    <td>角色</td>
                    <td><select id="userAddRoleIds" name="roleIds" style="width: 140px; height: 29px;"></select></td>
                </tr>
                <tr>
                    <td>电话</td>
                    <td>
                        <input type="text" name="phone" class="easyui-numberbox"/>
                    </td>
                    <td>用户状态</td>
                    <td>
                        <input id="status_add" name="status" class="easyui-combobox" data-options="width:140,height:29,editable:false,required:true,panelHeight:'auto'">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>