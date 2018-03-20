package com.cafe24.ourplanners.upload.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cafe24.ourplanners.util.MediaUtils;
import com.cafe24.ourplanners.util.UploadFileUtils;


@Controller
public class UploadController {

  private static final Logger logger = LoggerFactory.getLogger(UploadController.class);

  @Resource(name = "upload")
  private String uploadPath;

  //일반 업로드 폼 보기
  @RequestMapping(value = "upload/uploadForm", method = RequestMethod.GET)
  public void uploadForm() {
  }

  //일반 업로드 처리 테스트
  @RequestMapping(value = "upload/uploadForm", method = RequestMethod.POST)
  public String uploadForm(MultipartFile file, Model model) throws Exception {

	  logger.info("파일이름 :"+file.getOriginalFilename());
      logger.info("파일크기 : "+file.getSize());
      logger.info("컨텐트 타입 : "+file.getContentType());

   // 랜덤생성+파일이름 저장
   // 파일명 랜덤생성 메서드호출
    String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());

    // 파일의 원본이름 저장
    model.addAttribute("savedName", savedName);

    return "uploadResult";
  }

  //파일명 랜덤 생성 메소드
  private String uploadFile(String originalName, byte[] fileData) throws Exception {

	  // uuid 생성(Universal Unique IDentifier, 범용 고유 식별자)
      UUID uuid = UUID.randomUUID();
      // 랜덤생성+파일이름 저장
      String savedName = uuid.toString()+"_"+originalName;
      File target = new File(uploadPath, savedName);
      // 임시디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사
      // FileCopyUtils.copy(바이트배열, 파일객체)
      FileCopyUtils.copy(fileData, target);
      return savedName;

  }
  
  //ajax 업로드 폼 보기
  @RequestMapping(value = "upload/uploadAjax", method = RequestMethod.GET)
  public void uploadAjax() {
  }
  
  //ajax 업로드 처리
  @ResponseBody
  @RequestMapping(value ="upload/uploadAjax", method=RequestMethod.POST, 
                  produces = "text/plain;charset=UTF-8")//파일 한글처리
  public ResponseEntity<String> uploadAjax(MultipartFile file)throws Exception{
    
    logger.info("originalName: " + file.getOriginalFilename());
    
   
    return 
      new ResponseEntity<String>(
          UploadFileUtils.uploadFile(uploadPath, 
                file.getOriginalFilename(), 
                file.getBytes()), 
          HttpStatus.CREATED);
  }
  
  
  //이미지 표시 매핑
  @ResponseBody // view가 아닌 data리턴
  @RequestMapping("upload/displayFile")
  public ResponseEntity<byte[]> displayFile(String fileName,String directory, HttpServletRequest request) throws Exception {
      // 서버의 파일을 다운로드하기 위한 스트림
	  InputStream in = null; //java.io
      ResponseEntity<byte[]> entity = null;
      
      try {
          // 확장자를 추출하여 formatName에 저장
          String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
          // 추출한 확장자를 MediaUtils클래스에서  이미지파일여부를 검사하고 리턴받아 mType에 저장
          MediaType mType = MediaUtils.getMediaType(formatName);
          // 헤더 구성 객체(외부에서 데이터를 주고받을 때에는 header와 body를 구성해야하기 때문에)
          HttpHeaders headers = new HttpHeaders();
          // InputStream 생성
         
        //파일 기본경로
         String path = request.getSession().getServletContext().getRealPath("/resources/upload/"+directory);
         
  		/*File file = new File(path);
  		if(!file.exists()) {
  		  file.mkdirs();
  		}*/
  		System.out.println("display path : "+path);
  		System.out.println("display / filename 전체 파일 경로명:"+path+File.separator+fileName); 		
          
          in = new FileInputStream(path + fileName);
          //System.out.println("upload path :"+uploadPath);
          // 이미지 파일이면
          if (mType != null) { 
              headers.setContentType(mType);
          // 이미지가 아니면
          } else { 
              fileName = fileName.substring(fileName.indexOf("_") + 1);
              // 다운로드용 컨텐트 타입
              headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
              // 
              // 바이트배열을 스트링으로 : new String(fileName.getBytes("utf-8"),"iso-8859-1") * iso-8859-1 서유럽언어, 큰 따옴표 내부에  " \" 내용 \" "
              // 파일의 한글 깨짐 방지
              headers.add("Content-Disposition", "attachment; filename=\""+new String(fileName.getBytes("utf-8"), "iso-8859-1")+"\"");
              //headers.add("Content-Disposition", "attachment; filename='"+fileName+"'");
          }
          // 바이트배열, 헤더, HTTP상태코드
          entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
      } catch (Exception e) {
          e.printStackTrace();
          // HTTP상태 코드()
          entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
      } finally {
          in.close(); //스트림 닫기
      }
      return entity;
  }

  
  //파일삭제
  @ResponseBody // view가 아닌 데이터 리턴
  @RequestMapping(value = "upload/deleteFile", method = RequestMethod.POST)
  public ResponseEntity<String> deleteFile(String fileName) {
      // 파일의 확장자 추출
      String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
      // 이미지 파일 여부 검사
      MediaType mType = MediaUtils.getMediaType(formatName);
      // 이미지의 경우(썸네일 + 원본파일 삭제), 이미지가 아니면 원본파일만 삭제
      // 이미지 파일이면
      if (mType != null) {
          // 썸네일 이미지 파일 추출
          String front = fileName.substring(0, 12);
          String end = fileName.substring(14);
          // 썸네일 이미지 삭제
          new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
      }
      // 원본 파일 삭제
      new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();

      // 데이터와 http 상태 코드 전송
      return new ResponseEntity<String>("deleted", HttpStatus.OK);
  } 
  
  @ResponseBody
  @RequestMapping(value="upload/deleteAllFiles", method=RequestMethod.POST)
  public ResponseEntity<String> deleteFile(@RequestParam("files[]") String[] files){
    
    logger.info("delete all files: "+ Arrays.toString(files));
    
    if(files == null || files.length == 0) {
      return new ResponseEntity<String>("deleted", HttpStatus.OK);
    }
//    
//    for (String fileName : files) {
//      String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
//      
//      MediaType mType = MediaUtils.getMediaType(formatName);
//      
//      if(mType != null){      
//        
//        String front = fileName.substring(0,12);
//        String end = fileName.substring(14);
//        new File(uploadPath + (front+end).replace('/', File.separatorChar)).delete();
//      }
//      
//      new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
//      
//    }
    return new ResponseEntity<String>("deleted", HttpStatus.OK);
  }  

}
