class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true
	validates :email, presence: true, uniqueness: true

	# リレーションの定義(tasks:複数形)
	has_many :tasks
	# => userに紐づいたtaskを取得する「user.tasks」メソッド(今回は全て「current_user.tasks」メソッド)、
	#    taskに紐づいたuserを取得する「task.user」メソッドが使用可能になった
end
