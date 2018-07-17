class Idea < ApplicationRecord
  belongs_to :user

  has_many :reviews, dependent: :destroy


  validates(:title, presence: true)
  validates(
        :description,
        presence: {
            message: "must be given"
        },
        length: {
            minimum: 2
        }
  )
end
