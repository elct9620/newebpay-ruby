# frozen_string_literal: true

RSpec.describe Newebpay do
  it 'has a version number' do
    expect(Newebpay::VERSION).not_to be nil
  end

  describe '.use' do
    subject(:when_use_config) { described_class.use(nil) {} }

    it 'is expected to switch config' do
      allow(Newebpay::Config).to receive(:switch).with(nil)
      when_use_config
      expect(Newebpay::Config).to have_received(:switch).with(nil)
    end
  end
end
