package com.alj.dream.file_notice.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class NoticeFileViewController {
	
	@GetMapping("/notice/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(HttpServletRequest request,String fileName){
		System.out.println("파일 이름:" + fileName);
		
		File file = new File(request.getSession().getServletContext().getRealPath("resources/files/notice/attachfiles/") + fileName);
		System.out.println("파일 정보: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
		
	}

	@GetMapping(value="/notice/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(
			@RequestHeader("User-Agent") String userAgent,
			HttpServletRequest request, 
			String fileName){

		System.out.println("다운로드할 파일: " + fileName);
		String path = request.getSession().getServletContext().getRealPath("/resources/files/notice/attachfiles/") + fileName;
		
		Resource resource = new FileSystemResource(path);
		System.out.println("리소스: " + resource);
		
		
		if(resource.exists() == false) { 
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
				
		String resourceName = resource.getFilename();
		System.out.println("resourceName: " + resourceName);
		
		// pk 처리를 위해 붙인 nanoTime 을 파일명에서 제거
		String originnm = resourceName.substring(0, resourceName.lastIndexOf("_"));
		String exet = resourceName.substring(resourceName.lastIndexOf("."));
		String originalName = originnm+exet;
		
		System.out.println("originalName: " + originalName);

		HttpHeaders headers = new HttpHeaders();
		
		String downloadName = "";
		
		try {
			
			// 브라우저 확인 후 각기 처리
			if(userAgent.contains("Trident")) {
				// IE 브라우저
				downloadName = URLEncoder.encode(originalName, "UTF-8").replaceAll("\\+", " ");
				
			} else if(userAgent.contains("Edge")) {
				// Edge 브라우저
				downloadName = URLEncoder.encode(originalName, "UTF-8");
				
			} else {
				downloadName = new String(originalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			// 다운로드 될 이름 지정
			headers.add("Content-Disposition", "attachment; filename="+downloadName);
		
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
}
