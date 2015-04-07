require 'spec_helper'

describe Daedal::Queries::FunctionScoreQuery do

  let(:score_functions) do
    [
      filter: Daedal::Filters::TermFilter.new(field: :foo, term: :bar),
      weight: 100
    ]
  end

  let(:query) do
    Daedal::Queries::MatchAllQuery.new
  end

  let(:filter) do
    Daedal::Filters::TermFilter.new(field: :foo, term: :bar)
  end

  context 'without a query specified' do
    it 'will raise an error' do
      expect{ described_class.new(score_functions: score_functions) }.to raise_error
    end
  end

  context 'without a boost specified' do
    it 'will raise an error' do
      expect{ described_class.new(query: query, score_functions: score_functions) }.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with valid arguments' do
    it 'converts to a valid query with filter' do
      valid_query =  described_class.new(query: query, score_functions: score_functions,
                                         filter: filter, boost: 42, score_mode: 'sum')
      expect(valid_query.to_hash[:function_score][:query][:filtered][:query]).to eq(query.to_hash)
      expect(valid_query.to_hash[:function_score][:query][:filtered][:filter]).to eq(filter.to_hash)
      expect(valid_query.to_hash[:function_score][:functions]).to eq(score_functions.map do |f|
        { :filter => f[:filter].to_hash, :weight => f[:weight] }
      end)
      expect(valid_query.to_hash[:function_score][:boost]).to eq(42)
      expect(valid_query.to_hash[:function_score][:score_mode]).to eq('sum')
    end

    it 'converts to a valid query without filter' do
      valid_query =  described_class.new(query: query, score_functions: score_functions, boost: 42, score_mode: 'sum')
      expect(valid_query.to_hash[:function_score][:query]).to eq(query.to_hash)
      expect(valid_query.to_hash[:function_score][:functions]).to eq(score_functions.map do |f|
        { :filter => f[:filter].to_hash, :weight => f[:weight] }
      end)
      expect(valid_query.to_hash[:function_score][:boost]).to eq(42)
      expect(valid_query.to_hash[:function_score][:score_mode]).to eq('sum')
    end
  end
end