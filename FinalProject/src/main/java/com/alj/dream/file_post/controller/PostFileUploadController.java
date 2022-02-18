package com.alj.dream.file_post.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.alj.dream.file_post.domain.PostFileRequest;
import com.alj.dream.file_post.service.PostFileUploadService;

@Controller
@RequestMapping("/post/uploadfile")
public class PostFileUploadController {
	
	@Autowired
	private PostFileUploadService service;

	@PostMapping
	public void uploadfile(HttpServletRequest request, int post_idx, List<MultipartFile> fileList) {
		
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/files/post/");

		for (MultipartFile multipartFile : fileList) {
			System.out.println("-----------------------------");
			System.out.println("Upload file name : " + multipartFile.getOriginalFilename());
			System.out.println("Upload file size : " + multipartFile.getSize());

			int file_size = (int) multipartFile.getSize();

			String[] files = multipartFile.getOriginalFilename().split("\\.");
			String file_exet = files[files.length - 1];

			String file_nm = multipartFile.getOriginalFilename()+"_"+String.valueOf(System.nanoTime());

			File saveFile = new File(saveDir, file_nm + "." + file_exet);

			try {
				multipartFile.transferTo(saveFile);
				System.out.println("파일 업로드 성공");
				
				// 이미지인지 확인 후 썸네일 만들기
//				if(checkImageType(saveFile)) {
//					File thumbFile = new File(saveDir, "s_" + file_nm + "." + file_exet);
//					BufferedImage thumbnail = createThumbnail(multipartFile, 200, 200);
//					
//				}
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}

			// file_post 테이블에 insert
			PostFileRequest fileRequest = new PostFileRequest(file_nm, post_idx, file_exet, file_size);
			service.insertPostFile(fileRequest);
			System.out.println("파일 DB에 저장");
			System.out.println("=====================================\n");
			
		}
	}
	
	// 이미지 타입인지 확인
//	private boolean checkImageType(File file) {
//
//		try {
//
//			String contentType = Files.probeContentType(file.toPath());
//			return contentType.startsWith("image");
//			
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//		return false;
//
//	}

	// 썸네일 이미지 생성
//	private BufferedImage createThumbnail(MultipartFile file, int thumbWidth, int thumbHeight) throws IOException {
//		InputStream in = file.getInputStream();
//		
//		BufferedImage originalImage = ImageIO.read(in);
//		BufferedImage thumbImage = new BufferedImage(thumbWidth, thumbHeight, BufferedImage.TYPE_INT_RGB);
//		
//		Graphics2D g = thumbImage.createGraphics();
//		g.setBackground(Color.WHITE);
//	    g.drawImage(originalImage, 0, 0, thumbWidth, thumbHeight, null);
//	    g.dispose();
//		
//	    in.close();
//	    
//		return thumbImage;		
//	}
	
}
