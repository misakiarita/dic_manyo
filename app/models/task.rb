class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: {"未着手":0, "着手中":1, "完了":2}
  scope :title_search, -> (params) { where('(title Like ?)',"%#{params[:task][:title]}%") }
  scope :status_search, -> (params) {where(status: params[:task][:status])}
end
