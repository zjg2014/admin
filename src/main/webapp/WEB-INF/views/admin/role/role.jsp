<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>

<script type="text/javascript" src="${staticPath}/static/js/admin/role/role.js" charset="utf-8"></script>
<!-- 权限判断 供js用 -->
 <shiro:hasPermission name="/role/grant">
 	<input id="grantPermission" type="hidden" ></input>
 </shiro:hasPermission>
 <shiro:hasPermission name="/role/edit">
 	<input id="editPermission" type="hidden" ></input>
 </shiro:hasPermission>
 <shiro:hasPermission name="/role/delete">
 	<input id="deletePermission" type="hidden" ></input>
 </shiro:hasPermission>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',fit:true,border:false">
        <table id="roleDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="roleToolbar" style="display: none;">
    <shiro:hasPermission name="/role/add">
        <a onclick="addRoleFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>