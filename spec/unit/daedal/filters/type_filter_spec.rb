require 'spec_helper'

describe Daedal::Filters::TypeFilter do

  subject do
    Daedal::Filters::TypeFilter
  end

  let(:type) do
    :bar
  end

  let(:hash_filter) do
    {type: {:value => type}}
  end

  context 'without a type specified' do
    it 'will raise an error' do
      expect {subject.new}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with a type specified' do
    let(:filter) do
      subject.new(type: type)
    end
    it 'will populate the type attribute appropriately' do
      expect(filter.type).to eq type
    end
    it 'will have the correct hash representation' do
      expect(filter.to_hash).to eq hash_filter
    end
    it 'will have the correct json representation' do
      expect(filter.to_json).to eq hash_filter.to_json
    end
  end
end
