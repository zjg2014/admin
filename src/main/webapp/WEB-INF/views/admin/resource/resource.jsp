<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript" src="${staticPath}/static/js/admin/resource/resource.js" charset="utf-8"></script>
<!-- 权限判断 供js用 -->
 <shiro:hasPermission name="/resource/edit">
 	<input id="editPermission" type="hidden" ></input>
 </shiro:hasPermission>
 <shiro:hasPermission name="/resource/delete">
 	<input id="deletePermission" type="hidden" ></input>
 </shiro:hasPermission>
 
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false"  style="overflow: hidden;">
        <table id="resourceTreeGrid"></table>
    </div>
</div>
<div id="resourceToolbar" style="display: none;">
    <shiro:hasPermission name="/resource/add">
        <a onclick="addResourceFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus icon-green'">添加</a>
    </shiro:hasPermission>
</div>

