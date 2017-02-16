# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  name       :string           not null
#  live       :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord
  validates_presence_of :band, :name, :live

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
