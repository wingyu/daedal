require 'spec_helper'

describe Daedal::Queries::RangeQuery do

  subject do
    Daedal::Queries::RangeQuery
  end

  let(:field) { :foo }
  let(:boost) { 1.0 }

  minimum_attributes = [:lt, :lte, :gt, :gte].sort
  minimum_attributes.each { |a| let(a) { rand(0..100) } }

  context 'without a field specified' do
    it 'will raise an error' do
      expect { subject.new(lt: 42) }.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with field specified only (without minimum attribute or boost)' do
    it 'will raise an error' do
      expect { subject.new(field: field) }.to raise_error(RuntimeError)
    end
  end

  context 'with field and boost specified (without minimum attribute)' do
    it 'will raise an error' do
      expect { subject.new(field: field, boost: boost) }.to raise_error(RuntimeError)
    end
  end

  context 'with field and one minimum attribute' do
    minimum_attributes.each do |a|
      let(:params) { { field: field, a => self.send(a) } }
      it "will populate the field attribute appropriately" do
        expect(subject.new(params).field).to eq field
      end
      it "will populate the #{a} attribute appropriately" do
        expect(subject.new(params).send(a)).to eq params[a]
      end
    end
  end

  shared_examples "range query with minimum attributes" do |attrs|
    let(:attr_hash)  { attrs.each_with_object({}) { |a, h| h.merge!(a => self.send(a)) } }
    context "with minimum attributes #{attrs.inspect}" do
      context 'with field and one or more minimum attribute' do
        let(:params)     { { field: field }.merge(attr_hash) }
        let(:query)      { subject.new(params) }
        let(:hash_query) { { range: { field => attr_hash } } }
        it "will not raise an error when only #{attrs.join(', ')} is specified" do
          expect { query }.to_not raise_error
        end
        it "will have the correct hash representation when only #{attrs.join(', ')} is specified" do
          expect(query.to_hash).to eq hash_query
        end

        it "will have the correct json representation when only #{attrs.join(', ')} is specified" do
          expect(query.to_json).to eq hash_query.to_json
        end
      end

      context 'with field, boost and one or more minimum attribute' do
        let(:params)     { { field: field, boost: boost }.merge(attr_hash) }
        let(:query)      { subject.new(params) }
        let(:hash_query) { { range: { field => attr_hash } } }
        it "will not raise an error when only #{attrs.join(', ')} is specified" do
          expect { query }.to_not raise_error
        end
        it "will have the correct hash representation when only #{attrs.join(', ')} is specified" do
          expect(query.to_hash).to eq hash_query
        end

        it "will have the correct json representation when only #{attrs.join(', ')} is specified" do
          expect(query.to_json).to eq hash_query.to_json
        end
      end
    end
  end

  (1..minimum_attributes.length).to_a.each do |slice|
    minimum_attributes.combination(slice).each do |attrs|
      it_behaves_like "range query with minimum attributes", attrs
    end
  end
end