# frozen_string_literal: true

module OffsitePayments
  module Integrations
    module Newebpay
      # The Helper to build payment form
      #
      # @since 0.1.0
      class Helper < OffsitePayments::Helper
        # @see OffsitePayments::Helper#initialize
        #
        # @since 0.1.0
        def initialize(order, account, options = {})
          super
          add_field('RespondType', 'JSON')
          add_field('TimeStamp', Time.now.to_i)
          add_field('Version', VERSION)
          add_field('ItemDesc', options[:description])
        end

        mapping :order, 'MerchantOrderNo'
        mapping :account, 'MerchantID'
        mapping :amount, 'Amt'
        mapping :email, 'Email'
        mapping :description, 'ItemDesc'
        mapping :return_url, 'ReturnURL'
        mapping :notify_url, 'NotifyURL'
        mapping :forward_url, 'CustomerURL'
        mapping :language, 'LangType'
        mapping :timeout, 'TradeLimit'
        mapping :expire_date, 'ExpireDate'
        mapping :back_url, 'ClientBackURL'
        # TODO: Constraint to 1 (Yes) or 0 (No)
        mapping :modify_email, 'EmailModify'
        # TODO: Constraint to 1 (Yes) or 0 (No)
        mapping :require_login, 'LoginType'
        mapping :comment, 'OrderComment'
        mapping :image_url, 'ImageUrl'
        mapping :installment, 'InstFlag'
        mapping :credit_bouns, 'CreditRed'
        mapping :timestamp, 'TimeStamp'

        # The content of trade information
        #
        # @return [String]
        #
        # @since 0.1.0
        def params
          URI.encode_www_form(fields)
        end

        # Fields to build form
        #
        # @return [Hash]
        #
        # @since 0.1.0
        def form_fields
          fields.merge('TradeInfo' => trade_info, 'TradeSha' => trade_sha)
        end

        # The encrypted trade information
        #
        # @return [String]
        #
        # @since 0.1.0
        def trade_info
          ::Newebpay::Cipher.encrypt(params)
        end

        # The checksum for trade info
        #
        # @return [String]
        #
        # @since 0.1.0
        def trade_sha
          Digest::SHA256
            .hexdigest("HashKey=#{::Newebpay::Config.hash_key}&#{trade_info}&HashIV=#{::Newebpay::Config.hash_iv}")
            .upcase
        end
      end
    end
  end
end
