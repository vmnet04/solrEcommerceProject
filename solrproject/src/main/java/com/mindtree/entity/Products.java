package com.mindtree.entity;

import java.util.Date;

import org.apache.solr.client.solrj.beans.Field;
import org.springframework.stereotype.Component;

@Component
public class Products {

	@Field
	String product_id;
	
	@Field
	Date create_date;
	
	@Field
	String image_small;
	
	@Field
	String image_large;
	
	@Field
	String name;
	
	@Field
	String description;
	
	@Field
	String[] tagline;
	
	@Field
	String[] category;
	
	@Field
	String[] catlevel0;
	
	@Field
	String[] catlevel1;
	
	@Field
	String[] catlevel2;
	
	@Field
	String[] color;
	
	@Field
	String[] size;
	
	public String getProduct_id() {
		return product_id;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public String getImage_small() {
		return image_small;
	}

	public void setImage_small(String image_small) {
		this.image_small = image_small;
	}

	public String getImage_large() {
		return image_large;
	}

	public void setImage_large(String image_large) {
		this.image_large = image_large;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String[] getTagline() {
		return tagline;
	}

	public void setTagline(String[] tagline) {
		this.tagline = tagline;
	}

	public String[] getCategory() {
		return category;
	}

	public void setCategory(String[] category) {
		this.category = category;
	}

	public String[] getCatlevel0() {
		return catlevel0;
	}

	public void setCatlevel0(String[] catlevel0) {
		this.catlevel0 = catlevel0;
	}

	public String[] getCatlevel1() {
		return catlevel1;
	}

	public void setCatlevel1(String[] catlevel1) {
		this.catlevel1 = catlevel1;
	}

	public String[] getCatlevel2() {
		return catlevel2;
	}

	public void setCatlevel2(String[] catlevel2) {
		this.catlevel2 = catlevel2;
	}

	public String[] getColor() {
		return color;
	}

	public void setColor(String[] color) {
		this.color = color;
	}

	public String[] getSize() {
		return size;
	}

	public void setSize(String[] size) {
		this.size = size;
	}

	
}
