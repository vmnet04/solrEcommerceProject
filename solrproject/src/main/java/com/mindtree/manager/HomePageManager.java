package com.mindtree.manager;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mindtree.dao.HomePageDao;
import com.mindtree.entity.ProductsSize;
import com.mindtree.managerInterface.HomePageManagerInterface;

@Service
public class HomePageManager implements HomePageManagerInterface{

	@Autowired
	HomePageDao dao;
	
	public ProductsSize displayHomePage() throws SolrServerException, IOException {
		
		return dao.displayHomePage();
	}

}
