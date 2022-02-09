package com.alj.dream.loc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alj.dream.loc.domain.Location;
import com.alj.dream.loc.service.LocationListService;

@RestController
@RequestMapping("/loc/list")
public class LocationListController {
	
	private LocationListService locService;
	
	public LocationListController() {
		// TODO Auto-generated constructor stub
	}
	
	
	@Autowired
	public LocationListController(LocationListService locService) {
		this.locService = locService;
	}


	@PostMapping
	public List<Location> getLocations(){
		
		List<Location> list =null;
		try {
			list=locService.getLocations();
			
			
		}catch(Exception e) {
			
			e.printStackTrace();
		}
		
		return list;
		
	}
	

}
