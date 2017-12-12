package com.mindtree.managerInterface;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;

import com.mindtree.entity.ProductsSize;

public interface FacetManagerInterface {

	public ProductsSize facetQuery(int catlevel,String name,String search) throws SolrServerException, IOException;
	
}
