<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        
        
        $('#organizationEditForm').form({
            url : '${path }/organization/edit',
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
                    parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为organization.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#organizationEditForm');
                    parent.$.messager.alert('提示', eval(result.msg), 'warning');
                }
            }
        });
        
        var row = organizationTreeGrid.datagrid('getSelected');
        $('#organizationEditPid').combotree({
            url : '${path }/organization/tree?flag=false',
            parentField : 'pid',
            panelHeight : 'auto',
            value :row.pid
        });
        $("#id_edit").val(row.id);
        $("#code_edit").val(row.code);
        $("#name_edit").val(row.name);
        $("#seq_edit").val(row.seq);
        $("#icon_edit").val(row.iconCls);
        $("#address_edit").val(row.address);
    });
</script>
<div style="padding: 3px;">
    <form id="organizationEditForm" method="post">
        <table class="grid">
            <tr>
                <td>编号</td>
                <td><input id="id_edit" name="id" type="hidden"  ><input id="code_edit" name="code" type="text"/></td>
                <td>资源名称</td>
                <td><input id="name_edit" name="name" type="text" placeholder="请输入部门名称" class="easyui-validatebox" data-options="required:true" ></td>
            </tr>
            <tr>
                <td>排序</td>
                <td><input id="seq_edit" name="seq"  class="easyui-numberspinner" style="widtd: 140px; height: 29px;" required="required" data-options="editable:false"></td>
                <td>菜单图标</td>
                <td ><input id="icon_edit" name="icon"  onclick='top.window.openIconDialog(this)'/></td>
            </tr>
            <tr>
                <td>地址</td>
                <td colspan="3"><input id="address_edit" name="address" style="width: 300px;" /></td>
            </tr>
            <tr>
                <td>上级资源</td>
                <td colspan="3"><select id="organizationEditPid" name="pid" style="width: 200px; height: 29px;"></select>
                <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#pid').combotree('clear');" >清空</a></td>
            </tr>
        </table>
    </form>
</div>
