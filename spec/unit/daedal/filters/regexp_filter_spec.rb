require "spec_helper"

describe Daedal::Filters::RegexpFilter do
  subject { Daedal::Filters::RegexpFilter }

  context "without a field" do
    it { expect{subject.new(filter: :foo)}.to raise_error(Virtus::CoercionError) }
  end

  context "without a query" do
    it { expect{subject.new(fied: :foo)}.to raise_error(Virtus::CoercionError) }
  end

  context "with a field and a query" do
    let(:filter) { subject.new(field: :foo, query: :bar) }
    let(:hash_filter) { {regexp: {foo: {value: 'bar'}}} }

    it "will create a regexp query with the correct values" do
      expect(filter.field).to eq :foo
      expect(filter.query).to eq "bar"
    end

    it "will have the correct hash and json representations" do
      expect(filter.to_hash).to eq hash_filter
      expect(filter.to_json).to eq hash_filter.to_json
    end
  end

  context "with a field and an upper cased query" do
    let(:filter) { subject.new(field: :foo, query: "BAR") }
    let(:hash_filter) { {regexp: {foo: {value: 'bar'}}} }

    it "will create a regexp query with the correct values" do
      expect(filter.field).to eq :foo
      expect(filter.query).to eq "bar"
    end

    it "will have the correct hash and json representations" do
      expect(filter.to_hash).to eq hash_filter
      expect(filter.to_json).to eq hash_filter.to_json
    end
  end

  context "with flags" do
    let(:filter) { subject.new(field: :foo, query: :bar, flags: [:intersection, :complement]) }
    let(:hash_filter) { {regexp: {foo: {value: 'bar', flags: "intersection|complement"}}} }

    it { expect(filter.flags).to eq [:intersection, :complement] }

    it "will have the correct hash and json representation" do
      expect(filter.to_hash).to eq hash_filter
      expect(filter.to_json).to eq hash_filter.to_json
    end
  end
end
