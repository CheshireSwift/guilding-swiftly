require 'net/http'
require 'uri'
require 'json'
require 'rack'
require_relative 'Price'

BASE_URI = 'https://api.guildwars2.com/v2/'

module GW2API

  def self.get(path, query_hash = {})
    query_string = query_hash.length > 0 ? '?' + Rack::Utils.build_query(query_hash) : ''
    uri = URI::join(BASE_URI, path) + query_string
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def self.get_mats_value(api_key)
    bank_slots = get(
      'account/materials',
      {:access_token => api_key}
    ).select { |bank_slot| bank_slot['count'] > 0 }

    bank_slots.each_with_index.map do |bank_slot, i|
      STDOUT.write "#{i}/#{bank_slots.length} (#{(i.fdiv(bank_slots.length) * 100).round}%)\r"
      get_value(bank_slot['id']) * bank_slot['count']
    end
  end

  def self.get_value(item_id)
    if !item_id then
      puts "Missing entry."
      return Price.none
    end

    results = get("commerce/prices/#{item_id}")
    results['id'] ? Price.new(results["buys"]["unit_price"], results["sells"]["unit_price"]) : Price.none
  end

end

