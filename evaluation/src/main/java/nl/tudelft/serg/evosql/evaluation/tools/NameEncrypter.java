package nl.tudelft.serg.evosql.evaluation.tools;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

import org.apache.axis.types.HexBinary;

public class NameEncrypter {
	private final String[] hexNoToChar = {"G", "H", "I", "J", "K", "L", "M", "N", "O", "P"};
	Cipher ecipher, dcipher;

	NameEncrypter() throws Exception {
		KeyGenerator keygen = KeyGenerator.getInstance("AES");
		keygen.init(128);
		SecretKey key = keygen.generateKey();
		ecipher = Cipher.getInstance("AES");
		dcipher = Cipher.getInstance("AES");
		ecipher.init(Cipher.ENCRYPT_MODE, key);
		dcipher.init(Cipher.DECRYPT_MODE, key);
	}
	
	private String encrypt(String str) throws Exception {
		byte[] bytes = str.getBytes("UTF8");
		
		byte[] enc = ecipher.doFinal(bytes);
		
		// Get hex string
		String hexCoded = HexBinary.encode(enc);
		
		// Convert number values to letters
		for (int i = 0; i <= 9; i++) {
			hexCoded = hexCoded.replaceAll(""+i, hexNoToChar[i]);
		}
		
		return hexCoded.toUpperCase();
	}
	
	private String decrypt(String str) throws Exception {
		// Convert letters to number values
		for (int i = 0; i <= 9; i++) {
			str = str.replaceAll(hexNoToChar[i], ""+i);
		}
		
		byte[] bytes = HexBinary.decode(str.toLowerCase());
		
		byte[] dec = dcipher.doFinal(bytes);
		
		return new String(dec, "UTF8");
		
	}
	
	public String transform(boolean encrypt, String str) throws Exception {
		if (encrypt)
			return encrypt(str);
		else
			return decrypt(str);
	}
}
