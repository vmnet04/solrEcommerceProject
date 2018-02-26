package com.mindtree.dao;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.FacetField.Count;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.springframework.stereotype.Repository;

import com.mindtree.daoInterface.FacetQueryInteface;
import com.mindtree.entity.Categories;
import com.mindtree.entity.Products;
import com.mindtree.entity.ProductsSize;


@Repository
public class FacetQueryDao implements FacetQueryInteface{

	
	private InputStream inputstream;
	private Properties prop;
	private String url = null;
	
	public ProductsSize facetQuery(int catlevel, String name,String search) throws SolrServerException, IOException {
		try{
			prop = new Properties();
			String fileName = "application.properties";
			
			inputstream = getClass().getClassLoader().getResourceAsStream(fileName);
			if (inputstream != null) 
				prop.load(inputstream);
			else 
				throw new FileNotFoundException("property file '" + fileName + "' not found in the classpath");
			
			url = prop.getProperty("url");
			
			}catch (Exception e) {
				System.out.println("Exception: " + e);
			} finally {
				inputstream.close();
			}
	
		Products products = new Products();
		ProductsSize ps = new ProductsSize();
		
		ArrayList<Categories> catList = new ArrayList<Categories>();
		ArrayList<Products> productsList = new ArrayList<Products>();
		
		HttpSolrServer server = new HttpSolrServer(url);
		SolrQuery query = new SolrQuery();
		search = search.replaceAll("-"," ");
		query.setQuery(search);
		query.setFacet(true);
        query.addFacetField("catlevel0");
        query.setFacetLimit(10);
        query.setFacetSort("index");
		query.addFilterQuery("catlevel0:"+"\""+name+"\"");
		
		QueryResponse response = server.query(query);
		long size = response.getResults().getNumFound();
		
		ps.setSize(size);
		
		productsList = (ArrayList<Products>) response.getBeans(Products.class);
		ps.setProductList(productsList);
		
		System.out.println("Query :  " + query.toString());

		catList = setCategoriesList(search);
		System.out.println("Image Small"+productsList.get(0).getImage_small());
		
		ps.setCategoryList(catList);
		return ps;
	}
	

private ArrayList<Categories> setCategoriesList(String search) throws IOException, SolrServerException {
		
		ArrayList<Categories> catList = new ArrayList<Categories>();
		try{
			prop = new Properties();
			String fileName = "application.properties";
			
			inputstream = getClass().getClassLoader().getResourceAsStream(fileName);
			if (inputstream != null) 
				prop.load(inputstream);
			else 
				throw new FileNotFoundException("property file '" + fileName + "' not found in the classpath");
			
			url = prop.getProperty("url");
			
			}catch (Exception e) {
				System.out.println("Exception: " + e);
			} finally {
				inputstream.close();
			}
	
		
		
		
		HttpSolrServer server = new HttpSolrServer(url);
		SolrQuery query = new SolrQuery();
		
		search = search.replaceAll("-"," ");
		query.setQuery(search);
		query.setFacet(true).
        addFacetField("catlevel0").
        setFacetLimit(10).
        setFacetSort("index");
		
		QueryResponse response = server.query(query);
		long size = response.getResults().getNumFound();
		
		
		for(FacetField ff :response.getFacetFields()){
			
			List<Count> catNames = ff.getValues();
//			System.out.println("Catljdls" + ff.toString());
			
			for(Count c : catNames )
			{
				Categories categories = new Categories();
				categories.setName(c.getName());
				categories.setSize(c.getCount());
				catList.add(categories);
			}
			
		}
		
		return catList;
	}

}
