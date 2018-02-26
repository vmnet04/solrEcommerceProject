package com.mindtree.entity;

import java.util.ArrayList;

public class ProductsSize {

	ArrayList<Products> productList;
	long sizeP;
	ArrayList<Categories> categoryList;
	
	public ArrayList<Products> getProductList() {
		return productList;
	}
	public void setProductList(ArrayList<Products> productList) {
		this.productList = productList;
	}
	public ArrayList<Categories> getCategoryList() {
		return categoryList;
	}
	public void setCategoryList(ArrayList<Categories> categoryList) {
		this.categoryList = categoryList;
	}
	public long getSize() {
		return sizeP;
	}
	public void setSize(long size) {
		this.sizeP = size;
	}
}
