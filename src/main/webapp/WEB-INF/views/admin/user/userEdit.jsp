<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#userEditorganizationId').combotree({
            url : '${path }/organization/tree',
            parentField : 'pid',
            panelHeight : 'auto',
            value : '${user.organizationId}'
        });

        $('#userEditRoleIds').combotree({
            url : '${path }/role/tree',
            parentField : 'pid',
            panelHeight : 'auto',
            multiple : true,
            required : true,
            cascadeCheck : false,
            value : ${roleIds }
        });

        $('#userEditForm').form({
            url : '${path }/user/edit',
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
                    var form = $('#userEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        $("#sex_edit").combobox({
	    	data:window.parent.dictCache.getDictItems("sex"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
		    value:'${user.sex}'
	    });
        $("#userType_edit").combobox({
	    	data:window.parent.dictCache.getDictItems("user_type"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
		    value:'${user.userType}'
	    });
        $("#status_edit").combobox({
	    	data:window.parent.dictCache.getDictItems("user_status"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
		    value:'${user.status}'
	    });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="userEditForm" method="post">
            <div class="light-info" style="overflow: hidden;padding: 3px;">
                <div>密码不修改请留空。</div>
            </div>
            <table class="grid">
                <tr>
                    <td>登录名</td>
                    <td><input name="id" type="hidden"  value="${user.id}">
                    <input name="loginName" type="text" placeholder="请输入登录名称" class="easyui-validatebox" data-options="required:true" value="${user.loginName}"></td>
                    <td>姓名</td>
                    <td><input name="name" type="text" placeholder="请输入姓名" class="easyui-validatebox" data-options="required:true" value="${user.name}"></td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td><input type="text" name="password"/></td>
                    <td>性别</td>
                    <td>
                    	<input id="sex_edit" name="sex" class="easyui-combobox" data-options="width:140,height:29,editable:false,required:true,panelHeight:'auto'">
                     </td>
                </tr>
                <tr>
                    <td>年龄</td>
                    <td><input type="text" name="age" value="${user.age}" class="easyui-numberbox"/></td>
                    <td>用户类型</td>
                    <td>
                    	<input id="userType_edit" name="userType" class="easyui-combobox" data-options="width:140,height:29,editable:false,required:true,panelHeight:'auto'">
                    </td>
                </tr>
                <tr>
                    <td>部门</td>
                    <td><select id="userEditorganizationId" name="organizationId" style="width: 140px; height: 29px;" class="easyui-validatebox" data-options="required:true"></select></td>
                    <td>角色</td>
                    <td><input  id="userEditRoleIds" name="roleIds" style="width: 140px; height: 29px;"/></td>
                </tr>
                <tr>
                    <td>电话</td>
                    <td>
                        <input type="text" name="phone" class="easyui-numberbox" value="${user.phone}"/>
                    </td>
                    <td>用户类型</td>
                    <td>
                    	<input id="status_edit" name="status"  class="easyui-combobox" data-options="width:140,height:29,editable:false,required:true,panelHeight:'auto'">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>