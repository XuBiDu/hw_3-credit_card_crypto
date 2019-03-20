module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      document.chars.map{ |c| (c.ord + key).chr}.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      document.chars.map{ |c| (c.ord - key).chr}.join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      srand(key)
      sbox = (0..255).to_a.shuffle(random: Random.new(key))
      document.chars.map{ |c| sbox[c.ord].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      sbox = (0..255).to_a.shuffle(random: Random.new(key))
      document.chars.map{ |c| sbox.index(c.ord).chr }.join
    end
  end
end
