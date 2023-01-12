class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: {"未着手":0, "着手中":1, "完了":2}
  enum priority_level: {"高":0, "中":1, "低":2}
  belongs_to :user
  scope :title_search, -> (title) {where('title LIKE ?',"%#{title}%") }
  scope :status_search, -> (status) {where(status: status)}

  # scope :title_search, -> (params) { where('(title Like ?)',"%#{params[:task][:title]}%") }
  # scope :status_search, -> (params) {where(status: params[:task][:status])}
end
