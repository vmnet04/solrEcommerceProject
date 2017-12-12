package com.mindtree.daoInterface;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;

import com.mindtree.entity.ProductsSize;

public interface FacetQueryInteface {

	public ProductsSize facetQuery(int catlevel,String name,String search) throws SolrServerException, IOException;
}
