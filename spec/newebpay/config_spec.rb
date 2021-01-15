# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Newebpay::Config do
  let(:config) { described_class.new }

  describe '.current' do
    subject { described_class.current }

    it { is_expected.to be_a(described_class) }
  end

  describe '#config' do
    subject(:when_config) { config.config {} }

    it 'is expected to call instance_exec' do
      allow(config).to receive(:instance_exec)
      when_config
      expect(config).to have_received(:instance_exec)
    end
  end

  describe '#hash_key' do
    subject { config.hash_key }

    it { is_expected.to be_nil }

    context 'when hash_key is configured' do
      before { config.hash_key = 'example' }

      it { is_expected.to eq('example') }
    end
  end

  describe '#hash_iv' do
    subject { config.hash_iv }

    it { is_expected.to be_nil }

    context 'when hash_iv is configured' do
      before { config.hash_iv = 'example' }

      it { is_expected.to eq('example') }
    end
  end
end
