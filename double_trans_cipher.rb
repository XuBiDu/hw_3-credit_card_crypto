module DoubleTranspositionCipher
  def self.encrypt(doc, key)
    rand = Random.new(key)
    matrix = Matrix.new(doc)
    rows_perm = Permutation.new(matrix.nrows, rand)
    cols_perm = Permutation.new(matrix.ncols, rand)
    matrix.permute_rows(rows_perm.normal)
          .permute_cols(cols_perm.normal)
          .flatten
  end

  def self.decrypt(ciphertext, key)
    rand = Random.new(key)
    matrix = Matrix.new(ciphertext)
    rows_perm = Permutation.new(matrix.nrows, rand)
    cols_perm = Permutation.new(matrix.ncols, rand)
    matrix.permute_cols(cols_perm.reverse)
          .permute_rows(rows_perm.reverse)
          .flatten_trim
  end

  class Matrix
    SPECIAL_CHAR = "\cD".freeze
    attr_reader :nrows, :ncols, :data
    def initialize(doc)
      @ncols = Math.sqrt(doc.size).ceil
      @nrows = (doc.size.to_f / @ncols).ceil
      pad(doc)
    end

    def pad(doc)
      @data = (doc.chars + Array.new(@nrows * @ncols - doc.size, SPECIAL_CHAR))
              .each_slice(@ncols).to_a
    end

    def permute_rows(permutation)
      throw :error if permutation.size != @nrows
      @data = permutation.map { |j| @data[j]}
      self
    end

    def permute_cols(permutation)
      throw :error if permutation.size != @ncols
      @data = permutation.map { |j| @data.transpose[j]}.transpose
      self
    end

    def flatten
      @data.flatten.join
    end

    def flatten_trim
      @data.flatten.reject{ |c| c == SPECIAL_CHAR }.join
    end
  end

  class Permutation
    attr_reader :normal
    def initialize(length, rand)
      @normal = (0..length - 1).to_a.shuffle(random: rand)
    end

    def reverse
      @normal.zip(0..@normal.size - 1).to_a.sort_by { |p| p[0] }.map { |p| p[1] }
    end
  end
end
