# frozen_string_literal: true

RSpec.shared_examples 'has trade info' do |checksum|
  subject { object }

  let(:object) { described_class.new(query_string) }

  describe '#trade_info' do
    subject { object.trade_info }

    it { is_expected.to have_key('Status') }
    it { is_expected.to have_key('Message') }
    it { is_expected.to have_key('Result') }

    context 'when decrypt failed' do
      before { config.hash_key = 'B' * 32 }

      after { config.hash_key = 'A' * 32 }

      it { is_expected.to be_empty }
    end
  end

  describe '#checksum' do
    subject { object.checksum }

    it { is_expected.to eq(checksum) }
  end

  describe '#valid?' do
    it { is_expected.to be_valid }

    context 'when hash_key invalid' do
      before { config.hash_key = 'B' * 32 }

      after { config.hash_key = 'A' * 32 }

      it { is_expected.not_to be_valid }
    end
  end
end
