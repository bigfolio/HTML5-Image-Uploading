class Image < ActiveRecord::Base
  has_attached_file :attachment, :styles => { :medium => "600x600>", :thumb => "100x100>" }
end
