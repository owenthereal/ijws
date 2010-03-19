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

    def base_definitions
      read_inheritable_attribute(:base_definitions)
    end 
  end
end

module BaseCoder
  BASE62_CHARS =  %w{0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z}
  CHARS = BASE62_CHARS
  BASE = CHARS.length

  def self.encode(value)
    s = []
    while value > BASE
      value, rem = value.divmod(BASE)
      s << CHARS[rem]
    end
    s << CHARS[value]
    s.reverse.to_s
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

