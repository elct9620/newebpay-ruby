# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OffsitePayments::Integrations::Newebpay do
  describe '.service_url' do
    subject(:get_service_url) { described_class.service_url }

    it { is_expected.to eq('https://core.newebpay.com/MPG/mpg_gateway') }

    context 'when under test mode' do
      before { allow(OffsitePayments).to receive(:mode).and_return(:test) }

      it { is_expected.to eq('https://ccore.newebpay.com/MPG/mpg_gateway') }
    end

    context 'when under unknow mode' do
      before { allow(OffsitePayments).to receive(:mode).and_return(:unknown) }

      it { expect { get_service_url }.to raise_error(StandardError) }
    end
  end
end
