package com.mindtree.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mindtree.entity.ProductsSize;
import com.mindtree.manager.HomePageManager;

@Controller
@CrossOrigin
@Scope("session")
public class HomePageController {

	@Autowired
	HomePageManager homePage;
	
	@RequestMapping("/")
	public ModelAndView showMainPage(HttpServletRequest request) throws SolrServerException, IOException{
		
		ProductsSize ps = homePage.displayHomePage();
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("products",ps.getProductList());
		mv.addObject("categories",ps.getCategoryList());
		mv.addObject("size",ps.getSize());
		mv.setViewName("index");
		
		return mv;
	}
}
