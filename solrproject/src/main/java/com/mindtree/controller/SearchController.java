package com.mindtree.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mindtree.entity.ProductsSize;
import com.mindtree.manager.FacetQueryManager;
import com.mindtree.manager.SearchManager;

@Controller
@CrossOrigin
@Scope("session")
public class SearchController {

	@Autowired
	SearchManager searchManager;
	
	@Autowired
	FacetQueryManager facetManager;
	
	@RequestMapping(value = "/search",method=RequestMethod.POST)
	@ResponseBody ModelAndView searchQuery(@RequestBody String search,HttpServletRequest request,ModelAndView mv) throws SolrServerException, IOException{
		
		System.out.println("Search : "+search+"\n");
		ProductsSize ps = searchManager.searchQuery(search);
		
		HttpSession session = request.getSession();
		
		mv.addObject("products",ps.getProductList());
		mv.addObject("categories",ps.getCategoryList());
		mv.addObject("size",ps.getSize());
		mv.setViewName("index");
		System.out.println("mv"+mv+"\n\n");
		session.setAttribute("searchText", search);
		session.setAttribute("size1",ps.getSize());
		session.setAttribute("catList", ps.getCategoryList());
		session.setAttribute("productList",ps.getProductList());
		
		
		return mv;
				
	}
	
	@RequestMapping(value="/{catlevel}/{search}/{name}",method=RequestMethod.GET)
	@ResponseBody ModelAndView facetQuery(@PathVariable("catlevel") int catlevel, @PathVariable("name") String name,HttpServletRequest request,
																		@PathVariable("search") String search) 
									throws SolrServerException, IOException{
		
		HttpSession session = request.getSession();
		//String search = (String) session.getAttribute("searchText");
		
		System.out.println("search in facet -- "+search);
		System.out.println("name -- "+name);
		System.out.println("catlevel -- "+ catlevel);
		
		ProductsSize ps = facetManager.facetQuery(catlevel, name, search);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("products",ps.getProductList());
		mv.addObject("categories",ps.getCategoryList());
		mv.addObject("size",ps.getSize());
		mv.setViewName("index");
		
		session.setAttribute("searchText", search);
		session.setAttribute("catlevel",catlevel);
		session.setAttribute("size1",ps.getSize());
		session.setAttribute("catList", ps.getCategoryList());
		session.setAttribute("productList",ps.getProductList());
		
		System.out.println("modelandviee "+mv);
		System.out.println("Size: "+ps.getSize());
		return mv;
	}
}




