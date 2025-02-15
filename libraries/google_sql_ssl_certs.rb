# frozen_string_literal: false

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: MMv1     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------
require 'gcp_backend'
class SQLSslCerts < GcpResourceBase
  name 'google_sql_ssl_certs'
  desc 'SslCert plural resource'
  supports platform: 'gcp'

  attr_reader :table

  filter_table_config = FilterTable.create

  filter_table_config.add(:certs, field: :cert)
  filter_table_config.add(:cert_serial_numbers, field: :cert_serial_number)
  filter_table_config.add(:common_names, field: :common_name)
  filter_table_config.add(:create_times, field: :create_time)
  filter_table_config.add(:expiration_times, field: :expiration_time)
  filter_table_config.add(:instances, field: :instance)
  filter_table_config.add(:sha1_fingerprints, field: :sha1_fingerprint)

  filter_table_config.connect(self, :table)

  def initialize(params = {})
    super(params.merge({ use_http_transport: true }))
    @params = params
    @table = fetch_wrapped_resource('items')
  end

  def fetch_wrapped_resource(wrap_path)
    # fetch_resource returns an array of responses (to handle pagination)
    result = @connection.fetch_all(product_url, resource_base_url, @params, 'Get')
    return if result.nil?

    # Conversion of string -> object hash to symbol -> object hash that InSpec needs
    converted = []
    result.each do |response|
      next if response.nil? || !response.key?(wrap_path)
      response[wrap_path].each do |hash|
        hash_with_symbols = {}
        hash.each_key do |key|
          name, value = transform(key, hash)
          hash_with_symbols[name] = value
        end
        converted.push(hash_with_symbols)
      end
    end

    converted
  end

  def transform(key, value)
    return transformers[key].call(value) if transformers.key?(key)

    [key.to_sym, value]
  end

  def transformers
    {
      'cert' => ->(obj) { return :cert, obj['cert'] },
      'certSerialNumber' => ->(obj) { return :cert_serial_number, obj['certSerialNumber'] },
      'commonName' => ->(obj) { return :common_name, obj['commonName'] },
      'createTime' => ->(obj) { return :create_time, parse_time_string(obj['createTime']) },
      'expirationTime' => ->(obj) { return :expiration_time, parse_time_string(obj['expirationTime']) },
      'instance' => ->(obj) { return :instance, obj['instance'] },
      'sha1Fingerprint' => ->(obj) { return :sha1_fingerprint, obj['sha1Fingerprint'] },
    }
  end

  # Handles parsing RFC3339 time string
  def parse_time_string(time_string)
    time_string ? Time.parse(time_string) : nil
  end

  private

  def product_url(_ = nil)
    'https://sqladmin.googleapis.com/sql/v1beta4/'
  end

  def resource_base_url
    'projects/{{project}}/instances/{{instance}}/sslCerts'
  end
end
