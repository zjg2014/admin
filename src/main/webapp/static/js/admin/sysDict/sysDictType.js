var sysDictTypeDataGrid;
    $(function() {
        sysDictTypeDataGrid = $('#sysDictTypeDataGrid').datagrid({
        url : path+'/sysDictType/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : true,
        idField : 'id',
        sortName : 'id',
        sortOrder : 'asc',
        pageSize : 20,
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        onSelect : function(node) {
        	debugger;
        	 var selectRow = sysDictTypeDataGrid.datagrid('getSelected');
        	sysDictItemDataGrid.datagrid('load', {
        		typeCode: selectRow.typeCode
            });
        },
        frozenColumns : [ [ {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true,
            hidden:'true'
        }, {
            width : '130',
            title : '字典名称',
            field : 'typeName',
            sortable : true
        },
        {
            width : '140',
            title : '字典编码',
            field : 'typeCode',
        }, {
            width : '140',
            title : '创建时间',
            field : 'createTime',
            sortable : true
        } ] ],
        onLoadSuccess:function(data){
            $('.sysDictType-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.sysDictType-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#sysDictTypeToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function sysDictTypeAddFun() {
    parent.$.modalDialog({
        title : '添加',
        width : 700,
        height : 600,
        href : path+'/sysDictType/addPage',
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = sysDictTypeDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#sysDictTypeAddForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function sysDictTypeEditFun(id) {
    if (id == undefined) {
        var rows = sysDictTypeDataGrid.datagrid('getSelections');
        id = rows[0].id;
    } else {
        sysDictTypeDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
    }
    parent.$.modalDialog({
        title : '编辑',
        width : 700,
        height : 600,
        href :  path+'/sysDictType/editPage?id=' + id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = sysDictTypeDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#sysDictTypeEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 删除
 */
 function sysDictTypeDeleteFun(id) {
     if (id == undefined) {//点击右键菜单才会触发这个
         var rows = sysDictTypeDataGrid.datagrid('getSelections');
         id = rows[0].id;
     } else {//点击操作里面的删除图标会触发这个
         sysDictTypeDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
     }
     parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
         if (b) {
             progressLoad();
             $.post(path+'/sysDictType/delete', {
                 id : id
             }, function(result) {
                 if (result.success) {
                     parent.$.messager.alert('提示', result.msg, 'info');
                     sysDictTypeDataGrid.datagrid('reload');
                 }
                 progressClose();
             }, 'JSON');
         }
     });
}
