class JsonbSerializers
  require 'active_support/core_ext/hash/indifferent_access'
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    (hash || {}).with_indifferent_access
  end
end
