package com.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class TakeFilePathAndName {

    public static void main(String[] args) {
        // This is the path where the file's name you want to take.
        String path = "D:\\workplace\\IDEA\\ECIPCSweb\\excel\\grade";
        getFile(path);
    }

    public static List<String> getFile(String path){
        // get file list where the path has
        File file = new File(path);
        // get the folder list
        File[] array = file.listFiles();

        List<String> fileName = new ArrayList<>();

        for(int i=0;i<array.length;i++){
            if(array[i].isFile()){
                // only take file name
                fileName.add(array[i].getName());
            }else if(array[i].isDirectory()){
                getFile(array[i].getPath());
            }
        }
        return fileName;
    }
}