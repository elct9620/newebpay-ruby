# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OffsitePayments::Integrations::Newebpay::Helper do
  let(:options) { {} }
  let(:helper) { described_class.new('DUMMY_ORDER', 'DUMMY_MERCHANT', options) }

  let(:config) { Newebpay::Config.new }

  before do
    allow(Time).to receive(:now).and_return(Time.parse('2021-01-01'))
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
    it { is_expected.to include('TimeStamp=1609430400') }
    it { is_expected.to include('RespondType=JSON') }
  end

  describe '#form_fields' do
    subject { helper.form_fields }

    it { is_expected.to have_key('TradeInfo') }
    it { is_expected.to have_key('TradeSha') }
  end

  describe '#trade_info' do
    subject(:trade_info) { helper.trade_info }

    it do
      expect(trade_info).to eq(
        'ba096233a931922f34e7273b1e7e81ba7379e4c9ffb1143437349a5a1302b21966f76902fae646bdf98ffd' \
        '15ee7066e9ffe9a3e3c090fdaef6f59fb059ef2af3af7147a89eec0e11eb5853a55cdc89e87bd07622ff0e' \
        '048d2b321fd0cc08336a1cdd959f5d72d5d029360c03e2f8467a'
      )
    end
  end

  describe '#trade_sha' do
    subject { helper.trade_sha }

    it { is_expected.to eq('C60B8AB01C76857E29A977E35115C8AC76EF1328391B59C81FC5F0EDC42C3481') }
  end
end
