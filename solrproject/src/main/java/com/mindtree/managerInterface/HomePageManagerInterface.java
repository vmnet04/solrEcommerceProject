package com.mindtree.managerInterface;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;

import com.mindtree.entity.ProductsSize;

public interface HomePageManagerInterface {

	public ProductsSize displayHomePage() throws SolrServerException, IOException;
}
