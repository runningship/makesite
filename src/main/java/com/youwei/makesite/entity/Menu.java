package com.youwei.makesite.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Menu {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String name;
	
	public Integer parentId;
	
	public Integer orderx;
	
	//menu(下面有子菜单),conts(下面没有子菜单)
	public String type;
	
	//当type=conts时，有效
	public String conts;
	
	public String _site;
}
