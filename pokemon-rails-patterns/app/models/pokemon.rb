class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI

  scope :caught, -> {where caught:true}
  scope :free, -> {where caught:false}
  scope :by_type, ->(type=nil) { type ? where(type:type) : all }
end
