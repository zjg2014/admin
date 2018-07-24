package com.zjg.admin.controller;

import javax.validation.Valid;

import java.util.List;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.zjg.admin.commons.base.BaseController;
import com.zjg.admin.commons.result.PageInfo;
import com.zjg.admin.model.SysDictItem;
import com.zjg.admin.model.SysDictType;
import com.zjg.admin.service.ISysDictTypeService;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author jianguo.zhao
 * @since 2018-07-21
 */
@Controller
@RequestMapping("/sysDictType")
public class SysDictTypeController extends BaseController {

    @Autowired private ISysDictTypeService sysDictTypeService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/sysDict/sysDictTypeList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(SysDictType sysDictType, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<SysDictType> ew = new EntityWrapper<SysDictType>(sysDictType);
        Page<SysDictType> pages = new Page<SysDictType>(pageInfo.getNowpage(), pageInfo.getSize());
        pages = sysDictTypeService.selectPage(pages, ew);
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
        return "admin/sysDict/sysDictTypeAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid SysDictType sysDictType) {
        sysDictType.setCreateTime(new Date());
        sysDictType.setUpdateTime(new Date());
        boolean b = sysDictTypeService.insert(sysDictType);
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
        SysDictType sysDictType = new SysDictType();
        sysDictType.setId(id);
        sysDictType.setUpdateTime(new Date());
        boolean b = sysDictTypeService.updateById(sysDictType);
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
        return "admin/sysDict/sysDictTypeEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid SysDictType sysDictType) {
        sysDictType.setUpdateTime(new Date());
        boolean b = sysDictTypeService.updateById(sysDictType);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
