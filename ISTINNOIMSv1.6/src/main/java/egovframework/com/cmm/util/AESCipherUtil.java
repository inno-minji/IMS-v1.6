package egovframework.com.cmm.util;

import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;

public class AESCipherUtil {
	//기업별로 16바이트 키값을 다르게 설정
	 private static final String key = "uR9eH8yX6oWt0K3D";  // 16바이트 키 (AES-128) 해당 고정값 으로 지정
	 private static final String iv = "jD2w9IhT4JkP5MnQ";   // 16바이트 IV (초기화 벡터) 해당 고정값 으로 지정
 
	// AES 암호화
	    public static String encrypt(String plaintext) throws Exception {
	    	 // null이거나 빈 문자열(띄어쓰기만 있는 경우)은 처리하지 않음
	    	if (plaintext == null || plaintext.trim().isEmpty()) {
	            return plaintext;  // 암호화하지 않고 원래 값 그대로 반환
	        }
	        // 키와 IV를 이용해 암호화 준비
	        SecretKey secretKey = new javax.crypto.spec.SecretKeySpec(key.getBytes(), "AES");
	        IvParameterSpec ivSpec = new IvParameterSpec(iv.getBytes());

	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivSpec);

	        byte[] encrypted = cipher.doFinal(plaintext.getBytes());
	        return Base64.getEncoder().encodeToString(encrypted);  // Base64로 인코딩
	    }
	    
	    public static String decrypt(String ciphertext) throws Exception {
	    	// null이거나 빈 문자열(띄어쓰기만 있는 경우)은 처리하지 않음
    	   if (ciphertext == null || ciphertext.trim().isEmpty()) {
    	        return ciphertext;  // 복호화하지 않고 원래 값 그대로 반환
    	    }
    	   try {
	        // 키와 IV를 이용해 복호화 준비
	        SecretKey secretKey = new javax.crypto.spec.SecretKeySpec(key.getBytes(), "AES");
	        IvParameterSpec ivSpec = new IvParameterSpec(iv.getBytes());

	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        cipher.init(Cipher.DECRYPT_MODE, secretKey, ivSpec);

	        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(ciphertext));
	        
	        return new String(decrypted);
	        
    	   } catch (IllegalBlockSizeException | BadPaddingException e) {
    	        // 패딩 오류가 발생한 경우 위변조 처리
    		   return "데이터베이스 값 변경이 감지되었습니다.";
    	    }
	    }
	    
	    
	    
}
