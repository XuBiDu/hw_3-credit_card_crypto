require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    it 'Should check hashes are never nil' do
      cards[0].hash.wont_be_nil
      cards[1].hash.wont_be_nil
      cards[2].hash.wont_be_nil
    end

    it 'Should check hashes are consistently produced' do
      cards[0].hash.must_equal cards[0].hash
      cards[1].hash.must_equal cards[1].hash
      cards[2].hash.must_equal cards[2].hash
    end

    it 'Should check for unique hashes' do
      cards[0].hash.wont_equal cards[1].hash
      cards[0].hash.wont_equal cards[2].hash
      cards[1].hash.wont_equal cards[2].hash
    end
  end

  describe 'Test cryptographic hashing' do
    it 'Should check hashes are never nil' do
      cards[0].hash_secure.wont_be_nil
      cards[1].hash_secure.wont_be_nil
      cards[2].hash_secure.wont_be_nil
    end

    it 'Should check hashes are consistently produced' do
      cards[0].hash_secure.must_equal cards[0].hash_secure
      cards[1].hash_secure.must_equal cards[1].hash_secure
      cards[2].hash_secure.must_equal cards[2].hash_secure
    end

    it 'Should check for unique hashes' do
      cards[0].hash_secure.wont_equal cards[1].hash_secure
      cards[0].hash_secure.wont_equal cards[2].hash_secure
      cards[1].hash_secure.wont_equal cards[2].hash_secure
    end
  end

  describe 'Compare cryptographic and regular hashing' do
    it 'Should check regular hash not same as cryptographic hash' do
      cards[0].hash_secure.wont_equal cards[0].hash
      cards[1].hash_secure.wont_equal cards[1].hash
      cards[2].hash_secure.wont_equal cards[2].hash
    end
  end
end
