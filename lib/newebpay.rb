# frozen_string_literal: true

require 'forwardable'

require 'newebpay/version'
require 'newebpay/config'
require 'newebpay/cipher'

require 'offsite_payments/integrations/newebpay'

# NewebPay
#
# @since 0.1.0
module Newebpay
  class Error < StandardError; end

  class << self
    extend Forwardable

    delegate %i[service_url helper return notification] => OffsitePayments::Integrations::Newebpay
  end
end
