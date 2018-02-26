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
	
	@RequestMapping(value ={ "/#/search","/search"},method=RequestMethod.POST)
	@ResponseBody ProductsSize searchQuery(@RequestBody String search) throws SolrServerException, IOException{
		
		
		System.out.println("search"+search);
		ProductsSize ps = searchManager.searchQuery(search);
		System.out.println(ps);
		System.out.println("Size : " + ps.getSize()+"\n");
		return ps;
				
	}
	
	@RequestMapping(value="/{catlevel}/{search}/{name}",method=RequestMethod.GET)
	@ResponseBody ProductsSize facetQuery(@PathVariable("catlevel") int catlevel, @PathVariable("name") String name,
																		@PathVariable("search") String search) 
									throws SolrServerException, IOException{
		
		
		
		System.out.println("search in facet -- "+search);
		System.out.println("name -- "+name);
		System.out.println("catlevel -- "+ catlevel);
		
		ProductsSize ps = facetManager.facetQuery(catlevel, name, search);
		
		
		System.out.println("Size: "+ps.getSize());
		return ps;
	}
}




