package com.alj.dream.post.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadFileController {
	
//	@GetMapping("/post/uploadFile")
//	public String uploadFile() {
//		return "/post/uploadFile";
//	}

	@PostMapping("/post/uploadFile")
	public void uploadFile(
			
			) {
		
	}
	
//	public void uploadFile(
//			HttpServletRequest request,
//			MultipartFile[] uploadFile
//			) {
//		System.out.println("Files upload...");
//		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/files/post/");
//		
//		for(MultipartFile multipartFile : uploadFile) {
//			System.out.println("-----------------------------");
//			System.out.println("Upload file name : " + multipartFile.getOriginalFilename());
//			System.out.println("Upload file size : " + multipartFile.getSize());
//			String uploadFileName = multipartFile.getOriginalFilename();
//			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
//			System.out.println("Only file name : " + uploadFileName);
//			
//			File saveFile = new File(uploadPath, uploadFileName);
//			
//			try {
//				multipartFile.transferTo(saveFile);
//			} catch (Exception e) {
//				System.out.println(e.getMessage());
//				e.printStackTrace();
//			}
//		}
//	}
	
//	@RequestMapping("/post/uploadFileResult")
//	public String getResult() {
//		return "/post/uploadfFileResult";
//	}
	
}
