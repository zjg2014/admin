<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#resourceAddPid').combotree({
            url : '${path }/resource/allTree',
            parentField : 'pid',
            panelHeight : 'auto'
        });

        $('#resourceAddForm').form({
            url : '${path }/resource/add',
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
                    parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为resource.jsp页面预定义好了
                    parent.layoutWestTree.tree('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#resourceAddForm');
                    parent.$.messager.alert('提示', eval(result.msg), 'warning');
                }
            }
        });
        
        $("#resourceType_add").combobox({
	    	data:window.parent.dictCache.getDictItems("resource_type"),
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
        $("#opened_add").combobox({
	    	data:window.parent.dictCache.getDictItems("open_status"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
	    });
        $("#openMode_add").combobox({
	    	data:window.parent.dictCache.getDictItems("open_mode"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
	    });
        
    });
</script>
<div style="padding: 3px;">
    <form id="resourceAddForm" method="post">
        <table class="grid">
            <tr>
                <td>资源名称</td>
                <td><input name="name" type="text" placeholder="请输入资源名称" class="easyui-validatebox span2" data-options="required:true" ></td>
                <td>资源类型</td>
                <td>
                    <input id="resourceType_add" name="resourceType" class="easyui-combobox" required="required" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                </td>
            </tr>
            <tr>
                <td>资源路径</td>
                <td><input name="url" type="text" placeholder="请输入资源路径" class="easyui-validatebox span2" data-options="width:140,height:29" ></td>
                <td>打开方式</td>
                <td>
                    <input id="openMode_add" name="openMode" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                </td>
            </tr>
            <tr>
                <td>菜单图标</td>
                <td ><input name="icon" onclick='top.window.openIconDialog(this)'/></td>
                <td>排序</td>
                <td><input name="seq" value="0"  class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required" data-options="editable:false"></td>
            </tr>
            <tr>
                <td>状态</td>
                <td>
                    <input id="status_add" name="status" class="easyui-combobox" required="required" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                </td>
                <td>菜单状态</td>
                <td>
                    <input id="opened_add" name="opened" class="easyui-combobox" required="required" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                </td>
            </tr>
            <tr>
                <td>上级资源</td>
                <td colspan="3">
                    <select id="resourceAddPid" name="pid" style="width: 200px; height: 29px;"></select>
                    <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#pid').combotree('clear');" >清空</a>
                </td>
            </tr>
        </table>
    </form>
</div>