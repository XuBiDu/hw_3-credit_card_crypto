# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end

  describe 'Using Caesar cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc.to_s, @key)
      enc.wont_equal @cc.to_s
      enc.wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc.to_s, @key)
      dec = SubstitutionCipher::Caesar.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end

  describe 'Using Permutation cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc.to_s, @key)
      enc.wont_equal @cc.to_s
      enc.wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc.to_s, @key)
      dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end

  describe 'Using Double-Transposition cipher' do
    it 'should encrypt card information' do
      enc = DoubleTranspositionCipher.encrypt(@cc.to_s, @key)
      enc.wont_equal @cc.to_s
      enc.wont_be_nil
    end

    it 'should decrypt text' do
      enc = DoubleTranspositionCipher.encrypt(@cc.to_s, @key)
      dec = DoubleTranspositionCipher.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end

  describe 'Using Modern SK cipher' do
    it 'should encrypt card information' do
      @key = ModernSymmetricCipher.generate_new_key
      enc = ModernSymmetricCipher.encrypt(@cc.to_s, @key)
      enc.wont_equal @cc.to_s
      enc.wont_be_nil
    end

    it 'should decrypt text' do
      @key = ModernSymmetricCipher.generate_new_key
      enc = ModernSymmetricCipher.encrypt(@cc.to_s, @key)
      dec = ModernSymmetricCipher.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end
end
