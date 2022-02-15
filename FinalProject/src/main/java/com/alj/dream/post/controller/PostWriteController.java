package com.alj.dream.post.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alj.dream.file_post.service.PostFileUploadService;
import com.alj.dream.post.domain.PostWriteRequest;
import com.alj.dream.post.service.PostWriteService;
import com.alj.dream.profile.domain.MyProfileInfo;
import com.alj.dream.profile.domain.ProfileRequest;

import security.AccountDetails;

@Controller
public class PostWriteController {

	@Autowired
	private PostWriteService writeService;

	@Autowired
	private PostFileUploadService uploadService;

	@GetMapping("/post/write")
	public String getWriteForm(Authentication authentication, Model model) {
		
		AccountDetails logininfo= (AccountDetails)authentication.getPrincipal();
		int m_idx = Integer.parseInt(logininfo.getM_idx());
		
		ProfileRequest writerProfile = writeService.getWriterProfile(m_idx);
		model.addAttribute("writerProfile", writerProfile);

		return "post/writeform";
	}

	@PostMapping("/post/write")
	@ResponseBody
	public Map<String, Integer> writePost(HttpServletRequest request, PostWriteRequest wRequest) {

		Map<String, Integer> result = new HashMap<String, Integer>();

		int resultCnt = 0;

		// 글 업로드
		resultCnt = writeService.insertPost(wRequest);

		// 파일업로드 처리
		int post_idx = wRequest.getPost_idx();

		List<MultipartFile> fileList = wRequest.getFileList();
		System.out.println(fileList);

		if (!fileList.isEmpty()) {
			uploadService.uploadfile(request, post_idx, fileList);
		}

		result.put("cnt", resultCnt);
		result.put("idx", post_idx);

		return result;

		// return "redirect:/post/list";
		// return
		// "redirect:".concat(request.getContextPath().concat("/post/content?post_idx").concat(String.valueOf(wRequest.getPost_idx())));

	}

	@PostMapping("/post/checkProfile")
	@ResponseBody
	public MyProfileInfo getProfile(String type, String idx) {
				
		return writeService.getProfile(idx);

	}

}
