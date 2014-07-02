require 'spec_helper'

describe Daedal::Queries::TermQuery do

  subject do
    Daedal::Queries::TermQuery
  end

  let(:field) do
    :foo
  end

  let(:term) do
    :bar
  end

  context 'without a field or a term specified' do
    it 'will raise an error' do
      expect { subject.new(boost: 2) }.to raise_error(Virtus::CoercionError)
    end
  end

  context 'without a field specified' do
    it 'will raise an error' do
      expect { subject.new(term: term) }.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with both value and term specified' do
    it 'will raise an error' do
      expect { subject.new(field: field, term: term, value: term) }.to raise_error(RuntimeError)
    end
  end

  context 'with value specified only (without boost)' do
    it 'will raise an error' do
      expect { subject.new(field: field, value: term) }.to raise_error(RuntimeError)
    end
  end

  context 'with a field and a term specified (without boost)' do
    let(:query) do
      subject.new(field: field, term: term)
    end

    let(:hash_query) do
      {term: {field => term}}
    end

    it 'will populate the field and term attributes appropriately' do
      expect(query.field).to eq field
      expect(query.term).to eq term
    end
    it 'will have the correct hash representation' do
      expect(query.to_hash).to eq hash_query
    end
    it 'will have the correct json representation' do
      expect(query.to_json).to eq hash_query.to_json
    end
  end

  context 'with a field and a term specified (with boost)' do
    let(:query) do
      subject.new(field: field, term: term, boost: 2.0)
    end

    let(:hash_query) do
      {term: {field => {term: term, boost: 2.0}}}
    end

    it 'will populate the field and term attributes appropriately' do
      expect(query.field).to eq field
      expect(query.term).to eq term
    end
    it 'will have the correct hash representation' do
      expect(query.to_hash).to eq hash_query
    end
    it 'will have the correct json representation' do
      expect(query.to_json).to eq hash_query.to_json
    end

  end

  context 'with a field and a value specified (with boost)' do
    let(:query) do
      subject.new(field: field, value: term, boost: 2.0)
    end

    let(:hash_query) do
      {term: {field => {value: term, boost: 2.0}}}
    end

    it 'will populate the field and term attributes appropriately' do
      expect(query.field).to eq field
      expect(query.value).to eq term
    end
    it 'will have the correct hash representation' do
      expect(query.to_hash).to eq hash_query
    end
    it 'will have the correct json representation' do
      expect(query.to_json).to eq hash_query.to_json
    end

  end

end