require 'spec_helper'

describe Daedal::Queries::TermsQuery do

  subject do
    Daedal::Queries::TermsQuery
  end

  let(:field) do
    :foo
  end

  let(:terms) do
    [:bar , :superfoo]
  end

  let(:hash_query) do
    {terms: {field => terms} , minimum_should_match: 1}
  end

  context 'without a field or a list of terms specified' do
    it 'will raise an error' do
      expect {subject.new}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'without a field specified' do
    it 'will raise an error' do
      expect {subject.new(terms: terms)}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with a field and a term specified' do
    let(:terms_query) do
      subject.new(field: field, terms: terms)
    end

    it 'will populate the field and term attributes appropriately' do
      expect(terms_query.field).to eq field
      expect(terms_query.terms).to eq terms
    end

    it 'will have minimum match option set to default 1' do
      expect(terms_query.minimum_should_match).to eq 1
    end

    it 'will have the correct hash representation' do
      expect(terms_query.to_hash).to eq hash_query
    end

    it 'will have the correct json representation' do
      expect(terms_query.to_json).to eq hash_query.to_json
    end
  end

  context 'with minimum should match of 2 specified' do
    let(:terms_query) do
      subject.new(field: field, terms: terms, minimum_should_match: 2)
    end

    before do
      hash_query[:minimum_should_match] = 2
    end

    it 'will set the phrase type to :phrase' do
      expect(terms_query.minimum_should_match).to eq 2
    end

    it 'will have the correct hash representation' do
      expect(terms_query.to_hash).to eq hash_query
    end

    it 'will have the correct json representation' do
      expect(terms_query.to_json).to eq hash_query.to_json
    end

  end


end