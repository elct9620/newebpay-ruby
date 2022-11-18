# frozen_string_literal: true

require 'openssl'

module Newebpay
  # The module for encrypt and decrypt trade info
  #
  # @since 0.1.0
  class Key
    # @param [String] key
    # @param [String] iv
    #
    # @return [Newebpay::Cipher]
    #
    # @since 0.3.0
    def initialize(key:, iv:)
      @key = key
      @iv = iv
    end

    # Encrypt data
    #
    # @param [String] data
    #
    # @return [String] the encrypted data as hex
    #
    # @since 0.1.0
    def encrypt(data, algorithm: 'aes-256-cbc')
      cipher = OpenSSL::Cipher.new(algorithm).tap do |c|
        c.encrypt
        c.key = @key
        c.iv = @iv
      end

      (cipher.update(data) + cipher.final).unpack1('H*')
    end

    # Decrypt data
    #
    # @param [String] data
    #
    # @return [String] the decrypted data as string
    #
    # @since 0.1.0
    def decrypt(data, algorithm: 'aes-256-cbc')
      cipher = OpenSSL::Cipher.new(algorithm).tap do |c|
        c.decrypt
        c.padding = 0
        c.key = @key
        c.iv = @iv
      end

      strip_padding(cipher.update([data].pack('H*')) + cipher.final)
    end

    # Checksum
    #
    # @param [String] data
    #
    # @return [String] the hashed checksum
    def checksum(data, algorithm: 'sha256')
      OpenSSL::Digest
        .hexdigest(algorithm, "HashKey=#{@key}&#{data}&HashIV=#{@iv}")
        .upcase
    end

    # Remove Padding from NewebPay
    #
    # @param [String] data
    #
    # @return [String]
    #
    # @since 0.1.0
    def strip_padding(data)
      padding = data[-1].ord
      padding_char = padding.chr
      data[/(.*)#{padding_char}{#{padding}}/, 1]
    end
  end
end
