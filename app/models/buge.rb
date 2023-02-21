class Buge < ApplicationRecord
    validates :title, presence: true, length: { minimum: 1, maximum: 25 }
    validates :status, presence: true, length: { minimum: 1, maximum: 25 }
    enum typeBug: [:feature, :bug]
    mount_uploader :image, ImageUploader
    belongs_to :project
    validates :project_id, presence: true
end