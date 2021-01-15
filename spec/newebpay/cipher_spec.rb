# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Newebpay::Cipher do
  let(:config) { Newebpay::Config.new }

  before do
    allow(Newebpay::Config).to receive(:current).and_return(config)

    Newebpay::Config.config do |c|
      c.hash_key = 'A' * 32
      c.hash_iv = 'A' * 16
    end
  end

  describe '.encrypt' do
    subject { described_class.encrypt('dummy') }

    it { is_expected.to eq('5d54df78166ea169cb090290bbca628a1231d591bcda0ca23719c2d468505afd') }
  end
end
