package com.alj.dream.file_profile.dao;

import java.util.List;

import com.alj.dream.file_profile.domain.FileInfo;

public interface ProfileFilesDao {
	int insertProfileFiles(List<FileInfo> files);
}
