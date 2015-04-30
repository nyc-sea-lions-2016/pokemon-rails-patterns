class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI

  scope :caught, -> {where caught:true}
  scope :free, -> {where caught:false}
  scope :by_type, ->(type=nil) { type ? where(type:type) : all }

  TYPES = %w(
    bug dark dragon electric fairy fighting fire flying
    ghost grass ground ice normal poison psychic rock
    shadow steel unknown water
  )
end
