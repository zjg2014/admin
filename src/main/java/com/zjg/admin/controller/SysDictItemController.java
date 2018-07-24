package com.zjg.admin.controller;

import java.util.Date;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.zjg.admin.commons.base.BaseController;
import com.zjg.admin.commons.result.PageInfo;
import com.zjg.admin.model.SysDictItem;
import com.zjg.admin.service.ISysDictItemService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author jianguo.zhao
 * @since 2018-07-21
 */
@Controller
@RequestMapping("/sysDictItem")
public class SysDictItemController extends BaseController {

    @Autowired private ISysDictItemService sysDictItemService;
    
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(SysDictItem sysDictItem, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<SysDictItem> ew = new EntityWrapper<SysDictItem>(sysDictItem);
        Page<SysDictItem> pages = new Page<SysDictItem>(pageInfo.getNowpage(), pageInfo.getSize());
        pages = sysDictItemService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/sysDict/sysDictItemAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid SysDictItem sysDictItem) {
        sysDictItem.setCreateTime(new Date());
        sysDictItem.setUpdateTime(new Date());
        boolean b = sysDictItemService.insert(sysDictItem);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    
    /**
     * 删除
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        boolean b = sysDictItemService.deleteById(id);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        return "admin/sysDict/sysDictItemEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid SysDictItem sysDictItem) {
        sysDictItem.setUpdateTime(new Date());
        boolean b = sysDictItemService.updateById(sysDictItem);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
    
    @RequestMapping(value = "getAllFromCache", method = RequestMethod.POST)
	public @ResponseBody Object getAll() {
		Map<String, Object> dictData = sysDictItemService.getMap();
		return this.renderSuccess(dictData);
	}
}
