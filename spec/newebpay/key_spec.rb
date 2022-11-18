# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Newebpay::Key do
  subject(:key) do
    described_class.new(
      key: 'A' * 32,
      iv: 'A' * 16
    )
  end

  describe '#decrypt' do
    subject { key.decrypt('5d54df78166ea169cb090290bbca628a1231d591bcda0ca23719c2d468505afd') }

    it { is_expected.to include('dummy') }
  end

  describe '#encrypt' do
    subject { key.encrypt('dummy') }

    it { is_expected.to eq('bc239beef860243040f2e0174cd490b7') }
  end

  describe '#checksum' do
    subject do
      key.checksum(
        'ba096233a931922f34e7273b1e7e81ba7379e4c9ffb1143437349a5a1302b21966f76902fae646bdf98ffd15ee7066e9ffe' \
        '9a3e3c090fdaef6f59fb059ef2af3af7147a89eec0e11eb5853a55cdc89e8ded40eb9485258c19cdf1da1f2c28c06fa7589' \
        'f2141922618b17a690cae351af'
      )
    end

    it { is_expected.to eq('2752103AC2C39B0007D9A27037971E0213ED9028716DB51B408E1F6DA4D74B26') }
  end
end
