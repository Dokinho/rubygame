module Saveable
  # def to_json(*args)
  #   {
  #     JSON.create_id => self.class.name,
  #     'attributes' => self.to_hash
  #   }.to_json(*args)
  # end

  # def self_class_regex
  #   /#<#{self.class}:0x\w*>/
  # end

  def class_regex
    /#<\w*:0x\w*>/
  end

  # def ref_id
  #   self.to_s.scan(class_regex).first
  # end

  def to_hash
    arity = self.method(:initialize).arity
    req_params = (arity < 0) ? (arity + 1).abs : arity

    hash = {klass: self.class, req_params: req_params}
    self.instance_variables.each do |var|
      value = self.instance_variable_get(var)
      if value.is_a?(Array)
        if value.any? { |elem| elem.to_s.match(class_regex) }
          hash[var] = value.map { |elem| "REF#{elem.id}" }
        else
          hash[var] = value
        end
      else
        if value.to_s.match(class_regex)
          hash[var] = "REF#{value.id}"
        else
          hash[var] = value
        end
      end
    end
    hash
  end

  def class_vars_to_hash
    hash = {}
    self.class_variables.each do |var|
      value = self.class_variable_get(var)
      hash[var] = value
    end
    hash
  end
end