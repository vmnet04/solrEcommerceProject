package com.mindtree.manager;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mindtree.dao.SearchDao;
import com.mindtree.entity.ProductsSize;
import com.mindtree.managerInterface.SearchManagerInterface;

@Service
public class SearchManager implements SearchManagerInterface{

	@Autowired
	SearchDao searchDao;
	
	public ProductsSize searchQuery(String search) throws SolrServerException, IOException {
		return searchDao.searchQuery(search);
	}

}
