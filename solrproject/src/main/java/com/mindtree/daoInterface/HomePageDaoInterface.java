package com.mindtree.daoInterface;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;

import com.mindtree.entity.ProductsSize;

public interface HomePageDaoInterface {

	public ProductsSize displayHomePage() throws SolrServerException, IOException;
}