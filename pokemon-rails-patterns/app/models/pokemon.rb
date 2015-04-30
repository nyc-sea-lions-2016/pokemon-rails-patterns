class Pokemon < ActiveRecord::Base
  self.inheritance_column = nil #Defending against STI
  validate :check_capture_constraints

  scope :caught, -> {where caught:true}
  scope :free, -> {where caught:false}
  scope :by_type, ->(type=nil) { type ? where(type:type) : all }

  TYPES = %w(
    bug dark dragon electric fairy fighting fire flying
    ghost grass ground ice normal poison psychic rock
    shadow steel unknown water
  )
  MAX_CATCH_PER_TYPE = 2

  private

  def check_capture_constraints
    return if !caught #always allow us to free
    count_of_type = Pokemon.where(type: type).count
    if count_of_type >= MAX_CATCH_PER_TYPE
      errors[:base] << "You may not catch more than #{MAX_CATCH_PER_TYPE} pokemon of the same type"
    end
  end
end
