require 'json'

module HashUtil

  # Sort hash keys (Ruby keeps track of key order in hashes).
  def self.multi_level_sort_keys(obj)
    if obj.is_a?(Hash)
      Hash[*obj.sort.map {|k, v| [k, multi_level_sort_keys(v)] }.flatten(1)]
    elsif obj.instance_of?(Array)
      obj.map {|element| multi_level_sort_keys(element) }
    else
      obj
    end
  end

  # Merge multi-level hashes.
  # Inspired by http://stackoverflow.com/questions/10691318/merge-some-complex-hashes-in-ruby
  #
  # Available options:
  #   :keys_to_strings - whether to convert all keys to strings
  def self.multi_level_merge(h1, h2, options = {})
    original_options = options
    options = options.clone
    keys_to_strings = options.delete(:keys_to_strings)
    unless options.empty?
      raise "Invalid options: #{options}"
    end

    h1 ||= {}
    h2 ||= {}

    if keys_to_strings
      # Convert all keys to strings as requested.
      h1 = Hash[h1.collect { | k, v | [k.to_s, v] }]
      h2 = Hash[h2.collect { | k, v | [k.to_s, v] }]
    end

    h1.merge(h2) do |key, first, second|
      if first.is_a?(Hash) && second.is_a?(Hash)
        multi_level_merge(first, second, original_options)
      else
        second
      end
    end
  end

  # Converts a hash-like object to a proper hash using JSON.
  def self.make_proper_hash(hash_like)
    JSON.parse(JSON.generate(hash_like))
  end

end
