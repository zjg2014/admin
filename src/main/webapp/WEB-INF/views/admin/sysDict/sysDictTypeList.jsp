<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript" src="${staticPath}/static/js/admin/sysDict/sysDictItem.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticPath}/static/js/admin/sysDict/sysDictType.js" charset="utf-8"></script>



 <shiro:hasPermission name="/sysDictItem/edit">
 	<input id="editDictItemPermission" type="hidden" ></input>
 </shiro:hasPermission>
 <shiro:hasPermission name="/sysDictItem/delete">
 	<input id="deleteDictItemPermission" type="hidden" ></input>
 </shiro:hasPermission>

<div class="easyui-layout" data-options="fit:true,border:false">
  <div data-options="region:'center',border:true,title:'字典项'" >
        <table id="sysDictItemDataGrid" data-options="fit:true,border:false"></table>
    </div>
    <div data-options="region:'west',border:true,split:false,title:'业务字典'"  style="width:500px;overflow: hidden; ">
        <ul id="sysDictTypeDataGrid" style="width:500px;margin: 10px 10px 10px 10px"></ul>
    </div>
</div>
<div id="sysDictTypeToolbar" style="display: none;">
    <shiro:hasPermission name="/sysDictType/add">
        <a onclick="sysDictTypeAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-add'">添加</a>
    </shiro:hasPermission>
</div>
<div id="sysDictItemToolbar" style="display: none;">
    <shiro:hasPermission name="/sysDictItem/add">
        <a onclick="sysDictItemAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-page-add'">添加</a>
    </shiro:hasPermission>
</div>