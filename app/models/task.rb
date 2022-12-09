class Task < ApplicationRecord
	# コールバック
	before_validation :set_nameless_name
	# バリデーション(検証))
	validates :name, presence: true, length: {maximum: 30}
	validate :validate_name_not_including_comma

	# リレーションの定義(user:単数形)
	belongs_to :user
	# => userに紐づいたtaskを取得する「user.tasks」メソッド(今回は全て「current_user.tasks」メソッド)、
	#    taskに紐づいたuserを取得する「task.user」メソッドが使用可能になった

	# 自前のクエリー用メソッドを作成する(indexアクションで使用)
	scope :recent, -> { order(created_at: :desc) }

# オリジナルの検証コードを作成する
	private

	def validate_name_not_including_comma
		errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
	end

	# コールバックの実装
	def set_nameless_name
		self.name = '名前なし' if name.blank?
	end
end
