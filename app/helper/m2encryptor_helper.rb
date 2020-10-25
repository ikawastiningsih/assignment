module M2encryptorHelper
	# @@key = nil
	@@iv = nil
	@@key = "1Hbfh667adfDEJ78"
	def self.encryption(msg)
		begin
			cipher = OpenSSL::Cipher.new("AES-128-ECB")
			cipher.encrypt()
			cipher.key = @@key
			crypt = cipher.update(msg) + cipher.final()
			crypt_string = (Base64.encode64(crypt))
			return crypt_string.strip
		rescue Exception => exc
			puts ("Message for the encryption log file for message #{msg} = #{exc.message}")
		end
	end

	def self.decryption(msg)
		begin
			cipher = OpenSSL::Cipher.new("AES-128-ECB")
			cipher.decrypt()
			cipher.key = @@key
			tempkey = Base64.decode64(msg)
			crypt = cipher.update(tempkey)
			crypt << cipher.final()
			return crypt
		rescue Exception => exc
			puts ("Message for the decryption log file for message #{msg} = #{exc.message}")
		end
	end
end
