 var sysDictItemDataGrid;
    $(function() {
        sysDictItemDataGrid = $('#sysDictItemDataGrid').datagrid({
        url : path+'/sysDictItem/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        frozenColumns : [ [ {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true,
            hidden:'true'
        }, {
            width : '60',
            title : '字典名称',
            field : 'itemName',
            sortable : true
        }, {
            width : '60',
            title : '字典值',
            field : 'itemCode',
            sortable : true
        }, {
            width : '60',
            title : '排列顺序',
            field : 'sortIndex',
            sortable : true
        }, {
            width : '140',
            title : '创建时间',
            field : 'createTime',
            sortable : true
        }, {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                var str = '';
                if($("#editDictItemPermission").size()>0){
                    str += $.formatString('<a href="javascript:void(0)" class="sysDictItem-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="sysDictItemEditFun(\'{0}\');" >编辑</a>', row.id);
                }
                if($("#deleteDictItemPermission").size()>0){
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="sysDictItem-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="sysDictItemDeleteFun(\'{0}\');" >删除</a>', row.id);
                }
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.sysDictItem-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.sysDictItem-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#sysDictItemToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function sysDictItemAddFun() {
	var selectRow = sysDictTypeDataGrid.datagrid('getSelected');
	if(selectRow = undefined || selectRow ==null){
		$.messager.alert('错误', "请选择业务字典", 'error')
		return;
	}
    parent.$.modalDialog({
        title : '添加',
        width : 700,
        height : 600,
        href : path+'/sysDictItem/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = sysDictItemDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#sysDictItemAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function sysDictItemEditFun(id) {
    if (id == undefined) {
        var rows = sysDictItemDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        sysDictItemDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 600,
        href :  path+'/sysDictItem/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = sysDictItemDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#sysDictItemEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function sysDictItemDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = sysDictItemDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         sysDictItemDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前数据？', function(b) {
         if (b) {
             progressLoad();
             $.post(path+'/sysDictItem/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     sysDictItemDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}