require 'spec_helper'

describe Daedal::Queries::RegexpQuery do
  subject { Daedal::Queries::RegexpQuery }

  context "without a field" do
    it { expect{subject.new(query: :foo)}.to raise_error(Virtus::CoercionError) }
  end

  context "without a query" do
    it { expect{subject.new(fied: :foo)}.to raise_error(Virtus::CoercionError) }
  end

  context "with a field and a query" do
    let(:query) { subject.new(field: :foo, query: :bar) }
    let(:hash_query) { {regexp: {foo: {value: 'bar'}}} }

    it "will create a regexp query with the correct values" do
      expect(query.field).to eq :foo
      expect(query.query).to eq "bar"
    end

    it "will have the correct hash and json representations" do
      expect(query.to_hash).to eq hash_query
      expect(query.to_json).to eq hash_query.to_json
    end
  end

  context "with a field and an upper cased query" do
    let(:query) { subject.new(field: :foo, query: "BAR") }
    let(:hash_query) { {regexp: {foo: {value: 'bar'}}} }

    it "will create a regexp query with the correct values" do
      expect(query.field).to eq :foo
      expect(query.query).to eq "bar"
    end

    it "will have the correct hash and json representations" do
      expect(query.to_hash).to eq hash_query
      expect(query.to_json).to eq hash_query.to_json
    end
  end

  context "with a boost" do
    let(:query) { subject.new(field: :foo, query: :bar, boost: 1.2) }
    let(:hash_query) { {regexp: {foo: {value: 'bar', boost: 1.2}}} }

    it { expect(query.boost).to eq 1.2 }

    it "will have the correct hash and json representation" do
      expect(query.to_hash).to eq hash_query
      expect(query.to_json).to eq hash_query.to_json
    end
  end

  context "with flags" do
    let(:query) { subject.new(field: :foo, query: :bar, flags: [:intersection, :complement]) }
    let(:hash_query) { {regexp: {foo: {value: 'bar', flags: "intersection|complement"}}} }

    it { expect(query.flags).to eq [:intersection, :complement] }

    it "will have the correct hash and json representation" do
      expect(query.to_hash).to eq hash_query
      expect(query.to_json).to eq hash_query.to_json
    end
  end

  context "with max determinized states" do
    let(:query) { subject.new(field: :foo, query: :bar, max_determinized_states: 20000) }
    let(:hash_query) { {regexp: {foo: {value: 'bar', max_determinized_states: 20000}}} }

    it { expect(query.max_determinized_states).to eq 20000 }

    it "will have the correct hash and json representation" do
      expect(query.to_hash).to eq hash_query
      expect(query.to_json).to eq hash_query.to_json
    end
  end
end
