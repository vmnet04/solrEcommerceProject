package com.mindtree.manager;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mindtree.dao.FacetQueryDao;
import com.mindtree.entity.ProductsSize;
import com.mindtree.managerInterface.FacetManagerInterface;

@Service
public class FacetQueryManager implements FacetManagerInterface {

	@Autowired
	FacetQueryDao fqdao;
	
	public ProductsSize facetQuery(int catlevel, String name, String search) throws SolrServerException, IOException {
		
		return fqdao.facetQuery(catlevel, name, search);
	}

	
}
