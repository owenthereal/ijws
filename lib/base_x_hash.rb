module BaseXHash
  def self.included(base)
    base.extend BaseXHash::ClassMethods
  end

  module ClassMethods
    def has_id(name)
      write_inheritable_attribute(:base_definitions, {}) if base_definitions.nil?
      base_definitions[:name] = name

      key "#{name}".to_sym, Integer

      define_method("#{name}_hash") do
        BaseCoder::encode(self["#{name}"])
      end
    end

    def find_via_hash(hash)
      id = BaseCoder::decode(hash)
      all(:uid => id).first
    end

    def base_definitions
      read_inheritable_attribute(:base_definitions)
    end 
  end
end

module BaseCoder
  CHARS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split('')
  BASE = 62

  def self.encode(value)
    s = []
    while value >= BASE
      value, rem = value.divmod(BASE)
      s << CHARS[rem]
    end
    s << CHARS[value]
    s.reverse.join("")
  end

  def self.decode(str)
    str = str.split('').reverse
    total = 0
    str.each_with_index do |v,k|
      total += (CHARS.index(v) * (BASE ** k))
    end
    total
  end
end