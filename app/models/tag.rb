class Tag < ApplicationRecord
  belongs_to :lib_tag
  belongs_to :job
end
