<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
      
        $('#resourceEditForm').form({
            url : '${path }/resource/edit',
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
                    var form = $('#resourceEditForm');
                    parent.$.messager.alert('提示', eval(result.msg), 'warning');
                }
            }
        });
        var row = resourceTreeGrid.datagrid('getSelected');
        
        $("#resourceType_edit").combobox({
	    	data:window.parent.dictCache.getDictItems("resource_type"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
		    value:row.resourceType,
	    });
        $("#status_edit").combobox({
	    	data:window.parent.dictCache.getDictItems("user_status"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
		    value:row.status,
	    });
        $("#opened_edit").combobox({
	    	data:window.parent.dictCache.getDictItems("open_status"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
		    value:row.opened,
	    });
        $("#openMode_edit").combobox({
	    	data:window.parent.dictCache.getDictItems("open_mode"),
	    	valueField:'itemCode',    
		    textField:'itemName',
		    editable:true,  //不可编辑，只能选择
		    value:row.openMode,
	    });
        $('#resourceEditPid').combotree({
            url : '${path }/resource/tree',
            parentField : 'pid',
            panelHeight : 'auto',
            value : row.pid
        });
        $("#id_edit").val(row.id);
        $("#name_edit").val(row.name);
        $("#url_edit").val(row.url);
        $("#icon_edit").val(row.iconCls);
        $("#seq_edit").val(row.seq);
        
    });
</script>
<div style="padding: 3px;">
    <form id="resourceEditForm" method="post">
        <table  class="grid">
            <tr>
                <td>资源名称</td>
                <td>
                    <input id="id_edit" name="id" type="hidden"  >
                    <input id="name_edit" name="name" type="text" placeholder="请输入资源名称"  class="easyui-validatebox span2" data-options="required:true" >
                </td>
                <td>资源类型</td>
                <td>
                    <input id="resourceType_edit" name="resourceType" class="easyui-combobox" data-options="width:140,height:29,editable:false,required:true,panelHeight:'auto'">
                </td>
            </tr>
            <tr>
                <td>资源路径</td>
                <td><input id="url_edit" name="url" type="text"  placeholder="请输入资源路径" class="easyui-validatebox span2" ></td>
                <td>打开方式</td>
                <td>
                    <input id="openMode_edit" name="openMode" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                </td>
            </tr>
            <tr>
                <td>菜单图标</td>
                <td><input id="icon_edit" name="icon"  onclick='top.window.openIconDialog(this)'/></td>
                <td>排序</td>
                <td><input id="seq_edit" name="seq"  class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required" data-options="editable:false"></td>
            </tr>
            <tr>
                <td>状态</td>
                <td>
                    <input id="status_edit" name="status" class="easyui-combobox" data-options="width:140,height:29,editable:false,required:true,panelHeight:'auto'">
                </td>
                <td>菜单状态</td>
                <td>
                    <input id="opened_edit" name="opened" class="easyui-combobox" data-options="width:140,height:29,editable:false,required:true,panelHeight:'auto'">
                </td>
            </tr>
            <tr>
                <td>上级资源</td>
                <td colspan="3"><select id="resourceEditPid" name="pid" style="width: 200px; height: 29px;"></select>
                <a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#pid').combotree('clear');" >清空</a></td>
            </tr>
        </table>
    </form>
</div>
