class FoodType
  def initialize(slug, value)
    @slug = slug
    @name = value[:name]
    @filename = value[:filename]
    @types = value[:types].map {|v| OpenStruct.new(id: v[:id], name: v[:name], filename: Proc.new {|date| "#{@filename.call(date)}#{v[:suffix] && '-'+v[:suffix]}"}, suffix: v[:suffix])}
  end

  @@current = :daily
  @@types = {
    daily: {name: 'Ежедневное меню', filename: lambda {|date| "#{date.strftime('%F')}"}, types: [{id: 0, name: 'обычное меню'}, {id: 1, name: 'меню для младших классов', suffix: 'sm'}]},
    typical: {name: 'Типовое меню', filename: lambda {|date| "tm#{date.strftime('%Y')}"}, types: [{id: 2, name: 'обычное меню'}, {id: 3, name: 'меню для младших классов', suffix: 'sm'}, {id: 4, name: 'меню для старших классов', suffix: 'ss'}]}
  }.map { |k,v| FoodType.new(k, v) }

  attr_accessor :name, :slug, :types, :filename

  def self.current
    @@types.select { |t| t.slug == @@current }.first
  end

  def self.current= slug
    @@current = @@types.select { |t| t.slug.to_s == slug.to_s }.any? && slug.to_sym || :daily
  end

  def self.outher
    @@types.select { |t| t.slug != @@current_tmp}
  end

  def self.all
    @@types
  end

# private
  # def initialize(slug, value, type_id)
  #   p "============="
  #   p slug, value, type_id
  #   @slug = slug
  #   @name = value.shift
  #   # get_id = lambda {(type_id + 1) * (_1 + 1) - 1}
  #   # @types = value.map.with_index {|name, id| OpenStruct.new(id: get_id(id), name: name)}
  # end
end