package com.alj.dream.file_post.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alj.dream.file_post.domain.PostFileRequest;

@Controller
@RequestMapping("/post/uploadfile")
public class PostFileUploadController {

	@PostMapping
	@ResponseBody
	public List<PostFileRequest> uploadfile(HttpServletRequest request, List<MultipartFile> attachfiles) {
		
		List<PostFileRequest> list = new ArrayList<PostFileRequest>();
		
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/files/post/attachfiles");
		System.out.println(saveDir);

		for (MultipartFile multipartFile : attachfiles) {
			
			System.out.println("-----------------------------");
			System.out.println("Upload file name : " + multipartFile.getOriginalFilename());
			System.out.println("Upload file size : " + multipartFile.getSize());

			String filename = multipartFile.getOriginalFilename();
			int pos = filename .lastIndexOf(".");
			String file_originnm = filename.substring(0, pos);
			String file_exet = filename.substring(pos + 1);
			
			int file_size = (int) multipartFile.getSize()/1024;

			String file_nm = file_originnm + "_" + String.valueOf(System.nanoTime());

			File saveFile = new File(saveDir, file_nm + "." + file_exet);

			if(!saveFile.exists()) {
				saveFile.mkdir();
			}
			
			try {
				multipartFile.transferTo(saveFile);
				System.out.println("파일 업로드 성공");
				
				PostFileRequest postFile = new PostFileRequest(file_nm, 0, file_exet, file_size, file_originnm);
				
				System.out.println(postFile);
				
				list.add(postFile);

			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}

		}
		
		return list;
	}
	
}
