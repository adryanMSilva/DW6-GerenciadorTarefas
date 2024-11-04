package com.project.taskmanager.dto;

public interface IDTO<T> {
	    void save(T obj);
	    void update(T obj);
	    void delete(T obj);
}
