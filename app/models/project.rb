class Project < ApplicationRecord
    validates :title, presence: true, length: { minimum: 1, maximum: 25 }
    validates_uniqueness_of :title
    validates :description, presence: true, length: {minimun: 1, maximum:500}
    has_many :buges

    has_many :users, through: :assigns
end