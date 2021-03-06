# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OffsitePayments::Integrations::Newebpay::Helper do
  let(:options) { {} }
  let(:helper) { described_class.new('DUMMY_ORDER', 'DUMMY_MERCHANT', options) }

  let(:config) { Newebpay::Config.new }

  before do
    allow(Time).to receive(:now).and_return(Time.parse('2021-01-01 00:00:00 +0000'))
    allow(Newebpay::Config).to receive(:current).and_return(config)

    Newebpay::Config.config do |c|
      c.hash_key = 'A' * 32
      c.hash_iv = 'A' * 16
    end
  end

  describe '#query_string' do
    subject { helper.params }

    it { is_expected.to include('MerchantID=DUMMY_MERCHANT') }
    it { is_expected.to include('MerchantOrderNo=DUMMY_ORDER') }
    it { is_expected.to include('TimeStamp=1609459200') }
    it { is_expected.to include('RespondType=JSON') }
  end

  describe '#form_fields' do
    subject { helper.form_fields }

    it { is_expected.to have_key('TradeInfo') }
    it { is_expected.to have_key('TradeSha') }
  end

  describe '#trade_info' do
    subject(:trade_info) { pp helper.trade_info }

    it do
      expect(trade_info).to eq(
        'ba096233a931922f34e7273b1e7e81ba7379e4c9ffb1143437349a5a1302b21966f76902fae646bdf98ffd15ee7066e9ffe' \
        '9a3e3c090fdaef6f59fb059ef2af3af7147a89eec0e11eb5853a55cdc89e8ded40eb9485258c19cdf1da1f2c28c06fa7589' \
        'f2141922618b17a690cae351af'
      )
    end
  end

  describe '#trade_sha' do
    subject { helper.trade_sha }

    it { is_expected.to eq('2752103AC2C39B0007D9A27037971E0213ED9028716DB51B408E1F6DA4D74B26') }
  end
end
