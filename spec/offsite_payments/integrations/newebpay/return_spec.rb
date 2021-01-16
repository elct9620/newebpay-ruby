# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OffsitePayments::Integrations::Newebpay::Return do
  let(:query_string) do
    'Status=SUCCESS&' \
    'TradeInfo=979503c01ef9fdc58d64566f1a0a7ca5a5afc8535f65f4144b923985294ad46d2d902b62d22c521586f7c7307' \
    '57d6b209e75ae416ec937d299b3791a5e39716f7724e8bc120c216dd5ee46bb13bac62400171f99f27da0f12e3cbc968bf5' \
    '30d90445c9a2a56826ed8384f4a4650496674d342eb7da605226cab253b0d71d209cea32699f867b748379164174eb9af92' \
    '104d8ea0428ceadb47edcf70f04fb93ebd216a8c42c2f58a0df6762dc92abd808be4d7d7be550ebc2fbc4e9d90067f620e4' \
    'd8c86de2d9c54eb56f925ef5842dc87c9c0b38dee6dcb30b5b24e0a991493aaedb5a2f075e5fe57b888e250006cb5fd71db' \
    'b0aa0a740cd3feede04b8bb1c7314ec048485bafa7d01555506467e119e3dee12a56e3c0ace613749a9b5dc590a6f81c424' \
    'e61e02c490baacf19cafab939a509c51426953cc86fe3ef675b84f245f0fda9b10507a29742ef380f7200bea202208818da' \
    '6fac2ccdacc74341790e4039314286b5df2d391f3f9cd0f8a480cc5e44e1c9d1bbf968f5163a26f1c9d25d78ebfa70bf46d' \
    'b3385d604da20d29618aacfafca87fc1a17dac768a6a4459a40986346fc6f395fc4d25789896254de7b9a7c8ad5cc1fe150' \
    'efac70146e0a74379c37439d0615d0293451852841ae66a3e0f252e54b5525a250d77e187911db2cd72bfd63ea6c84547c7' \
    '75f4b5582204&' \
    'TradeSha=6EF2CB8B032D6BBEC84A8A374DA4068C5746620EA0407F7F19E3FA84D14AD533'
  end

  let(:result) { described_class.new(query_string) }
  let(:config) { Newebpay::Config.new }

  shared_examples 'boolean check' do
    it { is_expected.to be_truthy }

    context 'when hash_key invalid' do
      before { config.hash_key = 'B' * 32 }

      after { config.hash_key = 'A' * 32 }

      it { is_expected.to be_falsy }
    end
  end

  before do
    allow(Newebpay::Config).to receive(:current).and_return(config)

    Newebpay::Config.config do |c|
      c.hash_key = 'A' * 32
      c.hash_iv = 'A' * 16
    end
  end

  describe '#checksum' do
    subject { result.checksum }

    it { is_expected.to eq('6EF2CB8B032D6BBEC84A8A374DA4068C5746620EA0407F7F19E3FA84D14AD533') }
  end

  describe '#valid?' do
    subject { result.valid? }

    it_behaves_like 'boolean check'
  end

  describe '#success?' do
    subject { result.success? }

    it_behaves_like 'boolean check'
  end

  describe '#message' do
    subject { result.message }

    it { is_expected.to eq('授權成功') }
  end

  describe '#trade_info' do
    subject { result.trade_info }

    it { is_expected.to have_key('Status') }
    it { is_expected.to have_key('Message') }
    it { is_expected.to have_key('Result') }

    context 'when decrypt failed' do
      before { config.hash_key = 'B' * 32 }

      after { config.hash_key = 'A' * 32 }

      it { is_expected.to be_empty }
    end
  end
end
