require 'spec_helper'

describe Daedal::Filters::NotFilter do

  context 'without filter specified' do
    it 'will raise an error' do
      expect { described_class.new }.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with filter specified' do
    subject { described_class.new(filter: term_filter) }

    let(:term_filter) { Daedal::Filters::TermFilter.new(field: :foo, term: :bar) }
    let(:hash_filter) { { :not => term_filter.to_hash } }

    it 'will populate the field and term attributes appropriately' do
      expect(subject.filter).to eq term_filter
    end
    it 'will have the correct hash representation' do
      expect(subject.to_hash).to eq hash_filter
    end
    it 'will have the correct json representation' do
      expect(subject.to_json).to eq hash_filter.to_json
    end
  end
end
