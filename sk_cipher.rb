require 'rbnacl'
require 'base64'

module ModernSymmetricCipher
  def self.generate_new_key
    Base64.strict_encode64(RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes))
  end

  def self.encrypt(doc, key)
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.strict_decode64(key))
    Base64.strict_encode64(simple_box.encrypt(doc))
  end

  def self.decrypt(ciphertext, key)
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.strict_decode64(key))
    simple_box.decrypt(Base64.strict_decode64(ciphertext))
  end
end
