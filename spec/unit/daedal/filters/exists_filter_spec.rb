require 'spec_helper'

describe Daedal::Filters::TermFilter do

  subject do
    Daedal::Filters::ExistsFilter
  end

  let(:field) do
    :some_index_name
  end

  let(:hash_filter) do
    {exists: {:field => field}}
  end

  context 'without a field specified' do
    it 'will raise an error' do
      expect {subject.new}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with a field and a term specified' do
    let(:filter) do
      subject.new(field: field)
    end

    it 'will populate the field and term attributes appropriately' do
      expect(filter.field).to eq field
    end

    it 'will have the correct hash representation' do
      expect(filter.to_hash).to eq hash_filter
    end

    it 'will have the correct json representation' do
      expect(filter.to_json).to eq hash_filter.to_json
    end
  end
end