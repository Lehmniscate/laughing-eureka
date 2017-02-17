# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  track_id   :integer          not null
#  note       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Note < ApplicationRecord
  validates_presence_of :user_id, :track_id, :note

  belongs_to :user
  belongs_to :track
end
