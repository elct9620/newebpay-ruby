# frozen_string_literal: true

require 'openssl'

module Newebpay
  # The module for encrypt and decrypt trade info
  #
  # @since 0.1.0
  module Cipher
    module_function

    # Encrypt data
    #
    # @param [String] data
    #
    # @return [String] the encrypted data as hex
    #
    # @since 0.1.0
    def encrypt(data)
      cipher = OpenSSL::Cipher.new('aes-256-cbc').tap do |c|
        c.encrypt
        c.padding = 0
        c.key = Newebpay::Config.hash_key
        c.iv = Newebpay::Config.hash_iv
      end

      (cipher.update(padding(data)) + cipher.final).unpack1('H*')
    end

    # Align data
    #
    # @param [String] data
    # @param [Number] block size
    #
    # @return [String]
    #
    # @since 0.1.0
    def padding(data, block_size = 32)
      pad = block_size - (data.length % 32)
      data + (pad.chr * pad)
    end
  end
end
