# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Newebpay::Cipher do
  subject(:cipher) do
    described_class.new(
      key: 'A' * 32,
      iv: 'A' * 16
    )
  end

  describe '#decrypt' do
    subject { cipher.decrypt('5d54df78166ea169cb090290bbca628a1231d591bcda0ca23719c2d468505afd') }

    it { is_expected.to include('dummy') }
  end

  describe '#encrypt' do
    subject { cipher.encrypt('dummy') }

    it { is_expected.to eq('bc239beef860243040f2e0174cd490b7') }
  end
end
