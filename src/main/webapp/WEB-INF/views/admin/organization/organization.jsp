<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript" src="${staticPath}/static/js/admin/organization/organization.js" charset="utf-8"></script>

<!-- 权限判断 供js用 -->
 <shiro:hasPermission name="/organization/edit">
 	<input id="editPermission" type="hidden" ></input>
 </shiro:hasPermission>
 <shiro:hasPermission name="/organization/delete">
 	<input id="deletePermission" type="hidden" ></input>
 </shiro:hasPermission>
 

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false"  style="overflow: hidden;">
        <table id="organizationTreeGrid"></table>
    </div>
    <div id="orgToolbar" style="display: none;">
        <shiro:hasPermission name="/organization/add">
            <a onclick="addOrganizationFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus icon-green'">添加</a>
        </shiro:hasPermission>
    </div>
</div>