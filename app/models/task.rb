class Task < ApplicationRecord
	# CSVの出力
	def self.csv_attributes
		["name", "description", "created_at", "updated_at"]
	end

	def self.generate_csv
		CSV.generate(headers: true) do |csv|
			csv << csv_attributes
			all.each do |task|
				csv << csv_attributes.map{|attr| task.send(attr) }
			end
		end
	end

	# CSVの入力
		def self.import(file)
			CSV.foreach(file.path, headers: true) do |row|
				task = new
				task.attributes = row.to_hash.slice(*csv_attributes)
				task.save!
			end
		end

	# タスクに画像ファイルを添付する
	has_one_attached :image

	# Ransackの検索条件を絞る(セキュリティ対策)
	def self.ransackable_attributes(auth_object = nil)
		%w[name created_at]
	end

	def self.ransackable_associations(auth_object = nil)
		[]
	end

	# # コールバック
	# before_validation :set_nameless_name

	# バリデーション(検証))
	# validates :name, presence: true, length: {maximum: 30}
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

	# # コールバックの実装
	# def set_nameless_name
	# 	self.name = '名前なし' if name.blank?
	# end
end
