require 'spec_helper'

describe Daedal::Attributes::Flag do
  class Whatever
    include Virtus.model

    attribute :flag, Daedal::Attributes::Flag
  end

  describe '#coerce' do
    it 'coerces a coercible value' do
      model = Whatever.new(flag: 'prefix')

      expect(model.flag).to eq :prefix
    end

    it 'raises a coercion error if flag is not allowed' do
      expect do
        Whatever.new(flag: 'asdasdasdsa')
      end.to raise_error Virtus::CoercionError
    end
  end
end
