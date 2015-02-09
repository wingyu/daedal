require 'spec_helper'

describe Daedal::Filters::GeoDistanceRangeFilter do

  subject do
    Daedal::Filters::GeoDistanceRangeFilter
  end

  context 'without a field specified' do
    it 'will raise an error' do
      expect{subject.new(lat: 10, lon: 30, gte: 5)}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'without a compare options specified' do
    it 'will raise an error' do
      expect{subject.new(field: :location, lat: 10, lon: 30)}.to raise_error
    end
  end

  context 'without a lat specified' do
    it 'will raise an error' do
      expect{subject.new(field: :location, gte: 5, lon: 30)}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'without a lon specified' do
    it 'will raise an error' do
      expect{subject.new(field: :location, lat: 10, gte: 5)}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with an invalid unit specified' do
    it 'will raise an error' do
      expect{subject.new(field: :test, gte: 5, lat: 10, lon: 30, unit: 'test')}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with an invalid lat specified' do
    it 'will raise an error' do
      expect{subject.new(field: :location, gte: 5, lat: 'test', lon: 30)}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with an invalid lon specified' do
    it 'will raise an error' do
      expect{subject.new(field: :location, gte: 5, lat: 10, lon: 'test')}.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with wrong compare options' do
    it 'will raise error with less than or equal to + less than compare' do
      expect{subject.new(field: :test, lat: 10, lon: 30, lte: 5, lt: 5)}.to raise_error
    end

    it 'will raise error with more than or equal to + more than compare' do
      expect{subject.new(field: :test, lat: 10, lon: 30, gte: 5, gt: 5)}.to raise_error
    end
  end

  context 'with all attributes' do
    let(:filter) do
      subject.new(field: :location, lat: 10, lon: 30, gte: 1, lte: 2)
    end

    let(:filter_hash) do
      {
        geo_distance_range: {
          gte: '1km',
          lte: '2km',
          location: {
            lat: 10,
            lon: 30
          }
        }
      }
    end

    it 'will have correct filter hash' do
      expect(filter.to_hash).to eq filter_hash
    end

    it 'will use km as the default unit' do
      expect(filter.unit).to eq 'km'
    end
  end

  context 'with miles as unit' do
    let(:filter) do
      subject.new(field: :location, lat: 10, lon: 30, gte: 1, lte: 2, unit: 'mi')
    end

    let(:filter_hash) do
      {
        geo_distance_range: {
          gte: '1mi',
          lte: '2mi',
          location: {
            lat: 10,
            lon: 30
          }
        }
      }
    end

    it 'should be possible to specify miles' do
      expect(filter.to_hash).to eq filter_hash
    end
  end
end